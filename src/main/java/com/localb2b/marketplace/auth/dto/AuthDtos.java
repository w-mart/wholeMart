package com.localb2b.marketplace.auth.dto;

import com.localb2b.marketplace.user.UserRole;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;

public class AuthDtos {

    public record LoginRequest(
            @NotBlank String mobile,
            @NotNull UserRole role,
            @NotBlank String password,
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
        public LoginRequest(String mobile, UserRole role, String password, String name) {
            this(mobile, role, password, name,
                    null, null, null, null, null, null, null, null,
                    null, null, null, null);
        }
    }

    public record RegisterRequest(
            @NotBlank String fullName,
            @NotBlank String mobile,
            String email,
            @NotNull UserRole role,
            @NotBlank String password,
            @NotBlank String confirmPassword,
            String businessName,
            String contactName,
            String shopName,
            String gstin,
            String ownerName,
            String city,
            String state,
            String addressLine,
            String pincode,
            String alternateMobile,
            BigDecimal latitude,
            BigDecimal longitude,
            String driverName,
            String licenseNumber,
            String aadhaarNumber,
            String vehicleType,
            String vehicleNumber,
            String employeeId,
            String department) {
    }

    public record RefreshTokenRequest(@NotBlank String refreshToken) {
    }

    public record AuthResponse(Long userId, UserRole role, String accessToken, String refreshToken) {
    }
}

