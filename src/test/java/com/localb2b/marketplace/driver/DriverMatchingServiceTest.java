package com.localb2b.marketplace.driver;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.localb2b.marketplace.delivery.DeliveryAssignment;
import com.localb2b.marketplace.delivery.DeliveryRepository;
import com.localb2b.marketplace.notification.NotificationService;
import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.order.OrderService;
import org.junit.jupiter.api.Test;

class DriverMatchingServiceTest {

    @Test
    void assignDriverToOrderCopiesOtpValuesIntoDeliveryAssignment() {
        DriverLocationRepository driverLocationRepository = mock(DriverLocationRepository.class);
        DeliveryRepository deliveryRepository = mock(DeliveryRepository.class);
        OrderRepository orderRepository = mock(OrderRepository.class);
        OrderService orderService = mock(OrderService.class);
        NotificationService notificationService = mock(NotificationService.class);

        DriverMatchingService service = new DriverMatchingService(
                driverLocationRepository,
                deliveryRepository,
                orderRepository,
                orderService,
                notificationService);

        MarketplaceOrder order = new MarketplaceOrder(10L, 20L, java.math.BigDecimal.TEN, com.localb2b.marketplace.order.OrderPaymentMode.COD);
        order.setPickupOtp("123456");
        order.setDeliveryOtp("654321");

        when(orderRepository.findById(42L)).thenReturn(java.util.Optional.of(order));
        when(orderService.assignDriver(42L, 99L)).thenReturn(order);
        when(deliveryRepository.save(any(DeliveryAssignment.class))).thenAnswer(invocation -> invocation.getArgument(0));

        DeliveryAssignment assignment = service.assignDriverToOrder(42L, 99L);

        assertThat(assignment.getPickupOtp()).isEqualTo("123456");
        assertThat(assignment.getDeliveryOtp()).isEqualTo("654321");
        verify(orderService).assignDriver(42L, 99L);
    }
}
