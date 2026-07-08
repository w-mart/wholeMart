package com.localb2b.marketplace.retailer;

import java.util.Collection;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RetailerProfileRepository extends JpaRepository<RetailerProfile, Long> {
    Optional<RetailerProfile> findByUserId(Long userId);
    List<RetailerProfile> findByUserIdIn(Collection<Long> userIds);
}
