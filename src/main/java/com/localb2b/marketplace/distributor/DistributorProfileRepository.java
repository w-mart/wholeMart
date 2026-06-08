package com.localb2b.marketplace.distributor;

import java.util.List;
import java.util.Optional;
import java.util.Collection;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DistributorProfileRepository extends JpaRepository<DistributorProfile, Long> {
    Optional<DistributorProfile> findByUserId(Long userId);

    List<DistributorProfile> findByUserIdIn(Collection<Long> userIds);

    List<DistributorProfile> findByApprovedTrue();

    org.springframework.data.domain.Page<DistributorProfile> findByApprovedTrue(org.springframework.data.domain.Pageable pageable);
}
