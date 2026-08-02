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
                                    boolean approved,
                                    String businessPan,
                                    String bankAccountNumber,
                                    String bankIfscCode,
                                    String bankName,
                                    String gstCertificateUrl,
                                    String shopImageUrl,
                                    String warehouseAddress,
                                    String warehouseCity,
                                    String warehouseState,
                                    String warehousePincode,
                                    BigDecimal warehouseLatitude,
                                    BigDecimal warehouseLongitude,
                                    String businessType,
                                    String website,
                                    String description) {
}
