package com.localb2b.marketplace.websocket;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class OrderStatusWebSocketHandler extends TextWebSocketHandler {
    private static final Logger log = LoggerFactory.getLogger(OrderStatusWebSocketHandler.class);
    private final WebSocketSessionManager sessionManager;
    public OrderStatusWebSocketHandler(WebSocketSessionManager sessionManager) {
        this.sessionManager = sessionManager;
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        Long userId = extractUserId(session);
        if (userId != null) {
            sessionManager.registerSession(userId, session);
            log.info("OrderStatus WS connected: userId={}, sessionId={}", userId, session.getId());
        }
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) {
        log.debug("OrderStatus WS message from sessionId={}: {}", session.getId(), message.getPayload());
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
        sessionManager.removeSession(session);
        log.info("OrderStatus WS disconnected: sessionId={}", session.getId());
    }

    public void notifyOrderStatusChange(Long retailerUserId, Long distributorUserId, String message) {
        sessionManager.sendMessageToUser(retailerUserId, message);
        sessionManager.sendMessageToUser(distributorUserId, message);
    }

    public void notifyUser(Long userId, String message) {
        sessionManager.sendMessageToUser(userId, message);
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
