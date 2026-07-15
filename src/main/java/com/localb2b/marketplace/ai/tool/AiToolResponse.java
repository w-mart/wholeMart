package com.localb2b.marketplace.ai.tool;

import com.localb2b.marketplace.ai.intent.IntentDetector.Intent;

import java.util.Map;
import java.util.Objects;

public record AiToolResponse(
        Intent intent,
        String toolName,
        boolean success,
        String message,
        Map<String, Object> data
) {
    public AiToolResponse {
        Objects.requireNonNull(intent, "intent");
        Objects.requireNonNull(toolName, "toolName");
        data = data == null ? Map.of() : Map.copyOf(data);
    }

    public static AiToolResponse ok(Intent intent, String toolName, String message, Map<String, Object> data) {
        return new AiToolResponse(intent, toolName, true, message, data);
    }

    public static AiToolResponse fail(Intent intent, String toolName, String message) {
        return new AiToolResponse(intent, toolName, false, message, Map.of());
    }
}

