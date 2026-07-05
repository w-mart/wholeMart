package com.localb2b.marketplace.delivery;

import com.localb2b.marketplace.user.common.CurrentUser;
import com.localb2b.marketplace.user.common.CurrentUserProvider;
import com.localb2b.marketplace.common.Pageables;
import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.user.UserRole;
import java.util.Collection;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/deliveries")
public class DeliveryApiController {
    private final DeliveryRepository deliveryRepository;
    private final CurrentUserProvider currentUserProvider;
    private final OrderRepository orderRepository;

    public DeliveryApiController(DeliveryRepository deliveryRepository, CurrentUserProvider currentUserProvider, OrderRepository orderRepository) {
        this.deliveryRepository = deliveryRepository;
        this.currentUserProvider = currentUserProvider;
        this.orderRepository = orderRepository;
    }

    @GetMapping
    public org.springframework.data.domain.Page<DeliveryDto> mine(@RequestParam(defaultValue = "0") int page,
                                                                   @RequestParam(defaultValue = "20") int size) {
        CurrentUser currentUser = currentUserProvider.requireCurrentUser();
        var pageable = Pageables.bounded(page, size);
        if (currentUser.role() == UserRole.ROLE_DRIVER) {
            return deliveryRepository.findByDriverUserId(currentUser.userId(), pageable)
                    .map(this::toDto);
        }
        Page<DeliveryAssignment> deliveries;
        if (currentUser.role() == UserRole.ROLE_ADMIN) {
            deliveries = deliveryRepository.findAll(pageable);
        } else {
            Collection<Long> orderIds = scopedOrderIds(currentUser);
            deliveries = orderIds.isEmpty() ? Page.empty(pageable) : deliveryRepository.findByOrderIdIn(orderIds, pageable);
        }
        return deliveries.map(this::toDto);
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

    private DeliveryDto toDto(DeliveryAssignment delivery) {
        return new DeliveryDto(delivery.getId(), delivery.getOrderId(), delivery.getDriverUserId(),
                delivery.getStatus(), delivery.getCreatedAt());
    }
}
