package com.localb2b.marketplace.ai.service;

import com.localb2b.marketplace.ai.context.CurrentUserProvider;
import com.localb2b.marketplace.ai.context.UserContext;
import com.localb2b.marketplace.ai.dto.AiChatRequest;
import com.localb2b.marketplace.ai.dto.AiChatResponse;
import com.localb2b.marketplace.ai.dto.DistributorInventorySummary;
import com.localb2b.marketplace.ai.dto.DistributorLedgerSummary;
import com.localb2b.marketplace.ai.dto.DistributorOrderSummary;
import com.localb2b.marketplace.ai.entity.AiAction;
import com.localb2b.marketplace.ai.entity.AiActionType;
import com.localb2b.marketplace.ai.entity.AiConversation;
import com.localb2b.marketplace.ai.entity.AiMessage;
import com.localb2b.marketplace.ai.repository.AiConversationRepository;
import com.localb2b.marketplace.ai.repository.AiMessageRepository;
import com.localb2b.marketplace.ai.tools.AdminAiTools;
import com.localb2b.marketplace.ai.tools.DistributorAiTools;
import com.localb2b.marketplace.ai.tools.DriverAiTools;
import com.localb2b.marketplace.ai.tools.RetailerAiTools;
import com.localb2b.marketplace.common.CurrentUser;
import java.util.List;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
public class AiAgentService {
    private final ChatClient chatClient;
    private final CurrentUserProvider currentUserProvider;
    private final AiActionService aiActionService;
    private final AiConversationRepository aiConversationRepository;
    private final AiMessageRepository aiMessageRepository;
    private final RetailerAiTools retailerAiTools;
    private final DistributorAiTools distributorAiTools;
    private final DriverAiTools driverAiTools;
    private final AdminAiTools adminAiTools;

    public AiAgentService(ObjectProvider<ChatClient.Builder> chatClientBuilderProvider,
                          CurrentUserProvider currentUserProvider,
                          AiActionService aiActionService,
                          AiConversationRepository aiConversationRepository,
                          AiMessageRepository aiMessageRepository,
                          RetailerAiTools retailerAiTools,
                          DistributorAiTools distributorAiTools,
                          DriverAiTools driverAiTools,
                          AdminAiTools adminAiTools) {
        ChatClient.Builder chatClientBuilder = chatClientBuilderProvider.getIfAvailable();
        this.chatClient = chatClientBuilder == null ? null : chatClientBuilder
                .defaultSystem("""
                        You are WholeMart AI Agent for a local B2B wholesale marketplace.

                        Strict rules:
                        1. Follow RBAC strictly.
                        2. Never expose another user's private data.
                        3. Never guess live business data.
                        4. Use available tools for orders, inventory, ledger, delivery, payments, and reports.
                        5. Keep answers short, practical, and action-oriented.
                        6. For sensitive actions, ask confirmation first.
                        7. Never execute payment, order, delivery, ledger, approval, or stock update without confirmation.
                        """)
                .build();
        this.currentUserProvider = currentUserProvider;
        this.aiActionService = aiActionService;
        this.aiConversationRepository = aiConversationRepository;
        this.aiMessageRepository = aiMessageRepository;
        this.retailerAiTools = retailerAiTools;
        this.distributorAiTools = distributorAiTools;
        this.driverAiTools = driverAiTools;
        this.adminAiTools = adminAiTools;
    }

    @Transactional
    public AiChatResponse chat(CurrentUser currentUser, AiChatRequest request) {
        UserContext user;
        try {
            user = currentUserProvider.getCurrentUser();
        } catch (IllegalStateException ex) {
            return new AiChatResponse(
                    null,
                    "I cannot proceed because your account profile is not fully configured. Please complete your profile or contact support for assistance.",
                    false,
                    null,
                    null
            );
        }

        AiConversation conversation = resolveConversation(currentUser, request.conversationId());
        aiMessageRepository.save(new AiMessage(conversation.getId(), "USER", request.message()));
        AiAction pendingAction = detectSensitiveAction(currentUser, request.message());
        String answer = pendingAction == null
                ? generateAnswer(user, request.message())
                : "This request requires confirmation before I take action: " + pendingAction.getActionType();
        aiMessageRepository.save(new AiMessage(conversation.getId(), "ASSISTANT", answer));
        return new AiChatResponse(
                conversation.getId(),
                answer,
                pendingAction != null,
                pendingAction == null ? null : pendingAction.getId(),
                pendingAction == null ? null : pendingAction.getActionType().name()
        );
    }

