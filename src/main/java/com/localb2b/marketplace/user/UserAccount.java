package com.localb2b.marketplace.user;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import lombok.Getter;

@Getter
@Entity
@Table(name = "users")
public class UserAccount extends BaseEntity {
    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true, length = 20)
    private String mobile;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 40)
    private UserRole role;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 40)
    private UserStatus status = UserStatus.ACTIVE;

    protected UserAccount() {
    }

    public UserAccount(String name, String mobile, UserRole role) {
        this.name = name;
        this.mobile = mobile;
        this.role = role;
    }

    public void updateLoginProfile(String name) {
        if (name != null && !name.isBlank()) {
            this.name = name;
        }
    }

    public void suspend() {
        this.status = UserStatus.SUSPENDED;
    }

    public void approve() {
        this.status = UserStatus.ACTIVE;
    }
}
