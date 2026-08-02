package com.localb2b.marketplace.driver;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface DriverProfileRepository extends JpaRepository<DriverProfile, Long> {
    Optional<DriverProfile> findByUserId(Long userId);

    List<DriverProfile> findByApprovedFalse();

    List<DriverProfile> findByApprovedTrue();

    @Query("SELECT d FROM DriverProfile d WHERE d.approved = true AND d.vehicleType IN :vehicleTypes")
    List<DriverProfile> findAvailableDriversByVehicleTypes(@Param("vehicleTypes") List<String> vehicleTypes);

    @Query("SELECT d FROM DriverProfile d WHERE d.approved = true AND d.vehicleType = :vehicleType")
    List<DriverProfile> findAvailableDriversByVehicleType(@Param("vehicleType") String vehicleType);
}
