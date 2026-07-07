package com.localb2b.marketplace.users.entity;

import com.localb2b.marketplace.users.enums.AccountStatus;
import com.localb2b.marketplace.users.enums.UserRole;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "wm_users")
public class User extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false,length = 100)
    private String firstName;

    @Column(length = 100)
    private String middleName;

    @Column(nullable = false,length = 100)
    private String lastName;

    @Column(nullable = false,unique = true,length = 15)
    private String mobileNumber;

    @Column(unique = true,length = 15)
    private String alternateMobileNumber;

    @Column(nullable = false,unique = true,length = 150)
    private String email;

    @Column(nullable = false)
    private String password;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false,length = 30)
    private UserRole role;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false,length = 30)
    private AccountStatus accountStatus;

    @Column(nullable = false)
    private Boolean mobileVerified=false;

    @Column(nullable = false)
    private Boolean emailVerified=false;

    @Column(nullable = false)
    private Boolean gstVerified=false;

    @Column(nullable = false)
    private Boolean kycVerified=false;

    private String profilePhoto;

    private LocalDateTime lastLogin;

    private Integer failedLoginAttempts;

    private Boolean accountLocked=false;

}