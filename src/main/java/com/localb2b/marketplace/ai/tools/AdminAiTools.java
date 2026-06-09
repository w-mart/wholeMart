package com.localb2b.marketplace.ai.tools;

import com.localb2b.marketplace.ai.context.CurrentUserProvider;
import com.localb2b.marketplace.ai.context.UserContext;
import com.localb2b.marketplace.distributor.DistributorService;
import org.springframework.ai.tool.annotation.Tool;
import org.springframework.stereotype.Component;

@Component
public class AdminAiTools {
    private final CurrentUserProvider currentUserProvider;
    private final DistributorService distributorService;

    public AdminAiTools(CurrentUserProvider currentUserProvider, DistributorService distributorService) {
        this.currentUserProvider = currentUserProvider;
        this.distributorService = distributorService;
    }

    @Tool(description = "Approve a distributor profile for the logged-in admin. Examples: 'approve distributor profile', 'accept distributor registration'.")
    public Object approveDistributor(Long profileId) {
        requireAdmin();
        return distributorService.approve(profileId);
    }

    private UserContext requireAdmin() {
        UserContext user = currentUserProvider.getCurrentUser();
        if (!"ROLE_ADMIN".equals(user.role())) {
            throw new SecurityException("Admin AI tools are only available to admins");
        }
        return user;
    }
}
