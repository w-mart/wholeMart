package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.delivery.DeliveryAssignment;
import com.localb2b.marketplace.delivery.DeliveryRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;

import java.util.Map;

@Component
public class DeliveryTool implements AiTool {

    private final DeliveryRepository deliveryRepository;
    private final AiSecurityValidator securityValidator;

    public DeliveryTool(DeliveryRepository deliveryRepository, AiSecurityValidator securityValidator) {
        this.deliveryRepository = deliveryRepository;
        this.securityValidator = securityValidator;
    }

    @Override
    public String name() {
        return "delivery";
    }

    @Override
    public boolean supports(Intent intent) {
        return intent == Intent.DELIVERY;
    }

    @Override
    public AiToolResponse execute(AiToolRequest request) {
        CurrentUser user = request.currentUser();
        try {
            securityValidator.validateNoRetailerToDistributorAccess(user);

            int size = ((Number) request.params().getOrDefault("size", 20)).intValue();
            var pageable = PageRequest.of(0, Math.max(1, Math.min(size, 50)));

            // Placeholder: only driver-scoped deliveries for now.
            if (user.role() != com.localb2b.marketplace.user.UserRole.ROLE_DRIVER
                    && user.role() != com.localb2b.marketplace.user.UserRole.ROLE_ADMIN) {
                return AiToolResponse.fail(request.intent(), name(), "Delivery details available for drivers/admin only (Phase 7 placeholder)");
            }

            Page<DeliveryAssignment> page = user.role() == com.localb2b.marketplace.user.UserRole.ROLE_DRIVER
                    ? deliveryRepository.findByDriverUserId(user.userId(), pageable)
                    : deliveryRepository.findAll(pageable);

            return AiToolResponse.ok(
                    request.intent(),
                    name(),
                    "Fetched deliveries",
                    Map.of("deliveries", page.getContent(), "total", page.getTotalElements())
            );
        } catch (Exception e) {
            return AiToolResponse.fail(request.intent(), name(), e.getMessage());
        }
    }
}

