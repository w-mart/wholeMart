package com.localb2b.marketplace.order;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import lombok.Getter;

@Getter
public class MarketplaceOrderDetails {
    private Long id;
    private Long retailerUserId;
    private Long distributorUserId;
    private BigDecimal totalAmount;
    private BigDecimal partialAmount;
    private BigDecimal paidAmount;
    private BigDecimal outstandingAmount;
    private OrderPaymentMode paymentMode;
    private OrderStatus status;
    private String deliveryAddress;
    private String deliverySlot;
    private String pickupOtp;
    private String deliveryOtp;
    private String rejectionReason;
    private String distributorNotes;
    private Boolean codCollected;
    private BigDecimal codCollectedAmount;
    private Instant packedAt;
    private Instant readyForPickupAt;
    private Instant pickedUpAt;
    private Instant deliveredAt;
    private Instant completedAt;
    private Instant createdAt;
    private String retailerName;
    private String retailerLocation;
    private String distributorShopName;
    private String distributorBusinessName;
    private String distributorAddress;
    private List<OrderItemDetails> items = List.of();

    protected MarketplaceOrderDetails() {
    }

    public MarketplaceOrderDetails(Long id,
            Long retailerUserId,
            Long distributorUserId,
            BigDecimal totalAmount,
            BigDecimal partialAmount,
            BigDecimal paidAmount,
            BigDecimal outstandingAmount,
            OrderPaymentMode paymentMode,
            OrderStatus status,
            String deliveryAddress,
            String deliverySlot,
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
            Instant createdAt,
            String retailerName,
            String retailerLocation,
            String distributorShopName,
            String distributorBusinessName,
            String distributorAddress,
            List<OrderItemDetails> items) {
        this.id = id;
        this.retailerUserId = retailerUserId;
        this.distributorUserId = distributorUserId;
        this.totalAmount = totalAmount;
        this.partialAmount = partialAmount;
        this.paidAmount = paidAmount;
        this.outstandingAmount = outstandingAmount;
        this.paymentMode = paymentMode;
        this.status = status;
        this.deliveryAddress = deliveryAddress;
        this.deliverySlot = deliverySlot;
        this.pickupOtp = pickupOtp;
        this.deliveryOtp = deliveryOtp;
        this.rejectionReason = rejectionReason;
        this.distributorNotes = distributorNotes;
        this.codCollected = codCollected;
        this.codCollectedAmount = codCollectedAmount;
        this.packedAt = packedAt;
        this.readyForPickupAt = readyForPickupAt;
        this.pickedUpAt = pickedUpAt;
        this.deliveredAt = deliveredAt;
        this.completedAt = completedAt;
        this.createdAt = createdAt;
        this.retailerName = retailerName;
        this.retailerLocation = retailerLocation;
        this.distributorShopName = distributorShopName;
        this.distributorBusinessName = distributorBusinessName;
        this.distributorAddress = distributorAddress;
        this.items = items == null ? List.of() : items;
    }
}
