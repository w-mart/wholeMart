package com.localb2b.marketplace.entity.retailer;

import com.localb2b.marketplace.common.model.BaseEntity;
import com.localb2b.marketplace.entity.user.UserAccount;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "retailer_profiles")
public class RetailerProfile extends BaseEntity {

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private UserAccount user;

    private String shopName;

    private String shopType;

    private String gstNo;

    private String panNo;

    private String fssaiNo;

    private Integer shopAreaSqFt;

    private Integer dailyCustomers;

    private BigDecimal monthlyRevenue;

    private LocalDate businessSince;

    private BigDecimal creditLimit;

    private Long preferredDistributor;

    private String preferredPaymentMethod;

    private String deliveryPreference;

    private String shopTiming;

    private BigDecimal rating;

    private boolean verified = false;

    public RetailerProfile() {
    }

    public RetailerProfile(UserAccount user, String shopName) {
        this.user = user;
        this.shopName = shopName;
    }

    public UserAccount getUser() {
        return user;
    }

    public void setUser(UserAccount user) {
        this.user = user;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }
}