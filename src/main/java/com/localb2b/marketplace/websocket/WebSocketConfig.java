package com.localb2b.marketplace.websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
    private final LocationWebSocketHandler locationWebSocketHandler;
    private final OrderStatusWebSocketHandler orderStatusWebSocketHandler;
    private final DriverAssignmentWebSocketHandler driverAssignmentWebSocketHandler;

    public WebSocketConfig(LocationWebSocketHandler locationWebSocketHandler,
                           OrderStatusWebSocketHandler orderStatusWebSocketHandler,
                           DriverAssignmentWebSocketHandler driverAssignmentWebSocketHandler) {
        this.locationWebSocketHandler = locationWebSocketHandler;
        this.orderStatusWebSocketHandler = orderStatusWebSocketHandler;
        this.driverAssignmentWebSocketHandler = driverAssignmentWebSocketHandler;
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(locationWebSocketHandler, "/ws/location")
                .setAllowedOrigins("*");
        registry.addHandler(orderStatusWebSocketHandler, "/ws/orders")
                .setAllowedOrigins("*");
        registry.addHandler(driverAssignmentWebSocketHandler, "/ws/driver-assignments")
                .setAllowedOrigins("*");
    }
}
