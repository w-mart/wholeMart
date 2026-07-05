package com.localb2b.marketplace.controller;

import com.localb2b.marketplace.dto.DashboardDTO;
import com.localb2b.marketplace.service.DashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    private DashboardService dashboardService;

    @GetMapping
    public String dashboard(Model model) {
        DashboardDTO dashboardData = dashboardService.getDashboardData();
        model.addAttribute("dashboard", dashboardData);
        return "dashboard";
    }
}
