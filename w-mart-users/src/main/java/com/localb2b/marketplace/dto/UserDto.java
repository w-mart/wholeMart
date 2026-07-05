package com.localb2b.marketplace.dto;

import com.localb2b.marketplace.entity.user.UserRole;
import com.localb2b.marketplace.enums.UserStatus;
import java.time.LocalDateTime;
import java.util.UUID;

public record UserDto(Long id, UUID uuid, String firstName, String lastName, String mobile, String email, UserRole role, UserStatus status, LocalDateTime createdAt) {
}
