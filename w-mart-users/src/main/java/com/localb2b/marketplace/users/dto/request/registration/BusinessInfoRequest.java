package com.localb2b.marketplace.users.dto.request.registration;

import com.localb2b.marketplace.users.enums.BusinessType;
import lombok.Data;

@Data
public class BusinessInfoRequest {
    private String businessName;
    private String shopName;
    private BusinessType businessType;
    private String gstin;
    private String panNumber;
}
