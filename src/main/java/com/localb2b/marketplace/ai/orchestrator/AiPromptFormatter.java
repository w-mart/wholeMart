package com.localb2b.marketplace.ai.orchestrator;

import com.localb2b.marketplace.ai.entity.AiMessage;
import com.localb2b.marketplace.ai.tool.AiToolResponse;

import java.util.List;

public class AiPromptFormatter {

    public static String formatHistory(List<AiMessage> history) {
        StringBuilder sb = new StringBuilder();
        for (AiMessage m : history) {
            sb.append("[")
                    .append(m.getRole())
                    .append("] ")
                    .append(m.getMessage());
            if (m.getToolUsed() != null && !m.getToolUsed().isBlank()) {
                sb.append(" (toolUsed=").append(m.getToolUsed()).append(")");
            }
            sb.append('\n');
        }
        return sb.toString();
    }

    public static String formatToolContext(AiToolResponse toolResponse) {
        if (toolResponse == null) {
            return "";
        }
        return "toolName=" + toolResponse.toolName()
                + ", success=" + toolResponse.success()
                + ", message=" + toolResponse.message()
                + ", data=" + (toolResponse.data() == null ? "{}" : toolResponse.data());
    }
}

