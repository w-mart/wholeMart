package com.localb2b.marketplace;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.web.config.EnableSpringDataWebSupport;

@SpringBootApplication
@EnableSpringDataWebSupport(pageSerializationMode = EnableSpringDataWebSupport.PageSerializationMode.VIA_DTO)
public class LocalB2bMarketplaceApplication {

    private static final Logger log = LoggerFactory.getLogger(LocalB2bMarketplaceApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(LocalB2bMarketplaceApplication.class, args);
    }
}
