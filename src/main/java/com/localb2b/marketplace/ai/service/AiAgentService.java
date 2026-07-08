package com.localb2b.marketplace.ai.service;

import com.localb2b.marketplace.ai.context.CurrentUserProvider;
import com.localb2b.marketplace.ai.context.UserContext;
import com.localb2b.marketplace.ai.dto.AiChatRequest;
import com.localb2b.marketplace.ai.dto.AiChatResponse;
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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
public class AiAgentService {
    private static final Logger log = LoggerFactory.getLogger(AiAgentService.class);

    private final ChatClient chatClient;
    private final CurrentUserProvider currentUserProvider;
    private final AiConversationRepository aiConversationRepository;
    private final AiMessageRepository aiMessageRepository;
    private final RetailerAiTools retailerAiTools;
    private final DistributorAiTools distributorAiTools;
    private final DriverAiTools driverAiTools;
    private final AdminAiTools adminAiTools;

    public AiAgentService(ObjectProvider<ChatClient.Builder> chatClientBuilderProvider,
                          CurrentUserProvider currentUserProvider,
                          AiConversationRepository aiConversationRepository,
                          AiMessageRepository aiMessageRepository,
                          RetailerAiTools retailerAiTools,
                          DistributorAiTools distributorAiTools,
                          DriverAiTools driverAiTools,
                          AdminAiTools adminAiTools) {
        ChatClient.Builder chatClientBuilder = resolveChatClientBuilder(chatClientBuilderProvider);
        this.chatClient = chatClientBuilder == null ? null : chatClientBuilder
                .defaultSystem("""
                        You are WholeMart AI for a local B2B wholesale marketplace.
                        Be concise, practical, and human. Use live-data tools only when attached.
                        Follow RBAC. Never expose another account's data or accept IDs from user text.
                        Format useful answers as short, neat paragraphs in clear business language.
                        """)
                .build();
        this.currentUserProvider = currentUserProvider;
        this.aiConversationRepository = aiConversationRepository;
        this.aiMessageRepository = aiMessageRepository;
        this.retailerAiTools = retailerAiTools;
        this.distributorAiTools = distributorAiTools;
        this.driverAiTools = driverAiTools;
        this.adminAiTools = adminAiTools;
    }

    private ChatClient.Builder resolveChatClientBuilder(ObjectProvider<ChatClient.Builder> chatClientBuilderProvider) {
        try {
            return chatClientBuilderProvider.getIfAvailable();
        } catch (BeansException ex) {
            return null;
        }
    }

    @Transactional
    public AiChatResponse chat(CurrentUser currentUser, AiChatRequest request) {
        UserContext user;
        try {
            user = currentUserProvider.getCurrentUser();
        } catch (IllegalStateException ex) {
            return new AiChatResponse(
                    null,
                    "I cannot proceed because your account profile is not fully configured. Please complete your profile or contact support.",
                    false,
                    null,
                    null
            );
        }

        AiConversation conversation = resolveConversation(currentUser, request.conversationId());
        aiMessageRepository.save(new AiMessage(conversation.getId(), "USER", request.message()));
        String answer = generateAnswer(user, request.message(), conversation);
        aiMessageRepository.save(new AiMessage(conversation.getId(), "ASSISTANT", answer));
        return new AiChatResponse(
                conversation.getId(),
                answer,
                false,
                null,
                null
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
            List<AiConversation> conversations = aiConversationRepository.findByUserId(currentUser.userId());
            if (!conversations.isEmpty()) {
                return conversations.get(0);
            }
            return aiConversationRepository.save(new AiConversation(currentUser.userId(), currentUser.role(), "User conversation"));
        }
        AiConversation conversation = aiConversationRepository.findById(conversationId)
                .orElseThrow(() -> new IllegalArgumentException("Conversation not found"));
        if (!conversation.getUserId().equals(currentUser.userId())) {
            throw new SecurityException("Conversation is outside current user scope");
        }
        return conversation;
    }

