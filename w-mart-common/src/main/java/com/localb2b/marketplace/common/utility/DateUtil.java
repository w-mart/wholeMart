package com.localb2b.marketplace.common.utility;
import java.time.LocalDateTime;

public final class DateUtil {

    private DateUtil(){}

    public static LocalDateTime now(){
        return LocalDateTime.now();
    }

}