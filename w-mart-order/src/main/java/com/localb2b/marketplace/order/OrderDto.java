package com.localb2b.marketplace.order;

import java.math.BigDecimal;
import java.time.Instant;

public record OrderDto(Long id,
                       Long retailerUserId,
                       Long distributorUserId,
                       BigDecimal totalAmount,
                       OrderPaymentMode paymentMode,
                       OrderStatus status,
                       Instant createdAt) {
}
