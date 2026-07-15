package com.localb2b.marketplace.ai.repository;

import com.localb2b.marketplace.ai.entity.AiConversation;
import com.localb2b.marketplace.ai.entity.AiMessage;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AiMessageRepository extends JpaRepository<AiMessage, Long> {

    List<AiMessage> findByConversationOrderByCreatedAtAsc(AiConversation conversation);

    List<AiMessage> findTop10ByConversationOrderByCreatedAtDesc(AiConversation conversation);
}

