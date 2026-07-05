package com.localb2b.marketplace.payment;

import com.localb2b.marketplace.user.common.CurrentUser;
import com.localb2b.marketplace.user.common.CurrentUserProvider;
import com.localb2b.marketplace.common.Pageables;
import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.user.UserRole;
import java.util.Collection;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.data.domain.Page;

@RestController
@RequestMapping("/api/v1/payments")
public class PaymentApiController {
    private final PaymentRepository paymentRepository;
    private final OrderRepository orderRepository;
    private final CurrentUserProvider currentUserProvider;

    public PaymentApiController(PaymentRepository paymentRepository, OrderRepository orderRepository, CurrentUserProvider currentUserProvider) {
        this.paymentRepository = paymentRepository;
        this.orderRepository = orderRepository;
        this.currentUserProvider = currentUserProvider;
    }

    @GetMapping
    public org.springframework.data.domain.Page<PaymentDto> all(@RequestParam(defaultValue = "0") int page,
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
        return payments.map(p -> new PaymentDto(p.getId(), p.getOrderId(), p.getAmount(), p.getStatus(), p.getCreatedAt()));
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
