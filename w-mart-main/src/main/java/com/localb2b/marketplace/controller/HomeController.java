package com.localb2b.marketplace.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {

    @GetMapping({"", "/home"})
    public String home() {
        return "home";
    }

    @GetMapping("about")
    public String about() {
        return "home";
    }

    @GetMapping("contact")
    public String contact() {
        return "home";
    }
}
