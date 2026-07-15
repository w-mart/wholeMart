package com.localb2b.marketplace.ai.service;

import com.localb2b.marketplace.ai.entity.AiConversation;
import com.localb2b.marketplace.ai.entity.AiMessage;
import com.localb2b.marketplace.ai.repository.AiConversationRepository;
import com.localb2b.marketplace.ai.repository.AiMessageRepository;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.common.CurrentUserProvider;
import com.localb2b.marketplace.user.UserRole;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;

@Service
public class ConversationManager {

    private final AiConversationRepository conversationRepository;
    private final AiMessageRepository messageRepository;
    private final CurrentUserProvider currentUserProvider;

    public ConversationManager(AiConversationRepository conversationRepository,
                                AiMessageRepository messageRepository,
                                CurrentUserProvider currentUserProvider) {
        this.conversationRepository = conversationRepository;
        this.messageRepository = messageRepository;
        this.currentUserProvider = currentUserProvider;
    }

    @Transactional
    public AiConversation createConversation(String title) {
        CurrentUser user = currentUserProvider.requireCurrentUser();

        AiConversation conversation = new AiConversation();
        conversation.setUserId(user.userId());
        conversation.setTitle(title == null || title.isBlank() ? "AI Chat" : title.trim());
        conversation.setStatus("ACTIVE");

        return conversationRepository.save(conversation);
    }

    @Transactional(readOnly = true)
    public AiConversation loadConversationOwned(Long conversationId) {
        Objects.requireNonNull(conversationId, "conversationId");
        CurrentUser user = currentUserProvider.requireCurrentUser();

        AiConversation conversation = conversationRepository.findById(conversationId)
                .orElseThrow(() -> new IllegalArgumentException("Conversation not found: " + conversationId));

        if (!isOwnerOrAdmin(user, conversation)) {
            throw new SecurityException("Conversation ownership check failed");
        }

        return conversation;
    }

    @Transactional
    public AiMessage saveUserMessage(AiConversation conversation, String message, String intent) {
        Objects.requireNonNull(conversation, "conversation");
        Objects.requireNonNull(message, "message");

        AiMessage aiMessage = new AiMessage();
        aiMessage.setConversation(conversation);
        aiMessage.setRole("user");
        aiMessage.setMessage(message);
        aiMessage.setIntent(intent);
        return messageRepository.save(aiMessage);
    }

    @Transactional
    public AiMessage saveAssistantMessage(AiConversation conversation, String message, String toolUsed) {
        Objects.requireNonNull(conversation, "conversation");
        Objects.requireNonNull(message, "message");

        AiMessage aiMessage = new AiMessage();
        aiMessage.setConversation(conversation);
        aiMessage.setRole("assistant");
        aiMessage.setMessage(message);
        aiMessage.setToolUsed(toolUsed);
        return messageRepository.save(aiMessage);
    }

    @Transactional(readOnly = true)
    public List<AiMessage> loadLastMessages(AiConversation conversation, int limit) {
        int safeLimit = Math.max(1, Math.min(limit, 50));
        return messageRepository.findTop10ByConversationOrderByCreatedAtDesc(conversation)
                .stream()
                .limit(safeLimit)
                .toList();
    }

    private boolean isOwnerOrAdmin(CurrentUser user, AiConversation conversation) {
        if (user.role() == UserRole.ROLE_ADMIN) {
            return true;
        }
        return conversation.getUserId().equals(user.userId());
    }
}

