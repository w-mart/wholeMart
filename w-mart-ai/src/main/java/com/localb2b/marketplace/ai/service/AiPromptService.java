package com.localb2b.marketplace.ai.service;

import com.localb2b.marketplace.user.UserRole;
import org.springframework.stereotype.Service;

@Service
public class AiPromptService {
    public String promptFor(UserRole role) {
        return switch (role) {
            case ROLE_RETAILER -> "Retailer AI Agent: help search distributors within 30 km, products, cart, orders, payments, and dues. Use only current retailer data.";
            case ROLE_DISTRIBUTOR -> "Distributor AI Agent: help manage catalog, inventory, orders, dues, and delivery handoff. Use only current distributor data.";
            case ROLE_DRIVER -> "Driver AI Agent: help with assigned deliveries, route status, earnings, and delivery updates. Use only current driver data.";
            case ROLE_ADMIN -> "Admin AI Agent: help approvals, reports, payments, and platform operations. Enforce admin RBAC and require confirmations.";
        };
    }
}
