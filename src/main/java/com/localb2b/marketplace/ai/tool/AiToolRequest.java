package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;
import com.localb2b.marketplace.common.CurrentUser;

import java.util.Map;
import java.util.Objects;

public record AiToolRequest(
        CurrentUser currentUser,
        Long conversationId,
        Intent intent,
        String userMessage,
        Map<String, Object> params
) {
    public AiToolRequest {
        Objects.requireNonNull(currentUser, "currentUser");
        Objects.requireNonNull(intent, "intent");
        Objects.requireNonNull(userMessage, "userMessage");
        if (conversationId != null) {
            // no-op
        }
        params = params == null ? Map.of() : Map.copyOf(params);
    }
}

