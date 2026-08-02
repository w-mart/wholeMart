package com.localb2b.marketplace.driver;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "driver_profiles")
public class DriverProfile extends BaseEntity {
    @Column(nullable = false, unique = true)
    private Long userId;

    @Column(nullable = false)
    private String displayName;

    private boolean approved;

    // KYC Fields
    private String licenseNumber;
    private String aadhaarNumber;
    private String panNumber;

    // Vehicle Details
    private String vehicleType;
    private String vehicleNumber;
    private String vehicleModel;
    private String vehicleColor;

    // Bank Details
    private String bankAccountNumber;
    private String bankIfscCode;
    private String bankName;
    private String upiId;

    // Earnings
    private BigDecimal totalEarnings = BigDecimal.ZERO;
    private BigDecimal todayEarnings = BigDecimal.ZERO;
    private Integer totalTrips = 0;

    // Address
    private String addressLine;
    private String city;
    private String state;
    private String pincode;

    private String profileImageUrl;

    protected DriverProfile() {
    }

    public DriverProfile(Long userId, String displayName) {
        this.userId = userId;
        this.displayName = displayName;
    }

    public void approve() {
        this.approved = true;
    }

    public void updateKyc(String licenseNumber, String aadhaarNumber, String panNumber) {
        if (licenseNumber != null && !licenseNumber.isBlank()) this.licenseNumber = licenseNumber;
        if (aadhaarNumber != null && !aadhaarNumber.isBlank()) this.aadhaarNumber = aadhaarNumber;
        if (panNumber != null && !panNumber.isBlank()) this.panNumber = panNumber;
    }

    public void updateVehicle(String vehicleType, String vehicleNumber, String vehicleModel, String vehicleColor) {
        if (vehicleType != null && !vehicleType.isBlank()) this.vehicleType = vehicleType;
        if (vehicleNumber != null && !vehicleNumber.isBlank()) this.vehicleNumber = vehicleNumber;
        if (vehicleModel != null && !vehicleModel.isBlank()) this.vehicleModel = vehicleModel;
        if (vehicleColor != null && !vehicleColor.isBlank()) this.vehicleColor = vehicleColor;
    }

    public void updateBankDetails(String bankAccountNumber, String bankIfscCode, String bankName, String upiId) {
        if (bankAccountNumber != null && !bankAccountNumber.isBlank()) this.bankAccountNumber = bankAccountNumber;
        if (bankIfscCode != null && !bankIfscCode.isBlank()) this.bankIfscCode = bankIfscCode;
        if (bankName != null && !bankName.isBlank()) this.bankName = bankName;
        if (upiId != null && !upiId.isBlank()) this.upiId = upiId;
    }

    public void addEarnings(BigDecimal amount) {
        if (amount != null) {
            this.totalEarnings = this.totalEarnings.add(amount);
            this.todayEarnings = this.todayEarnings.add(amount);
        }
    }

    public void incrementTrips() {
        this.totalTrips = (this.totalTrips == null ? 0 : this.totalTrips) + 1;
    }

    public void resetTodayEarnings() {
        this.todayEarnings = BigDecimal.ZERO;
    }
}
