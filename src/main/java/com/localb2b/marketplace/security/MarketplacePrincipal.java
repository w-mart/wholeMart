package com.localb2b.marketplace.security;

import com.localb2b.marketplace.user.UserRole;

public record MarketplacePrincipal(Long userId, UserRole role, String mobile) {
}
