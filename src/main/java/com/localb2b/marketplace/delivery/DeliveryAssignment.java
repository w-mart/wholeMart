package com.localb2b.marketplace.delivery;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import lombok.Getter;

@Getter
@Entity
@Table(name = "delivery_assignments")
public class DeliveryAssignment extends BaseEntity {
    @Column(nullable = false)
    private Long orderId;

    @Column(nullable = false)
    private Long driverUserId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private DeliveryStatus status = DeliveryStatus.ASSIGNED;

    protected DeliveryAssignment() {
    }

    public DeliveryAssignment(Long orderId, Long driverUserId) {
        this.orderId = orderId;
        this.driverUserId = driverUserId;
    }

    public void updateStatus(DeliveryStatus status) {
        this.status = status;
    }
}
