package com.localb2b.marketplace.delivery;

import java.time.Instant;

public record DeliveryDto(Long id, Long orderId, Long driverUserId, DeliveryStatus status, Instant createdAt) {
}
