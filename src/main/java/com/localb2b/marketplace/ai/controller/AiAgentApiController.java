package com.localb2b.marketplace.ai.controller;

import com.localb2b.marketplace.ai.dto.AiActionConfirmRequest;
import com.localb2b.marketplace.ai.dto.AiChatRequest;
import com.localb2b.marketplace.ai.dto.AiChatResponse;
import com.localb2b.marketplace.ai.entity.AiConversation;
import com.localb2b.marketplace.ai.entity.AiMessage;
import com.localb2b.marketplace.ai.service.AiActionService;
import com.localb2b.marketplace.ai.service.AiAgentService;
import com.localb2b.marketplace.common.CurrentUserProvider;
import jakarta.validation.Valid;
import java.util.List;
import java.util.Map;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/ai")
public class AiAgentApiController {
    private final AiAgentService aiAgentService;
    private final AiActionService aiActionService;
    private final CurrentUserProvider currentUserProvider;

    public AiAgentApiController(AiAgentService aiAgentService, AiActionService aiActionService, CurrentUserProvider currentUserProvider) {
        this.aiAgentService = aiAgentService;
        this.aiActionService = aiActionService;
        this.currentUserProvider = currentUserProvider;
    }

    @PostMapping("/agent/chat")
    public AiChatResponse chat(@Valid @RequestBody AiChatRequest request) {
        return aiAgentService.chat(currentUserProvider.requireCurrentUser(), request);
    }

    @PostMapping("/actions/confirm")
    public Map<String, String> confirm(@Valid @RequestBody AiActionConfirmRequest request) {
        return Map.of("message", aiActionService.confirm(currentUserProvider.requireCurrentUser(), request));
    }

    @GetMapping("/conversations")
    public List<AiConversation> conversations() {
        return aiAgentService.conversations(currentUserProvider.requireCurrentUser());
    }

    @GetMapping("/conversations/{id}/messages")
    public List<AiMessage> messages(@PathVariable Long id) {
        return aiAgentService.messages(currentUserProvider.requireCurrentUser(), id);
    }
}
