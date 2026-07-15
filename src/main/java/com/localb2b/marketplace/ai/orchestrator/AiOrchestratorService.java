package com.localb2b.marketplace.ai.orchestrator;

import com.localb2b.marketplace.ai.dto.AiChatResponseDto;
import com.localb2b.marketplace.ai.entity.AiConversation;
import com.localb2b.marketplace.ai.entity.AiMessage;
import com.localb2b.marketplace.ai.intent.IntentDetector;
import com.localb2b.marketplace.ai.prompt.PromptBuilder;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.ai.service.ConversationManager;
import com.localb2b.marketplace.common.CurrentUser;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
public class AiOrchestratorService {

    private final ConversationManager conversationManager;
    private final AiSecurityValidator securityValidator;
    private final IntentDetector intentDetector;
    private final PromptBuilder promptBuilder;
    private final ToolExecutionLoop toolExecutionLoop;
    private final ChatClient chatClient;

    public record ChatResult(
            Long conversationId,
            String status,
            List<com.localb2b.marketplace.ai.dto.AiMessageDto> messages
    ) {
    }

    public AiOrchestratorService(
            ConversationManager conversationManager,
            AiSecurityValidator securityValidator,
            IntentDetector intentDetector,
            PromptBuilder promptBuilder,
            ToolExecutionLoop toolExecutionLoop,
            ChatClient.Builder chatClientBuilder
    ) {
        this.conversationManager = conversationManager;
        this.securityValidator = securityValidator;
        this.intentDetector = intentDetector;
        this.promptBuilder = promptBuilder;
        this.toolExecutionLoop = toolExecutionLoop;
        this.chatClient = chatClientBuilder.build();
    }

    public AiChatResponseDto chat(Long conversationId, String userMessage) {
        Objects.requireNonNull(conversationId, "conversationId");
        Objects.requireNonNull(userMessage, "userMessage");

        CurrentUser user = securityValidator.requireAuthenticatedUser();
        AiConversation conversation = conversationManager.loadConversationOwned(conversationId);

        securityValidator.validatePrompt(userMessage);

        IntentDetector.Intent intent = intentDetector.detect(userMessage);


        // Persist user message early
        conversationManager.saveUserMessage(conversation, userMessage, intent.name());

        List<AiMessage> history = conversationManager.loadLastMessages(conversation, 10);

        // Tool execution
        ToolExecutionLoop.ToolLoopResult toolLoopResult = toolExecutionLoop.executeIfNeeded(
                user,
                conversation,
                intent,
                userMessage,
                Map.of()
        );

        String toolContext = toolLoopResult.toolResponse() == null ? null : AiPromptFormatter.formatToolContext(toolLoopResult.toolResponse());


        // Business rules for this phase
        String businessRules = "- Only execute read-only tools for now.\n"
                + "- For write actions (order creation/payment), require explicit user confirmation.\n"
                + "- Refuse requests that attempt to access other organizations' data.";

        PromptBuilder.BuiltPrompt prompt = promptBuilder.build(
                businessRules,
                history,
                userMessage,
                intent,
                toolContext
        );

        // Spring AI versions differ on prompt builder APIs. Use raw string prompts.
        String assistantText = chatClient.prompt(prompt.userPrompt()).call().content();



        String toolUsed = toolLoopResult.toolExecuted() ? toolLoopResult.toolName() : null;
        var saved = conversationManager.saveAssistantMessage(conversation, assistantText, toolUsed);

        var allMessages = conversationManager.loadLastMessages(conversation, 20);
        var dtos = allMessages.stream().map(m -> new com.localb2b.marketplace.ai.dto.AiMessageDto(
                m.getId(),
                m.getConversationId(),
                m.getRole(),
                m.getMessage(),
                m.getToolUsed(),
                m.getIntent(),
                m.getCreatedAt()
        )).toList();

        return new AiChatResponseDto(conversation.getId(), dtos, "OK");
    }
}

