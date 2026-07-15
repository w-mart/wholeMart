package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.distributor.DistributorProfile;
import com.localb2b.marketplace.distributor.DistributorProfileRepository;
import com.localb2b.marketplace.retailer.RetailerProfile;
import com.localb2b.marketplace.retailer.RetailerProfileRepository;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class CustomerTool implements AiTool {

    private final DistributorProfileRepository distributorProfileRepository;
    private final RetailerProfileRepository retailerProfileRepository;
    private final AiSecurityValidator securityValidator;

    public CustomerTool(DistributorProfileRepository distributorProfileRepository,
                         RetailerProfileRepository retailerProfileRepository,
                         AiSecurityValidator securityValidator) {
        this.distributorProfileRepository = distributorProfileRepository;
        this.retailerProfileRepository = retailerProfileRepository;
        this.securityValidator = securityValidator;
    }

    @Override
    public String name() {
        return "customer";
    }

    @Override
    public boolean supports(Intent intent) {
        // No dedicated customer intent exists yet; keep it available for later.
        return false;
    }

    @Override
    public AiToolResponse execute(AiToolRequest request) {
        CurrentUser user = request.currentUser();
        try {
            securityValidator.validateNoRetailerToDistributorAccess(user);
            // Placeholder: return nothing until we have a concrete customer intent.
            return AiToolResponse.ok(request.intent(), name(), "Customer tool not yet mapped", Map.of());
        } catch (Exception e) {
            return AiToolResponse.fail(request.intent(), name(), e.getMessage());
        }
    }
}

