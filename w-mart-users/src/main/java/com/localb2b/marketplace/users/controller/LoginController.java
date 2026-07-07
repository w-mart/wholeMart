package com.localb2b.marketplace.users.controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;

@Controller
public class LoginController {

    @GetMapping("/login")
    public String login(
            @RequestParam(required = false)
            String registered,
            Model model) {

        if (registered != null) {

            model.addAttribute(
                    "successMessage",
                    "Registration completed successfully. Please login.");

        }

        return "users/login";
    }
}