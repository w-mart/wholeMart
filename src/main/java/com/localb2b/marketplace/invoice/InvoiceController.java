package com.localb2b.marketplace.invoice;

import com.localb2b.marketplace.common.CurrentUserProvider;
import com.localb2b.marketplace.common.Pageables;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/invoices")
public class InvoiceController {
    private final InvoiceService invoiceService;
    private final CurrentUserProvider currentUserProvider;

    public InvoiceController(InvoiceService invoiceService, CurrentUserProvider currentUserProvider) {
        this.invoiceService = invoiceService;
        this.currentUserProvider = currentUserProvider;
    }

    @PostMapping("/generate/{orderId}")
    public InvoiceDto generate(@PathVariable Long orderId) {
        Invoice invoice = invoiceService.generateInvoice(orderId);
        return toDto(invoice);
    }

    @GetMapping("/order/{orderId}")
    public InvoiceDto byOrder(@PathVariable Long orderId) {
        Invoice invoice = invoiceService.getInvoiceByOrder(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Invoice not found for order: " + orderId));
        return toDto(invoice);
    }

    @GetMapping("/{id}")
    public InvoiceDto get(@PathVariable Long id) {
        return invoiceService.getInvoiceById(id);
    }

    @GetMapping
    public Page<InvoiceDto> mine(@RequestParam(defaultValue = "0") int page,
                                 @RequestParam(defaultValue = "20") int size) {
        var pageable = Pageables.bounded(page, size);
        return invoiceService.getMyInvoices(currentUserProvider.requireCurrentUser(), pageable);
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
