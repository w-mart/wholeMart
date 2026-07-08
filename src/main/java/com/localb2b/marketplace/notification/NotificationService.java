package com.localb2b.marketplace.notification;

import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {
    private static final String TOPIC = "localb2b.notifications";
    private final KafkaTemplate<String, Object> kafkaTemplate;

    public NotificationService(KafkaTemplate<String, Object> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    public void publish(NotificationEvent event) {
        kafkaTemplate.send(TOPIC, String.valueOf(event.userId()), event);
    }
}
