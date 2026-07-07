package com.localb2b.marketplace.users.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "wm_retailer_profile")
public class RetailerProfile extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;

    private Integer dailyCustomers;

    private Double averageDailyPurchase;

    private Boolean homeDeliveryRequired;

    private Boolean creditRequired;

    private String preferredDeliveryTime;

}