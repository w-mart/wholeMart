package com.localb2b.marketplace.order;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.localb2b.marketplace.cart.CartService;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.distributor.DistributorProfile;
import com.localb2b.marketplace.distributor.DistributorProfileRepository;
import com.localb2b.marketplace.driver.DriverMatchingService;
import com.localb2b.marketplace.notification.NotificationService;
import com.localb2b.marketplace.product.ProductRepository;
import com.localb2b.marketplace.retailer.RetailerProfileRepository;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
import java.util.Optional;
import org.junit.jupiter.api.Test;

class OrderServiceTest {

    @Test
    void acceptOrderAttemptsDriverMatchingUsingDistributorLocation() {
        OrderRepository orderRepository = mock(OrderRepository.class);
        OrderItemRepository orderItemRepository = mock(OrderItemRepository.class);
        CartService cartService = mock(CartService.class);
        ProductRepository productRepository = mock(ProductRepository.class);
        RetailerProfileRepository retailerProfileRepository = mock(RetailerProfileRepository.class);
        DistributorProfileRepository distributorProfileRepository = mock(DistributorProfileRepository.class);
        NotificationService notificationService = mock(NotificationService.class);
        DriverMatchingService driverMatchingService = mock(DriverMatchingService.class);

        OrderService orderService = new OrderService(
                orderRepository,
                orderItemRepository,
                cartService,
                productRepository,
                retailerProfileRepository,
                distributorProfileRepository,
                notificationService,
                driverMatchingService);

        CurrentUser distributor = new CurrentUser(20L, UserRole.ROLE_DISTRIBUTOR, "9999999999");
        MarketplaceOrder order = new MarketplaceOrder(10L, 20L, BigDecimal.TEN, OrderPaymentMode.COD);
        when(orderRepository.findById(42L)).thenReturn(Optional.of(order));
        when(orderRepository.save(any(MarketplaceOrder.class))).thenAnswer(invocation -> invocation.getArgument(0));
        when(distributorProfileRepository.findByUserId(20L))
                .thenReturn(Optional.of(new DistributorProfile(20L, "Acme Dist", new BigDecimal("19.1234"), new BigDecimal("72.5678"))));
        when(driverMatchingService.autoMatchDriver(any(MarketplaceOrder.class), any(BigDecimal.class), any(BigDecimal.class)))
                .thenReturn(Optional.empty());

        MarketplaceOrder acceptedOrder = orderService.acceptOrder(distributor, 42L);

        assertThat(acceptedOrder.getStatus()).isEqualTo(OrderStatus.WAITING_FOR_DRIVER);
        assertThat(acceptedOrder.getPickupOtp()).isNotBlank();
        assertThat(acceptedOrder.getDeliveryOtp()).isNotBlank();
        verify(driverMatchingService).autoMatchDriver(any(MarketplaceOrder.class), eq(new BigDecimal("19.1234")), eq(new BigDecimal("72.5678")));
    }
}
