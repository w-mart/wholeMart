package com.localb2b.marketplace.common;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

public final class Pageables {
    private static final int MAX_PAGE_SIZE = 100;

    private Pageables() {
    }

    public static Pageable bounded(int page, int size) {
        return PageRequest.of(Math.max(0, page), Math.min(Math.max(1, size), MAX_PAGE_SIZE));
    }
}
