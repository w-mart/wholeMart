package com.localb2b.marketplace.cart;

import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.product.Product;
import com.localb2b.marketplace.product.ProductRepository;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
import java.util.Map;
import java.util.function.Function;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CartService {
    private final CartRepository cartRepository;
    private final ProductRepository productRepository;

    public CartService(CartRepository cartRepository, ProductRepository productRepository) {
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
    }

    @Transactional
    public CartItem addToCart(CurrentUser currentUser, Long productId, int quantity) {
        if (currentUser.role() != UserRole.ROLE_RETAILER) {
            throw new IllegalStateException("Only retailers can add to cart");
        }
        if (quantity < 1) {
            throw new IllegalArgumentException("Cart quantity must be at least 1");
        }
        return cartRepository.findByRetailerUserIdAndProductId(currentUser.userId(), productId)
                .map(item -> {
                    item.increaseQuantity(quantity);
                    return item;
                })
                .orElseGet(() -> cartRepository.save(new CartItem(currentUser.userId(), productId, quantity)));
    }

    @Transactional(readOnly = true)
    public List<CartItem> myCart(CurrentUser currentUser) {
        return cartRepository.findByRetailerUserId(currentUser.userId());
    }

    @Transactional(readOnly = true)
    public List<CartItemDetailsDto> myCartDetails(CurrentUser currentUser) {
        List<CartItem> cartItems = myCart(currentUser);
        Map<Long, Product> productsById = productRepository.findAllById(
                        cartItems.stream().map(CartItem::getProductId).toList())
                .stream()
                .collect(java.util.stream.Collectors.toMap(Product::getId, Function.identity()));

        return cartItems.stream()
                .map(item -> toDetailsDto(item, productsById.get(item.getProductId())))
                .filter(java.util.Objects::nonNull)
                .toList();
    }

    private CartItemDetailsDto toDetailsDto(CartItem item, Product product) {
        // A deleted product cannot be ordered, so it is omitted from the
        // mobile-ready response rather than exposing incomplete price data.
        if (product == null) {
            return null;
        }
        BigDecimal unitPrice = product.getUnitPrice() == null ? BigDecimal.ZERO : product.getUnitPrice();
        return new CartItemDetailsDto(
                item.getId(), item.getProductId(), product.getDistributorUserId(),
                product.getName(), product.getBrand(), product.getCategory(), product.getSku(), product.getImageUrl(),
                unitPrice, item.getQuantity(), unitPrice.multiply(BigDecimal.valueOf(item.getQuantity())),
                product.getStockQuantity(), item.getCreatedAt());
    }

    @Transactional
    public void removeFromCart(CurrentUser currentUser, Long cartItemId) {
        CartItem item = cartRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException("Cart item not found"));
        if (!item.getRetailerUserId().equals(currentUser.userId())) {
            throw new SecurityException("Cart item is outside current retailer scope");
        }
        cartRepository.delete(item);
    }

    @Transactional
    public CartItem updateQuantity(CurrentUser currentUser, Long cartItemId, int quantity) {
        if (quantity < 1) {
            throw new IllegalArgumentException("Cart quantity must be at least 1");
        }
        CartItem item = cartRepository.findById(cartItemId)
                .orElseThrow(() -> new IllegalArgumentException("Cart item not found"));
        if (!item.getRetailerUserId().equals(currentUser.userId())) {
            throw new SecurityException("Cart item is outside current retailer scope");
        }
        item.setQuantity(quantity);
        return item;
    }

    @Transactional
    public void clear(CurrentUser currentUser) {
        cartRepository.deleteByRetailerUserId(currentUser.userId());
    }
}
