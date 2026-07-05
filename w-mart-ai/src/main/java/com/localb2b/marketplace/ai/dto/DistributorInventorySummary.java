package com.localb2b.marketplace.ai.dto;

public record DistributorInventorySummary(
        long totalItems,
        long lowStockItems,
        long expiredItems
) {
}
