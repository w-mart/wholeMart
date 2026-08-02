package com.localb2b.marketplace.ledger;

import java.math.BigDecimal;

public record DistributorLedgerSummary(
        BigDecimal capturedRevenue,
        BigDecimal paidOrders,
        BigDecimal paidReturns,
        BigDecimal totalOutstanding,
        BigDecimal openingBalance,
        BigDecimal closingBalance
) {
    public DistributorLedgerSummary {
        if (capturedRevenue == null) capturedRevenue = BigDecimal.ZERO;
        if (paidOrders == null) paidOrders = BigDecimal.ZERO;
        if (paidReturns == null) paidReturns = BigDecimal.ZERO;
        if (totalOutstanding == null) totalOutstanding = BigDecimal.ZERO;
        if (openingBalance == null) openingBalance = BigDecimal.ZERO;
        if (closingBalance == null) closingBalance = BigDecimal.ZERO;
    }
}

