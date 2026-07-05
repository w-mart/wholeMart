package com.localb2b.marketplace.notification;

import org.springframework.stereotype.Service;

@Service
public class NotificationService {
    private static final String TOPIC = "localb2b.notifications";
    private final NotificationPublisher kafkaTemplate;

    public NotificationService(NotificationPublisher kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    public void publish(NotificationEvent event) {
        kafkaTemplate.send(TOPIC, String.valueOf(event.userId()), event);
    }

    public interface NotificationPublisher {
        void send(String topic, String key, Object data);
    }
}
