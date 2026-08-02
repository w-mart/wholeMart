package com.localb2b.marketplace.invoice;

import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InvoiceRepository extends JpaRepository<Invoice, Long> {
    Optional<Invoice> findByOrderId(Long orderId);
    List<Invoice> findByRetailerUserId(Long retailerUserId);
    List<Invoice> findByDistributorUserId(Long distributorUserId);
    Page<Invoice> findByRetailerUserId(Long retailerUserId, Pageable pageable);
    Page<Invoice> findByDistributorUserId(Long distributorUserId, Pageable pageable);
    Optional<Invoice> findByInvoiceNumber(String invoiceNumber);
}
