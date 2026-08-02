package com.localb2b.marketplace.driver;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.Instant;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "driver_locations")
public class DriverLocation extends BaseEntity {
    @Column(nullable = false, unique = true)
    private Long driverUserId;

    @Column(nullable = false, precision = 10, scale = 7)
    private BigDecimal latitude;

    @Column(nullable = false, precision = 10, scale = 7)
    private BigDecimal longitude;

    @Column(nullable = false)
    private boolean isOnline = false;

    @Column(nullable = false)
    private boolean isBusy = false;

    private String vehicleType;

    @Column(nullable = false)
    private Instant lastUpdatedAt;

    protected DriverLocation() {
    }

    public DriverLocation(Long driverUserId, BigDecimal latitude, BigDecimal longitude, String vehicleType) {
        this.driverUserId = driverUserId;
        this.latitude = latitude;
        this.longitude = longitude;
        this.vehicleType = vehicleType;
        this.isOnline = true;
        this.isBusy = false;
        this.lastUpdatedAt = Instant.now();
    }

    public void goOnline(BigDecimal latitude, BigDecimal longitude) {
        this.isOnline = true;
        this.latitude = latitude;
        this.longitude = longitude;
        this.lastUpdatedAt = Instant.now();
    }

    public void goOffline() {
        this.isOnline = false;
        this.isBusy = false;
        this.lastUpdatedAt = Instant.now();
    }

    public void updateLocation(BigDecimal latitude, BigDecimal longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.lastUpdatedAt = Instant.now();
    }

    public void markBusy() {
        this.isBusy = true;
    }

    public void markAvailable() {
        this.isBusy = false;
    }
}
