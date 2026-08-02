package com.localb2b.marketplace.distributor;

import com.localb2b.marketplace.common.CurrentUserProvider;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/distributors")
public class DistributorApiController {
    private final DistributorService distributorService;
    private final CurrentUserProvider currentUserProvider;

    public DistributorApiController(DistributorService distributorService, CurrentUserProvider currentUserProvider) {
        this.distributorService = distributorService;
        this.currentUserProvider = currentUserProvider;
    }

    @GetMapping("/nearby")
    public List<DistributorProfileDto> nearby() {
        Long userId = currentUserProvider.requireCurrentUser().userId();
        List<DistributorProfileDto> result = distributorService.findNearbyApproved(userId, 30).stream()
                .map(this::toDto)
                .toList();
        System.out.println("[API] /api/v1/distributors/nearby userId=" + userId + " -> size=" + result.size());
        return result;
    }

    @GetMapping("/nearby/summary")
    public DistributorService.DistributorSummary nearbySummary() {
        return distributorService.getNearbySummary(currentUserProvider.requireCurrentUser().userId(), 30);
    }

    private DistributorProfileDto toDto(DistributorProfile profile) {
        return new DistributorProfileDto(profile.getId(), profile.getUserId(), profile.getBusinessName(),
                profile.getContactName(), profile.getShopName(), profile.getGstin(), profile.getCity(),
                profile.getState(), profile.getAddressLine(), profile.getPincode(),
                profile.getLatitude(), profile.getLongitude(), profile.isApproved(),
                profile.getBusinessPan(),
                profile.getBankAccountNumber(),
                profile.getBankIfscCode(),
                profile.getBankName(),
                profile.getGstCertificateUrl(),
                profile.getShopImageUrl(),
                profile.getWarehouseAddress(),
                profile.getWarehouseCity(),
                profile.getWarehouseState(),
                profile.getWarehousePincode(),
                profile.getWarehouseLatitude(),
                profile.getWarehouseLongitude(),
                profile.getBusinessType(),
                profile.getWebsite(),
                profile.getDescription());
    }
}
