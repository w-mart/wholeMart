package com.localb2b.marketplace;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.util.StringUtils;

@SpringBootApplication
@EnableSpringDataWebSupport(pageSerializationMode = EnableSpringDataWebSupport.PageSerializationMode.VIA_DTO)
public class LocalB2bMarketplaceApplication {

    private static final Logger log = LoggerFactory.getLogger(LocalB2bMarketplaceApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(LocalB2bMarketplaceApplication.class, args);
    }

    @Bean
    ApplicationRunner aiStartupDiagnostics(Environment environment,
                                           ObjectProvider<ChatClient.Builder> chatClientBuilderProvider) {
        return args -> {
            String chatModel = environment.getProperty("spring.ai.model.chat", "not-set");
            String aiKey = environment.getProperty("spring.ai.openai.api-key", "");
            boolean hasConfiguredKey = StringUtils.hasText(aiKey)
                    && !"PASTE_VALID_GROQ_API_KEY_HERE".equals(aiKey);
            boolean chatClientAvailable = false;
            String chatClientError = null;

            try {
                chatClientAvailable = chatClientBuilderProvider.getIfAvailable() != null;
            } catch (BeansException ex) {
                chatClientError = ex.getMostSpecificCause().getMessage();
            }

            log.info("AI startup diagnostics: spring.ai.model.chat={}, aiKeyConfigured={}, chatClientAvailable={}",
                    chatModel, hasConfiguredKey, chatClientAvailable);
            if (chatClientError != null) {
                log.warn("AI startup diagnostics: ChatClient is unavailable: {}", chatClientError);
            }
        };
    }
}
