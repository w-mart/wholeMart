package com.localb2b.marketplace.common.util;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;

public final class DateUtil {
    private static final DateTimeFormatter ISO_FORMATTER = DateTimeFormatter.ISO_INSTANT;

    private DateUtil() {
    }

    public static Instant now() {
        return Instant.now();
    }

    public static String format(Instant instant) {
        return instant == null ? null : ISO_FORMATTER.format(instant);
    }

    public static LocalDateTime toLocalDateTime(Instant instant) {
        return instant == null ? null : LocalDateTime.ofInstant(instant, ZoneOffset.UTC);
    }
}
