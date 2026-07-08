package com.localb2b.marketplace.payment;

import java.math.BigDecimal;
import java.time.Instant;

public record PaymentDto(Long id, Long orderId, BigDecimal amount, PaymentStatus status, Instant createdAt) {
}
