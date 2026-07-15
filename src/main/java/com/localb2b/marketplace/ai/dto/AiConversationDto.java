package com.localb2b.marketplace.ai.dto;

import java.time.Instant;

public record AiConversationDto(
        Long id,
        Long userId,
        String title,
        String status,
        Instant createdAt,
        Instant updatedAt
) {
}

