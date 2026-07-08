package com.localb2b.marketplace.ledger;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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

    protected LedgerEntry() {
    }

    public LedgerEntry(Long retailerUserId, Long distributorUserId, BigDecimal amount, String reason) {
        this.retailerUserId = retailerUserId;
        this.distributorUserId = distributorUserId;
        this.amount = amount;
        this.reason = reason;
    }

}
