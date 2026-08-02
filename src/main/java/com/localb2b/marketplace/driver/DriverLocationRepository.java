package com.localb2b.marketplace.driver;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface DriverLocationRepository extends JpaRepository<DriverLocation, Long> {
    Optional<DriverLocation> findByDriverUserId(Long driverUserId);

    List<DriverLocation> findByIsOnlineTrueAndIsBusyFalse();

    @Query("SELECT dl FROM DriverLocation dl WHERE dl.isOnline = true AND dl.isBusy = false " +
           "AND dl.vehicleType = :vehicleType " +
           "ORDER BY dl.lastUpdatedAt DESC")
    List<DriverLocation> findAvailableByVehicleType(@Param("vehicleType") String vehicleType);
}
