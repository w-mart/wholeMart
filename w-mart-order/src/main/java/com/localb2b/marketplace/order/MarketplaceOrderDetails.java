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
    private OrderPaymentMode paymentMode;
    private OrderStatus status;
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
                                   OrderPaymentMode paymentMode,
                                   OrderStatus status,
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
        this.paymentMode = paymentMode;
        this.status = status;
        this.createdAt = createdAt;
        this.retailerName = retailerName;
        this.retailerLocation = retailerLocation;
        this.distributorShopName = distributorShopName;
        this.distributorBusinessName = distributorBusinessName;
        this.distributorAddress = distributorAddress;
        this.items = items == null ? List.of() : items;
    }

}