    @Transactional(readOnly = true)
    public List<AiConversation> conversations(CurrentUser currentUser) {
        return aiConversationRepository.findByUserId(currentUser.userId());
    }

    @Transactional(readOnly = true)
    public List<AiMessage> messages(CurrentUser currentUser, Long conversationId) {
        AiConversation conversation = aiConversationRepository.findById(conversationId)
                .orElseThrow(() -> new IllegalArgumentException("Conversation not found"));
        if (!conversation.getUserId().equals(currentUser.userId())) {
            throw new SecurityException("Conversation is outside current user scope");
        }
        return aiMessageRepository.findByConversationId(conversationId);
    }

    private AiConversation resolveConversation(CurrentUser currentUser, Long conversationId) {
        if (conversationId == null) {
            return aiConversationRepository.save(new AiConversation(currentUser.userId(), currentUser.role(), "New conversation"));
        }
        AiConversation conversation = aiConversationRepository.findById(conversationId)
                .orElseThrow(() -> new IllegalArgumentException("Conversation not found"));
        if (!conversation.getUserId().equals(currentUser.userId())) {
            throw new SecurityException("Conversation is outside current user scope");
        }
        return conversation;
    }

    private String generateAnswer(UserContext user, String message) {
        if (isSmallTalk(message)) {
            return smallTalkAnswer(user, message);
        }
        if (containsCrossUserRequest(message)) {
            return "I can only show data for your logged-in " + user.role().replace("ROLE_", "").toLowerCase() + " account.";
        }
        if (chatClient != null) {
            try {
                String answer = chatClient.prompt()
                        .system(buildRolePrompt(user))
                        .user(message)
                        .tools(getToolsByRole(user.role()))
                        .call()
                        .content();
                if (StringUtils.hasText(answer)) {
                    return answer;
                }
            } catch (RuntimeException ignored) {
                // Local development may run without an AI model/API key. Fall back to scoped summaries.
            }
        }
        return fallbackAnswer(user, message);
    }

    private Object[] getToolsByRole(String role) {
        return switch (role) {
            case "ROLE_RETAILER" -> new Object[]{retailerAiTools};
            case "ROLE_DISTRIBUTOR" -> new Object[]{distributorAiTools};
            case "ROLE_DRIVER" -> new Object[]{driverAiTools};
            case "ROLE_ADMIN" -> new Object[]{adminAiTools};
            default -> new Object[]{};
        };
    }

    private String buildRolePrompt(UserContext user) {
        return switch (user.role()) {
            case "ROLE_RETAILER" -> """
                    You are Retailer AI Agent.
                    Current userId: %d
                    Current retailerId: %d
                    User name: %s

                    Use tools for live data. Never show another retailer's data.
                    """.formatted(user.userId(), user.retailerId(), user.displayName());
            case "ROLE_DISTRIBUTOR" -> """
                    You are Distributor AI Agent.
                    Current userId: %d
                    Current distributorId: %d
                    User name: %s

                    You can help with today's order pipeline, inventory, low stock,
                    payments, ledger, sales summary, delivery planning, and next actions.
                    Use tools for live data. Never show another distributor's data.
                    """.formatted(user.userId(), user.distributorId(), user.displayName());
            case "ROLE_DRIVER" -> """
                    You are Driver AI Agent.
                    Current userId: %d
                    Current driverId: %d
                    User name: %s

                    Use tools for live data. Never show another driver's data.
                    """.formatted(user.userId(), user.driverId(), user.displayName());
            case "ROLE_ADMIN" -> """
                    You are Admin AI Agent.
                    Admin can access platform-level summaries, approvals, delayed orders,
                    disputes, user management, reports, and analytics.
                    Use tools for live data. Avoid exposing unnecessary sensitive information.
                    """;
            default -> "You are a safe marketplace assistant.";
        };
    }

