package com.localb2b.marketplace.ai.orchestrator;

import com.localb2b.marketplace.ai.entity.AiConversation;
import com.localb2b.marketplace.ai.intent.IntentDetector;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.ai.tool.AiTool;
import com.localb2b.marketplace.ai.tool.AiToolRequest;
import com.localb2b.marketplace.ai.tool.AiToolResponse;
import com.localb2b.marketplace.common.CurrentUser;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class ToolExecutionLoop {

    private final List<AiTool> tools;
    private final AiSecurityValidator securityValidator;

    public record ToolLoopResult(
            boolean toolExecuted,
            String toolName,
            AiToolResponse toolResponse
    ) {
    }

    public ToolExecutionLoop(List<AiTool> tools, AiSecurityValidator securityValidator) {
        this.tools = tools;
        this.securityValidator = securityValidator;
    }

    public ToolLoopResult executeIfNeeded(
            CurrentUser user,
            AiConversation conversation,
            IntentDetector.Intent intent,
            String userMessage,
            Map<String, Object> params
    ) {
        for (AiTool tool : tools) {
            if (!tool.supports(intent)) {
                continue;
            }

            AiToolRequest req = new AiToolRequest(
                    user,
                    conversation.getId(),
                    intent,
                    userMessage,
                    params
            );

            AiToolResponse resp = tool.execute(req);
            // For Phase 10 we do a conservative single-tool execution.
            return new ToolLoopResult(true, tool.name(), resp);
        }

        return new ToolLoopResult(false, "none", null);
    }
}

