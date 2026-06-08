package com.localb2b.marketplace.user;

import java.time.Instant;

public record UserDto(Long id, String name, String mobile, UserRole role, UserStatus status, Instant createdAt) {
}
