package com.localb2b.marketplace.ai.dto;

import com.fasterxml.jackson.annotation.JsonAlias;
import jakarta.validation.constraints.NotNull;

public record AiActionConfirmRequest(@NotNull Long actionId, @JsonAlias("confirmed") boolean confirm) {
}
