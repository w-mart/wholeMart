package com.localb2b.marketplace.distributor;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import lombok.Getter;

@Getter
@Entity
@Table(name = "distributor_profiles")
public class DistributorProfile extends BaseEntity {
    @Column(nullable = false, unique = true)
    private Long userId;

    @Column(nullable = false)
    private String businessName;

    private String contactName;
    private String shopName;
    private String gstin;
    private String city;
    private String state;
    private String addressLine;
    private String pincode;
    private String email;
    private String alternateMobile;
    private BigDecimal latitude = BigDecimal.ZERO;
    private BigDecimal longitude = BigDecimal.ZERO;
    private boolean approved;

    protected DistributorProfile() {
    }

    public DistributorProfile(Long userId, String businessName) {
        this.userId = userId;
        this.businessName = businessName;
    }

    public DistributorProfile(Long userId, String businessName, BigDecimal latitude, BigDecimal longitude) {
        this.userId = userId;
        this.businessName = businessName;
        this.latitude = latitude == null ? BigDecimal.ZERO : latitude;
        this.longitude = longitude == null ? BigDecimal.ZERO : longitude;
    }

    public void updateProfile(String businessName, BigDecimal latitude, BigDecimal longitude) {
        if (businessName != null && !businessName.isBlank()) {
            this.businessName = businessName;
        }
        if (latitude != null) {
            this.latitude = latitude;
        }
        if (longitude != null) {
            this.longitude = longitude;
        }
    }

    public void updateProfile(String businessName,
                              String contactName,
                              String shopName,
                              String gstin,
                              String city,
                              String state,
                              String addressLine,
                              String pincode,
                              String email,
                              String alternateMobile,
                              BigDecimal latitude,
                              BigDecimal longitude) {
        updateProfile(businessName, latitude, longitude);
        this.contactName = valueOrCurrent(clean(contactName), this.contactName);
        this.shopName = valueOrCurrent(clean(shopName), this.shopName);
        this.gstin = valueOrCurrent(clean(gstin), this.gstin);
        this.city = valueOrCurrent(clean(city), this.city);
        this.state = valueOrCurrent(clean(state), this.state);
        this.addressLine = valueOrCurrent(clean(addressLine), this.addressLine);
        this.pincode = valueOrCurrent(clean(pincode), this.pincode);
        this.email = valueOrCurrent(clean(email), this.email);
        this.alternateMobile = valueOrCurrent(clean(alternateMobile), this.alternateMobile);
    }

    private String clean(String value) {
        if (value == null) {
            return null;
        }
        // Strip leading/trailing whitespace, then leading/trailing commas
        return value.trim().replaceAll("^,+|,+$", "").trim();
    }

    private String valueOrCurrent(String nextValue, String currentValue) {
        return nextValue == null || nextValue.isBlank() ? currentValue : nextValue;
    }

    public void approve() {
        this.approved = true;
    }
}
