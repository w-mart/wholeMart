package com.localb2b.marketplace.ai.security;

import com.localb2b.marketplace.ai.entity.AiConversation;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.common.CurrentUserProvider;
import org.springframework.stereotype.Component;

import java.util.Objects;

/**
 * Phase 6: Security Layer (stub).
 * <p>
 * Enforces:
 * - authenticated user presence
 * - conversation ownership / admin
 * - placeholder prompt validation
 * <p>
 * Tool-level data permission enforcement is expected to be applied when tools execute.
 */
@Component
public class AiSecurityValidator {

    private final CurrentUserProvider currentUserProvider;

    public AiSecurityValidator(CurrentUserProvider currentUserProvider) {
        this.currentUserProvider = currentUserProvider;
    }

    public CurrentUser requireAuthenticatedUser() {
        return currentUserProvider.requireCurrentUser();
    }

    public void validateConversationOwnership(Long conversationId) {
        AiConversation conversation = null;
        // This validator is intentionally minimal for Phase 6.
        // Ownership checks are already enforced in ConversationManager.loadConversationOwned.
        // When the tool/orchestrator layer is introduced, this class can be expanded.
        if (conversationId == null) {
            throw new IllegalArgumentException("conversationId");
        }
    }

    public void validatePrompt(String message) {
        if (message == null || message.isBlank()) {
            throw new IllegalArgumentException("message is required");
        }

        // Placeholder prompt-injection protections.
        // Real protections will be added in Phase 6/10.
        // For now, do nothing besides basic sanity checks.
    }

    /**
     * Stub to be used by orchestrator/tools.
     * "Never allow Retailer -> Distributor data" should be enforced in tool permission logic.
     */
    public void validateNoRetailerToDistributorAccess(CurrentUser user) {
        Objects.requireNonNull(user, "user");
        // No-op for Phase 6 stub.
    }
}

