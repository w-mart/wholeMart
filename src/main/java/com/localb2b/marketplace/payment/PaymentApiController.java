package com.localb2b.marketplace.payment;

import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.common.CurrentUserProvider;
import com.localb2b.marketplace.common.Pageables;
import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
import java.util.Collection;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.data.domain.Page;

@RestController
@RequestMapping("/api/v1/payments")
public class PaymentApiController {
    private final PaymentService paymentService;
    private final PaymentRepository paymentRepository;
    private final OrderRepository orderRepository;
    private final CurrentUserProvider currentUserProvider;

    public PaymentApiController(PaymentService paymentService, PaymentRepository paymentRepository,
            OrderRepository orderRepository, CurrentUserProvider currentUserProvider) {
        this.paymentService = paymentService;
        this.paymentRepository = paymentRepository;
        this.orderRepository = orderRepository;
        this.currentUserProvider = currentUserProvider;
    }

    @GetMapping
    public Page<PaymentDto> all(@RequestParam(defaultValue = "0") int page,
                                @RequestParam(defaultValue = "20") int size) {
        var pageable = Pageables.bounded(page, size);
        CurrentUser currentUser = currentUserProvider.requireCurrentUser();
        Page<Payment> payments;
        if (currentUser.role() == UserRole.ROLE_ADMIN) {
            payments = paymentRepository.findAll(pageable);
        } else {
            Collection<Long> orderIds = scopedOrderIds(currentUser);
            payments = orderIds.isEmpty() ? Page.empty(pageable) : paymentRepository.findByOrderIdIn(orderIds, pageable);
        }
        return payments.map(this::toDto);
    }

    @PostMapping("/orders/{orderId}/initiate")
    public PaymentDto initiatePayment(@PathVariable Long orderId,
                                      @RequestParam BigDecimal amount,
                                      @RequestParam String paymentMethod) {
        Payment payment = paymentService.initiatePayment(orderId, amount, paymentMethod);
        return toDto(payment);
    }

    @PostMapping("/orders/{orderId}/confirm")
    public PaymentDto confirmPayment(@PathVariable Long orderId,
                                     @RequestParam String paymentReference) {
        Payment payment = paymentService.confirmPayment(orderId, paymentReference);
        return toDto(payment);
    }

    @PostMapping("/orders/{orderId}/cod-confirm")
    public PaymentDto confirmCodPayment(@PathVariable Long orderId,
                                        @RequestParam BigDecimal amount,
                                        @RequestParam String paymentReference) {
        Payment payment = paymentService.confirmCodPayment(orderId, amount, paymentReference);
        return toDto(payment);
    }

    @GetMapping("/orders/{orderId}")
    public PaymentDto getByOrder(@PathVariable Long orderId) {
        Payment payment = paymentService.getPaymentByOrder(orderId).orElseThrow(() -> new IllegalArgumentException("Payment not found for order: " + orderId));
        return toDto(payment);
    }

    private PaymentDto toDto(Payment p) {
        return new PaymentDto(p.getId(), p.getOrderId(), p.getAmount(), p.getStatus(), p.getPaymentMethod(), p.getPaymentReference(), p.getCreatedAt());
    }

    private Collection<Long> scopedOrderIds(CurrentUser currentUser) {
        if (currentUser.role() == UserRole.ROLE_DISTRIBUTOR) {
            return orderRepository.findByDistributorUserId(currentUser.userId()).stream()
                    .map(MarketplaceOrder::getId)
                    .toList();
        }
        return orderRepository.findByRetailerUserId(currentUser.userId()).stream()
                .map(MarketplaceOrder::getId)
                .toList();
    }
}
