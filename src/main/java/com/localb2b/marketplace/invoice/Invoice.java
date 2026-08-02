package com.localb2b.marketplace.invoice;

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
@Table(name = "invoices")
public class Invoice extends BaseEntity {
    @Column(nullable = false)
    private Long orderId;

    @Column(nullable = false)
    private Long retailerUserId;

    @Column(nullable = false)
    private Long distributorUserId;

    @Column(nullable = false, unique = true)
    private String invoiceNumber;

    @Column(nullable = false, precision = 12, scale = 2)
    private BigDecimal totalAmount;

    @Column(precision = 12, scale = 2)
    private BigDecimal gstAmount;

    @Column(precision = 12, scale = 2)
    private BigDecimal paidAmount;

    @Column(precision = 12, scale = 2)
    private BigDecimal outstandingAmount;

    @Column(nullable = false)
    private String status;

    private String pdfUrl;

    @Column(columnDefinition = "text")
    private String invoiceJson;

    private Instant generatedAt;

    protected Invoice() {
    }

    public Invoice(Long orderId, Long retailerUserId, Long distributorUserId, String invoiceNumber, BigDecimal totalAmount) {
        this.orderId = orderId;
        this.retailerUserId = retailerUserId;
        this.distributorUserId = distributorUserId;
        this.invoiceNumber = invoiceNumber;
        this.totalAmount = totalAmount;
        this.status = "GENERATED";
        this.generatedAt = Instant.now();
    }
}
