package com.localb2b.marketplace.delivery;

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
@Setter
@Entity
@Table(name = "delivery_assignments")
public class DeliveryAssignment extends BaseEntity {
    @Column(nullable = false)
    private Long orderId;

    @Column(nullable = false)
    private Long driverUserId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DeliveryStatus status = DeliveryStatus.WAITING_FOR_DRIVER;

    private String pickupOtp;
    private String deliveryOtp;

    private Instant driverAcceptedAt;
    private Instant pickedUpAt;
    private Instant deliveredAt;

    private String rejectionReason;

    @Column(precision = 10, scale = 7)
    private BigDecimal pickupLatitude;

    @Column(precision = 10, scale = 7)
    private BigDecimal pickupLongitude;

    @Column(precision = 10, scale = 7)
    private BigDecimal deliveryLatitude;

    @Column(precision = 10, scale = 7)
    private BigDecimal deliveryLongitude;

    @Column(precision = 12, scale = 2)
    private BigDecimal deliveryFee = BigDecimal.ZERO;

    protected DeliveryAssignment() {
    }

    public DeliveryAssignment(Long orderId, Long driverUserId) {
        this.orderId = orderId;
        this.driverUserId = driverUserId;
        this.status = DeliveryStatus.ASSIGNED;
    }

    public void driverAccept() {
        this.status = DeliveryStatus.DRIVER_ACCEPTED;
        this.driverAcceptedAt = Instant.now();
    }

    public void driverReject(String reason) {
        this.status = DeliveryStatus.DRIVER_REJECTED;
        this.rejectionReason = reason;
    }

    public void markPickedUp() {
        this.status = DeliveryStatus.PICKED_UP;
        this.pickedUpAt = Instant.now();
    }

    public void markInTransit() {
        this.status = DeliveryStatus.IN_TRANSIT;
    }

    public void markOutForDelivery() {
        this.status = DeliveryStatus.OUT_FOR_DELIVERY;
    }

    public void markDelivered() {
        this.status = DeliveryStatus.DELIVERED;
        this.deliveredAt = Instant.now();
    }

    public void markFailed(String reason) {
        this.status = DeliveryStatus.FAILED;
        this.rejectionReason = reason;
    }
}
