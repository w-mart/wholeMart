package com.localb2b.marketplace.ai.repository;

import com.localb2b.marketplace.ai.entity.AiMessage;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AiMessageRepository extends JpaRepository<AiMessage, Long> {
    List<AiMessage> findByConversationIdOrderByIdAsc(Long conversationId);
    List<AiMessage> findByConversationId(Long conversationId);
}
