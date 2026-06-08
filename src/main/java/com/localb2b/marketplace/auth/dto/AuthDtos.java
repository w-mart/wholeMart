package com.localb2b.marketplace.auth.dto;

import com.localb2b.marketplace.user.UserRole;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

public class AuthDtos {
    public record LoginRequest(
            @NotBlank String mobile,
            @NotNull UserRole role,
            String name,
            String businessName,
            String contactName,
            String shopName,
            String gstin,
            String city,
            String state,
            String addressLine,
            String pincode,
            String email,
            String alternateMobile,
            BigDecimal latitude,
            BigDecimal longitude) {
        public LoginRequest(String mobile, UserRole role, String name) {
            this(mobile, role, name, null, null, null, null, null, null, null, null, null, null, null, null);
        }
    }

    public record RefreshTokenRequest(@NotBlank String refreshToken) {
    }

    public record AuthResponse(Long userId, UserRole role, String accessToken, String refreshToken) {
    }
}
