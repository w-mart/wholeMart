package com.localb2b.marketplace.order;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import lombok.Getter;

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

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private OrderPaymentMode paymentMode;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private OrderStatus status = OrderStatus.PLACED;

    protected MarketplaceOrder() {
    }

    public MarketplaceOrder(Long retailerUserId, Long distributorUserId, BigDecimal totalAmount, OrderPaymentMode paymentMode) {
        this.retailerUserId = retailerUserId;
        this.distributorUserId = distributorUserId;
        this.totalAmount = totalAmount;
        this.paymentMode = paymentMode;
    }

    public void accept() {
        status = OrderStatus.ACCEPTED;
    }

    public void reject() {
        status = OrderStatus.REJECTED;
    }

    public void cancel() {
        status = OrderStatus.CANCELLED;
    }
}
