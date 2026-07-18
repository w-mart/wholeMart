package com.localb2b.marketplace.ai.controller;

import com.localb2b.marketplace.ai.dto.AiConversationDto;
import com.localb2b.marketplace.ai.dto.AiMessageDto;
import jakarta.validation.constraints.NotNull;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/ai/conversations")
public class AiConversationController {

    private final com.localb2b.marketplace.ai.service.ConversationManager conversationManager;
    private final com.localb2b.marketplace.ai.repository.AiConversationRepository conversationRepository;
    private final com.localb2b.marketplace.common.CurrentUserProvider currentUserProvider;


    public AiConversationController(com.localb2b.marketplace.ai.service.ConversationManager conversationManager,
                                    com.localb2b.marketplace.ai.repository.AiConversationRepository conversationRepository,
                                    com.localb2b.marketplace.common.CurrentUserProvider currentUserProvider) {
        this.conversationManager = conversationManager;
        this.conversationRepository = conversationRepository;
        this.currentUserProvider = currentUserProvider;
    }



    /**
     * Phase 4: Conversation list owned by current user (latest first).
     */
    @GetMapping
    public ResponseEntity<?> listConversations(@org.springframework.web.bind.annotation.RequestParam(defaultValue = "50") int limit) {
        // current user is enforced by ConversationManager ownership checks; list uses userId filter
        // via repository.
        var user = currentUserProvider.requireCurrentUser();
        int safeLimit = Math.max(1, Math.min(limit, 50));

        var conversations = conversationRepository.findByUserIdOrderByUpdatedAtDesc(user.userId());
        var sliced = conversations.stream().limit(safeLimit).toList();

        var dtos = sliced.stream().map(c -> new AiConversationDto(
                c.getId(),
                c.getUserId(),
                c.getTitle(),
                c.getStatus(),
                c.getCreatedAt(),
                c.getUpdatedAt()
        )).toList();

        return ResponseEntity.ok(Map.of(
                "conversations", dtos,
                "status", "OK"
        ));
    }


    public record CreateConversationRequest(@jakarta.validation.constraints.Size(max = 120) String title) {}

    /**
     * Create a new conversation for the current user.
     */
    @PostMapping
    public ResponseEntity<?> createConversation(@RequestBody(required = false) CreateConversationRequest request) {
        var title = request == null ? null : request.title();
        var conversation = conversationManager.createConversation(title);

        var dto = new AiConversationDto(
                conversation.getId(),
                conversation.getUserId(),
                conversation.getTitle(),
                conversation.getStatus(),
                conversation.getCreatedAt(),
                conversation.getUpdatedAt()
        );

        return ResponseEntity.ok(Map.of(
                "conversation", dto,
                "status", "OK"
        ));
    }

    /**
     * Phase 4: Get messages for a conversation, with ownership/admin enforcement.
     */
    @GetMapping("/{id}/messages")
    public ResponseEntity<?> getMessages(@PathVariable("id") @NotNull String id,
                                         @RequestParam(defaultValue = "20") int limit) {



        var conversation = conversationManager.loadConversationOwned(Long.parseLong(id));
        var messages = conversationManager.loadLastMessages(conversation, limit);

        var dtos = messages.stream().map(m -> new AiMessageDto(
                m.getId(),
                m.getConversationId(),
                m.getRole(),
                m.getMessage(),
                m.getToolUsed(),
                m.getIntent(),
                m.getCreatedAt()
        )).toList();

        return ResponseEntity.ok(Map.of(
                "conversationId", id,
                "messages", dtos,
                "status", "OK"
        ));
    }
}
