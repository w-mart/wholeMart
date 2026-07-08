package com.localb2b.marketplace.ai.entity;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;
import lombok.Getter;

@Getter
@Entity
@Table(name = "ai_actions")
public class AiAction extends BaseEntity {
    @Column(nullable = false)
    private Long userId;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AiActionType actionType;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private AiActionStatus status = AiActionStatus.PENDING_CONFIRMATION;

    @Lob
    @Column(nullable = false)
    private String payloadJson;

    protected AiAction() {
    }

    public AiAction(Long userId, AiActionType actionType, String payloadJson) {
        this.userId = userId;
        this.actionType = actionType;
        this.payloadJson = payloadJson;
    }

    public void confirm() {
        status = AiActionStatus.CONFIRMED;
    }
}
