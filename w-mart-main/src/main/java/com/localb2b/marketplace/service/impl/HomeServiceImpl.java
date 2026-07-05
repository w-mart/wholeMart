package com.localb2b.marketplace.service.impl;

import com.localb2b.marketplace.service.HomeService;
import org.springframework.stereotype.Service;

@Service
public class HomeServiceImpl implements HomeService {

    @Override
    public String getWelcomeMessage() {
        return "Welcome to WholeMart - LocalB2B AI Marketplace";
    }

    @Override
    public void logHomePageVisit() {
        // Log the home page visit
    }
}
