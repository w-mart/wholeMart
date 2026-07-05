package com.localb2b.marketplace.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserController {

    @GetMapping("/web/auth/login")
    public String showLoginPage() {
        return "redirect:/"; // Redirect to home, which will show the popup
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam String fullName, @RequestParam String email, @RequestParam String password) {
        // TODO: Add user registration logic (e.g., save to database)
        return "redirect:/";
    }
}