package com.localb2b.marketplace.websocket;

import com.localb2b.marketplace.delivery.DeliveryService;
import java.math.BigDecimal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class LocationWebSocketHandler extends TextWebSocketHandler {
    private static final Logger log = LoggerFactory.getLogger(LocationWebSocketHandler.class);
    private final WebSocketSessionManager sessionManager;
    private final DeliveryService deliveryService;

    public LocationWebSocketHandler(WebSocketSessionManager sessionManager, DeliveryService deliveryService) {
        this.sessionManager = sessionManager;
        this.deliveryService = deliveryService;
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        Long userId = extractUserId(session);
        if (userId != null) {
            sessionManager.registerSession(userId, session);
            log.info("Location WS connected: userId={}, sessionId={}", userId, session.getId());
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        Long userId = extractUserId(session);
        if (userId == null) return;
        String payload = message.getPayload();
        try {
            String[] parts = payload.split(",");
            if (parts.length == 2) {
                BigDecimal lat = new BigDecimal(parts[0].trim());
                BigDecimal lng = new BigDecimal(parts[1].trim());
                deliveryService.updateDriverLocation(userId, lat, lng);
                session.sendMessage(new TextMessage("{\"type\":\"LOCATION_UPDATED\",\"lat\":" + lat + ",\"lng\":" + lng + "}"));
            }
        } catch (Exception e) {
            log.error("Invalid location payload from userId={}: {}", userId, payload);
            session.sendMessage(new TextMessage("{\"type\":\"ERROR\",\"message\":\"Invalid location format. Use: lat,lng\"}"));
        }
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        sessionManager.removeSession(session);
        log.info("Location WS disconnected: sessionId={}", session.getId());
    }

    private Long extractUserId(WebSocketSession session) {
        Object userIdAttr = session.getAttributes().get("userId");
        if (userIdAttr instanceof Number n) {
            return n.longValue();
        }
        if (userIdAttr instanceof String s) {
            try {
                return Long.parseLong(s);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }
}
