package com.shineway.core_service.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;

@Configuration
public class RedisConfig {

    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory cf) {
        var template = new RedisTemplate<String, Object>();
        template.setConnectionFactory(cf);
        var keySer = new org.springframework.data.redis.serializer.StringRedisSerializer();
        var valSer = new org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer();
        template.setKeySerializer(keySer);
        template.setHashKeySerializer(keySer);
        template.setValueSerializer(valSer);
        template.setHashValueSerializer(valSer);
        template.afterPropertiesSet();
        return template;
    }

}
