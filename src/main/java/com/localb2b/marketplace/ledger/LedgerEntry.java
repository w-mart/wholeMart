package com.localb2b.marketplace.ledger;

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
@Table(name = "ledger_entries")
public class LedgerEntry extends BaseEntity {
    @Column(nullable = false)
    private Long retailerUserId;

    @Column(nullable = false)
    private Long distributorUserId;

    @Column(nullable = false, precision = 12, scale = 2)
    private BigDecimal amount;

    @Column(nullable = false)
    private String reason;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private LedgerEntryType type;

    private Long orderId;

    @Column(precision = 12, scale = 2)
    private BigDecimal balanceAfter;

    protected LedgerEntry() {
    }

    public LedgerEntry(Long retailerUserId, Long distributorUserId, BigDecimal amount, String reason) {
        this.retailerUserId = retailerUserId;
        this.distributorUserId = distributorUserId;
        this.amount = amount;
        this.reason = reason;
        this.type = LedgerEntryType.CREDIT;
    }

    public LedgerEntry(Long retailerUserId, Long distributorUserId, BigDecimal amount, String reason,
                       LedgerEntryType type, Long orderId, BigDecimal balanceAfter) {
        this.retailerUserId = retailerUserId;
        this.distributorUserId = distributorUserId;
        this.amount = amount;
        this.reason = reason;
        this.type = type;
        this.orderId = orderId;
        this.balanceAfter = balanceAfter;
    }

}
