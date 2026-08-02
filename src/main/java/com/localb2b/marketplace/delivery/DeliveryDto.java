package com.localb2b.marketplace.delivery;

import java.math.BigDecimal;
import java.time.Instant;

public record DeliveryDto(
        Long id,
        Long orderId,
        Long driverUserId,
        DeliveryStatus status,
        String pickupOtp,
        String deliveryOtp,
        Instant driverAcceptedAt,
        Instant pickedUpAt,
        Instant deliveredAt,
        String rejectionReason,
        BigDecimal pickupLatitude,
        BigDecimal pickupLongitude,
        BigDecimal deliveryLatitude,
        BigDecimal deliveryLongitude,
        BigDecimal deliveryFee,
        Instant createdAt) {
}
