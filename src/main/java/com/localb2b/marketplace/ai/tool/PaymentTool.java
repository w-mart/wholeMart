package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.order.MarketplaceOrderDetails;
import com.localb2b.marketplace.payment.Payment;
import com.localb2b.marketplace.payment.PaymentRepository;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public class PaymentTool implements AiTool {

    private final PaymentRepository paymentRepository;
    private final AiSecurityValidator securityValidator;

    public PaymentTool(PaymentRepository paymentRepository, AiSecurityValidator securityValidator) {
        this.paymentRepository = paymentRepository;
        this.securityValidator = securityValidator;
    }

    @Override
    public String name() {
        return "payment";
    }

    @Override
    public boolean supports(Intent intent) {
        return intent == Intent.PAYMENT_STATUS;
    }

    @Override
    public AiToolResponse execute(AiToolRequest request) {
        CurrentUser user = request.currentUser();
        try {
            securityValidator.validateNoRetailerToDistributorAccess(user);

            // Placeholder: return all payments visible through repository rules.
            List<Payment> payments = paymentRepository.findAll();

            return AiToolResponse.ok(
                    request.intent(),
                    name(),
                    "Fetched payments",
                    Map.of("payments", payments)
            );
        } catch (Exception e) {
            return AiToolResponse.fail(request.intent(), name(), e.getMessage());
        }
    }
}

