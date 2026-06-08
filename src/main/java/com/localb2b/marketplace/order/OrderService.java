package com.localb2b.marketplace.order;

import com.localb2b.marketplace.cart.CartService;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.distributor.DistributorProfile;
import com.localb2b.marketplace.distributor.DistributorProfileRepository;
import com.localb2b.marketplace.product.Product;
import com.localb2b.marketplace.product.ProductRepository;
import com.localb2b.marketplace.retailer.RetailerProfile;
import com.localb2b.marketplace.retailer.RetailerProfileRepository;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
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

    public OrderService(OrderRepository orderRepository, OrderItemRepository orderItemRepository,
            CartService cartService, ProductRepository productRepository,
            RetailerProfileRepository retailerProfileRepository,
            DistributorProfileRepository distributorProfileRepository) {
        this.orderRepository = orderRepository;
        this.orderItemRepository = orderItemRepository;
        this.cartService = cartService;
        this.productRepository = productRepository;
        this.retailerProfileRepository = retailerProfileRepository;
        this.distributorProfileRepository = distributorProfileRepository;
    }

    @Transactional
    public MarketplaceOrder placeOrder(CurrentUser currentUser, Long distributorUserId, OrderPaymentMode paymentMode) {
        if (currentUser.role() != UserRole.ROLE_RETAILER) {
            throw new IllegalStateException("Only retailers can place orders");
        }
        var cartItems = cartService.myCart(currentUser);
        if (cartItems.isEmpty()) {
            throw new IllegalStateException("Cart is empty");
        }
        Map<Long, Product> productsById = productRepository.findAllById(
                cartItems.stream().map(item -> item.getProductId()).toList())
                .stream()
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
        MarketplaceOrder order = orderRepository
                .save(new MarketplaceOrder(currentUser.userId(), distributorUserId, totalAmount, paymentMode));
        orderItemRepository.saveAll(cartItems.stream().map(item -> {
            Product product = productsById.get(item.getProductId());
            return new OrderItem(order.getId(), product.getId(), product.getName(), product.getSku(),
                    product.getUnitPrice(), item.getQuantity());
        }).toList());
        cartService.clear(currentUser);
        return order;
    }

    @Transactional(readOnly = true)
    public List<MarketplaceOrderDetails> myOrders(CurrentUser currentUser) {
        List<MarketplaceOrder> orders = currentUser.role() == UserRole.ROLE_DISTRIBUTOR
                ? orderRepository.findByDistributorUserId(currentUser.userId())
                : orderRepository.findByRetailerUserId(currentUser.userId());
        if (orders.isEmpty()) {
            return List.of();
        }

        Map<Long, RetailerProfile> retailerProfiles = retailerProfileRepository.findByUserIdIn(
                orders.stream().map(MarketplaceOrder::getRetailerUserId).distinct().toList())
                .stream()
                .collect(Collectors.toMap(RetailerProfile::getUserId, Function.identity()));
        Map<Long, DistributorProfile> distributorProfiles = distributorProfileRepository.findByUserIdIn(
                orders.stream().map(MarketplaceOrder::getDistributorUserId).distinct().toList())
                .stream()
                .collect(Collectors.toMap(DistributorProfile::getUserId, Function.identity()));
        Map<Long, List<OrderItemDetails>> itemsByOrderId = orderItemRepository.findByOrderIdIn(
                orders.stream().map(MarketplaceOrder::getId).toList())
                .stream()
                .collect(Collectors.groupingBy(OrderItem::getOrderId,
                        Collectors.mapping(item -> new OrderItemDetails(
                                item.getProductId(),
                                item.getProductName(),
                                item.getSku(),
                                item.getUnitPrice(),
                                item.getQuantity(),
                                item.getLineTotal()), Collectors.toList())));

        return orders.stream()
                .map(order -> {
                    RetailerProfile profile = retailerProfiles.get(order.getRetailerUserId());
                    DistributorProfile distributorProfile = distributorProfiles.get(order.getDistributorUserId());
                    String retailerName = profile != null ? profile.getShopName()
                            : "Retailer #" + order.getRetailerUserId();
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
                            order.getPaymentMode(),
                            order.getStatus(),
                            order.getCreatedAt(),
                            retailerName,
                            retailerLocation,
                            distributorShopName,
                            distributorBusinessName,
                            distributorAddress,
                            itemsByOrderId.getOrDefault(order.getId(), List.of()));
                })
                .toList();
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

    @Transactional
    public MarketplaceOrder accept(CurrentUser currentUser, Long orderId) {
        MarketplaceOrder order = ownedDistributorOrder(currentUser, orderId);
        order.accept();
        return order;
    }

    private MarketplaceOrder ownedDistributorOrder(CurrentUser currentUser, Long orderId) {
        MarketplaceOrder order = orderRepository.findById(orderId)
                .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        if (!order.getDistributorUserId().equals(currentUser.userId())) {
            throw new SecurityException("Order is outside current distributor scope");
        }
        return order;
    }
}
