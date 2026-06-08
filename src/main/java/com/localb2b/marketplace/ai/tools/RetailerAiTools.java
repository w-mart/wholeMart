package com.localb2b.marketplace.ai.tools;

import com.localb2b.marketplace.cart.CartService;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.distributor.DistributorService;
import org.springframework.stereotype.Component;

@Component
public class RetailerAiTools {
    private final DistributorService distributorService;
    private final CartService cartService;

    public RetailerAiTools(DistributorService distributorService, CartService cartService) {
        this.distributorService = distributorService;
        this.cartService = cartService;
    }

    public Object findNearbyDistributors(CurrentUser currentUser) {
        return distributorService.findNearbyApproved(currentUser.userId(), 30);
    }

    public Object currentCart(CurrentUser currentUser) {
        return cartService.myCart(currentUser);
    }
}
