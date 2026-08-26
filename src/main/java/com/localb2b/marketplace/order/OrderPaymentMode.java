package com.localb2b.marketplace.order;

import com.fasterxml.jackson.annotation.JsonCreator;
import java.util.Locale;

public enum OrderPaymentMode {
    FULL,
    PARTIAL,
    PAY_LATER,
    COD;

    /** Accepts mobile values such as "cod" while retaining enum storage values. */
    @JsonCreator
    public static OrderPaymentMode fromJson(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        try {
            return valueOf(value.trim().toUpperCase(Locale.ROOT));
        } catch (IllegalArgumentException exception) {
            throw new IllegalArgumentException("paymentMode must be FULL, PARTIAL, PAY_LATER, or COD");
        }
    }
}
