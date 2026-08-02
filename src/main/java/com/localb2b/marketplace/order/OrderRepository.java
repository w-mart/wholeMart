package com.localb2b.marketplace.order;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<MarketplaceOrder, Long> {
    List<MarketplaceOrder> findByRetailerUserId(Long retailerUserId);
    List<MarketplaceOrder> findByDistributorUserId(Long distributorUserId);
    Page<MarketplaceOrder> findByRetailerUserId(Long retailerUserId, Pageable pageable);
    Page<MarketplaceOrder> findByDistributorUserId(Long distributorUserId, Pageable pageable);
    long countByDistributorUserIdAndStatus(Long distributorUserId, OrderStatus status);
    List<MarketplaceOrder> findByStatus(OrderStatus status);
    long countByRetailerUserIdAndStatus(Long retailerUserId, OrderStatus status);
    long countByStatus(OrderStatus status);
}
