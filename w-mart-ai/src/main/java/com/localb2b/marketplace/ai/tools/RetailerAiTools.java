package com.localb2b.marketplace.ai.tools;

import com.localb2b.marketplace.ai.context.CurrentUserProvider;
import com.localb2b.marketplace.ai.context.UserContext;
import com.localb2b.marketplace.cart.CartService;
import com.localb2b.marketplace.user.common.CurrentUser;
import com.localb2b.marketplace.distributor.DistributorService;
import org.springframework.ai.tool.annotation.Tool;
import org.springframework.stereotype.Component;

@Component
public class RetailerAiTools {
    private final CurrentUserProvider currentUserProvider;
    private final DistributorService distributorService;
    private final CartService cartService;

    public RetailerAiTools(CurrentUserProvider currentUserProvider,
                          DistributorService distributorService,
                          CartService cartService) {
        this.currentUserProvider = currentUserProvider;
        this.distributorService = distributorService;
        this.cartService = cartService;
    }

    @Tool(description = "Find nearby approved distributors for the logged-in retailer. Examples: 'aaj kya karna hai', 'suggest next actions'.")
    public Object findNearbyDistributors() {
        UserContext user = requireRetailer();
        return distributorService.findNearbyApproved(user.userId(), 30);
    }

    @Tool(description = "Get current cart status for the logged-in retailer. Examples: 'cart ka kya scene hai', 'what should I order'.")
    public Object currentCart() {
        CurrentUser currentUser = currentUserProvider.requireCommonCurrentUser();
        return cartService.myCart(currentUser);
    }

    private UserContext requireRetailer() {
        UserContext user = currentUserProvider.getCurrentUser();
        if (!"ROLE_RETAILER".equals(user.role())) {
            throw new SecurityException("Retailer AI tools are only available to retailers");
        }
        return user;
    }
}
