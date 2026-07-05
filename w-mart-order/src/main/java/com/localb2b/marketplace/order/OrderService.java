package com.localb2b.marketplace.order;

import com.localb2b.marketplace.cart.CartService;
import com.localb2b.marketplace.user.common.CurrentUser;
import com.localb2b.marketplace.distributor.DistributorProfile;
import com.localb2b.marketplace.distributor.DistributorProfileRepository;
import com.localb2b.marketplace.product.Product;
import com.localb2b.marketplace.product.ProductRepository;
import com.localb2b.marketplace.retailer.RetailerProfile;
import com.localb2b.marketplace.retailer.RetailerProfileRepository;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
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
    public MarketplaceOrder placeOrder(CurrentUser user, Long distributorId, OrderPaymentMode mode) {
        validateRetailer(user);
        
        var cartItems = cartService.myCart(user);
        if (cartItems.isEmpty()) throw new IllegalStateException("Cart is empty");
        
        var products = productRepository.findAllById(cartItems.stream()
            .map(cartItem -> cartItem.getProductId())
            .toList()).stream()
            .collect(Collectors.toMap(Product::getId, Function.identity()));
        
        var totalAmount = cartItems.stream()
            .reduce(BigDecimal.ZERO,
                (total, item) -> total.add(calculateItemPrice(products, item, distributorId)),
                BigDecimal::add);
        
        var order = orderRepository.save(new MarketplaceOrder(user.userId(), distributorId, totalAmount, mode));
        orderItemRepository.saveAll(cartItems.stream()
            .map(item -> createOrderItem(order, products.get(item.getProductId()), item))
            .toList());
        
        cartService.clear(user);
        return order;
    }

    @Transactional(readOnly = true)
    public List<MarketplaceOrderDetails> myOrders(CurrentUser user) {
        var orders = user.role() == UserRole.ROLE_DISTRIBUTOR
            ? orderRepository.findByDistributorUserId(user.userId())
            : orderRepository.findByRetailerUserId(user.userId());
        
        if (orders.isEmpty()) return List.of();
        
        var retailerProfiles = retailerProfileRepository.findByUserIdIn(
            orders.stream().map(MarketplaceOrder::getRetailerUserId).distinct().toList())
            .stream()
            .collect(Collectors.toMap(RetailerProfile::getUserId, Function.identity()));
        
        var distributorProfiles = distributorProfileRepository.findByUserIdIn(
            orders.stream().map(MarketplaceOrder::getDistributorUserId).distinct().toList())
            .stream()
            .collect(Collectors.toMap(DistributorProfile::getUserId, Function.identity()));
        
        var itemsByOrderId = orderItemRepository.findByOrderIdIn(
            orders.stream().map(MarketplaceOrder::getId).toList())
            .stream()
            .collect(Collectors.groupingBy(OrderItem::getOrderId,
                Collectors.mapping(item -> new OrderItemDetails(
                    item.getProductId(), item.getProductName(), item.getSku(),
                    item.getUnitPrice(), item.getQuantity(), item.getLineTotal()),
                    Collectors.toList())));
        
        return orders.stream()
            .map(order -> toOrderDetails(order, retailerProfiles, distributorProfiles, itemsByOrderId))
            .toList();
    }

    @Transactional
    public MarketplaceOrder accept(CurrentUser user, Long orderId) {
        var order = ownedDistributorOrder(user, orderId);
        order.accept();
        return order;
    }

    private BigDecimal calculateItemPrice(Map<Long, Product> products, var item, Long expectedDistributorId) {
        var product = products.get(item.getProductId());
        if (product == null) throw new IllegalStateException("Cart product not found");
        if (!product.getDistributorUserId().equals(expectedDistributorId)) {
            throw new IllegalStateException("Cart contains products from another distributor");
        }
        return product.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
    }

    private OrderItem createOrderItem(MarketplaceOrder order, Product product, var cartItem) {
        return new OrderItem(order.getId(), product.getId(), product.getName(), product.getSku(),
            product.getUnitPrice(), cartItem.getQuantity());
    }

    private MarketplaceOrderDetails toOrderDetails(MarketplaceOrder order,
            Map<Long, RetailerProfile> retailers, Map<Long, DistributorProfile> distributors,
            Map<Long, List<OrderItemDetails>> itemsByOrderId) {
        var retailer = retailers.get(order.getRetailerUserId());
        var distributor = distributors.get(order.getDistributorUserId());
        
        return new MarketplaceOrderDetails(
            order.getId(), order.getRetailerUserId(), order.getDistributorUserId(),
            order.getTotalAmount(), order.getPaymentMode(), order.getStatus(), order.getCreatedAt(),
            getRetailerName(retailer, order.getRetailerUserId()),
            getRetailerLocation(retailer),
            getDistributorShopName(distributor, order.getDistributorUserId()),
            getDistributorBusinessName(distributor, order.getDistributorUserId()),
            getDistributorAddress(distributor),
            itemsByOrderId.getOrDefault(order.getId(), List.of()));
    }

    private String getRetailerName(RetailerProfile profile, Long userId) {
        return profile != null ? profile.getShopName() : "Retailer #" + userId;
    }

    private String getDistributorShopName(DistributorProfile profile, Long userId) {
        if (profile == null) return "Distributor #" + userId;
        return profile.getShopName() != null && !profile.getShopName().isBlank()
            ? profile.getShopName() : profile.getBusinessName();
    }

    private String getDistributorBusinessName(DistributorProfile profile, Long userId) {
        return profile != null ? profile.getBusinessName() : "Distributor #" + userId;
    }

    private String getRetailerLocation(RetailerProfile profile) {
        if (profile == null) return "Location not available";
        
        var address = formatAddress(profile.getAddressLine(), profile.getCity(), 
            profile.getState(), profile.getPincode());
        if (!address.isBlank()) return address;
        
        if (profile.getLatitude() != null && profile.getLongitude() != null
                && (profile.getLatitude().compareTo(BigDecimal.ZERO) != 0
                        || profile.getLongitude().compareTo(BigDecimal.ZERO) != 0)) {
            return profile.getLatitude().stripTrailingZeros().toPlainString() + ", "
                + profile.getLongitude().stripTrailingZeros().toPlainString();
        }
        return "Location not available";
    }

    private String getDistributorAddress(DistributorProfile profile) {
        return profile == null ? "Address not available"
            : formatAddress(profile.getAddressLine(), profile.getCity(),
                profile.getState(), profile.getPincode());
    }

    private String formatAddress(String line, String city, String state, String pincode) {
        var address = List.of(clean(line), clean(city), clean(state), clean(pincode)).stream()
            .filter(p -> !p.isBlank())
            .collect(Collectors.joining(", "));
        return address.isBlank() ? "Address not available" : address;
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }

    private MarketplaceOrder ownedDistributorOrder(CurrentUser user, Long orderId) {
        var order = orderRepository.findById(orderId)
            .orElseThrow(() -> new IllegalArgumentException("Order not found"));
        if (!order.getDistributorUserId().equals(user.userId())) {
            throw new SecurityException("Order outside distributor scope");
        }
        return order;
    }

    private void validateRetailer(CurrentUser user) {
        if (user.role() != UserRole.ROLE_RETAILER) {
            throw new IllegalStateException("Only retailers can place orders");
        }
    }
}
