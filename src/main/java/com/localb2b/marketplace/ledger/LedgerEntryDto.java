package com.localb2b.marketplace.ledger;

import java.math.BigDecimal;
import java.time.Instant;

public record LedgerEntryDto(Long id,
                             Long retailerUserId,
                             Long distributorUserId,
                             BigDecimal amount,
                             String reason,
                             Instant createdAt) {
}
