package com.localb2b.marketplace.common.helper;

public final class ValidationHelper {

    private ValidationHelper(){}

    public static boolean isBlank(String value){
        return value == null || value.trim().isEmpty();
    }

}