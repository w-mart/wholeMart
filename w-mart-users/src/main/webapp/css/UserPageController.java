package com.localb2b.marketplace.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserPageController {

    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // Renders login.jsp
    }

    @GetMapping("/register")
    public String showRegistrationPage() {
        return "register"; // Renders register.jsp
    }

    @GetMapping("/dashboard")
    public String showDashboardPage() {
        return "dashboard"; // Renders dashboard.jsp
    }
}