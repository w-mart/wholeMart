package com.localb2b.marketplace.cart;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;

@Getter
@Entity
@Table(name = "cart_items")
public class CartItem extends BaseEntity {
    @Column(nullable = false)
    private Long retailerUserId;

    @Column(nullable = false)
    private Long productId;

    @Column(nullable = false)
    private int quantity;

    protected CartItem() {
    }

    public CartItem(Long retailerUserId, Long productId, int quantity) {
        this.retailerUserId = retailerUserId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity < 1) {
            throw new IllegalArgumentException("Cart quantity must be at least 1");
        }
        this.quantity = quantity;
    }

    public void increaseQuantity(int quantity) {
        setQuantity(this.quantity + quantity);
    }
}
