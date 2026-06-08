package com.localb2b.marketplace.ai.tools;

import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.delivery.DeliveryRepository;
import org.springframework.stereotype.Component;

@Component
public class DriverAiTools {
    private final DeliveryRepository deliveryRepository;

    public DriverAiTools(DeliveryRepository deliveryRepository) {
        this.deliveryRepository = deliveryRepository;
    }

    public Object myDeliveries(CurrentUser currentUser) {
        return deliveryRepository.findByDriverUserId(currentUser.userId());
    }
}
