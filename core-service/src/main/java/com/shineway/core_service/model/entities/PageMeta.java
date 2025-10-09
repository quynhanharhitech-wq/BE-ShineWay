package com.shineway.core_service.model.entities;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PageMeta {
    private Integer page; // 0-based
    private Integer size;
    private Long totalElements;
    private Integer totalPages;
    private Boolean hasNext;
    private Boolean hasPrevious;

    public static PageMeta from(Page<?> p) {
        return PageMeta.builder()
                .page(p.getNumber())
                .size(p.getSize())
                .totalElements(p.getTotalElements())
                .totalPages(p.getTotalPages())
                .hasNext(p.hasNext())
                .hasPrevious(p.hasPrevious())
                .build();
    }

    public Pageable toPageable(int defaultPage, int defaultSize, Sort sort) {
        int p = (page == null) ? defaultPage : page;
        int s = (size == null) ? defaultSize : size;
        return (sort == null) ? PageRequest.of(p, s) : PageRequest.of(p, s, sort);
    }
}
