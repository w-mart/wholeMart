package com.localb2b.marketplace.websocket;

import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArraySet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

@Component
public class WebSocketSessionManager {
    private static final Logger log = LoggerFactory.getLogger(WebSocketSessionManager.class);
    private final ConcurrentHashMap<Long, CopyOnWriteArraySet<WebSocketSession>> userSessions = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, WebSocketSession> allSessions = new ConcurrentHashMap<>();

    public void registerSession(Long userId, WebSocketSession session) {
        userSessions.computeIfAbsent(userId, k -> new CopyOnWriteArraySet<>()).add(session);
        allSessions.put(session.getId(), session);
        log.info("WebSocket session registered: userId={}, sessionId={}", userId, session.getId());
    }

    public void removeSession(WebSocketSession session) {
        allSessions.remove(session.getId());
        userSessions.forEach((userId, sessions) -> {
            sessions.remove(session);
            if (sessions.isEmpty()) {
                userSessions.remove(userId);
            }
        });
        log.info("WebSocket session removed: sessionId={}", session.getId());
    }

    public Set<WebSocketSession> getSessionsForUser(Long userId) {
        return userSessions.getOrDefault(userId, new CopyOnWriteArraySet<>());
    }

    public boolean isUserOnline(Long userId) {
        Set<WebSocketSession> sessions = userSessions.get(userId);
        return sessions != null && !sessions.isEmpty() && sessions.stream().anyMatch(WebSocketSession::isOpen);
    }

    public void sendMessageToUser(Long userId, String message) {
        Set<WebSocketSession> sessions = userSessions.get(userId);
        if (sessions == null) {
            log.debug("No WebSocket sessions for userId={}", userId);
            return;
        }
        for (WebSocketSession session : sessions) {
            if (session.isOpen()) {
                try {
                    synchronized (session) {
                        session.sendMessage(new org.springframework.web.socket.TextMessage(message));
                    }
                } catch (IOException e) {
                    log.error("Failed to send WebSocket message to userId={}, sessionId={}: {}",
                            userId, session.getId(), e.getMessage());
                }
            }
        }
    }

    public void broadcastToUsers(Set<Long> userIds, String message) {
        for (Long userId : userIds) {
            sendMessageToUser(userId, message);
        }
    }

    public int getTotalActiveSessions() {
        return allSessions.size();
    }

    public int getTotalOnlineUsers() {
        return userSessions.size();
    }
}
