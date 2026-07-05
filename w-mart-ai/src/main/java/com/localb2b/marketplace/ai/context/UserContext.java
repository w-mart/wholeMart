package com.localb2b.marketplace.ai.context;

public record UserContext(
        Long userId,
        String role,
        Long retailerId,
        Long distributorId,
        Long driverId,
        String displayName
) {
}
