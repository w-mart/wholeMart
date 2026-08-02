package com.localb2b.marketplace.order;

import com.localb2b.marketplace.common.CurrentUserProvider;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    @GetMapping("/{id}")
    public MarketplaceOrderDetails getOrder(@PathVariable Long id) {
        return orderService.getOrderDetails(id, currentUserProvider.requireCurrentUser());
    }

    @PostMapping
    public OrderDto place(@Valid @RequestBody PlaceOrderRequest request) {
        return toDto(orderService.placeOrder(
            currentUserProvider.requireCurrentUser(),
            request.distributorUserId(),
            request.paymentMode(),
            request.partialAmount()));
    }


    // ===== DISTRIBUTOR ACTIONS =====
    @PostMapping("/{id}/accept")
    public OrderDto accept(@PathVariable Long id) {
        return toDto(orderService.acceptOrder(currentUserProvider.requireCurrentUser(), id));
    }

    @PostMapping("/{id}/reject")
    public OrderDto reject(@PathVariable Long id, @RequestParam(required = false) String reason) {
        return toDto(orderService.rejectOrder(currentUserProvider.requireCurrentUser(), id, reason));
    }

    @PostMapping("/{id}/start-packing")
    public OrderDto startPacking(@PathVariable Long id) {
        return toDto(orderService.startPacking(currentUserProvider.requireCurrentUser(), id));
    }

    @PostMapping("/{id}/ready-for-pickup")
    public OrderDto markReadyForPickup(@PathVariable Long id) {
        return toDto(orderService.markReadyForPickup(currentUserProvider.requireCurrentUser(), id));
    }


    // ===== DRIVER ACTIONS =====
    @PostMapping("/{id}/assign-driver")
    public OrderDto assignDriver(@PathVariable Long id, @RequestParam Long driverUserId) {
        return toDto(orderService.assignDriver(id, driverUserId));
    }

    @PostMapping("/{id}/driver-accept")
    public OrderDto driverAccept(@PathVariable Long id) {
        return toDto(orderService.driverAcceptOrder(id));
    }

    @PostMapping("/{id}/verify-pickup-otp")
    public OrderDto verifyPickupOtp(@PathVariable Long id, @RequestParam String otp) {
        return toDto(orderService.verifyPickupOtpAndPickup(id, otp));
    }

    @PostMapping("/{id}/verify-delivery-otp")
    public OrderDto verifyDeliveryOtp(@PathVariable Long id, @RequestParam String otp) {
        return toDto(orderService.verifyDeliveryOtpAndDeliver(id, otp));
    }


    // ===== PAYMENT ACTIONS =====
    @PostMapping("/{id}/record-payment")
    public OrderDto recordPayment(@PathVariable Long id, @RequestParam BigDecimal amount) {
        return toDto(orderService.recordPayment(currentUserProvider.requireCurrentUser(), id, amount));
    }

    @PostMapping("/{id}/collect-cod")
    public OrderDto collectCod(@PathVariable Long id, @RequestParam BigDecimal amount) {
        return toDto(orderService.collectCodPayment(currentUserProvider.requireCurrentUser(), id, amount));
    }

    @PostMapping("/{id}/complete")
    public OrderDto complete(@PathVariable Long id) {
        return toDto(orderService.completeOrder(currentUserProvider.requireCurrentUser(), id));
    }

    @PostMapping("/{id}/cancel")
    public OrderDto cancel(@PathVariable Long id) {
        return toDto(orderService.cancelOrder(currentUserProvider.requireCurrentUser(), id));
    }

    public record PlaceOrderRequest(
            @NotNull Long distributorUserId,
            @NotNull OrderPaymentMode paymentMode,
            BigDecimal partialAmount) {
    }

    private OrderDto toDto(MarketplaceOrder order) {
        return new OrderDto(
                order.getId(),
                order.getRetailerUserId(),
                order.getDistributorUserId(),
                order.getTotalAmount(),
                order.getPartialAmount(),
                order.getPaidAmount(),
                order.getPaymentMode(),
                order.getStatus(),
                order.getDeliveryAddress(),
                order.getDeliverySlot(),
                order.getDeliveryPincode(),
                order.getPickupOtp(),
                order.getDeliveryOtp(),
                order.getRejectionReason(),
                order.getDistributorNotes(),
                order.getCodCollected(),
                order.getCodCollectedAmount(),
                order.getPackedAt(),
                order.getReadyForPickupAt(),
                order.getPickedUpAt(),
                order.getDeliveredAt(),
                order.getCompletedAt(),
                order.getCreatedAt());
    }
}
