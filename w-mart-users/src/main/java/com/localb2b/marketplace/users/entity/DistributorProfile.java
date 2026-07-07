package com.localb2b.marketplace.users.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="wm_distributor_profile")
public class DistributorProfile extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;

    private Integer warehouseCapacity;

    private Boolean coldStorageAvailable;

    private Double minimumOrderValue;

    private Double freeDeliveryAboveAmount;

    private Boolean gstVerified;

}