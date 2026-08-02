package com.localb2b.marketplace.auth;

import com.localb2b.marketplace.auth.dto.AuthDtos.LoginRequest;
import com.localb2b.marketplace.user.UserRole;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/web/auth")
public class AuthWebController {
    private final AuthService authService;

    public AuthWebController(AuthService authService) {
        this.authService = authService;
    }

    @GetMapping("/login")
    public String login(Model model) {
        model.addAttribute("roles", UserRole.values());
        return "auth/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/web/auth/login";
    }

    @PostMapping("/login")
    public String loginSubmit(@RequestParam(required = false) String mobile, 
                               @RequestParam String role,
                               @RequestParam String password,
                               @RequestParam(required = false) String name,
                               @RequestParam(required = false) String businessName,
                               @RequestParam(required = false) String contactName,
                               @RequestParam(required = false) String shopName,
                               @RequestParam(required = false) String gstin,
                               @RequestParam(required = false) String city,
                               @RequestParam(required = false) String state,
                               @RequestParam(required = false) String addressLine,
                               @RequestParam(required = false) String pincode,
                               @RequestParam String email,
                               @RequestParam(required = false) String alternateMobile,
                               @RequestParam(required = false) BigDecimal latitude,
                               @RequestParam(required = false) BigDecimal longitude,
                               HttpSession session,
                               Model model) {
        try {
            String normalizedMobile = mobile != null ? AuthService.normalizeMobile(mobile) : null;
            // UI sends ROLE_* values; support also Admin/Retailer style just in case.
            String normalizedRole = role == null ? null : role.trim();
            if (normalizedRole != null && !normalizedRole.startsWith("ROLE_")) {
                normalizedRole = "ROLE_" + normalizedRole.toUpperCase();
            }
            UserRole userRole = UserRole.valueOf(normalizedRole);

            var response = authService.login(new LoginRequest(
                    normalizedMobile,
                    userRole,
                    password,
                    name,
                    businessName,
                    contactName,
                    shopName,
                    gstin,
                    city,
                    state,
                    addressLine,
                    pincode,
                    email,
                    alternateMobile,
                    latitude,
                    longitude));
            session.setAttribute("userId", response.userId());
            session.setAttribute("role", response.role().name());
            session.setAttribute("email", email);
            session.setAttribute("mobile", normalizedMobile);
            session.setAttribute("username", name == null || name.isBlank() ? response.role().name().replace("ROLE_", "") + " User" : name);
            return dashboardRedirect(response.role());
        } catch (RuntimeException ex) {
            model.addAttribute("roles", UserRole.values());
            model.addAttribute("error", ex.getMessage());
            return "auth/login";
        }
    }

    @PostMapping("/register")
    public String registerSubmit(@RequestParam String fullName,
                                  @RequestParam String mobile,
                                  @RequestParam(required = false) String email,
                                  @RequestParam String role,
                                  @RequestParam String password,
                                  @RequestParam String confirmPassword,
                                  @RequestParam(required = false) String businessName,
                                  @RequestParam(required = false) String contactName,
                                  @RequestParam(required = false) String shopName,
                                  @RequestParam(required = false) String gstin,
                                  @RequestParam(required = false) String ownerName,
                                  @RequestParam(required = false) String city,
                                  @RequestParam(required = false) String state,
                                  @RequestParam(required = false) String addressLine,
                                  @RequestParam(required = false) String pincode,
                                  @RequestParam(required = false) String alternateMobile,
                                  @RequestParam(required = false) BigDecimal latitude,
                                  @RequestParam(required = false) BigDecimal longitude,
                                  @RequestParam(required = false) String licenseNumber,
                                  @RequestParam(required = false) String aadhaarNumber,
                                  @RequestParam(required = false) String vehicleType,
                                  @RequestParam(required = false) String vehicleNumber,
                                  HttpSession session,
                                  Model model) {
        try {
            // Normalize role from "Retailer" to "ROLE_RETAILER"
            String normalizedRole = role == null ? null : role.trim();
            if (normalizedRole != null && !normalizedRole.startsWith("ROLE_")) {
                normalizedRole = "ROLE_" + normalizedRole.toUpperCase();
            }
            UserRole userRole = UserRole.valueOf(normalizedRole);

            String normalizedMobile = AuthService.normalizeMobile(mobile);
            var response = authService.register(new com.localb2b.marketplace.auth.dto.AuthDtos.RegisterRequest(
                    fullName,
                    normalizedMobile,
                    email,
                    userRole,
                    password,
                    confirmPassword,
                    businessName,
                    contactName,
                    shopName,
                    gstin,
                    ownerName,
                    city,
                    state,
                    addressLine,
                    pincode,
                    alternateMobile,
                    latitude,
                    longitude,
                    fullName,
                    licenseNumber,
                    aadhaarNumber,
                    vehicleType,
                    vehicleNumber,
                    null,
                    null));

            session.setAttribute("userId", response.userId());
            session.setAttribute("role", response.role().name());
            session.setAttribute("mobile", normalizedMobile);
            session.setAttribute("username", fullName);
            return dashboardRedirect(response.role());
        } catch (RuntimeException ex) {
            model.addAttribute("roles", UserRole.values());
            model.addAttribute("error", ex.getMessage());
            return "auth/login";
        }
    }

    private String dashboardRedirect(UserRole role) {
        return switch (role) {
            case ROLE_RETAILER -> "redirect:/web/retailer/dashboard";
            case ROLE_DISTRIBUTOR -> "redirect:/web/distributor/dashboard";
            case ROLE_DRIVER -> "redirect:/web/driver/dashboard";
            case ROLE_ADMIN -> "redirect:/web/admin/dashboard";
        };
    }
}
