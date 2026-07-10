package com.localb2b.marketplace.distributor;

import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.localb2b.marketplace.user.UserRepository;
import com.localb2b.marketplace.user.UserRole;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DistributorService {
    private final DistributorProfileRepository distributorProfileRepository;
    private final UserRepository userRepository;

    public DistributorService(DistributorProfileRepository distributorProfileRepository, UserRepository userRepository) {
        this.distributorProfileRepository = distributorProfileRepository;
        this.userRepository = userRepository;
    }

    @Transactional
    public List<DistributorProfile> findNearbyApproved(Long retailerUserId, double radiusKm) {
        syncMissingDistributorProfiles();
        // UI expects the table count to match nearby/summary "total".
        // Therefore, return all distributors (approved + unapproved) from /nearby.
        // The DTO still includes profile.isApproved().
        return distributorProfileRepository.findAll();
    }

    @Transactional
    public DistributorSummary getNearbySummary(Long retailerUserId, double radiusKm) {
        syncMissingDistributorProfiles();
        List<DistributorProfile> profiles = distributorProfileRepository.findAll();
        long approved = profiles.stream().filter(DistributorProfile::isApproved).count();
        return new DistributorSummary(profiles.size(), approved);
    }

    @Transactional
    public DistributorDto approve(Long profileId) {
        DistributorProfile profile = distributorProfileRepository.findById(profileId)
                .orElseThrow(() -> new IllegalArgumentException("Distributor profile not found"));
        profile.approve();
        distributorProfileRepository.save(profile);
        return new DistributorDto(profile.getId(), profile.getUserId(), profile.getBusinessName(), profile.isApproved());
    }

    @Transactional(readOnly = true)
    public Page<DistributorDto> findAllProfiles(Pageable pageable) {
        syncMissingDistributorProfiles();
        return distributorProfileRepository.findAll(pageable).map(p -> new DistributorDto(p.getId(), p.getUserId(), p.getBusinessName(), p.isApproved()));
    }

    private void syncMissingDistributorProfiles() {
        userRepository.findByRole(UserRole.ROLE_DISTRIBUTOR).forEach(user -> {
            distributorProfileRepository.findByUserId(user.getId())
                    .orElseGet(() -> distributorProfileRepository.save(new DistributorProfile(user.getId(), user.getName())));
        });
    }

    public record DistributorSummary(int total, long approved) {
    }
}
