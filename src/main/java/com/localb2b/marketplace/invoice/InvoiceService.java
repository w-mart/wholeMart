package com.localb2b.marketplace.invoice;

import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderItem;
import com.localb2b.marketplace.order.OrderItemRepository;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.order.OrderStatus;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class InvoiceService {
    private final InvoiceRepository invoiceRepository;
    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;

    public InvoiceService(InvoiceRepository invoiceRepository, OrderRepository orderRepository,
                          OrderItemRepository orderItemRepository) {
        this.invoiceRepository = invoiceRepository;
        this.orderRepository = orderRepository;
        this.orderItemRepository = orderItemRepository;
    }

    @Transactional
    public Invoice generateInvoice(Long orderId) {
        Optional<Invoice> existing = invoiceRepository.findByOrderId(orderId);
        if (existing.isPresent()) {
            return existing.get();
        }
        MarketplaceOrder order = orderRepository.findById(orderId).orElseThrow(() -> new IllegalArgumentException("Order not found: " + orderId));
        if (order.getStatus() != OrderStatus.COMPLETED && order.getStatus() != OrderStatus.PAYMENT_COMPLETED
                && order.getStatus() != OrderStatus.DELIVERED) {
            throw new IllegalStateException("Invoice can only be generated for completed/delivered orders");
        }
        String invoiceNumber = "INV-" + System.currentTimeMillis() + "-" + UUID.randomUUID().toString().substring(0, 6);
        List<OrderItem> items = orderItemRepository.findByOrderId(orderId);
        BigDecimal gstAmount = BigDecimal.ZERO;
        if (order.getTotalAmount().compareTo(BigDecimal.ZERO) > 0) {
            gstAmount = order.getTotalAmount().multiply(BigDecimal.valueOf(0.05));
        }
        Invoice invoice = new Invoice(orderId, order.getRetailerUserId(), order.getDistributorUserId(), invoiceNumber, order.getTotalAmount());
        invoice.setGstAmount(gstAmount);
        invoice.setPaidAmount(order.getPaidAmount());
        invoice.setOutstandingAmount(order.getOutstandingAmount());
        invoice.setGeneratedAt(Instant.now());
        invoice.setInvoiceJson(buildInvoiceJson(order, items));
        return invoiceRepository.save(invoice);
    }

    @Transactional(readOnly = true)
    public Optional<Invoice> getInvoiceByOrder(Long orderId) {
        return invoiceRepository.findByOrderId(orderId);
    }

    @Transactional(readOnly = true)
    public Page<InvoiceDto> getMyInvoices(CurrentUser currentUser, Pageable pageable) {
        Page<Invoice> invoices;
        switch (currentUser.role()) {
            case ROLE_DISTRIBUTOR:
                invoices = invoiceRepository.findByDistributorUserId(currentUser.userId(), pageable);
                break;
            case ROLE_RETAILER:
                invoices = invoiceRepository.findByRetailerUserId(currentUser.userId(), pageable);
                break;
            default:
                invoices = Page.empty(pageable);
        }
        return invoices.map(this::toDto);
    }

    @Transactional(readOnly = true)
    public InvoiceDto getInvoiceById(Long id) {
        Invoice invoice = invoiceRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invoice not found: " + id));
        return toDto(invoice);
    }

    private String buildInvoiceJson(MarketplaceOrder order, List<OrderItem> items) {
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"orderId\":").append(order.getId()).append(",");
        sb.append("\"totalAmount\":").append(order.getTotalAmount()).append(",");
        sb.append("\"paidAmount\":").append(order.getPaidAmount()).append(",");
        sb.append("\"items\":[");
        for (int i = 0; i < items.size(); i++) {
            OrderItem item = items.get(i);
            sb.append("{");
            sb.append("\"product\":\"").append(escape(item.getProductName())).append("\",");
            sb.append("\"sku\":\"").append(escape(item.getSku())).append("\",");
            sb.append("\"quantity\":").append(item.getQuantity()).append(",");
            sb.append("\"unitPrice\":").append(item.getUnitPrice()).append(",");
            sb.append("\"lineTotal\":").append(item.getLineTotal());
            sb.append("}");
            if (i < items.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]}");
        return sb.toString();
    }

    private String escape(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    private InvoiceDto toDto(Invoice invoice) {
        return new InvoiceDto(
                invoice.getId(),
                invoice.getOrderId(),
                invoice.getRetailerUserId(),
                invoice.getDistributorUserId(),
                invoice.getInvoiceNumber(),
                invoice.getTotalAmount(),
                invoice.getGstAmount(),
                invoice.getPaidAmount(),
                invoice.getOutstandingAmount(),
                invoice.getStatus(),
                invoice.getPdfUrl(),
                invoice.getGeneratedAt(),
                invoice.getCreatedAt());
    }
}
