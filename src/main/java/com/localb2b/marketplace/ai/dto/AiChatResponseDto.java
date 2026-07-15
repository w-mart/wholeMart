package com.localb2b.marketplace.ai.dto;

import java.util.List;

public record AiChatResponseDto(
        Long conversationId,
        List<AiMessageDto> messages,
        String status
) {
}

