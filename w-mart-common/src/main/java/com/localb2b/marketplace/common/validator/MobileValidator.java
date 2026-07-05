package com.localb2b.marketplace.common.validator;

import com.localb2b.marketplace.common.util.ValidationUtil;

import java.util.regex.Pattern;

public final class MobileValidator {
    private static final Pattern MOBILE_PATTERN = Pattern.compile("^\\+?[0-9]{10,15}$");

    private MobileValidator() {
    }

    public static boolean isValid(String mobile) {
        return ValidationUtil.hasText(mobile) && MOBILE_PATTERN.matcher(mobile).matches();
    }
}
