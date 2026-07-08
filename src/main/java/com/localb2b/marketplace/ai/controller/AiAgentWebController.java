package com.localb2b.marketplace.ai.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AiAgentWebController {
    @GetMapping({"/web/retailer/ai-chat", "/web/distributor/ai-chat", "/web/driver/ai-chat", "/web/admin/ai-chat"})
    public String aiChat(HttpServletRequest request) {
        String uri = request.getRequestURI();
        if (uri.contains("/retailer/")) {
            return "retailer/ai-chat";
        }
        if (uri.contains("/distributor/")) {
            return "distributor/ai-chat";
        }
        if (uri.contains("/driver/")) {
            return "driver/ai-chat";
        }
        return "admin/ai-chat";
    }
}
