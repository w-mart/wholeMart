package com.localb2b.marketplace.invoice;

import java.math.BigDecimal;
import java.time.Instant;

public record InvoiceDto(
        Long id,
        Long orderId,
        Long retailerUserId,
        Long distributorUserId,
        String invoiceNumber,
        BigDecimal totalAmount,
        BigDecimal gstAmount,
        BigDecimal paidAmount,
        BigDecimal outstandingAmount,
        String status,
        String pdfUrl,
        Instant generatedAt,
        Instant createdAt) {
}
