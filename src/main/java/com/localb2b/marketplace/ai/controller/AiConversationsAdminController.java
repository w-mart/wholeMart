package com.localb2b.marketplace.ai.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * Placeholder to avoid accidental empty package scanning issues.
 */
@RestController
@RequestMapping("/api/v1/ai/admin")
class AiConversationsAdminController {

    @GetMapping("/ping")
    ResponseEntity<?> ping() {
        return ResponseEntity.ok(Map.of("status", "AI_ADMIN_STUB"));
    }
}