    private String generateAnswer(UserContext user, String message, AiConversation conversation) {
        if (containsCrossUserRequest(message)) {
            return "I can only show data for your logged-in "
                    + user.role().replace("ROLE_", "").toLowerCase()
                    + " account.";
        }

        if ("ROLE_DISTRIBUTOR".equals(user.role()) && isSalesRequest(normalize(message))) {
            return todaySalesAnswer();
        }

        if ("ROLE_DISTRIBUTOR".equals(user.role()) && canAnswerWithDistributorTools(message)) {
            return fallbackAnswer(user, message);
        }

        if (chatClient == null) {
            return aiNotWorkingMessage();
        }

        try {
            var prompt = chatClient.prompt()
                    .system(buildRolePrompt(user, conversation))
                    .user(message);
            if (needsLiveData(message)) {
                prompt = prompt.tools(getToolsByRole(user.role()));
            }
            String answer = prompt.call().content();

            if (StringUtils.hasText(answer)) {
                return answer.trim();
            }

            return aiNotWorkingMessage();
        } catch (RuntimeException ex) {
            Throwable root = ex;
            while (root.getCause() != null) {
                root = root.getCause();
            }

            String rootMessage = root.getMessage() == null ? "" : root.getMessage();
            String lowerRootMessage = rootMessage.toLowerCase();
            log.warn("AI request failed: {} - {}", root.getClass().getSimpleName(), rootMessage);
            if (lowerRootMessage.contains("api key not valid") || lowerRootMessage.contains("invalid api key")) {
                return "AI is not working. Groq API key is invalid. Set a valid GROQ_API_KEY from Groq Console, then restart the app.";
            }
            if (lowerRootMessage.contains("quota exceeded")
                    || lowerRootMessage.contains("rate limit")
                    || rootMessage.contains("429")) {
                return "AI is not working. Groq rate limit or quota is exceeded. Please wait, check Groq Console limits, or use another valid key.";
            }

            return "AI is not working. " + root.getClass().getSimpleName() + " - " + rootMessage;
        }
    }

