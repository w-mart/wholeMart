package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.ledger.DistributorLedgerSummary;
import com.localb2b.marketplace.ledger.LedgerService;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.Map;

@Component
public class DashboardTool implements AiTool {

    private final LedgerService ledgerService;
    private final AiSecurityValidator securityValidator;

    public DashboardTool(LedgerService ledgerService, AiSecurityValidator securityValidator) {
        this.ledgerService = ledgerService;
        this.securityValidator = securityValidator;
    }

    @Override
    public String name() {
        return "dashboard";
    }

    @Override
    public boolean supports(Intent intent) {
        return intent == Intent.DASHBOARD;
    }

    @Override
    public AiToolResponse execute(AiToolRequest request) {
        CurrentUser user = request.currentUser();
        try {
            securityValidator.validateNoRetailerToDistributorAccess(user);

            if (user.role() != com.localb2b.marketplace.user.UserRole.ROLE_DISTRIBUTOR
                    && user.role() != com.localb2b.marketplace.user.UserRole.ROLE_ADMIN) {
                return AiToolResponse.fail(request.intent(), name(), "Dashboard summary is available for distributors/admin only");
            }

            DistributorLedgerSummary summary = ledgerService.getDistributorLedgerSummary(user.userId());
            BigDecimal today = ledgerService.getTodayCapturedRevenue(user.userId());

            return AiToolResponse.ok(
                    request.intent(),
                    name(),
                    "Fetched dashboard summary",
                    Map.of("summary", summary, "todayCapturedRevenue", today)
            );
        } catch (Exception e) {
            return AiToolResponse.fail(request.intent(), name(), e.getMessage());
        }
    }
}

