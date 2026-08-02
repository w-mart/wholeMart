package com.localb2b.marketplace.driver;

import com.localb2b.marketplace.delivery.DeliveryAssignment;
import com.localb2b.marketplace.delivery.DeliveryRepository;
import com.localb2b.marketplace.notification.NotificationEvent;
//import com.localb2b.marketplace.delivery.DeliveryStatus;
//import com.localb2b.marketplace.notification.NotificationEvent;
import com.localb2b.marketplace.notification.NotificationService;
import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.order.OrderService;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DriverMatchingService {
    private static final double EARTH_RADIUS_KM = 6371.0;
    private static final double MAX_SEARCH_RADIUS_KM = 5.0;
    private static final int MATCHING_TIMEOUT_SECONDS = 15;

    private final DriverLocationRepository driverLocationRepository;
    private final DeliveryRepository deliveryRepository;
    private final OrderRepository orderRepository;
    private final OrderService orderService;
    private final NotificationService notificationService;

    public DriverMatchingService(DriverLocationRepository driverLocationRepository,
                                  DeliveryRepository deliveryRepository,
                                  OrderRepository orderRepository,
                                  @Lazy OrderService orderService,
                                  NotificationService notificationService) {
        this.driverLocationRepository = driverLocationRepository;
        this.deliveryRepository = deliveryRepository;
        this.orderRepository = orderRepository;
        this.orderService = orderService;
        this.notificationService = notificationService;
    }

    /**
     * Find the best available driver for a pickup order.
     * Searches for online, non-busy drivers within 5km of the distributor's location.
     * Selects the closest driver whose vehicle type can handle the order.
     */
    @Transactional
    public Optional<DriverLocation> findBestDriver(MarketplaceOrder order, BigDecimal distLat, BigDecimal distLng) {
        List<DriverLocation> availableDrivers = driverLocationRepository.findByIsOnlineTrueAndIsBusyFalse();

        if (availableDrivers.isEmpty()) {
            return Optional.empty();
        }

        return availableDrivers.stream()
                .map(driver -> {
                    double distance = calculateDistance(
                            distLat.doubleValue(), distLng.doubleValue(),
                            driver.getLatitude().doubleValue(), driver.getLongitude().doubleValue());
                    return new DriverWithDistance(driver, distance);
                })
                .filter(d -> d.distance <= MAX_SEARCH_RADIUS_KM)
                .min(Comparator.comparingDouble(d -> d.distance))
                .map(d -> d.driver);
    }

    /**
     * Assign a driver to an order. Creates a DeliveryAssignment and updates the order status.
     */
    @Transactional
    public DeliveryAssignment assignDriverToOrder(Long orderId, Long driverUserId) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));

        // Update order status
        orderService.assignDriver(orderId, driverUserId);

        // Create delivery assignment
        DeliveryAssignment assignment = new DeliveryAssignment(orderId, driverUserId);
        assignment.setPickupOtp(order.getPickupOtp());
        assignment.setDeliveryOtp(order.getDeliveryOtp());
        assignment = deliveryRepository.save(assignment);

        // Mark driver as busy
        driverLocationRepository.findByDriverUserId(driverUserId).ifPresent(dl -> {
            dl.markBusy();
            driverLocationRepository.save(dl);
        });

        // Notify driver
        // notificationService.publish(NotificationEvent.now(driverUserId, "DRIVER_ASSIGNMENT",
        //         "New pickup assigned from Order #" + orderId));

        return assignment;
    }

    /**
     * Handle driver rejection - find next best driver automatically.
     */
    @Transactional
    public Optional<DeliveryAssignment> handleDriverRejection(Long orderId, Long rejectedDriverUserId,
                                                                BigDecimal distLat, BigDecimal distLng) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));

        // Mark rejecting driver as available
        driverLocationRepository.findByDriverUserId(rejectedDriverUserId).ifPresent(dl -> {
            dl.markAvailable();
            driverLocationRepository.save(dl);
        });

        // Find next best driver
        Optional<DriverLocation> nextDriver = findBestDriver(order, distLat, distLng);
        if (nextDriver.isPresent()) {
            DeliveryAssignment assignment = assignDriverToOrder(orderId, nextDriver.get().getDriverUserId());
            return Optional.of(assignment);
        }

        // No driver found - update order status back to waiting
        order.waitForDriver();
        orderRepository.save(order);
        return Optional.empty();
    }

    /**
     * Calculate distance between two GPS coordinates using Haversine formula.
     */
    public static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return EARTH_RADIUS_KM * c;
    }

    /**
     * Auto-match when order is ready for pickup.
     */
    @Transactional
    public Optional<DeliveryAssignment> autoMatchDriver(MarketplaceOrder order,
                                                          BigDecimal distLat, BigDecimal distLng) {
        Optional<DriverLocation> bestDriver = findBestDriver(order, distLat, distLng);
        if (bestDriver.isPresent()) {
            DeliveryAssignment assignment = assignDriverToOrder(order.getId(), bestDriver.get().getDriverUserId());
            return Optional.of(assignment);
        }
        return Optional.empty();
    }

    @Transactional
    public void broadcastPickupRequest(MarketplaceOrder order, BigDecimal distLat, BigDecimal distLng) {
        List<DriverLocation> availableDrivers = driverLocationRepository.findByIsOnlineTrueAndIsBusyFalse();
        for (DriverLocation dl : availableDrivers) {
            DeliveryAssignment da = new DeliveryAssignment(order.getId(), dl.getDriverUserId());
            da.setPickupLatitude(distLat);
            da.setPickupLongitude(distLng);
            da.setPickupOtp(order.getPickupOtp());
            da.setDeliveryOtp(order.getDeliveryOtp());
            da = deliveryRepository.save(da);
            notificationService.publish(
                    NotificationEvent.now(dl.getDriverUserId(), "DRIVER_REQUEST",
                            "New pickup request: Order #" + order.getId() + " (assignment " + da.getId() + ")"));
        }
    }

    /**
     * Validate driver is within acceptable range of a location.
     */
    public boolean isDriverWithinRange(DriverLocation driver, BigDecimal targetLat, BigDecimal targetLng, double radiusKm) {
        double distance = calculateDistance(
                driver.getLatitude().doubleValue(), driver.getLongitude().doubleValue(),
                targetLat.doubleValue(), targetLng.doubleValue());
        return distance <= radiusKm;
    }

    private record DriverWithDistance(DriverLocation driver, double distance) {
    }
}
