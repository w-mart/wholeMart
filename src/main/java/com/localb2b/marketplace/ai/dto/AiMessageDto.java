package com.localb2b.marketplace.ai.dto;

import java.time.Instant;

public record AiMessageDto(
        Long id,
        Long conversationId,
        String role,
        String message,
        String toolUsed,
        String intent,
        Instant createdAt
) {
}

