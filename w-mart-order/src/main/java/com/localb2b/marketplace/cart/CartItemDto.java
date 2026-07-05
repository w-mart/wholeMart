package com.localb2b.marketplace.cart;

import java.time.Instant;

public record CartItemDto(Long id, Long productId, int quantity, Instant createdAt) {
}
