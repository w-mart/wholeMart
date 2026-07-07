package com.localb2b.marketplace.users.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="wm_driver_profile")
public class DriverProfile extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;

    private String licenseNumber;

    private String aadhaarNumber;

    private String panNumber;

    private Boolean policeVerificationCompleted;

    private Integer experienceYears;

}