package com.localb2b.marketplace.order;

public enum OrderStatus {
    PLACED,
    ACCEPTED,
    REJECTED,
    PACKING,
    READY_FOR_PICKUP,
    WAITING_FOR_DRIVER,
    DRIVER_ASSIGNED,
    DRIVER_ACCEPTED,
    PICKED_UP,
    IN_TRANSIT,
    OUT_FOR_DELIVERY,
    DELIVERED,
    PAYMENT_COMPLETED,
    COMPLETED,
    CANCELLED
}
