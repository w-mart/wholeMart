package com.localb2b.marketplace.users.entity;

import com.localb2b.marketplace.users.enums.BusinessType;
import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "wm_business_profile")
public class BusinessProfile extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false,length = 200)
    private String businessName;

    @Column(length = 200)
    private String shopName;

    @Enumerated(EnumType.STRING)
    private BusinessType businessType;

    @Column(unique = true,length = 15)
    private String gstin;

    @Column(length = 10)
    private String panNumber;

    @Column(length = 20)
    private String fssaiNumber;

    @Column(length = 30)
    private String udyamRegistrationNumber;

    private Integer establishmentYear;

    private Integer employeeCount;

    private Double monthlyTurnover;

    private Double deliveryRadiusKm;

    private Double minimumOrderAmount;

    @Column(length = 500)
    private String businessDescription;

}