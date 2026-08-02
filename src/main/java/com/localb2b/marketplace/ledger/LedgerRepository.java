package com.localb2b.marketplace.ledger;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface LedgerRepository extends JpaRepository<LedgerEntry, Long> {
    List<LedgerEntry> findByRetailerUserId(Long retailerUserId);

    List<LedgerEntry> findByDistributorUserId(Long distributorUserId);

    @Query("select coalesce(sum(l.amount), 0) from LedgerEntry l where l.distributorUserId = :distributorUserId")
    BigDecimal sumAmountByDistributorUserId(@Param("distributorUserId") Long distributorUserId);

    @Query("select coalesce(sum(l.amount), 0) from LedgerEntry l where l.distributorUserId = :distributorUserId and l.createdAt >= :start and l.createdAt < :end")
    BigDecimal sumAmountByDistributorUserIdBetween(
            @Param("distributorUserId") Long distributorUserId,
            @Param("start") Instant start,
            @Param("end") Instant end
    );

    @Query("select coalesce(sum(l.amount), 0) from LedgerEntry l where l.retailerUserId = :retailerUserId and l.type = 'DEBIT'")
    BigDecimal sumDebitsByRetailerUserId(@Param("retailerUserId") Long retailerUserId);

    @Query("select coalesce(sum(l.amount), 0) from LedgerEntry l where l.retailerUserId = :retailerUserId and l.type = 'CREDIT'")
    BigDecimal sumCreditsByRetailerUserId(@Param("retailerUserId") Long retailerUserId);

    @Query("select coalesce(sum(l.amount), 0) from LedgerEntry l where l.distributorUserId = :distributorUserId and l.type = 'DEBIT'")
    BigDecimal sumDebitsByDistributorUserId(@Param("distributorUserId") Long distributorUserId);

    @Query("select coalesce(sum(l.amount), 0) from LedgerEntry l where l.distributorUserId = :distributorUserId and l.type = 'CREDIT'")
    BigDecimal sumCreditsByDistributorUserId(@Param("distributorUserId") Long distributorUserId);

    @Query("select coalesce(sum(l.amount), 0) from LedgerEntry l where l.orderId = :orderId and l.type = 'DEBIT'")
    BigDecimal sumDebitsByOrderId(@Param("orderId") Long orderId);

    @Query("select coalesce(sum(l.amount), 0) from LedgerEntry l where l.orderId = :orderId and l.type = 'CREDIT'")
    BigDecimal sumCreditsByOrderId(@Param("orderId") Long orderId);

    List<LedgerEntry> findByDistributorUserIdAndRetailerUserIdOrderByCreatedAtDesc(Long distributorUserId, Long retailerUserId);
}
