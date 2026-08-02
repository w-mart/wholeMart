package com.localb2b.marketplace.distributor;

public record DistributorDto(Long id, Long userId, String businessName, boolean approved, String gstin) {
}
