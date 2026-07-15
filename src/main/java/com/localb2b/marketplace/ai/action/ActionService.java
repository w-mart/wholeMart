package com.localb2b.marketplace.ai.action;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.localb2b.marketplace.ai.entity.AiConversation;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.ai.service.ConversationManager;
import com.localb2b.marketplace.common.CurrentUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Objects;

@Service
public class ActionService {

    private final AiPendingActionRepository repository;
    private final ConversationManager conversationManager;
    private final AiSecurityValidator securityValidator;
    private final ObjectMapper objectMapper;

    public record ConfirmResult(Long actionId, boolean confirmed, String status) {}

    public ActionService(
            AiPendingActionRepository repository,
            ConversationManager conversationManager,
            AiSecurityValidator securityValidator,
            ObjectMapper objectMapper
    ) {
        this.repository = repository;
        this.conversationManager = conversationManager;
        this.securityValidator = securityValidator;
        this.objectMapper = objectMapper;
    }

    @Transactional
    public ConfirmResult confirm(Long actionId, String confirmation, CurrentUser user) {
        Objects.requireNonNull(user, "user");
        if (actionId == null) {
            throw new IllegalArgumentException("actionId");
        }
        if (confirmation == null || confirmation.isBlank()) {
            return new ConfirmResult(actionId, false, "INVALID_CONFIRMATION");
        }

        // Phase 11: enforce conversation ownership/admin.
        AiPendingAction pending = repository.findById(actionId)
                .orElseThrow(() -> new IllegalArgumentException("Pending action not found: " + actionId));

        // ConversationManager already enforces ownership/admin when loading conversation.
        AiConversation conversation = conversationManager.loadConversationOwned(pending.getConversationId());
        // ownership verified by loadConversationOwned; no further checks needed.

        // Basic confirmation semantics (can be tightened later)
        String normalized = confirmation.trim().toUpperCase();
        boolean ok = normalized.equals("CONFIRM") || normalized.equals("YES") || normalized.equals("APPROVE");
        if (!ok) {
            pending.setStatus("REJECTED");
            return new ConfirmResult(actionId, false, "REJECTED");
        }

        pending.setStatus("CONFIRMED");
        // Phase 11 placeholder: we do not execute domain writes yet.
        // In a later phase, actionType/payloadJson will be mapped to real services.
        pending = repository.save(pending);

        return new ConfirmResult(pending.getId(), true, "OK");
    }
}


