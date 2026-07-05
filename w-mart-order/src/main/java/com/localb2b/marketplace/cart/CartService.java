package com.localb2b.marketplace.cart;

import com.localb2b.marketplace.user.common.CurrentUser;
import com.localb2b.marketplace.user.UserRole;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CartService {
    private static final Logger log = LoggerFactory.getLogger(CartService.class);
    private final CartRepository repository;

    public CartService(CartRepository repository) {
        this.repository = repository;
    }

    @Transactional
    public CartItem addToCart(CurrentUser user, Long productId, int quantity) {
        validateRetailer(user);
        validateQuantity(quantity);
        
        log.info("Adding product {} qty {} to cart for user {}", productId, quantity, user.userId());
        return repository.findByRetailerUserIdAndProductId(user.userId(), productId)
            .peek(item -> item.increaseQuantity(quantity))
            .orElseGet(() -> repository.save(new CartItem(user.userId(), productId, quantity)));
    }

    @Transactional(readOnly = true)
    public List<CartItem> myCart(CurrentUser user) {
        log.info("Fetching cart for user {}", user.userId());
        return repository.findByRetailerUserId(user.userId());
    }

    @Transactional
    public void removeFromCart(CurrentUser user, Long cartItemId) {
        log.info("Removing cart item {} for user {}", cartItemId, user.userId());
        var item = repository.findById(cartItemId)
            .orElseThrow(() -> new IllegalArgumentException("Cart item not found"));
        validateOwnership(user, item);
        repository.delete(item);
    }

    @Transactional
    public CartItem updateQuantity(CurrentUser user, Long cartItemId, int quantity) {
        validateQuantity(quantity);
        log.info("Updating cart item {} qty {} for user {}", cartItemId, quantity, user.userId());
        
        var item = repository.findById(cartItemId)
            .orElseThrow(() -> new IllegalArgumentException("Cart item not found"));
        validateOwnership(user, item);
        item.setQuantity(quantity);
        return item;
    }

    @Transactional
    public void clear(CurrentUser user) {
        log.info("Clearing cart for user {}", user.userId());
        repository.deleteByRetailerUserId(user.userId());
    }

    private void validateRetailer(CurrentUser user) {
        if (user.role() != UserRole.ROLE_RETAILER) {
            throw new IllegalStateException("Only retailers can add to cart");
        }
    }

    private void validateQuantity(int quantity) {
        if (quantity < 1) throw new IllegalArgumentException("Quantity must be >= 1");
    }

    private void validateOwnership(CurrentUser user, CartItem item) {
        if (!item.getRetailerUserId().equals(user.userId())) {
            throw new SecurityException("Cart item outside retailer scope");
        }
    }
}
