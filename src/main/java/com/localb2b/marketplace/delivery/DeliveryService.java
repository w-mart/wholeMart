package com.localb2b.marketplace.delivery;

import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.common.Pageables;
import com.localb2b.marketplace.driver.DriverLocation;
import com.localb2b.marketplace.driver.DriverLocationRepository;
import com.localb2b.marketplace.driver.DriverMatchingService;
import com.localb2b.marketplace.driver.DriverProfile;
import com.localb2b.marketplace.driver.DriverProfileRepository;
import com.localb2b.marketplace.notification.NotificationEvent;
import com.localb2b.marketplace.notification.NotificationService;
import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.order.OrderService;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
import java.security.SecureRandom;
import java.time.Instant;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DeliveryService {
    private final DeliveryRepository deliveryRepository;
    private final DriverLocationRepository driverLocationRepository;
    private final DriverMatchingService driverMatchingService;
    private final OrderRepository orderRepository;
    private final OrderService orderService;
    private final NotificationService notificationService;
    private final DriverProfileRepository driverProfileRepository;
    private static final SecureRandom OTP_RANDOM = new SecureRandom();

    public DeliveryService(DeliveryRepository deliveryRepository,
                           DriverLocationRepository driverLocationRepository,
                           DriverMatchingService driverMatchingService,
                           OrderRepository orderRepository,
                           OrderService orderService,
                           NotificationService notificationService,
                           DriverProfileRepository driverProfileRepository) {
        this.deliveryRepository = deliveryRepository;
        this.driverLocationRepository = driverLocationRepository;
        this.driverMatchingService = driverMatchingService;
        this.orderRepository = orderRepository;
        this.orderService = orderService;
        this.notificationService = notificationService;
        this.driverProfileRepository = driverProfileRepository;
    }


    @Transactional
    public Optional<DeliveryAssignment> initiateDriverMatching(Long orderId, BigDecimal distLat, BigDecimal distLng) {
        MarketplaceOrder order = orderRepository.findById(orderId).orElseThrow(() -> new IllegalArgumentException("Order not found"));
        order.waitForDriver();
        orderRepository.save(order);
        Optional<DeliveryAssignment> assignment = driverMatchingService.autoMatchDriver(order, distLat, distLng);
        if (assignment.isPresent()) {
            DeliveryAssignment da = assignment.get();
            da.setPickupLatitude(distLat);
            da.setPickupLongitude(distLng);
            deliveryRepository.save(da);
        }
        return assignment;
    }



    @Transactional
    public DeliveryAssignment acceptDelivery(Long assignmentId, CurrentUser currentUser) {
        DeliveryAssignment assignment = deliveryRepository.findById(assignmentId).orElseThrow(() -> new IllegalArgumentException("Delivery assignment not found"));
        if (!assignment.getDriverUserId().equals(currentUser.userId())) {
            throw new SecurityException("Assignment belongs to another driver");
        }
        assignment.driverAccept();
        assignment = deliveryRepository.save(assignment);
        orderService.driverAcceptOrder(assignment.getOrderId());
        MarketplaceOrder order = orderRepository.findById(assignment.getOrderId()).orElseThrow();
        notificationService.publish(NotificationEvent.now(order.getDistributorUserId(), "DELIVERY", "Driver has accepted delivery for Order #" + order.getId()));
        notificationService.publish(NotificationEvent.now(order.getRetailerUserId(), "DELIVERY", "Driver is on the way to pickup Order #" + order.getId()));
        return assignment;
    }


    
    @Transactional
    public Optional<DeliveryAssignment> rejectDelivery(Long assignmentId, Long driverUserId, String reason) {
        DeliveryAssignment assignment = deliveryRepository.findById(assignmentId).orElseThrow(() -> new IllegalArgumentException("Delivery assignment not found"));
        assignment.driverReject(reason);
        deliveryRepository.save(assignment);
        driverLocationRepository.findByDriverUserId(driverUserId).ifPresent(dl -> {
            dl.markAvailable();
            driverLocationRepository.save(dl);
        });
        MarketplaceOrder order = orderRepository.findById(assignment.getOrderId()).orElseThrow();
        return driverMatchingService.handleDriverRejection(
                assignment.getOrderId(), driverUserId,
                assignment.getPickupLatitude(), assignment.getPickupLongitude());
    }

    

    @Transactional
    public DeliveryAssignment verifyPickup(Long assignmentId, String otp) {
        DeliveryAssignment assignment = deliveryRepository.findById(assignmentId).orElseThrow(() -> new IllegalArgumentException("Delivery assignment not found"));
        if (!otp.equals(assignment.getPickupOtp())) {
            throw new IllegalStateException("Invalid pickup OTP");
        }
        assignment.markPickedUp();
        assignment = deliveryRepository.save(assignment);
        orderService.verifyPickupOtpAndPickup(assignment.getOrderId(), otp);
        return assignment;
    }

    

    @Transactional
    public DeliveryAssignment verifyDelivery(Long assignmentId, String otp) {
        DeliveryAssignment assignment = deliveryRepository.findById(assignmentId).orElseThrow(() -> new IllegalArgumentException("Delivery assignment not found"));
        if (!otp.equals(assignment.getDeliveryOtp())) {
            throw new IllegalStateException("Invalid delivery OTP");
        }
        assignment.markDelivered();
        assignment = deliveryRepository.save(assignment);
        orderService.verifyDeliveryOtpAndDeliver(assignment.getOrderId(), otp);
        return assignment;
    }

    

    @Transactional(readOnly = true)
    public Page<DeliveryDto> getMyDeliveries(CurrentUser currentUser, int page, int size) {
        var pageable = Pageables.bounded(page, size);
        if (currentUser.role() == UserRole.ROLE_DRIVER) {
            return deliveryRepository.findByDriverUserId(currentUser.userId(), pageable)
                    .map(this::toDto);
        }
        Page<DeliveryAssignment> deliveries;
        if (currentUser.role() == UserRole.ROLE_ADMIN) {
            deliveries = deliveryRepository.findAll(pageable);
        } else {
            Collection<Long> orderIds = getScopedOrderIds(currentUser);
            deliveries = orderIds.isEmpty() ? Page.empty(pageable) : deliveryRepository.findByOrderIdIn(orderIds, pageable);
        }
        return deliveries.map(this::toDto);
    }

    

    @Transactional(readOnly = true)
    public List<DeliveryDto> getActiveDeliveries(Long driverUserId) {
        return deliveryRepository.findByDriverUserIdAndStatusIn(driverUserId,
                        List.of(DeliveryStatus.ASSIGNED, DeliveryStatus.DRIVER_ACCEPTED,
                                DeliveryStatus.PICKED_UP, DeliveryStatus.IN_TRANSIT,
                                DeliveryStatus.OUT_FOR_DELIVERY))
                .stream()
                .map(this::toDto)
                .toList();
    }

    

    @Transactional
    public void updateDriverLocation(Long driverUserId, BigDecimal lat, BigDecimal lng) {
        driverLocationRepository.findByDriverUserId(driverUserId).ifPresent(dl -> {
            dl.updateLocation(lat, lng);
            driverLocationRepository.save(dl);
        });
    }

    

    private Collection<Long> getScopedOrderIds(CurrentUser currentUser) {
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
        return new DeliveryDto(
                delivery.getId(),
                delivery.getOrderId(),
                delivery.getDriverUserId(),
                delivery.getStatus(),
                delivery.getPickupOtp(),
                delivery.getDeliveryOtp(),
                delivery.getDriverAcceptedAt(),
                delivery.getPickedUpAt(),
                delivery.getDeliveredAt(),
                delivery.getRejectionReason(),
                delivery.getPickupLatitude(),
                delivery.getPickupLongitude(),
                delivery.getDeliveryLatitude(),
                delivery.getDeliveryLongitude(),
                delivery.getDeliveryFee(),
                delivery.getCreatedAt());
    }
}
