package com.localb2b.marketplace.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    @GetMapping
    public String viewProfile(Model model) {
        return "profile";
    }

    @PostMapping("/update")
    public String updateProfile() {
        return "redirect:/profile";
    }
}
