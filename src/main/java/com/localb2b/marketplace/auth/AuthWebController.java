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

    @PostMapping("/login")
    public String loginSubmit(@RequestParam String mobile,
                              @RequestParam UserRole role,
                              @RequestParam(required = false) String name,
                              @RequestParam(required = false) String businessName,
                              @RequestParam(required = false) String contactName,
                              @RequestParam(required = false) String shopName,
                              @RequestParam(required = false) String gstin,
                              @RequestParam(required = false) String city,
                              @RequestParam(required = false) String state,
                              @RequestParam(required = false) String addressLine,
                              @RequestParam(required = false) String pincode,
                              @RequestParam(required = false) String email,
                              @RequestParam(required = false) String alternateMobile,
                              @RequestParam(required = false) BigDecimal latitude,
                              @RequestParam(required = false) BigDecimal longitude,
                              HttpSession session,
                              Model model) {
        try {
            String normalizedMobile = AuthService.normalizeMobile(mobile);
            var response = authService.login(new LoginRequest(
                    normalizedMobile,
                    role,
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
            session.setAttribute("mobile", normalizedMobile);
            session.setAttribute("username", name == null || name.isBlank() ? response.role().name().replace("ROLE_", "") + " User" : name);
            return dashboardRedirect(response.role());
        } catch (RuntimeException ex) {
            model.addAttribute("roles", UserRole.values());
            model.addAttribute("error", "Unable to sign in right now. Please check the database connection and try again.");
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
