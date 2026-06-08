package com.localb2b.marketplace.ledger;

import java.math.BigDecimal;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface LedgerRepository extends JpaRepository<LedgerEntry, Long> {
    List<LedgerEntry> findByRetailerUserId(Long retailerUserId);

    List<LedgerEntry> findByDistributorUserId(Long distributorUserId);

    @Query("""
            select coalesce(sum(l.amount), 0)
            from LedgerEntry l
            where l.distributorUserId = :distributorUserId
            """)
    BigDecimal sumAmountByDistributorUserId(@Param("distributorUserId") Long distributorUserId);
}
