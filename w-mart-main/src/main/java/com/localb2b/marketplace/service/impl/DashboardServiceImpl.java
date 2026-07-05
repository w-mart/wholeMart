package com.localb2b.marketplace.service.impl;

import com.localb2b.marketplace.dto.DashboardDTO;
import com.localb2b.marketplace.service.DashboardService;
import org.springframework.stereotype.Service;

@Service
public class DashboardServiceImpl implements DashboardService {

    @Override
    public DashboardDTO getDashboardData() {
        DashboardDTO dashboard = new DashboardDTO();
        dashboard.setTotalUsers(0);
        dashboard.setActiveOrders(0);
        dashboard.setTotalRevenue(0.0);
        return dashboard;
    }

    @Override
    public void refreshDashboard() {
        // Refresh dashboard data
    }
}
