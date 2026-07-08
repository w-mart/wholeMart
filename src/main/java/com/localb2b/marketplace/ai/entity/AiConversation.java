package com.localb2b.marketplace.ai.entity;

import com.localb2b.marketplace.common.entity.BaseEntity;
import com.localb2b.marketplace.user.UserRole;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import lombok.Getter;

@Getter
@Entity
@Table(name = "ai_conversations")
public class AiConversation extends BaseEntity {
    @Column(nullable = false)
    private Long userId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private UserRole role;

    @Column(nullable = false)
    private String title;

    protected AiConversation() {
    }

    public AiConversation(Long userId, UserRole role, String title) {
        this.userId = userId;
        this.role = role;
        this.title = title;
    }

}
