package com.localb2b.marketplace.order;

import com.localb2b.marketplace.common.CurrentUserProvider;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/orders")
public class OrderApiController {
    private final OrderService orderService;
    private final CurrentUserProvider currentUserProvider;

    public OrderApiController(OrderService orderService, CurrentUserProvider currentUserProvider) {
        this.orderService = orderService;
        this.currentUserProvider = currentUserProvider;
    }

    @GetMapping
    public List<MarketplaceOrderDetails> myOrders() {
        return orderService.myOrders(currentUserProvider.requireCurrentUser());
    }

    @PostMapping
    public OrderDto place(@Valid @RequestBody PlaceOrderRequest request) {
        return toDto(orderService.placeOrder(currentUserProvider.requireCurrentUser(), request.distributorUserId(), request.paymentMode()));
    }

    @PostMapping("/{id}/accept")
    public OrderDto accept(@PathVariable Long id) {
        return toDto(orderService.accept(currentUserProvider.requireCurrentUser(), id));
    }

    public record PlaceOrderRequest(@NotNull Long distributorUserId, @NotNull OrderPaymentMode paymentMode) {
    }

    private OrderDto toDto(MarketplaceOrder order) {
        return new OrderDto(order.getId(), order.getRetailerUserId(), order.getDistributorUserId(),
                order.getTotalAmount(), order.getPaymentMode(), order.getStatus(), order.getCreatedAt());
    }
}
