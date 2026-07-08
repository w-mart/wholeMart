package com.localb2b.marketplace.cart;

import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.user.UserRole;
import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CartService {
    private final CartRepository cartRepository;

    public CartService(CartRepository cartRepository) {
        this.cartRepository = cartRepository;
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
