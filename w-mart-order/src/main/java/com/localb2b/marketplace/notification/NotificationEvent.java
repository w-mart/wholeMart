package com.localb2b.marketplace.notification;

import java.time.Instant;

public record NotificationEvent(Long userId, String channel, String message, Instant createdAt) {
    public static NotificationEvent now(Long userId, String channel, String message) {
        return new NotificationEvent(userId, channel, message, Instant.now());
    }
}
