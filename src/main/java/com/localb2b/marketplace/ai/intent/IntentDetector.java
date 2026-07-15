package com.localb2b.marketplace.ai.intent;

import org.springframework.stereotype.Component;

/**
 * Non-AI intent detection based on simple keyword matching.
 *
 * Phase 5: stub implementation to unblock routing later.
 */
@Component
public class IntentDetector {


    public Intent detect(String message) {
        if (message == null || message.isBlank()) {
            return Intent.UNKNOWN;
        }
        String m = message.trim().toLowerCase();

        // Minimal keyword heuristics (extend later)
        if (m.contains("order") || m.contains("today") || m.contains("delivery") || m.contains("dispatch")) {
            return Intent.TODAY_ORDERS;
        }
        if (m.contains("inventory") || m.contains("stock") || m.contains("availability")) {
            return Intent.INVENTORY;
        }
        if (m.contains("payment") || m.contains("paid") || m.contains("due") || m.contains("invoice")) {
            return Intent.PAYMENT_STATUS;
        }
        if (m.contains("sale") || m.contains("revenue") || m.contains("month") || m.contains("year")) {
            return Intent.SALES;
        }
        if (m.contains("product") || m.contains("item") || m.contains("catalog")) {
            return Intent.PRODUCTS;
        }
        if (m.contains("return") || m.contains("refund")) {
            return Intent.RETURNS;
        }
        if (m.contains("dashboard") || m.contains("summary") || m.contains("overview")) {
            return Intent.DASHBOARD;
        }
        if (m.contains("invoice")) {
            return Intent.INVOICES;
        }
        if (m.contains("create") || m.contains("new")) {
            return Intent.CREATE;
        }
        if (m.contains("delivery") || m.contains("route") || m.contains("driver")) {
            return Intent.DELIVERY;
        }

        return Intent.UNKNOWN;
    }

    public enum Intent {
        TODAY_ORDERS,
        INVENTORY,
        PAYMENT_STATUS,
        SALES,
        PRODUCTS,
        RETURNS,
        DASHBOARD,
        DELIVERY,
        INVOICES,
        CREATE,
        UNKNOWN
    }
}

