package com.localb2b.marketplace.order;

import java.math.BigDecimal;

public record OrderItemDetails(Long productId,
                               String productName,
                               String sku,
                               BigDecimal unitPrice,
                               int quantity,
                               BigDecimal lineTotal,
                               String packSize,
                               BigDecimal weightKg) {
}
