package com.localb2b.marketplace.entity.distributor;

import com.localb2b.marketplace.common.model.BaseEntity;
import com.localb2b.marketplace.entity.user.UserAccount;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "distributor_profiles")
public class DistributorProfile extends BaseEntity {

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private UserAccount user;

    private String companyName;

    private String gstNo;

    private String panNo;

    private String licenseNo;

    private Integer warehouseArea;

    private Integer employeeCount;

    private BigDecimal annualTurnover;

    private BigDecimal minimumOrderValue;

    private BigDecimal creditLimit;

    private BigDecimal rating;

    private String verificationStatus;

    private Long approvedBy;

    private LocalDateTime approvedAt;

    private Integer deliveryRadius;

    private Integer vehicleCount;

    @Column(precision = 10, scale = 7)
    private BigDecimal warehouseLatitude;

    @Column(precision = 10, scale = 7)
    private BigDecimal warehouseLongitude;

    public DistributorProfile() {
    }

    public DistributorProfile(UserAccount user, String companyName) {
        this.user = user;
        this.companyName = companyName;
    }

    public UserAccount getUser() {
        return user;
    }

    public void setUser(UserAccount user) {
        this.user = user;
    }

    public String getVerificationStatus() {
        return verificationStatus;
    }

    public void setVerificationStatus(String verificationStatus) {
        this.verificationStatus = verificationStatus;
    }

    public Long getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(Long approvedBy) {
        this.approvedBy = approvedBy;
    }

    public LocalDateTime getApprovedAt() {
        return approvedAt;
    }

    public void setApprovedAt(LocalDateTime approvedAt) {
        this.approvedAt = approvedAt;
    }
}