package com.localb2b.marketplace.ai.entity;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;

@Entity
@Table(name = "ai_messages")
public class AiMessage extends BaseEntity {
    @Column(nullable = false)
    private Long conversationId;

    @Column(nullable = false)
    private String sender;

    @Lob
    @Column(nullable = false)
    private String content;

    protected AiMessage() {
    }

    public AiMessage(Long conversationId, String sender, String content) {
        this.conversationId = conversationId;
        this.sender = sender;
        this.content = content;
    }
}
