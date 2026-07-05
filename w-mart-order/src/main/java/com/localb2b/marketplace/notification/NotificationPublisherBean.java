package com.localb2b.marketplace.notification;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
public class NotificationPublisherBean implements NotificationService.NotificationPublisher {

    private static final Logger log = LoggerFactory.getLogger(NotificationPublisherBean.class);

    @Override
    public void send(String topic, String key, Object data) {
        log.info("Notification publish to topic='{}' key='{}' data={}", topic, key, data);
    }
}
