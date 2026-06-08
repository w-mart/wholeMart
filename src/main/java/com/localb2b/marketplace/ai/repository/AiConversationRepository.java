package com.localb2b.marketplace.ai.repository;

import com.localb2b.marketplace.ai.entity.AiConversation;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AiConversationRepository extends JpaRepository<AiConversation, Long> {
    List<AiConversation> findByUserId(Long userId);
}
