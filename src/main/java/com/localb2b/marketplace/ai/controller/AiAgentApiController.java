package com.localb2b.marketplace.ai.controller;

import com.localb2b.marketplace.ai.dto.AiChatResponseDto;
import com.localb2b.marketplace.ai.intent.IntentDetector;
import com.localb2b.marketplace.ai.security.AiSecurityValidator;
import com.localb2b.marketplace.ai.service.ConversationManager;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/ai/agent")
public class AiAgentApiController {

    private final com.localb2b.marketplace.ai.orchestrator.AiOrchestratorService orchestrator;

    public AiAgentApiController(com.localb2b.marketplace.ai.orchestrator.AiOrchestratorService orchestrator) {
        this.orchestrator = orchestrator;
    }


    public record ChatRequest(
            @NotNull Long conversationId,
            @NotBlank String message
    ) {
    }


    /**
     * Phase 3: REST API stub only (no AI logic yet).
     */
    @PostMapping("/chat")
    public ResponseEntity<?> chat(@RequestBody @Valid ChatRequest request) {
        // Phase 8+: delegate to orchestrator (security -> conversation -> intent -> tool? -> ChatClient -> persist response)
        AiChatResponseDto response = orchestrator.chat(request.conversationId(), request.message());
        return ResponseEntity.ok(response);
    }




}

