package com.localb2b.marketplace.payment;

import java.math.BigDecimal;
import java.time.Instant;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
    Page<Payment> findByOrderIdIn(Collection<Long> orderIds, Pageable pageable);
    Optional<Payment> findByOrderId(Long orderId);
    List<Payment> findByOrderIdOrderByCreatedAtDesc(Long orderId);

    @Query("select coalesce(sum(p.amount), 0) from Payment p where p.status = 'PAID'")
    BigDecimal sumPaidAmount();

    @Query("select coalesce(sum(p.amount), 0) from Payment p where p.createdAt >= :start and p.createdAt < :end")
    BigDecimal sumPaymentsBetween(@Param("start") Instant start, @Param("end") Instant end);
}
