package com.localb2b.marketplace.entity.driver;

import com.localb2b.marketplace.common.model.BaseEntity;
import com.localb2b.marketplace.entity.user.UserAccount;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "driver_profiles")
public class DriverProfile extends BaseEntity {

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private UserAccount user;

    private String aadhaar;

    private String licenseNumber;

    private LocalDate licenseExpiry;

    private String vehicleType;

    private String vehicleNumber;

    private LocalDate insuranceExpiry;

    private LocalDate joiningDate;

    private Integer experienceYears;

    @Column(precision = 10, scale = 7)
    private BigDecimal currentLocationLatitude;

    @Column(precision = 10, scale = 7)
    private BigDecimal currentLocationLongitude;

    private boolean available = false;

    private BigDecimal rating;

    private Integer completedDeliveries;

    private BigDecimal walletBalance;

    public DriverProfile() {
    }

    public DriverProfile(UserAccount user, String licenseNumber) {
        this.user = user;
        this.licenseNumber = licenseNumber;
    }

    public UserAccount getUser() {
        return user;
    }

    public void setUser(UserAccount user) {
        this.user = user;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
}