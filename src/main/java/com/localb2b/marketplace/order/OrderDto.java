package com.localb2b.marketplace.order;

import java.math.BigDecimal;
import java.time.Instant;

public record OrderDto(Long id,
                       Long retailerUserId,
                       Long distributorUserId,
                       BigDecimal totalAmount,
                       BigDecimal partialAmount,
                       BigDecimal paidAmount,
                       OrderPaymentMode paymentMode,
                       OrderStatus status,
                       String deliveryAddress,
                       String deliverySlot,
                       String deliveryPincode,
                       String pickupOtp,
                       String deliveryOtp,
                       String rejectionReason,
                       String distributorNotes,
                       Boolean codCollected,
                       BigDecimal codCollectedAmount,
                       Instant packedAt,
                       Instant readyForPickupAt,
                       Instant pickedUpAt,
                       Instant deliveredAt,
                       Instant completedAt,
                       Instant createdAt) {
}
