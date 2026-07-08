package com.localb2b.marketplace.common;

import com.localb2b.marketplace.user.UserRole;

public record CurrentUser(Long userId, UserRole role, String mobile) {
}
