package com.localb2b.marketplace.ai.dto;

public record AiChatResponse(
        Long conversationId,
        String answer,
        boolean requiresConfirmation,
        Long actionId,
        String actionType
) {
}
