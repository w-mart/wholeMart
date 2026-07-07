package com.localb2b.marketplace.users.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="wm_address")
public class Address extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;

    private String country;

    private String state;

    private String district;

    private String city;

    private String area;

    private String locality;

    private String landmark;

    private String pinCode;

    private String addressLine1;

    private String addressLine2;

    private Double latitude;

    private Double longitude;

    private Boolean defaultAddress;
}