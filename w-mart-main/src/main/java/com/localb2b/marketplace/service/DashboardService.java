package com.localb2b.marketplace.service;

import com.localb2b.marketplace.dto.DashboardDTO;

public interface DashboardService {

    DashboardDTO getDashboardData();

    void refreshDashboard();
}
