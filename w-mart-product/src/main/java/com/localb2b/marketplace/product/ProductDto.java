package com.localb2b.marketplace.product;

import java.math.BigDecimal;

public record ProductDto(Long id, Long distributorUserId, String name, String category, BigDecimal unitPrice) {
}
