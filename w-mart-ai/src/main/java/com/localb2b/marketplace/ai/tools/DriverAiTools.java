package com.localb2b.marketplace.ai.tools;

import com.localb2b.marketplace.ai.context.CurrentUserProvider;
import com.localb2b.marketplace.ai.context.UserContext;
import com.localb2b.marketplace.delivery.DeliveryRepository;
import org.springframework.ai.tool.annotation.Tool;
import org.springframework.stereotype.Component;

@Component
public class DriverAiTools {
    private final CurrentUserProvider currentUserProvider;
    private final DeliveryRepository deliveryRepository;

    public DriverAiTools(CurrentUserProvider currentUserProvider, DeliveryRepository deliveryRepository) {
        this.currentUserProvider = currentUserProvider;
        this.deliveryRepository = deliveryRepository;
    }

    @Tool(description = "Get assigned deliveries for the logged-in driver. Examples: 'delivery status bata', 'aaj ka route kya hai'.")
    public Object myDeliveries() {
        UserContext driver = requireDriver();
        return deliveryRepository.findByDriverUserId(driver.userId());
    }

    private UserContext requireDriver() {
        UserContext user = currentUserProvider.getCurrentUser();
        if (!"ROLE_DRIVER".equals(user.role())) {
            throw new SecurityException("Driver AI tools are only available to drivers");
        }
        return user;
    }
}
