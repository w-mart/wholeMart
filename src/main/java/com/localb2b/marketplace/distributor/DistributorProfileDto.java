package com.localb2b.marketplace.distributor;

import java.math.BigDecimal;

public record DistributorProfileDto(Long id,
                                    Long userId,
                                    String businessName,
                                    String contactName,
                                    String shopName,
                                    String gstin,
                                    String city,
                                    String state,
                                    String addressLine,
                                    String pincode,
                                    BigDecimal latitude,
                                    BigDecimal longitude,
                                    boolean approved) {
}
