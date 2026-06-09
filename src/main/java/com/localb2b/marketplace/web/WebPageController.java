package com.localb2b.marketplace.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class WebPageController {

    @GetMapping("/")
    public String home() {
        return "home";
    }

    @GetMapping("/.")
    public String dotHome() {
        return "redirect:/";
    }

    @GetMapping("/web/{area}/{page}")
    public String page(@PathVariable String area, @PathVariable String page) {
        return area + "/" + page;
    }
}
