package com.localb2b.marketplace.common.validator;

import com.localb2b.marketplace.common.util.ValidationUtil;

public final class PasswordValidator {
    private PasswordValidator() {
    }

    public static boolean isValid(String password) {
        return ValidationUtil.hasText(password) && password.length() >= 8;
    }
}
