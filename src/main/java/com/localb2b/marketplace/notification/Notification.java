package com.localb2b.marketplace.notification;

import com.localb2b.marketplace.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;

@Getter
@Entity
@Table(name = "notifications")
public class Notification extends BaseEntity {
    @Column(nullable = false)
    private Long userId;

    @Column(nullable = false)
    private String channel;

    @Column(nullable = false, length = 1024)
    private String message;

    protected Notification() {
    }

    public Notification(Long userId, String channel, String message) {
        this.userId = userId;
        this.channel = channel;
        this.message = message;
    }
}
