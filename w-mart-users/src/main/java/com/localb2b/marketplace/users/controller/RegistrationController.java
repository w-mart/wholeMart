package com.localb2b.marketplace.users.controller;

import com.localb2b.marketplace.users.dto.request.UserRegistrationRequest;
import com.localb2b.marketplace.users.service.RegistrationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
@RequiredArgsConstructor
public class RegistrationController {

    private final RegistrationService registrationService;

    @GetMapping("/register")
    public String showRegistrationPage(Model model) {

        model.addAttribute("user", new UserRegistrationRequest());

        return "users/registration";
    }

    @PostMapping("/register")
    public String registerUser(
            @Valid @ModelAttribute("user") UserRegistrationRequest request,
            BindingResult bindingResult,
            Model model) {

        if (bindingResult.hasErrors()) {
            return "users/registration";
        }

        if (!request.getPersonalInfo().getPassword().equals(request.getPersonalInfo().getConfirmPassword())) {

            model.addAttribute("passwordError",
                    "Password and Confirm Password do not match.");

            return "users/registration";
        }

        try {

            registrationService.registerUser(request);

            return "redirect:/login?registered";

        } catch (Exception ex) {

            model.addAttribute("registrationError",
                    ex.getMessage());

            return "users/registration";
        }

    }

}