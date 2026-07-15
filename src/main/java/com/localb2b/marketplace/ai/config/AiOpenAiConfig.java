package com.localb2b.marketplace.ai.config;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Minimal AI configuration for Phase 1.
 * <p>
 * ChatModel/ChatClient are already wired in the main application; this class exists
 * so the AI module can later be configured in isolation.
 */
@Configuration
public class AiOpenAiConfig {

    @Bean
    public ChatClient.Builder aiChatClientBuilder(ChatClient.Builder baseBuilder) {
        return baseBuilder;
    }
}