    private String fallbackAnswer(UserContext user, String message) {
        if (!"ROLE_DISTRIBUTOR".equals(user.role())) {
            return "AI tools for your role are being prepared. I can only use your authenticated account scope.";
        }
        String normalized = message == null ? "" : message.toLowerCase();
        DistributorOrderSummary orders = distributorAiTools.getTodayOrderSummary();
        DistributorInventorySummary inventory = distributorAiTools.getInventorySummary();
        DistributorLedgerSummary ledger = distributorAiTools.getLedgerSummary();
        if (normalized.contains("payment") || normalized.contains("dues") || normalized.contains("ledger")) {
            return "Payment summary: captured revenue Rs. %s, pending settlements Rs. %s, overdue dues Rs. %s."
                    .formatted(ledger.capturedRevenue(), ledger.pendingSettlements(), ledger.overdueDues());
        }
        if ((normalized.contains("inventory") || normalized.contains("stock"))
                && (normalized.contains("value") || normalized.contains("rupee") || normalized.contains("rs") || normalized.contains("amount") || normalized.contains("worth"))) {
            return "Inventory value: Rs. %s across %d products."
                    .formatted(distributorAiTools.getInventoryValue(), inventory.totalItems());
        }
        if (normalized.contains("stock") || normalized.contains("inventory")) {
            return "Inventory summary: %d total items, %d low-stock items, %d expired items."
                    .formatted(inventory.totalItems(), inventory.lowStockItems(), inventory.expiredItems());
        }
        if (normalized.contains("order")) {
            return "Order summary: %d waiting for review, %d ready for packing, %d completed deliveries."
                    .formatted(orders.waitingForReview(), orders.readyForPacking(), orders.completedDelivery());
        }
        return "Start with %s. You have %d low-stock items, %d orders waiting for review, and overdue dues of Rs. %s."
                .formatted(distributorAiTools.getRecommendedNextActions().get(0),
                        inventory.lowStockItems(),
                        orders.waitingForReview(),
                        ledger.overdueDues());
    }

    private boolean isSmallTalk(String message) {
        if (message == null) {
            return true;
        }
        String normalized = message.trim().toLowerCase();
        if (!StringUtils.hasText(normalized)) {
            return true;
        }
        String compact = normalized.replaceAll("[^a-z]", "");
        return normalized.matches("[?!.]+")
                || compact.equals("hi")
                || compact.equals("hii")
                || compact.equals("hey")
                || compact.equals("hello")
                || compact.equals("helo")
                || compact.equals("whatsup")
                || compact.equals("sup")
                || compact.equals("greetings")
                || compact.equals("goodmorning")
                || compact.equals("goodafternoon")
                || compact.equals("goodevening")
                || normalized.contains("how are you")
                || normalized.contains("who are you")
                || normalized.contains("what can you do")
                || normalized.contains("help me")
                || normalized.contains("are you there");
    }

    private String smallTalkAnswer(UserContext user, String message) {
        String roleName = user.role().replace("ROLE_", "").toLowerCase();
        String displayName = StringUtils.hasText(user.displayName()) ? user.displayName() : "there";
        String normalized = message == null ? "" : message.trim().toLowerCase();
        if (normalized.contains("how are you")) {
            return "I'm doing well, " + displayName + ". I'm ready to help with your " + roleName + " work.";
        }
        if (normalized.contains("who are you") || normalized.contains("what can you do")) {
            return "I'm WholeMart's AI assistant for your " + roleName + " account. Ask me about orders, inventory, payments, ledger, delivery, or reports.";
        }
        if (normalized.contains("help me") || normalized.contains("are you there")) {
            return "I'm here to help. Ask me something like 'Show today's order summary' or 'What should I do first today?'.";
        }
        return "Hi " + displayName + ". I'm here to help with your " + roleName + " account. Ask me about orders, inventory, payments, ledger, delivery, or reports.";
    }

    private boolean containsCrossUserRequest(String message) {
        if (message == null) {
            return false;
        }
        String normalized = message.toLowerCase();
        return normalized.contains("another distributor")
                || normalized.contains("other distributor")
                || normalized.contains("another retailer")
                || normalized.contains("other retailer")
                || normalized.contains("another driver")
                || normalized.contains("other driver");
    }

    private AiAction detectSensitiveAction(CurrentUser currentUser, String message) {
        String normalized = message.toUpperCase();
        for (AiActionType type : AiActionType.values()) {
            if (normalized.contains(type.name().replace("_", " "))) {
                return aiActionService.createPending(currentUser, type, "{\"source\":\"chat\"}");
            }
        }
        return null;
    }
}
