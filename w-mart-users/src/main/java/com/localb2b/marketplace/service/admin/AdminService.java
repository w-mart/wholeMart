package com.localb2b.marketplace.service.admin;

import com.localb2b.marketplace.entity.distributor.DistributorProfile;
import com.localb2b.marketplace.entity.user.UserAccount;
import com.localb2b.marketplace.entity.user.UserRole;
import com.localb2b.marketplace.enums.UserStatus;
import com.localb2b.marketplace.repository.distributor.DistributorProfileRepository;
import com.localb2b.marketplace.repository.user.UserAccountRepository;
import java.time.LocalDateTime;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AdminService {

    private final UserAccountRepository userAccountRepository;
    private final DistributorProfileRepository distributorProfileRepository;

    public AdminService(UserAccountRepository userAccountRepository, DistributorProfileRepository distributorProfileRepository) {
        this.userAccountRepository = userAccountRepository;
        this.distributorProfileRepository = distributorProfileRepository;
    }

    @Transactional
    public void approveDistributor(Long distributorUserId, Long adminUserId) {
        UserAccount distributorAccount = userAccountRepository.findById(distributorUserId)
                .orElseThrow(() -> new IllegalArgumentException("Distributor user account not found with ID: " + distributorUserId));

        if (distributorAccount.getRole() != UserRole.ROLE_DISTRIBUTOR) {
            throw new IllegalStateException("User is not a distributor.");
        }

        // Find the distributor profile
        DistributorProfile distributorProfile = distributorProfileRepository.findByUser(distributorAccount)
                .orElseThrow(() -> new IllegalStateException("Distributor profile not found for user: " + distributorAccount.getUsername()));

        distributorAccount.setStatus(UserStatus.ACTIVE);
        userAccountRepository.save(distributorAccount);

        distributorProfile.setVerificationStatus("APPROVED");
        distributorProfile.setApprovedBy(adminUserId);
        distributorProfile.setApprovedAt(LocalDateTime.now());
        distributorProfileRepository.save(distributorProfile);
    }
}