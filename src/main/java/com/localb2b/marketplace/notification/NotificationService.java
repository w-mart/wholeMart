package com.localb2b.marketplace.notification;

//import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {
    // private static final String TOPIC = "localb2b.notifications";
    // private final KafkaTemplate<String, Object> kafkaTemplate;
    //
    // public NotificationService(KafkaTemplate<String, Object> kafkaTemplate) {
    //     this.kafkaTemplate = kafkaTemplate;
    // }

    private final NotificationRepository notificationRepository;

    public NotificationService(NotificationRepository notificationRepository) {
        this.notificationRepository = notificationRepository;
    }

    public void publish(NotificationEvent event) {
        // Previously we used Kafka for notifications. For now persist to DB instead.
        Notification n = new Notification(event.userId(), event.channel(), event.message());
        notificationRepository.save(n);
        // kafkaTemplate.send(TOPIC, String.valueOf(event.userId()), event);
    }
}
