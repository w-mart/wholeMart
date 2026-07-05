package com.localb2b.marketplace.entity.admin;

import com.localb2b.marketplace.common.model.BaseEntity;
import com.localb2b.marketplace.entity.user.UserAccount;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.time.LocalDate;

@Entity
@Table(name = "admin_profiles")
public class AdminProfile extends BaseEntity {

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private UserAccount user;

    private String designation;

    private String department;

    private String permissions;

    private LocalDate joiningDate;

    public AdminProfile() {
    }

    public AdminProfile(UserAccount user, String designation) {
        this.user = user;
        this.designation = designation;
    }

    public UserAccount getUser() {
        return user;
    }

    public void setUser(UserAccount user) {
        this.user = user;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
}