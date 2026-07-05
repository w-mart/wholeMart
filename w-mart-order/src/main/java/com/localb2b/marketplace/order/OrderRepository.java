package com.localb2b.marketplace.order;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<MarketplaceOrder, Long> {
    List<MarketplaceOrder> findByRetailerUserId(Long retailerUserId);

    List<MarketplaceOrder> findByDistributorUserId(Long distributorUserId);

    long countByDistributorUserIdAndStatus(Long distributorUserId, OrderStatus status);
}
