package com.localb2b.marketplace.product;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByDistributorUserId(Long distributorUserId);

    List<Product> findByDistributorUserIdAndNameContainingIgnoreCase(Long distributorUserId, String query);

    List<Product> findByNameContainingIgnoreCase(String query);

    Page<Product> findAll(Pageable pageable);

    Page<Product> findByNameContainingIgnoreCase(String query, Pageable pageable);

    Page<Product> findByDistributorUserId(Long distributorUserId, Pageable pageable);

    Page<Product> findByDistributorUserIdAndNameContainingIgnoreCase(Long distributorUserId, String query, Pageable pageable);

    long countByDistributorUserId(Long distributorUserId);
}
