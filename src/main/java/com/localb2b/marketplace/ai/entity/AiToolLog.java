package com.localb2b.marketplace.ai.entity;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;

@Entity
@Table(name = "ai_tool_logs")
public class AiToolLog extends BaseEntity {
    @Column(nullable = false)
    private Long userId;

    @Column(nullable = false)
    private String toolName;

    @Lob
    private String inputJson;

    protected AiToolLog() {
    }

    public AiToolLog(Long userId, String toolName, String inputJson) {
        this.userId = userId;
        this.toolName = toolName;
        this.inputJson = inputJson;
    }
}
