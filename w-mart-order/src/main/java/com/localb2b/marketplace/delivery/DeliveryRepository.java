package com.localb2b.marketplace.delivery;

import java.util.Collection;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DeliveryRepository extends JpaRepository<DeliveryAssignment, Long> {
    List<DeliveryAssignment> findByDriverUserId(Long driverUserId);

    Page<DeliveryAssignment> findByDriverUserId(Long driverUserId, Pageable pageable);

    Page<DeliveryAssignment> findByOrderIdIn(Collection<Long> orderIds, Pageable pageable);
}
