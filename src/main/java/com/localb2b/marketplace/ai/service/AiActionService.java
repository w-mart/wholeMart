package com.localb2b.marketplace.ai.service;

import com.localb2b.marketplace.ai.dto.AiActionConfirmRequest;
import com.localb2b.marketplace.ai.entity.AiAction;
import com.localb2b.marketplace.ai.entity.AiActionType;
import com.localb2b.marketplace.ai.repository.AiActionRepository;
import com.localb2b.marketplace.common.CurrentUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AiActionService {
    private final AiActionRepository aiActionRepository;

    public AiActionService(AiActionRepository aiActionRepository) {
        this.aiActionRepository = aiActionRepository;
    }

    @Transactional
    public AiAction createPending(CurrentUser currentUser, AiActionType actionType, String payloadJson) {
        return aiActionRepository.save(new AiAction(currentUser.userId(), actionType, payloadJson));
    }

    @Transactional
    public String confirm(CurrentUser currentUser, AiActionConfirmRequest request) {
        AiAction action = aiActionRepository.findById(request.actionId())
                .orElseThrow(() -> new IllegalArgumentException("AI action not found"));
        if (!action.getUserId().equals(currentUser.userId())) {
            throw new SecurityException("AI action is outside current user scope");
        }
        if (!request.confirm()) {
            return "Action rejected.";
        }
        action.confirm();
        return "Action confirmed and queued for execution: " + action.getActionType();
    }
}
