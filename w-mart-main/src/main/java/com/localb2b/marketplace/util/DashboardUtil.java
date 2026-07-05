package com.localb2b.marketplace.util;

import com.localb2b.marketplace.dto.DashboardDTO;

public class DashboardUtil {

    public static String formatRevenue(double revenue) {
        return String.format("$%.2f", revenue);
    }

    public static String getMetricStatus(DashboardDTO dashboard) {
        if (dashboard.getActiveOrders() > 100) {
            return "High Activity";
        } else if (dashboard.getActiveOrders() > 50) {
            return "Medium Activity";
        } else {
            return "Low Activity";
        }
    }

    public static int calculatePercentage(int value, int total) {
        if (total == 0) return 0;
        return (value * 100) / total;
    }
}
