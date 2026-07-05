package com.localb2b.marketplace.inventory;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface InventoryRepository extends JpaRepository<InventoryItem, Long> {
    Optional<InventoryItem> findByProductId(Long productId);

    @Query("""
            select count(i)
            from InventoryItem i
            where i.productId in (
                select p.id
                from Product p
                where p.distributorUserId = :distributorUserId
            )
            and i.availableQuantity <= 5
            """)
    long countLowStockByDistributorUserId(@Param("distributorUserId") Long distributorUserId);

    default long countExpiredItemsByDistributorUserId(Long distributorUserId) {
        return 0;
    }
}
