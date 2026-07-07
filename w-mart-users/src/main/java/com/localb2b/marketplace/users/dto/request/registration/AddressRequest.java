package com.localb2b.marketplace.users.dto.request.registration;

import lombok.Data;

@Data
public class AddressRequest {
    private String country;

    private String state;

    private String district;

    private String city;

    private String area;

    private String locality;

    private String landmark;

    private String pinCode;

    private String addressLine1;

    private String addressLine2;
}