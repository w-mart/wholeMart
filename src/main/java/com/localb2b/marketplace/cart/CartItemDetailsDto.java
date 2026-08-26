package com.localb2b.marketplace.cart;

import java.math.BigDecimal;
import java.time.Instant;

/**
 * Mobile-ready cart item including the current product information needed to
 * render a cart row without issuing one product request per cart item.
 */
public record CartItemDetailsDto(
        Long cartItemId,
        Long productId,
        Long distributorUserId,
        String name,
        String brand,
        String category,
        String sku,
        String imageUrl,
        BigDecimal unitPrice,
        int quantity,
        BigDecimal lineTotal,
        Integer stockQuantity,
        Instant createdAt) {
}
