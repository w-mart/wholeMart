package com.localb2b.marketplace.repository;

import org.springframework.stereotype.Repository;

@Repository
public interface HomeRepository {

    String fetchWelcomeContent();
}
