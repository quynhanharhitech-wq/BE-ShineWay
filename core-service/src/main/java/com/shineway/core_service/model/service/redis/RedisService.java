package com.shineway.core_service.model.service.redis;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;

import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.Cursor;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ScanOptions;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.util.Assert;

public class RedisService<T> {

    private final String namespace;
    private final RedisTemplate<String, T> template;
    private final Class<T> valueType;
    private final Duration defaultTtl;

    public RedisService(String namespace,
            RedisTemplate<String, T> template,
            Class<T> valueType,
            Duration defaultTtl) {
        Assert.hasText(namespace, "namespace must not be empty");
        Assert.notNull(template, "template must not be null");
        Assert.notNull(valueType, "valueType must not be null");
        this.namespace = namespace.trim();
        this.template = template;
        this.valueType = valueType;
        this.defaultTtl = defaultTtl;
    }

    // ------------------ Key helpers ------------------
    public String key(Object id) {
        Assert.notNull(id, "id must not be null");
        return namespace + ":" + id;
    }

    public String getNamespace() {
        return namespace;
    }

    public Class<T> getValueType() {
        return valueType;
    }

    // ------------------ CRUD ------------------

    /** Upsert với TTL mặc định (nếu có) */
    public void save(Object id, T value) {
        save(id, value, defaultTtl);
    }

    /** Upsert với TTL tuỳ chọn (null = không set TTL) */
    public void save(Object id, T value, Duration ttl) {
        Assert.notNull(value, "value must not be null");
        String k = key(id);
        ValueOperations<String, T> ops = template.opsForValue();
        ops.set(k, value);
        if (ttl != null && !ttl.isNegative() && !ttl.isZero()) {
            template.expire(k, ttl);
        }
    }

    /** Tạo mới nếu chưa tồn tại (atomic) + TTL tuỳ chọn */
    public boolean setIfAbsent(Object id, T value, Duration ttl) {
        Assert.notNull(value, "value must not be null");
        String k = key(id);
        ValueOperations<String, T> ops = template.opsForValue();
        Boolean ok = (ttl == null || ttl.isZero() || ttl.isNegative())
                ? ops.setIfAbsent(k, value)
                : ops.setIfAbsent(k, value, ttl);
        return Boolean.TRUE.equals(ok);
    }

    /** Đọc theo id */
    public Optional<T> findById(Object id) {
        String k = key(id);
        T v = template.opsForValue().get(k);
        return Optional.ofNullable(v);
    }

    /** Kiểm tra tồn tại */
    public boolean exists(Object id) {
        Boolean e = template.hasKey(key(id));
        return Boolean.TRUE.equals(e);
    }

    /** Xoá theo id */
    public boolean deleteById(Object id) {
        Boolean r = template.delete(key(id));
        return Boolean.TRUE.equals(r);
    }

    /** Đặt TTL/expire cho key (ghi đè TTL cũ) */
    public boolean expire(Object id, Duration ttl) {
        Assert.notNull(ttl, "ttl must not be null");
        return Boolean.TRUE.equals(template.expire(key(id), ttl));
    }

    /** Gia hạn TTL hiện tại (đặt TTL mới) */
    public boolean refreshTtl(Object id, Duration ttl) {
        return expire(id, ttl);
    }

    /** Lấy tất cả (giới hạn số lượng) bằng SCAN theo namespace */
    public List<T> findAll(int limit) {
        Assert.isTrue(limit > 0, "limit must be > 0");
        List<String> keys = scanKeys(limit);
        if (keys.isEmpty())
            return List.of();
        List<T> result = new ArrayList<>(keys.size());
        keys.forEach(k -> {
            T v = template.opsForValue().get(k);
            if (v != null)
                result.add(v);
        });
        // Nếu nhiều key, dùng MGET tối ưu hơn (ops.multiGet) — phụ thuộc serializer:
        // result = template.opsForValue().multiGet(keys) ...
        return result;
    }

    /** Xoá toàn bộ key thuộc namespace (dùng SCAN, không KEYS) — trả số key xoá */
    public long clearNamespace() {
        List<String> keys = scanKeys(Integer.MAX_VALUE); // quét hết
        if (keys.isEmpty())
            return 0L;
        Long deleted = template.delete(keys);
        return deleted == null ? 0L : deleted;
    }

    // ------------------ Internal: SCAN helper ------------------

    /**
     * SCAN theo pattern namespace:* với batchSize hợp lý.
     * Không block Redis như KEYS.
     */
    private List<String> scanKeys(int limit) {
        final String match = namespace + ":*";
        final int batchSize = Math.min(Math.max(100, limit), 1000); // 100..1000

        return template.execute(new RedisCallback<List<String>>() {
            @Override
            public List<String> doInRedis(RedisConnection connection) throws DataAccessException {
                List<String> keys = new ArrayList<>(Math.min(limit, 256));
                ScanOptions options = ScanOptions.scanOptions()
                        .match(match)
                        .count(batchSize)
                        .build();
                try (Cursor<byte[]> cursor = connection.scan(options)) {
                    while (cursor.hasNext() && keys.size() < limit) {
                        keys.add(new String(cursor.next())); // vì keySerializer mặc định là String
                    }
                } catch (Exception e) {
                    throw new IllegalStateException("SCAN failed", e);
                }
                return keys;
            }
        });
    }

    // ------------------ Convenience ------------------

    /** Lấy hoặc tạo mặc định nếu chưa có (không TTL) */
    public T getOrDefault(Object id, T defaultValue) {
        return findById(id).orElse(defaultValue);
    }

    /** Lấy hoặc compute nếu chưa có; nếu compute trả null thì không lưu. */
    public T getOrCompute(Object id, ValueSupplier<T> supplier, Duration ttl) {
        T existing = template.opsForValue().get(key(id));
        if (existing != null)
            return existing;
        T computed = supplier.get();
        if (computed != null)
            save(id, computed, ttl);
        return computed;
    }

    @FunctionalInterface
    public interface ValueSupplier<V> {
        V get();
    }

    // ------------------ Equals/HashCode/ToString (tuỳ chọn) ------------------

    @Override
    public String toString() {
        return "RedisService<" + valueType.getSimpleName() + ">{ns=" + namespace + ", defaultTtl=" + defaultTtl + "}";
    }

    @Override
    public int hashCode() {
        return Objects.hash(namespace, valueType);
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof RedisService<?> other))
            return false;
        return Objects.equals(this.namespace, other.namespace)
                && Objects.equals(this.valueType, other.valueType);
    }

}
