package com.localb2b.marketplace.common.validator;

public final class CommonValidator {
    private CommonValidator() {
    }

    public static boolean isValidName(String value) {
        return value != null && value.trim().length() >= 2 && value.trim().length() <= 100;
    }
}
