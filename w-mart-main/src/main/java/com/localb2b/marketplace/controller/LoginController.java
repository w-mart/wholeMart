package com.localb2b.marketplace.controller;

import com.localb2b.marketplace.dto.LoginRequest;
import com.localb2b.marketplace.dto.LoginResponse;
import com.localb2b.marketplace.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/web/main/auth")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @PostMapping("/login")
    public String login(LoginRequest loginRequest) {
        LoginResponse response = loginService.authenticate(loginRequest);
        if (response.isSuccess()) {
            return "redirect:/dashboard";
        }
        return "redirect:/web/main/auth/login?error=true";
    }

    @GetMapping("/logout")
    public String logout() {
        return "redirect:/";
    }
}
