package com.localb2b.marketplace.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import com.localb2b.marketplace.entity.user.UserRole;

public record RegistrationRequest(
    @NotBlank @Size(max = 50) String firstName,
    @Size(max = 50) String lastName,
    @NotBlank @Size(max = 50) String username,
    @NotBlank @Email @Size(max = 100) String email,
    @NotBlank @Size(max = 20) String mobile,
    @NotBlank @Size(min = 8, max = 128) String password,
    @NotNull UserRole role,

    // Profile-specific fields
    String companyName, // For Distributor
    String shopName,    // For Retailer
    String designation, // For Admin
    String licenseNumber // For Driver
) {
}