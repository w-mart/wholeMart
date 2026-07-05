package com.localb2b.marketplace.repository.retailer;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.localb2b.marketplace.entity.user.UserAccount;
import com.localb2b.marketplace.entity.retailer.RetailerProfile;

public interface RetailerProfileRepository extends JpaRepository<RetailerProfile, Long> {
    Optional<RetailerProfile> findByUser(UserAccount user);
}