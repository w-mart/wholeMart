package com.localb2b.marketplace.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebPageController {
    @GetMapping("/")
    public String home() { return "home"; }

    @GetMapping("/web/retailer/dashboard")
    public String retailerDashboard() { return "retailer/dashboard"; }
    @GetMapping("/web/retailer/distributors")
    public String retailerDistributors() { return "retailer/distributors"; }
    @GetMapping("/web/retailer/products")
    public String retailerProducts() { return "retailer/products"; }
    @GetMapping("/web/retailer/cart")
    public String retailerCart() { return "retailer/cart"; }
    @GetMapping("/web/retailer/orders")
    public String retailerOrders() { return "retailer/orders"; }
    @GetMapping("/web/retailer/ledger")
    public String retailerLedger() { return "retailer/ledger"; }
    @GetMapping("/web/retailer/payments")
    public String retailerPayments() { return "retailer/payments"; }
    @GetMapping("/web/retailer/reports")
    public String retailerReports() { return "retailer/reports"; }
    @GetMapping("/web/retailer/alerts")
    public String retailerAlerts() { return "retailer/alerts"; }

    @GetMapping("/web/distributor/dashboard")
    public String distributorDashboard() { return "distributor/dashboard"; }
    @GetMapping("/web/distributor/products")
    public String distributorProducts() { return "distributor/products"; }
    @GetMapping("/web/distributor/add-product")
    public String distributorAddProduct() { return "distributor/add-product"; }
    @GetMapping("/web/distributor/orders")
    public String distributorOrders() { return "distributor/orders"; }
    @GetMapping("/web/distributor/orders/view")
    public String distributorOrderView() { return "distributor/order-view"; }
    @GetMapping("/web/distributor/dues")
    public String distributorDues() { return "distributor/dues"; }
    @GetMapping("/web/distributor/delivery")
    public String distributorDelivery() { return "distributor/delivery"; }
    @GetMapping("/web/distributor/drivers")
    public String distributorDrivers() { return "distributor/drivers"; }
    @GetMapping("/web/distributor/alerts")
    public String distributorAlerts() { return "distributor/alerts"; }
    @GetMapping("/web/distributor/reports")
    public String distributorReports() { return "distributor/reports"; }

    @GetMapping("/web/driver/dashboard")
    public String driverDashboard() { return "driver/dashboard"; }
    @GetMapping("/web/driver/deliveries")
    public String driverDeliveries() { return "driver/deliveries"; }
    @GetMapping("/web/driver/earnings")
    public String driverEarnings() { return "driver/earnings"; }
    @GetMapping("/web/driver/orders")
    public String driverOrders() { return "driver/orders"; }
    @GetMapping("/web/driver/reports")
    public String driverReports() { return "driver/reports"; }
    @GetMapping("/web/driver/alerts")
    public String driverAlerts() { return "driver/alerts"; }

    @GetMapping("/web/admin/dashboard")
    public String adminDashboard() { return "admin/dashboard"; }
    @GetMapping("/web/admin/users")
    public String adminUsers() { return "admin/users"; }
    @GetMapping("/web/admin/distributor-approvals")
    public String adminDistributorApprovals() { return "admin/distributor-approvals"; }
    @GetMapping("/web/admin/driver-approvals")
    public String adminDriverApprovals() { return "admin/driver-approvals"; }
    @GetMapping("/web/admin/orders")
    public String adminOrders() { return "admin/orders"; }
    @GetMapping("/web/admin/payments")
    public String adminPayments() { return "admin/payments"; }
    @GetMapping("/web/admin/reports")
    public String adminReports() { return "admin/reports"; }

    @GetMapping("/web/aip-studio")
    public String aipStudio() { return "aip-studio"; }
}
