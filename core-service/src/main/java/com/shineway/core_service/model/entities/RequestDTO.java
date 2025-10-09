package com.shineway.core_service.model.entities;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class RequestDTO<T> {

    private T data;

    private String keyword;

    private Filters filters;

    private PageMeta pageMeta;

    // ---------- Static factories tiện dụng ----------
    public static <T> RequestDTO<T> of(T data) {
        return RequestDTO.<T>builder().data(data).build();
    }

    public static <T> RequestDTO<T> of(T data, PageMeta pageMeta) {
        return RequestDTO.<T>builder().data(data).pageMeta(pageMeta).build();
    }

    public static PageMeta page(int page, int size) {
        return PageMeta.builder().page(page).size(size).build();
    }
    
}
