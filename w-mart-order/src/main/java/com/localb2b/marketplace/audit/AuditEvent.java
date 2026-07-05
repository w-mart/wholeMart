package com.localb2b.marketplace.audit;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Lob;
import jakarta.persistence.Table;
import java.time.Instant;
import lombok.Getter;

@Getter
@Entity
@Table(name = "audit_events")
public class AuditEvent extends BaseEntity {
    @Column(nullable = true)
    private Long actorUserId;

    @Column(nullable = false)
    private String eventType;

    private String targetType;

    private Long targetId;

    @Lob
    private String detailsJson;

    @Column(nullable = false)
    private Instant occurredAt;

    protected AuditEvent() {
    }

    public AuditEvent(Long actorUserId,
                      String eventType,
                      String targetType,
                      Long targetId,
                      String detailsJson,
                      Instant occurredAt) {
        this.actorUserId = actorUserId;
        this.eventType = eventType;
        this.targetType = targetType;
        this.targetId = targetId;
        this.detailsJson = detailsJson;
        this.occurredAt = occurredAt;
    }

    public AuditEvent(Long actorUserId, String eventType, String targetType, Long targetId, String detailsJson) {
        this(actorUserId, eventType, targetType, targetId, detailsJson, Instant.now());
    }

    public AuditEvent(Long actorUserId, String eventType, String targetType, Long targetId) {
        this(actorUserId, eventType, targetType, targetId, null, Instant.now());
    }

}
