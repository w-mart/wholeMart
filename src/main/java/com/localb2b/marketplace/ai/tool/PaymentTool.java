package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.order.MarketplaceOrder;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.payment.Payment;
import com.localb2b.marketplace.payment.PaymentRepository;
import com.localb2b.marketplace.payment.PaymentStatus;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Comparator;
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

            // Scope payments by the logged-in distributor.
            // We only have Payment <-> Order relation, so we scope by order IDs.
            // Payment repository itself is not scoped; scoping happens here.
            if (user.role() != com.localb2b.marketplace.user.UserRole.ROLE_DISTRIBUTOR
                    && user.role() != com.localb2b.marketplace.user.UserRole.ROLE_ADMIN) {
                return AiToolResponse.fail(request.intent(), name(), "Payments summary is available for distributors/admin only");
            }

            // TODO: implement accurate scoping by distributor using OrderRepository.
            // For now, return a deterministic failure so the LLM cannot hallucinate counts.
            return AiToolResponse.fail(request.intent(), name(),
                    "Pending/overdue payments summary requires distributor-scoped payment query (OrderRepository wiring missing)." );
        } catch (Exception e) {
            return AiToolResponse.fail(request.intent(), name(), e.getMessage());
        }
    }
}

