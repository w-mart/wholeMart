package com.localb2b.marketplace.order;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.Instant;
import lombok.Getter;
import lombok.Setter;

@Getter
@Entity
@Table(name = "orders")
public class MarketplaceOrder extends BaseEntity {
    @Column(nullable = false)
    private Long retailerUserId;

    @Column(nullable = false)
    private Long distributorUserId;

    @Column(nullable = false, precision = 12, scale = 2)
    private BigDecimal totalAmount;

    @Setter
    @Column(precision = 12, scale = 2)
    private BigDecimal partialAmount;

    @Setter
    @Column(precision = 12, scale = 2)
    private BigDecimal paidAmount = BigDecimal.ZERO;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private OrderPaymentMode paymentMode;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private OrderStatus status = OrderStatus.PLACED;

    @Setter
    private String deliveryAddress;

    @Setter
    private String deliverySlot;

    @Setter
    private String deliveryPincode;

    @Setter
    private BigDecimal deliveryLatitude;

    @Setter
    private BigDecimal deliveryLongitude;

    @Setter
    private String pickupOtp;

    @Setter
    private String deliveryOtp;

    private Instant packedAt;
    private Instant readyForPickupAt;
    private Instant pickedUpAt;
    private Instant deliveredAt;
    private Instant completedAt;

    @Setter
    private String modifiedQuantityJson;

    @Setter
    private String rejectionReason;

    @Setter
    private String distributorNotes;

    @Setter
    private Boolean codCollected = false;

    @Setter
    private BigDecimal codCollectedAmount;

    protected MarketplaceOrder() {
    }

    public MarketplaceOrder(Long retailerUserId, Long distributorUserId, BigDecimal totalAmount, OrderPaymentMode paymentMode) {
        this.retailerUserId = retailerUserId;
        this.distributorUserId = distributorUserId;
        this.totalAmount = totalAmount;
        this.paymentMode = paymentMode;
        this.status = OrderStatus.PLACED;
    }

    // === State Machine Transitions ===

    public void distributorAccept() {
        this.status = OrderStatus.ACCEPTED;
    }

    public void distributorReject(String reason) {
        this.status = OrderStatus.REJECTED;
        this.rejectionReason = reason;
    }

    public void startPacking() {
        this.status = OrderStatus.PACKING;
    }

    public void markReadyForPickup() {
        this.status = OrderStatus.READY_FOR_PICKUP;
        this.readyForPickupAt = Instant.now();
    }

    public void waitForDriver() {
        this.status = OrderStatus.WAITING_FOR_DRIVER;
    }

    public void assignDriver() {
        this.status = OrderStatus.DRIVER_ASSIGNED;
    }

    public void driverAccept() {
        this.status = OrderStatus.DRIVER_ACCEPTED;
    }

    public void markPickedUp() {
        this.status = OrderStatus.PICKED_UP;
        this.pickedUpAt = Instant.now();
    }

    public void markInTransit() {
        this.status = OrderStatus.IN_TRANSIT;
    }

    public void markOutForDelivery() {
        this.status = OrderStatus.OUT_FOR_DELIVERY;
    }

    public void markDelivered() {
        this.status = OrderStatus.DELIVERED;
        this.deliveredAt = Instant.now();
    }

    public void markPaymentCompleted() {
        this.status = OrderStatus.PAYMENT_COMPLETED;
    }

    public void markCompleted() {
        this.status = OrderStatus.COMPLETED;
        this.completedAt = Instant.now();
    }

    public void cancel() {
        this.status = OrderStatus.CANCELLED;
    }

    // === Helpers ===

    public BigDecimal getOutstandingAmount() {
        if (partialAmount != null && paidAmount != null) {
            return partialAmount.subtract(paidAmount);
        }
        return totalAmount.subtract(paidAmount);
    }

    public boolean isPartialPayment() {
        return paymentMode == OrderPaymentMode.PARTIAL && partialAmount != null;
    }

    public boolean isCod() {
        return paymentMode == OrderPaymentMode.COD;
    }

    public boolean isPayLater() {
        return paymentMode == OrderPaymentMode.PAY_LATER;
    }
}
