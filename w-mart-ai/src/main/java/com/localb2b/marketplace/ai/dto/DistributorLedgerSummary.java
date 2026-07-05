package com.localb2b.marketplace.ai.dto;

import java.math.BigDecimal;

public record DistributorLedgerSummary(
        BigDecimal capturedRevenue,
        BigDecimal pendingSettlements,
        BigDecimal overdueDues
) {
}
