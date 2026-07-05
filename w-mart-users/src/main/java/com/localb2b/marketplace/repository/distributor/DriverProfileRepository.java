package com.localb2b.marketplace.repository.distributor;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.localb2b.marketplace.entity.user.UserAccount;
import com.localb2b.marketplace.entity.driver.DriverProfile;

public interface DriverProfileRepository extends JpaRepository<DriverProfile, Long> {
    Optional<DriverProfile> findByUser(UserAccount user);
}