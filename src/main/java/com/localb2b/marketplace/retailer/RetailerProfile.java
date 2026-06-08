package com.localb2b.marketplace.retailer;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.math.BigDecimal;

@Entity
@Table(name = "retailer_profiles")
public class RetailerProfile extends BaseEntity {
    @Column(nullable = false, unique = true)
    private Long userId;

    @Column(nullable = false)
    private String shopName;

    private String city;
    private String state;
    private String addressLine;
    private String pincode;
    private BigDecimal latitude = BigDecimal.ZERO;
    private BigDecimal longitude = BigDecimal.ZERO;

    protected RetailerProfile() {
    }

    public RetailerProfile(Long userId, String shopName) {
        this.userId = userId;
        this.shopName = shopName;
    }

    public Long getUserId() {
        return userId;
    }

    public String getShopName() {
        return shopName;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public String getPincode() {
        return pincode;
    }

    public BigDecimal getLatitude() {
        return latitude;
    }

    public BigDecimal getLongitude() {
        return longitude;
    }

    public void updateProfile(String shopName,
                              String city,
                              String state,
                              String addressLine,
                              String pincode,
                              BigDecimal latitude,
                              BigDecimal longitude) {
        if (shopName != null && !shopName.isBlank()) {
            this.shopName = shopName;
        }
        this.city = valueOrCurrent(city, this.city);
        this.state = valueOrCurrent(state, this.state);
        this.addressLine = valueOrCurrent(addressLine, this.addressLine);
        this.pincode = valueOrCurrent(pincode, this.pincode);
        if (latitude != null) {
            this.latitude = latitude;
        }
        if (longitude != null) {
            this.longitude = longitude;
        }
    }

    private String valueOrCurrent(String nextValue, String currentValue) {
        return nextValue == null || nextValue.isBlank() ? currentValue : nextValue;
    }
}