    private String aiNotWorkingMessage() {
        return "AI is not working. Please enable Groq with SPRING_AI_MODEL_CHAT=openai and set a valid GROQ_API_KEY.";
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

    private String buildRolePrompt(UserContext user, AiConversation conversation) {
        String basePrompt = switch (user.role()) {
            case "ROLE_RETAILER" -> """
                    Role: RETAILER.
                    Help with nearby distributors, cart, orders, payments, and next actions.
                    """;
            case "ROLE_DISTRIBUTOR" -> """
                    Role: DISTRIBUTOR.
                    Help with orders, inventory, ledger, payments, delivery planning, and next actions.
                    """;
            case "ROLE_DRIVER" -> """
                    Role: DRIVER.
                    Help with assigned deliveries, route status, and daily planning.
                    """;
            case "ROLE_ADMIN" -> """
                    Role: ADMIN.
                    Help with approvals, reports, payments, and investigations.
                    """;
            default -> "You are a safe marketplace assistant.";
        };
        String memory = buildConversationMemory(conversation);
        if (StringUtils.hasText(memory)) {
            basePrompt += "\nRecent context:\n" + memory;
        }
        return basePrompt;
    }

    private String buildConversationMemory(AiConversation conversation) {
        List<AiMessage> history = aiMessageRepository.findByConversationIdOrderByIdAsc(conversation.getId());
        if (history.isEmpty()) {
            return "";
        }
        int start = Math.max(0, history.size() - 2);
        StringBuilder memory = new StringBuilder();
        for (int i = start; i < history.size(); i++) {
            AiMessage message = history.get(i);
            memory.append(message.getSender())
                    .append(": ")
                    .append(truncate(message.getContent().replaceAll("\n", " "), 180))
                    .append("\n");
        }
        return memory.toString().trim();
    }

    private String truncate(String value, int maxLength) {
        if (value == null || value.length() <= maxLength) {
            return value;
        }
        return value.substring(0, maxLength) + "...";
    }

    private String fallbackAnswer(UserContext user, String message) {
        String normalized = message == null ? "" : message.trim().toLowerCase();

        if ("ROLE_DISTRIBUTOR".equals(user.role())) {
            if (isNextActionRequest(normalized)) {
                List<String> actions = distributorAiTools.getRecommendedNextActions();
                return formatNextActions(actions);
            }
            if (isPaymentRequest(normalized)) {
                var ledger = distributorAiTools.getLedgerSummary();
                return """
                        Payment and dues summary: Rs. %s has been captured, Rs. %s is pending settlement, and Rs. %s is overdue. Please follow up on pending retailer payments first and recheck the ledger after updates.
                        """.formatted(
                        ledger.capturedRevenue(),
                        ledger.pendingSettlements(),
                        ledger.overdueDues()
                ).trim();
            }
            if (isInventoryValueRequest(normalized)) {
                return """
                        Inventory value: Your current inventory is worth Rs. %s. Review high-value stock, refill fast-moving products, and check low-stock items before accepting large orders.
                        """.formatted(distributorAiTools.getInventoryValue()).trim();
            }
            if (isInventoryRequest(normalized)) {
                var inventory = distributorAiTools.getInventorySummary();
                return """
                        Inventory summary: You have %s items in stock, with %s low-stock items and %s expired items. Refill low-stock products first, review expired stock, and update quantities before checking new orders.
                        """.formatted(
                        inventory.totalItems(),
                        inventory.lowStockItems(),
                        inventory.expiredItems()
                ).trim();
            }
            if (isOrderRequest(normalized)) {
                return fallbackDistributorSummary();
            }
            return fallbackDistributorSummary();
        }

        return "AI model is temporarily unavailable. I can answer with live data once the model is available.";
    }

    private String fallbackDistributorSummary() {
        var orders = distributorAiTools.getTodayOrderSummary();
        var inventory = distributorAiTools.getInventorySummary();
        var ledger = distributorAiTools.getLedgerSummary();
        return """
                Distribution Status: Your inventory currently has %s items, including %s low-stock items and %s expired items. For orders, %s are waiting, %s are accepted, and %s are delivered. Payments show Rs. %s captured and Rs. %s overdue. You can ask me to check open orders, review inventory, view ledger and dues, plan delivery, or answer another question.
                """.formatted(
                inventory.totalItems(),
                inventory.lowStockItems(),
                inventory.expiredItems(),
                orders.waitingForReview(),
                orders.readyForPacking(),
                orders.completedDelivery(),
                ledger.capturedRevenue(),
                ledger.overdueDues()
        ).trim();
    }

    private String formatNextActions(List<String> actions) {
        List<String> safeActions = actions == null || actions.isEmpty()
                ? List.of("No urgent issue right now. Review sales report and update fast-moving stock.")
                : actions;
        return "Recommended next action: " + String.join(" ", safeActions)
                + " You can also ask for today's order summary, low-stock details, or payment and dues status.";
    }

    private boolean needsLiveData(String message) {
        String normalized = normalize(message);
        return isNextActionRequest(normalized)
                || isPaymentRequest(normalized)
                || isInventoryRequest(normalized)
                || isInventoryValueRequest(normalized)
                || isOrderRequest(normalized)
                || isSalesRequest(normalized)
                || normalized.contains("delivery")
                || normalized.contains("deliveries")
                || normalized.contains("route")
                || normalized.contains("report")
                || normalized.contains("approval")
                || normalized.contains("approve")
                || normalized.contains("cart")
                || normalized.contains("nearby")
                || normalized.contains("distributor")
                || normalized.contains("retailer");
    }

    private boolean canAnswerWithDistributorTools(String message) {
        String normalized = normalize(message);
        return isNextActionRequest(normalized)
                || isPaymentRequest(normalized)
                || isInventoryRequest(normalized)
                || isInventoryValueRequest(normalized)
                || isOrderRequest(normalized);
    }

    private String todaySalesAnswer() {
        return """
                Today's sales: Rs. %s has been captured so far. Compare it with yesterday's sales, check pending orders, and follow up on unpaid retailer dues.
                """.formatted(distributorAiTools.getTodayCapturedRevenue()).trim();
    }

    private String normalize(String message) {
        return message == null ? "" : message.trim().toLowerCase();
    }

    private boolean isNextActionRequest(String normalized) {
        return normalized.contains("what should i do")
                || normalized.contains("aaj kya karna")
                || normalized.contains("suggest next")
                || normalized.contains("next action")
                || normalized.contains("priority");
    }

    private boolean isPaymentRequest(String normalized) {
        return normalized.contains("payment")
                || normalized.contains("dues")
                || normalized.contains("ledger")
                || normalized.contains("pending")
                || normalized.contains("overdue")
                || normalized.contains("collection");
    }

    private boolean isSalesRequest(String normalized) {
        return normalized.contains("sale")
                || normalized.contains("sales")
                || normalized.contains("revenue")
                || normalized.contains("income")
                || normalized.contains("earning")
                || normalized.contains("kamai");
    }

    private boolean isInventoryRequest(String normalized) {
        return normalized.contains("inventory")
                || normalized.contains("stock")
                || normalized.contains("low stock")
                || normalized.contains("expired")
                || normalized.contains("availability");
    }

    private boolean isInventoryValueRequest(String normalized) {
        return normalized.contains("value")
                || normalized.contains("rupees")
                || normalized.contains("rs")
                || normalized.contains("worth");
    }

    private boolean isOrderRequest(String normalized) {
        return normalized.contains("order")
                || normalized.contains("orders")
                || normalized.contains("pipeline")
                || normalized.contains("order summary")
                || normalized.contains("order ka")
                || normalized.contains("scene");
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
}
