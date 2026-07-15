package com.localb2b.marketplace.ai.controller;

import com.localb2b.marketplace.ai.action.ActionService;
import com.localb2b.marketplace.common.CurrentUserProvider;
import com.localb2b.marketplace.common.CurrentUser;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


@RestController
@RequestMapping("/api/v1/ai/actions")
public class AiActionsController {

    private final ActionService actionService;
    private final CurrentUserProvider currentUserProvider;

    public AiActionsController(ActionService actionService, CurrentUserProvider currentUserProvider) {
        this.actionService = actionService;
        this.currentUserProvider = currentUserProvider;
    }

    public record ConfirmRequest(
            @NotNull Long actionId,
            @NotBlank String confirmation
    ) {
    }

    @PostMapping("/confirm")
    public ResponseEntity<?> confirm(@RequestBody @Valid ConfirmRequest request) {
        CurrentUser user = currentUserProvider.requireCurrentUser();
        var result = actionService.confirm(request.actionId(), request.confirmation(), user);
        return ResponseEntity.ok(Map.of(
                "actionId", result.actionId(),
                "confirmed", result.confirmed(),
                "status", result.status()
        ));
    }
}


