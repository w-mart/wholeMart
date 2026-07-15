package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.inventory.InventoryRepository;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class InventoryTool implements AiTool {

    private final InventoryRepository inventoryRepository;
    private final AiSecurityValidator securityValidator;

    public InventoryTool(InventoryRepository inventoryRepository, AiSecurityValidator securityValidator) {
        this.inventoryRepository = inventoryRepository;
        this.securityValidator = securityValidator;
    }

    @Override
    public String name() {
        return "inventory";
    }

    @Override
    public boolean supports(Intent intent) {
        return intent == Intent.INVENTORY;
    }

    @Override
    public AiToolResponse execute(AiToolRequest request) {
        CurrentUser user = request.currentUser();
        try {
            securityValidator.validateNoRetailerToDistributorAccess(user);

            // Placeholder: no product filter yet. We return a minimal inventory snapshot.
            var items = inventoryRepository.findAll();

            return AiToolResponse.ok(
                    request.intent(),
                    name(),
                    "Fetched inventory",
                    Map.of("items", items)
            );
        } catch (Exception e) {
            return AiToolResponse.fail(request.intent(), name(), e.getMessage());
        }
    }
}

