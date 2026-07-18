package com.localb2b.marketplace.cart;

import com.localb2b.marketplace.common.CurrentUserProvider;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import java.util.List;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/cart")
public class CartApiController {
    private final CartService cartService;
    private final CurrentUserProvider currentUserProvider;

    public CartApiController(CartService cartService, CurrentUserProvider currentUserProvider) {
        this.cartService = cartService;
        this.currentUserProvider = currentUserProvider;
    }

    @GetMapping
    public List<CartItemDto> myCart() {
        return cartService.myCart(currentUserProvider.requireCurrentUser()).stream()
                .map(this::toDto)
                .toList();
    }

    @PostMapping("/items")
    public CartItemDto add(@Valid @RequestBody AddCartItemRequest request) {
        return toDto(cartService.addToCart(currentUserProvider.requireCurrentUser(), request.productId(), request.quantity()));
    }

    @DeleteMapping("/items/{id}")
    public void remove(@PathVariable Long id) {
        cartService.removeFromCart(currentUserProvider.requireCurrentUser(), id);
    }

    @DeleteMapping("/all")
    public void clear() {
        cartService.clear(currentUserProvider.requireCurrentUser());
    }

    @PutMapping("/items/{id}")
    public CartItemDto update(@PathVariable Long id, @Valid @RequestBody UpdateCartItemRequest request) {
        return toDto(cartService.updateQuantity(currentUserProvider.requireCurrentUser(), id, request.quantity()));
    }

    public record AddCartItemRequest(@NotNull Long productId, @Min(1) int quantity) {
    }

    public record UpdateCartItemRequest(@Min(1) int quantity) {
    }

    private CartItemDto toDto(CartItem item) {
        return new CartItemDto(item.getId(), item.getProductId(), item.getQuantity(), item.getCreatedAt());
    }
}
