package com.localb2b.marketplace.payment;

public enum PaymentStatus {
    INITIATED,
    AWAITING_COD_CONFIRMATION,
    PENDING,
    PAID,
    PARTIAL,
    REFUNDED
}
