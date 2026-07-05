package com.localb2b.marketplace.dto.response;

import com.localb2b.marketplace.entity.user.UserRole;
import com.localb2b.marketplace.enums.UserStatus;

import java.util.UUID;

public record RegistrationResponse(
        UUID userUuid,
        String username,
        UserRole role,
        UserStatus status
) {}