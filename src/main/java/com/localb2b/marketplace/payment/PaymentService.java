package com.localb2b.marketplace.payment;

import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderRepository;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PaymentService {
    private final PaymentRepository paymentRepository;
    private final OrderRepository orderRepository;
    public PaymentService(PaymentRepository paymentRepository, OrderRepository orderRepository) {
        this.paymentRepository = paymentRepository;
        this.orderRepository = orderRepository;
    }

    @Transactional
    public Payment initiatePayment(Long orderId, BigDecimal amount, String paymentMethod) {
        MarketplaceOrder order = orderRepository.findById(orderId).orElseThrow(() -> new IllegalArgumentException("Order not found"));
        Payment payment = new Payment(orderId, amount, PaymentStatus.INITIATED, paymentMethod, null);
        payment = paymentRepository.save(payment);
        if ("COD".equalsIgnoreCase(paymentMethod)) {
            payment.setStatus(PaymentStatus.AWAITING_COD_CONFIRMATION);
            payment = paymentRepository.save(payment);
        }
        return payment;
    }

    @Transactional
    public Payment confirmPayment(Long orderId, String paymentReference) {
        Payment payment = paymentRepository.findByOrderId(orderId).orElseThrow(() -> new IllegalArgumentException("No payment found for order: " + orderId));
        payment.setStatus(PaymentStatus.PAID);
        payment.setPaymentReference(paymentReference);
        payment = paymentRepository.save(payment);
        MarketplaceOrder order = orderRepository.findById(orderId).orElseThrow(() -> new IllegalArgumentException("Order not found"));
        order.setPaidAmount(order.getPaidAmount().add(payment.getAmount()));
        if (order.getPaidAmount().compareTo(order.getTotalAmount()) >= 0) {
            order.markPaymentCompleted();
        }
        orderRepository.save(order);
        return payment;
    }

    @Transactional
    public Payment confirmCodPayment(Long orderId, BigDecimal amount, String paymentReference) {
        Payment payment = paymentRepository.findByOrderId(orderId).orElseThrow(() -> new IllegalArgumentException("No payment found for order: " + orderId));
        payment.setStatus(PaymentStatus.PAID);
        payment.setAmount(amount);
        payment.setPaymentReference(paymentReference);
        payment = paymentRepository.save(payment);
        MarketplaceOrder order = orderRepository.findById(orderId).orElseThrow(() -> new IllegalArgumentException("Order not found"));
        order.setCodCollected(true);
        order.setCodCollectedAmount(amount);
        order.setPaidAmount(amount);
        orderRepository.save(order);
        return payment;
    }

    @Transactional(readOnly = true)
    public Optional<Payment> getPaymentByOrder(Long orderId) {
        return paymentRepository.findByOrderId(orderId);
    }

    @Transactional(readOnly = true)
    public List<Payment> getPaymentHistoryByOrder(Long orderId) {
        return paymentRepository.findByOrderIdOrderByCreatedAtDesc(orderId);
    }

    @Transactional(readOnly = true)
    public BigDecimal getTodayCollectedRevenue() {
        ZoneId zoneId = ZoneId.systemDefault();
        Instant start = LocalDate.now(zoneId).atStartOfDay(zoneId).toInstant();
        Instant end = LocalDate.now(zoneId).plusDays(1).atStartOfDay(zoneId).toInstant();
        BigDecimal revenue = paymentRepository.sumPaymentsBetween(start, end);
        return revenue == null ? BigDecimal.ZERO : revenue;
    }
}

