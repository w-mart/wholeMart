package com.localb2b.marketplace.entity.user;

import com.localb2b.marketplace.common.model.BaseEntity;
import com.localb2b.marketplace.enums.UserStatus;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "user_accounts", uniqueConstraints = {
    @UniqueConstraint(columnNames = "username"),
    @UniqueConstraint(columnNames = "email"),
    @UniqueConstraint(columnNames = "mobile")
})
public class UserAccount extends BaseEntity {

    @Column(nullable = false, updatable = false, unique = true)
    private UUID uuid = UUID.randomUUID();

    @NotBlank
    @Size(max = 50)
    private String firstName;

    @Size(max = 50)
    private String middleName;

    @NotBlank
    @Size(max = 50)
    private String lastName;

    @Size(max = 10)
    private String gender;

    private LocalDate dob;

    @NotBlank
    @Size(max = 50)
    @Column(nullable = false, unique = true)
    private String username;

    @NotBlank
    @Size(max = 128)
    @Column(nullable = false)
    private String password;

    @Email
    @Size(max = 100)
    @Column(nullable = false, unique = true)
    private String email;

    @NotBlank
    @Size(max = 20)
    @Column(nullable = false, unique = true)
    private String mobile;

    @Size(max = 20)
    private String alternateMobile;

    @Size(max = 255)
    private String profileImage;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private UserRole role;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserStatus status = UserStatus.PENDING;

    @Column(nullable = false)
    private boolean emailVerified = false;

    @Column(nullable = false)
    private boolean mobileVerified = false;

    @Column(nullable = false)
    private boolean twoFactorEnabled = false;

    private int failedLoginAttempts = 0;

    private LocalDateTime lastLoginTime;

    @Size(max = 45)
    private String lastLoginIp;

    @Column(nullable = false)
    private boolean deleted = false;

    public UUID getUuid() {
        return uuid;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public UserStatus getStatus() {
        return status;
    }

    public void setStatus(UserStatus status) {
        this.status = status;
    }
}