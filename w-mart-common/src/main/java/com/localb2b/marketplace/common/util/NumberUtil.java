package com.localb2b.marketplace.common.util;

import java.math.BigDecimal;

public final class NumberUtil {
    private NumberUtil() {
    }

    public static boolean isPositive(Number value) {
        return value != null && BigDecimal.valueOf(value.doubleValue()).compareTo(BigDecimal.ZERO) > 0;
    }

    public static boolean isNonNegative(Number value) {
        return value != null && BigDecimal.valueOf(value.doubleValue()).compareTo(BigDecimal.ZERO) >= 0;
    }

    public static BigDecimal toBigDecimal(Number value) {
        return value == null ? null : BigDecimal.valueOf(value.doubleValue());
    }
}
