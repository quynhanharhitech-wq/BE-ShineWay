package com.shineway.core_service.model.entities;

import java.util.Collection;
import java.util.List;
import java.util.function.Function;

import com.fasterxml.jackson.annotation.JsonInclude;
import org.springframework.data.domain.Page;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ResponseDTO<T> {

    public enum Status {
        SUCCESS, ERROR
    }

    private Status status;
    private String message;
    private T data;
    private PageMeta pageMeta;

    // ---- factories ----
    public static <T> ResponseDTO<T> success(T data) {
        return ResponseDTO.<T>builder().status(Status.SUCCESS).data(data).build();
    }

    public static <T> ResponseDTO<T> success(T data, String message) {
        return ResponseDTO.<T>builder().status(Status.SUCCESS).message(message).data(data).build();
    }

    public static <T> ResponseDTO<T> error(String message) {
        return ResponseDTO.<T>builder().status(Status.ERROR).message(message).build();
    }

    // ---- mappers tiện dụng ----
    public static <E, R> ResponseDTO<R> fromEntity(E entity, Function<E, R> mapper, String message) {
        R dto = mapper.apply(entity);
        return ResponseDTO.<R>builder().status(Status.SUCCESS).message(message).data(dto).build();
    }

    public static <E, R> ResponseDTO<List<R>> fromList(Collection<E> entities, Function<E, R> mapper, String message) {
        List<R> list = (entities == null) ? List.of() : entities.stream().map(mapper).toList();
        return ResponseDTO.<List<R>>builder().status(Status.SUCCESS).message(message).data(list).build();
    }

    // Page<E> -> List<R> + meta (có mapper)
    public static <E, R> ResponseDTO<List<R>> fromPage(Page<E> page, Function<E, R> mapper, String message) {
        List<R> content = page.getContent().stream().map(mapper).toList();
        return ResponseDTO.<List<R>>builder()
                .status(Status.SUCCESS).message(message).data(content)
                .pageMeta(PageMeta.from(page))
                .build();
    }

    // Page<R> đã map sẵn -> List<R> + meta (không cần mapper)
    public static <R> ResponseDTO<List<R>> fromPage(Page<R> page, String message) {
        return ResponseDTO.<List<R>>builder()
                .status(Status.SUCCESS).message(message).data(page.getContent())
                .pageMeta(PageMeta.from(page))
                .build();
    }
}
