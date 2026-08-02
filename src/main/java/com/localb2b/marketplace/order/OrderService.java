package com.localb2b.marketplace.order;

import com.localb2b.marketplace.cart.CartService;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.distributor.DistributorProfile;
import com.localb2b.marketplace.distributor.DistributorProfileRepository;
import com.localb2b.marketplace.driver.DriverMatchingService;
import com.localb2b.marketplace.notification.NotificationEvent;
import com.localb2b.marketplace.notification.NotificationService;
import com.localb2b.marketplace.product.Product;
import com.localb2b.marketplace.product.ProductRepository;
import com.localb2b.marketplace.retailer.RetailerProfile;
import com.localb2b.marketplace.retailer.RetailerProfileRepository;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
import java.security.SecureRandom;
import java.time.Instant;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import org.springframework.context.annotation.Lazy;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final CartService cartService;
    private final ProductRepository productRepository;
    private final RetailerProfileRepository retailerProfileRepository;
    private final DistributorProfileRepository distributorProfileRepository;
    private final NotificationService notificationService;
    private final DriverMatchingService driverMatchingService;
    private static final SecureRandom OTP_RANDOM = new SecureRandom();

    public OrderService(OrderRepository orderRepository, OrderItemRepository orderItemRepository,
            CartService cartService, ProductRepository productRepository,
            RetailerProfileRepository retailerProfileRepository,
            DistributorProfileRepository distributorProfileRepository,
            NotificationService notificationService,
            @Lazy DriverMatchingService driverMatchingService) {
        this.orderRepository = orderRepository;
        this.orderItemRepository = orderItemRepository;
        this.cartService = cartService;
        this.productRepository = productRepository;
        this.retailerProfileRepository = retailerProfileRepository;
        this.distributorProfileRepository = distributorProfileRepository;
        this.notificationService = notificationService;
        this.driverMatchingService = driverMatchingService;
    }

    // ===== ORDER CREATION =====
    @Transactional
    public MarketplaceOrder placeOrder(CurrentUser currentUser, Long distributorUserId,
            OrderPaymentMode paymentMode, BigDecimal partialAmount) {
        if (currentUser.role() != UserRole.ROLE_RETAILER) {
            throw new IllegalStateException("Only retailers can place orders");
        }
        var cartItems = cartService.myCart(currentUser);
        if (cartItems.isEmpty()) {
            throw new IllegalStateException("Cart is empty");
        }
        Map<Long, Product> productsById = productRepository
                .findAllById(cartItems.stream().map(item -> item.getProductId()).toList()).stream()
                .collect(Collectors.toMap(Product::getId, Function.identity()));
        BigDecimal totalAmount = cartItems.stream().reduce(BigDecimal.ZERO, (total, item) -> {
            Product product = productsById.get(item.getProductId());
            if (product == null) {
                throw new IllegalStateException("Cart product not found");
            }
            if (!product.getDistributorUserId().equals(distributorUserId)) {
                throw new IllegalStateException("Cart contains products from another distributor");
            }
            return total.add(product.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
        }, BigDecimal::add);

        MarketplaceOrder order = new MarketplaceOrder(currentUser.userId(), distributorUserId, totalAmount,
                paymentMode);
        if (paymentMode == OrderPaymentMode.PARTIAL && partialAmount != null) {
            order.setPartialAmount(partialAmount);
            order.setPaidAmount(partialAmount);
        }
        MarketplaceOrder savedOrder = orderRepository.save(order);
        final Long savedOrderId = savedOrder.getId();
        orderItemRepository.saveAll(cartItems.stream().map(item -> {
            Product product = productsById.get(item.getProductId());
            return new OrderItem(savedOrderId, product.getId(), product.getName(), product.getSku(),
                    product.getUnitPrice(), item.getQuantity());
        }).toList());

        cartService.clear(currentUser);
        notificationService.publish(NotificationEvent.now(distributorUserId, "ORDER",
                "New order #" + savedOrderId + " received for ₹" + totalAmount));
        notificationService.publish(NotificationEvent.now(currentUser.userId(), "ORDER",
                "Order #" + savedOrderId + " placed successfully for ₹" + totalAmount));
        return savedOrder;
    }

    // ===== DISTRIBUTOR ACTIONS =====
    @Transactional
    public MarketplaceOrder acceptOrder(CurrentUser currentUser, Long orderId) {
        MarketplaceOrder order = ownedDistributorOrder(currentUser, orderId);
        if (order.getStatus() != OrderStatus.PLACED) {
            throw new IllegalStateException("Order cannot be accepted as it is not in PLACED state.");
        }
        order.distributorAccept();
        order.setPickupOtp(generateOtp());
        order.setDeliveryOtp(generateOtp());
        order.markReadyForPickup();
        order.waitForDriver();

        if (order.getReadyForPickupAt() == null) {
            order.setReadyForPickupAt(Instant.now());
        }

        MarketplaceOrder savedOrder = orderRepository.save(order);

        var distributorProfileOpt = distributorProfileRepository.findByUserId(currentUser.userId());
        if (distributorProfileOpt.isPresent()) {
            var profile = distributorProfileOpt.get();
            var match = driverMatchingService.autoMatchDriver(savedOrder, profile.getLatitude(), profile.getLongitude());
            if (match.isEmpty()) {
                // No immediate match — notify all available drivers
                driverMatchingService.broadcastPickupRequest(savedOrder, profile.getLatitude(), profile.getLongitude());
            }
        }

        notificationService.publish(NotificationEvent.now(savedOrder.getRetailerUserId(), "ORDER",
                "Order #" + orderId + " has been accepted by distributor"));
        return savedOrder;
    }

    @Transactional
    public MarketplaceOrder rejectOrder(CurrentUser currentUser, Long orderId, String reason) {
        MarketplaceOrder order = ownedDistributorOrder(currentUser, orderId);
        order.distributorReject(reason);
        order = orderRepository.save(order);
        notificationService.publish(NotificationEvent.now(order.getRetailerUserId(), "ORDER",
                "Order #" + orderId + " was rejected. Reason: " + reason));
        return order;
    }

    @Transactional
    public MarketplaceOrder startPacking(CurrentUser currentUser, Long orderId) {
        MarketplaceOrder order = ownedDistributorOrder(currentUser, orderId);
        order.startPacking();
        return orderRepository.save(order);
    }

    @Transactional
    public MarketplaceOrder markReadyForPickup(CurrentUser currentUser, Long orderId) {
        MarketplaceOrder order = ownedDistributorOrder(currentUser, orderId);
        order.markReadyForPickup();
        order.setPickupOtp(generateOtp());
        order.waitForDriver();
        return orderRepository.save(order);
    }

    // ===== DRIVER ACTIONS =====
    @Transactional
    public MarketplaceOrder assignDriver(Long orderId, Long driverUserId) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        order.assignDriver();
        order = orderRepository.save(order);
        notificationService.publish(
                NotificationEvent.now(driverUserId, "DRIVER_ASSIGNMENT", "New pickup assigned: Order #" + orderId));
        return order;
    }

    @Transactional
    public MarketplaceOrder driverAcceptOrder(Long orderId) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        order.driverAccept();
        return orderRepository.save(order);
    }

    @Transactional
    public MarketplaceOrder verifyPickupOtpAndPickup(Long orderId, String otp) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        if (!otp.equals(order.getPickupOtp())) {
            throw new IllegalStateException("Invalid pickup OTP");
        }
        order.markPickedUp();
        order.markInTransit();
        return orderRepository.save(order);
    }

    @Transactional
    public MarketplaceOrder verifyDeliveryOtpAndDeliver(Long orderId, String otp) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        if (!otp.equals(order.getDeliveryOtp())) {
            throw new IllegalStateException("Invalid delivery OTP");
        }
        order.markDelivered();
        order = orderRepository.save(order);
        if (order.isCod()) {
            order.setCodCollected(false);
        }
        notificationService.publish(NotificationEvent.now(order.getRetailerUserId(), "DELIVERY",
                "Order #" + orderId + " has been delivered!"));
        notificationService.publish(NotificationEvent.now(order.getDistributorUserId(), "DELIVERY",
                "Order #" + orderId + " has been delivered to retailer."));
        return order;
    }

    // ===== COD & PAYMENT =====
    @Transactional
    public MarketplaceOrder collectCodPayment(CurrentUser currentUser, Long orderId, BigDecimal amount) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        if (!order.isCod()) {
            throw new IllegalStateException("Not a COD order");
        }
        order.setCodCollected(true);
        order.setCodCollectedAmount(amount);
        order.setPaidAmount(amount);
        return orderRepository.save(order);
    }

    @Transactional
    public MarketplaceOrder recordPayment(CurrentUser currentUser, Long orderId, BigDecimal amount) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        BigDecimal newPaid = order.getPaidAmount().add(amount);
        order.setPaidAmount(newPaid);
        if (newPaid.compareTo(order.getTotalAmount()) >= 0) {
            order.markPaymentCompleted();
        }
        return orderRepository.save(order);
    }

    @Transactional
    public MarketplaceOrder completeOrder(CurrentUser currentUser, Long orderId) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        order.markCompleted();
        order.setDeliveryOtp(generateOtp());
        return orderRepository.save(order);
    }

    @Transactional
    public MarketplaceOrder cancelOrder(CurrentUser currentUser, Long orderId) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        order.cancel();
        return orderRepository.save(order);
    }

    // ===== QUERIES =====
    @Transactional(readOnly = true)
    public List<MarketplaceOrderDetails> myOrders(CurrentUser currentUser) {
        List<MarketplaceOrder> orders = currentUser.role() == UserRole.ROLE_DISTRIBUTOR
                ? orderRepository.findByDistributorUserId(currentUser.userId())
                : orderRepository.findByRetailerUserId(currentUser.userId());
        if (orders.isEmpty()) {
            return List.of();
        }
        return enrichOrders(orders);
    }

    @Transactional(readOnly = true)
    public Page<MarketplaceOrderDetails> myOrdersPaged(CurrentUser currentUser, Pageable pageable) {
        Page<MarketplaceOrder> ordersPage = currentUser.role() == UserRole.ROLE_DISTRIBUTOR
                ? orderRepository.findByDistributorUserId(currentUser.userId(), pageable)
                : orderRepository.findByRetailerUserId(currentUser.userId(), pageable);
        if (ordersPage.isEmpty()) {
            return Page.empty(pageable);
        }
        List<MarketplaceOrderDetails> enriched = enrichOrders(ordersPage.getContent());
        return new org.springframework.data.domain.PageImpl<>(enriched, pageable, ordersPage.getTotalElements());
    }

    @Transactional(readOnly = true)
    public MarketplaceOrderDetails getOrderDetails(Long orderId, CurrentUser currentUser) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        return enrichOrder(order);
    }

    // ===== INTERNAL HELPERS =====
    private List<MarketplaceOrderDetails> enrichOrders(List<MarketplaceOrder> orders) {
        Map<Long, RetailerProfile> retailerProfiles = retailerProfileRepository.findByUserIdIn(
                orders.stream().map(MarketplaceOrder::getRetailerUserId).distinct().toList())
                .stream()
                .collect(Collectors.toMap(RetailerProfile::getUserId, Function.identity()));
        Map<Long, DistributorProfile> distributorProfiles = distributorProfileRepository.findByUserIdIn(
                orders.stream().map(MarketplaceOrder::getDistributorUserId).distinct().toList())
                .stream()
                .collect(Collectors.toMap(DistributorProfile::getUserId, Function.identity()));
        List<OrderItem> orderItems = orderItemRepository.findByOrderIdIn(
                orders.stream().map(MarketplaceOrder::getId).toList());
        Map<Long, Product> productsById = productRepository.findAllById(
                orderItems.stream().map(OrderItem::getProductId).distinct().toList()).stream()
                .collect(Collectors.toMap(Product::getId, Function.identity()));
        Map<Long, List<OrderItemDetails>> itemsByOrderId = orderItems.stream()
                .collect(Collectors.groupingBy(OrderItem::getOrderId,
                        Collectors.mapping(item -> {
                            Product product = productsById.get(item.getProductId());
                            return new OrderItemDetails(
                                    item.getProductId(),
                                    item.getProductName(),
                                    item.getSku(),
                                    item.getUnitPrice(),
                                    item.getQuantity(),
                                    item.getLineTotal(),
                                    product != null ? product.getPackSize() : null,
                                    product != null ? product.getWeightKg() : null);
                        }, Collectors.toList())));
        return orders.stream()
                .map(order -> buildOrderDetails(order, retailerProfiles, distributorProfiles, itemsByOrderId))
                .toList();
    }

    private MarketplaceOrderDetails enrichOrder(MarketplaceOrder order) {
        Map<Long, RetailerProfile> retailerProfiles = retailerProfileRepository.findByUserIdIn(
                List.of(order.getRetailerUserId()))
                .stream()
                .collect(Collectors.toMap(RetailerProfile::getUserId, Function.identity()));
        Map<Long, DistributorProfile> distributorProfiles = distributorProfileRepository.findByUserIdIn(
                List.of(order.getDistributorUserId()))
                .stream()
                .collect(Collectors.toMap(DistributorProfile::getUserId, Function.identity()));
        List<OrderItem> orderItems = orderItemRepository.findByOrderIdIn(List.of(order.getId()));
        Map<Long, Product> productsById = productRepository.findAllById(
                orderItems.stream().map(OrderItem::getProductId).distinct().toList()).stream()
                .collect(Collectors.toMap(Product::getId, Function.identity()));
        Map<Long, List<OrderItemDetails>> itemsByOrderId = orderItems.stream()
                .collect(Collectors.groupingBy(OrderItem::getOrderId,
                        Collectors.mapping(item -> {
                            Product product = productsById.get(item.getProductId());
                            return new OrderItemDetails(
                                    item.getProductId(),
                                    item.getProductName(),
                                    item.getSku(),
                                    item.getUnitPrice(),
                                    item.getQuantity(),
                                    item.getLineTotal(),
                                    product != null ? product.getPackSize() : null,
                                    product != null ? product.getWeightKg() : null);
                        }, Collectors.toList())));
        return buildOrderDetails(order, retailerProfiles, distributorProfiles, itemsByOrderId);
    }

    private MarketplaceOrderDetails buildOrderDetails(MarketplaceOrder order,
            Map<Long, RetailerProfile> retailerProfiles,
            Map<Long, DistributorProfile> distributorProfiles,
            Map<Long, List<OrderItemDetails>> itemsByOrderId) {
        RetailerProfile profile = retailerProfiles.get(order.getRetailerUserId());
        DistributorProfile distributorProfile = distributorProfiles.get(order.getDistributorUserId());
        String retailerName = profile != null ? profile.getShopName() : "Retailer #" + order.getRetailerUserId();
        String retailerLocation = formatRetailerLocation(profile);
        String distributorShopName = distributorShopName(distributorProfile, order.getDistributorUserId());
        String distributorBusinessName = distributorProfile != null ? distributorProfile.getBusinessName()
                : "Distributor #" + order.getDistributorUserId();
        String distributorAddress = formatDistributorAddress(distributorProfile);
        return new MarketplaceOrderDetails(
                order.getId(),
                order.getRetailerUserId(),
                order.getDistributorUserId(),
                order.getTotalAmount(),
                order.getPartialAmount(),
                order.getPaidAmount(),
                order.getOutstandingAmount(),
                order.getPaymentMode(),
                order.getStatus(),
                order.getDeliveryAddress(),
                order.getDeliverySlot(),
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
                order.getCreatedAt(),
                retailerName,
                retailerLocation,
                distributorShopName,
                distributorBusinessName,
                distributorAddress,
                itemsByOrderId.getOrDefault(order.getId(), List.of()));
    }

    private MarketplaceOrder ownedDistributorOrder(CurrentUser currentUser, Long orderId) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        if (!order.getDistributorUserId().equals(currentUser.userId())) {
            throw new SecurityException("Order is outside current distributor scope");
        }
        return order;
    }

    private static String generateOtp() {
        return String.format("%06d", OTP_RANDOM.nextInt(1000000));
    }

    private static String distributorShopName(DistributorProfile profile, Long distributorUserId) {
        if (profile == null) {
            return "Distributor #" + distributorUserId;
        }
        if (profile.getShopName() != null && !profile.getShopName().isBlank()) {
            return profile.getShopName();
        }
        return profile.getBusinessName();
    }

    private static String formatDistributorAddress(DistributorProfile profile) {
        if (profile == null) {
            return "Address not available";
        }
        List<String> parts = List.of(
                clean(profile.getAddressLine()),
                clean(profile.getCity()),
                clean(profile.getState()),
                clean(profile.getPincode()));
        String address = parts.stream().filter(part -> !part.isBlank()).collect(Collectors.joining(", "));
        return address.isBlank() ? "Address not available" : address;
    }

    private static String clean(String value) {
        return value == null ? "" : value.trim();
    }

    private static String formatRetailerLocation(RetailerProfile profile) {
        if (profile == null) {
            return "Location not available";
        }
        List<String> parts = List.of(
                clean(profile.getAddressLine()),
                clean(profile.getCity()),
                clean(profile.getState()),
                clean(profile.getPincode()));
        String address = parts.stream().filter(part -> !part.isBlank()).collect(Collectors.joining(", "));
        if (!address.isBlank()) {
            return address;
        }
        if (profile.getLatitude() != null && profile.getLongitude() != null
                && (profile.getLatitude().compareTo(BigDecimal.ZERO) != 0
                        || profile.getLongitude().compareTo(BigDecimal.ZERO) != 0)) {
            return profile.getLatitude().stripTrailingZeros().toPlainString() + ", "
                    + profile.getLongitude().stripTrailingZeros().toPlainString();
        }
        return "Location not available";
    }
}
