package com.localb2b.marketplace.users.entity;

import jakarta.persistence.*;
import lombok.*;

import com.localb2b.marketplace.users.entity.DriverProfile;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name="wm_vehicle")
public class Vehicle extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="driver_id")
    private DriverProfile driver;

    private String vehicleType;

    private String vehicleNumber;

    private String vehicleBrand;

    private Double maximumLoadKg;

    private Boolean active;

}