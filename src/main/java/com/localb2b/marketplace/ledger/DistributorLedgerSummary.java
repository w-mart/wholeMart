package com.localb2b.marketplace.ledger;

import java.math.BigDecimal;

public record DistributorLedgerSummary(
        BigDecimal capturedRevenue,
        BigDecimal paidOrders,
        BigDecimal paidReturns
) {
}

