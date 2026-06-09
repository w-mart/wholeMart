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
        this.contactName = valueOrCurrent(contactName, this.contactName);
        this.shopName = valueOrCurrent(shopName, this.shopName);
        this.gstin = valueOrCurrent(gstin, this.gstin);
        this.city = valueOrCurrent(city, this.city);
        this.state = valueOrCurrent(state, this.state);
        this.addressLine = valueOrCurrent(addressLine, this.addressLine);
        this.pincode = valueOrCurrent(pincode, this.pincode);
        this.email = valueOrCurrent(email, this.email);
        this.alternateMobile = valueOrCurrent(alternateMobile, this.alternateMobile);
    }

    private String valueOrCurrent(String nextValue, String currentValue) {
        return nextValue == null || nextValue.isBlank() ? currentValue : nextValue;
    }

    public void approve() {
        this.approved = true;
    }
}
