package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.order.MarketplaceOrderDetails;
import com.localb2b.marketplace.order.OrderPaymentMode;
import com.localb2b.marketplace.order.OrderService;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class OrderTool implements AiTool {

    private final OrderService orderService;
    private final AiSecurityValidator securityValidator;

    public OrderTool(OrderService orderService, AiSecurityValidator securityValidator) {
        this.orderService = orderService;
        this.securityValidator = securityValidator;
    }

    @Override
    public String name() {
        return "order";
    }

    @Override
    public boolean supports(Intent intent) {
        return intent == Intent.TODAY_ORDERS || intent == Intent.DASHBOARD || intent == Intent.CREATE;
    }

    @Override
    public AiToolResponse execute(AiToolRequest request) {
        CurrentUser user = request.currentUser();
        try {
            // Tool-level data permission checks placeholder; extend when rules become concrete.
            securityValidator.validateNoRetailerToDistributorAccess(user);

            // Conservative initial behavior: only allow “my orders” style queries.
            List<MarketplaceOrderDetails> orders = orderService.myOrders(user);

            return AiToolResponse.ok(
                    request.intent(),
                    name(),
                    "Fetched orders",
                    Map.of("orders", orders)
            );
        } catch (Exception e) {
            return AiToolResponse.fail(request.intent(), name(), e.getMessage());
        }
    }
}

