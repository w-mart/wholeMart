package com.localb2b.marketplace.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.localb2b.marketplace.service.admin.AdminService;
import com.localb2b.marketplace.entity.user.UserAccount;
import com.localb2b.marketplace.repository.user.UserAccountRepository;

@RestController
@RequestMapping("/api/v1/admins")
public class AdminController {

    private final AdminService adminService;
    private final UserAccountRepository userAccountRepository;

    public AdminController(AdminService adminService, UserAccountRepository userAccountRepository) {
        this.adminService = adminService;
        this.userAccountRepository = userAccountRepository;
    }

    @PostMapping("/distributors/{distributorId}/approve")
    @PreAuthorize("hasAnyRole('ADMIN', 'SUPER_ADMIN')")
    public ResponseEntity<?> approveDistributor(
            @PathVariable Long distributorId,
            @AuthenticationPrincipal UserDetails adminUserDetails) {

        // Get the admin's UserAccount to pass their ID for auditing
        UserAccount adminAccount = userAccountRepository.findByUsername(adminUserDetails.getUsername())
                .orElseThrow(() -> new IllegalStateException("Admin user account not found."));

        adminService.approveDistributor(distributorId, adminAccount.getId());
        return ResponseEntity.ok().body("Distributor approved successfully.");
    }
}