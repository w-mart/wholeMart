package com.localb2b.marketplace.ai.dto;

public record DistributorOrderSummary(
        long waitingForReview,
        long readyForPacking,
        long completedDelivery
) {
}
