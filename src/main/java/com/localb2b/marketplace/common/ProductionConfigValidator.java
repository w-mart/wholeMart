package com.localb2b.marketplace.common;

import java.util.Arrays;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public class ProductionConfigValidator implements ApplicationRunner {
    private static final String DEV_JWT_SECRET = "dev-secret-change-me-dev-secret-change-me";

    private final Environment environment;
    private final String jwtSecret;
    private final String dbPassword;

    public ProductionConfigValidator(Environment environment,
                                     @Value("${localb2b.auth.jwt-secret}") String jwtSecret,
                                     @Value("${spring.datasource.password:}") String dbPassword) {
        this.environment = environment;
        this.jwtSecret = jwtSecret;
        this.dbPassword = dbPassword;
    }

    @Override
    public void run(ApplicationArguments args) {
        if (!Arrays.asList(environment.getActiveProfiles()).contains("prod")) {
            return;
        }
        if (DEV_JWT_SECRET.equals(jwtSecret)) {
            throw new IllegalStateException("JWT secret must be configured for the prod profile");
        }
        if ("admin".equals(dbPassword)) {
            throw new IllegalStateException("Database password must be configured for the prod profile");
        }
    }
}
