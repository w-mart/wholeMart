package com.localb2b.marketplace;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.data.web.config.EnableSpringDataWebSupport;

@SpringBootApplication(scanBasePackages = "com.localb2b.marketplace")
@EnableSpringDataWebSupport(pageSerializationMode = EnableSpringDataWebSupport.PageSerializationMode.VIA_DTO)
public class LocalB2bMarketplaceApplication extends SpringBootServletInitializer {

    private static final Logger log = LoggerFactory.getLogger(LocalB2bMarketplaceApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(LocalB2bMarketplaceApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(LocalB2bMarketplaceApplication.class);
    }
}
