package com.localb2b.marketplace.auth;

import com.localb2b.marketplace.auth.dto.AuthDtos.AuthResponse;
import com.localb2b.marketplace.auth.dto.AuthDtos.LoginRequest;
import com.localb2b.marketplace.distributor.DistributorProfile;
import com.localb2b.marketplace.distributor.DistributorProfileRepository;
import com.localb2b.marketplace.driver.DriverProfile;
import com.localb2b.marketplace.driver.DriverProfileRepository;
import com.localb2b.marketplace.retailer.RetailerProfile;
import com.localb2b.marketplace.retailer.RetailerProfileRepository;
import com.localb2b.marketplace.security.JwtService;
import com.localb2b.marketplace.security.MarketplacePrincipal;
import com.localb2b.marketplace.user.UserAccount;
import com.localb2b.marketplace.user.UserRepository;
import com.localb2b.marketplace.user.UserRole;
import com.localb2b.marketplace.user.UserStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

@Service
public class AuthService {
    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final RetailerProfileRepository retailerProfileRepository;
    private final DistributorProfileRepository distributorProfileRepository;
    private final DriverProfileRepository driverProfileRepository;

    public AuthService(UserRepository userRepository,
                       JwtService jwtService,
                       RetailerProfileRepository retailerProfileRepository,
                       DistributorProfileRepository distributorProfileRepository,
                       DriverProfileRepository driverProfileRepository) {
        this.userRepository = userRepository;
        this.jwtService = jwtService;
        this.retailerProfileRepository = retailerProfileRepository;
        this.distributorProfileRepository = distributorProfileRepository;
        this.driverProfileRepository = driverProfileRepository;
    }

    @Transactional
    public AuthResponse login(LoginRequest request) {
        String normalizedMobile = normalizeMobile(request.mobile());
        if (normalizedMobile.isBlank()) {
            throw new IllegalArgumentException("Mobile number is required");
        }

        UserAccount user = userRepository.findByMobile(normalizedMobile)
                .map(existingUser -> {
                    if (existingUser.getStatus() != UserStatus.ACTIVE) {
                        throw new ResponseStatusException(HttpStatus.FORBIDDEN, "User account is not active");
                    }
                    if (!existingUser.getRole().equals(request.role())) {
                        throw new IllegalArgumentException("Login role does not match existing account role");
                    }
                    existingUser.updateLoginProfile(request.name());
                    return existingUser;
                })
                .orElseGet(() -> userRepository.save(new UserAccount(defaultName(request), normalizedMobile, request.role())));
        ensureRoleProfile(user, request);
        return new AuthResponse(user.getId(), user.getRole(), jwtService.createAccessToken(user), jwtService.createRefreshToken(user));
    }

    public static String normalizeMobile(String mobile) {
        if (mobile == null) {
            return "";
        }
        return mobile.replaceAll("\\D+", "").trim();
    }

    @Transactional(readOnly = true)
    public AuthResponse refresh(String refreshToken) {
        MarketplacePrincipal principal = jwtService.parse(refreshToken);
        UserAccount user = userRepository.findById(principal.userId())
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        if (user.getStatus() != UserStatus.ACTIVE) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "User account is not active");
        }
        return new AuthResponse(user.getId(), user.getRole(), jwtService.createAccessToken(user), jwtService.createRefreshToken(user));
    }

    private String defaultName(LoginRequest request) {
        return request.name() == null || request.name().isBlank() ? request.role().name().replace("ROLE_", "") + " User" : request.name();
    }

    private void ensureRoleProfile(UserAccount user, LoginRequest request) {
        String displayName = defaultName(request);
        if (request.role() == UserRole.ROLE_RETAILER) {
            String shopName = request.shopName() == null || request.shopName().isBlank()
                    ? displayName
                    : request.shopName();
            retailerProfileRepository.findByUserId(user.getId())
                    .map(profile -> {
                        profile.updateProfile(
                                shopName,
                                request.city(),
                                request.state(),
                                request.addressLine(),
                                request.pincode(),
                                request.latitude(),
                                request.longitude());
                        return profile;
                    })
                    .orElseGet(() -> {
                        RetailerProfile profile = new RetailerProfile(user.getId(), shopName);
                        profile.updateProfile(
                                shopName,
                                request.city(),
                                request.state(),
                                request.addressLine(),
                                request.pincode(),
                                request.latitude(),
                                request.longitude());
                        return retailerProfileRepository.save(profile);
                    });
        } else if (request.role() == UserRole.ROLE_DISTRIBUTOR) {
            String businessName = request.businessName() == null || request.businessName().isBlank()
                    ? displayName
                    : request.businessName();
            distributorProfileRepository.findByUserId(user.getId())
                    .map(profile -> {
                        profile.updateProfile(
                                businessName,
                                request.contactName(),
                                request.shopName(),
                                request.gstin(),
                                request.city(),
                                request.state(),
                                request.addressLine(),
                                request.pincode(),
                                request.email(),
                                request.alternateMobile(),
                                request.latitude(),
                                request.longitude());
                        return profile;
                    })
                    .orElseGet(() -> {
                        DistributorProfile profile = new DistributorProfile(
                                user.getId(),
                                businessName,
                                request.latitude(),
                                request.longitude());
                        profile.updateProfile(
                                businessName,
                                request.contactName(),
                                request.shopName(),
                                request.gstin(),
                                request.city(),
                                request.state(),
                                request.addressLine(),
                                request.pincode(),
                                request.email(),
                                request.alternateMobile(),
                                request.latitude(),
                                request.longitude());
                        return distributorProfileRepository.save(profile);
                    });
        } else if (request.role() == UserRole.ROLE_DRIVER) {
            driverProfileRepository.findByUserId(user.getId())
                    .orElseGet(() -> driverProfileRepository.save(new DriverProfile(user.getId(), displayName)));
        }
    }
}
