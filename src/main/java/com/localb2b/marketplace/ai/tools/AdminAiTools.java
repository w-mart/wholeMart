package com.localb2b.marketplace.ai.tools;

import com.localb2b.marketplace.distributor.DistributorService;
import org.springframework.stereotype.Component;

@Component
public class AdminAiTools {
    private final DistributorService distributorService;

    public AdminAiTools(DistributorService distributorService) {
        this.distributorService = distributorService;
    }

    public Object approveDistributor(Long profileId) {
        return distributorService.approve(profileId);
    }
}
