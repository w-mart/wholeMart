package com.localb2b.marketplace.common.util;

public final class ValidationUtil {
    private ValidationUtil() {
    }

    public static boolean hasText(String value) {
        return StringUtil.isNotBlank(value);
    }

    public static boolean isValidLength(String value, int min, int max) {
        if (value == null) {
            return false;
        }
        int length = value.trim().length();
        return length >= min && length <= max;
    }
}
