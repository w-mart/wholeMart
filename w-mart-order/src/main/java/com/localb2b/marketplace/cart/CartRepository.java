package com.localb2b.marketplace.cart;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CartRepository extends JpaRepository<CartItem, Long> {
    List<CartItem> findByRetailerUserId(Long retailerUserId);

    Optional<CartItem> findByRetailerUserIdAndProductId(Long retailerUserId, Long productId);

    void deleteByRetailerUserId(Long retailerUserId);
}
