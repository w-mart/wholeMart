package com.localb2b.marketplace.ai.dto;

import jakarta.validation.constraints.NotBlank;

public record AiChatRequest(Long conversationId, @NotBlank String message) {
}
