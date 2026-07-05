package com.localb2b.marketplace.service;

import com.localb2b.marketplace.dto.request.RegistrationRequest;
import com.localb2b.marketplace.entity.admin.AdminProfile;
import com.localb2b.marketplace.entity.distributor.DistributorProfile;
import com.localb2b.marketplace.entity.driver.DriverProfile;
import com.localb2b.marketplace.entity.retailer.RetailerProfile;
import com.localb2b.marketplace.entity.user.UserAccount;
import com.localb2b.marketplace.entity.user.UserRole;
import com.localb2b.marketplace.repository.admin.AdminProfileRepository;
import com.localb2b.marketplace.repository.distributor.DistributorProfileRepository;
import com.localb2b.marketplace.repository.distributor.DriverProfileRepository;
import com.localb2b.marketplace.repository.retailer.RetailerProfileRepository;
import org.springframework.stereotype.Component;

import java.util.EnumMap;
import java.util.Map;
import java.util.function.BiConsumer;

/**
 * Factory to create and hold profile creation logic.
 * This separates the profile creation logic from the registration service.
 */
@Component
public class ProfileCreatorFactory {

    private final AdminProfileRepository adminProfileRepository;
    private final DistributorProfileRepository distributorProfileRepository;
    private final DriverProfileRepository driverProfileRepository;
    private final RetailerProfileRepository retailerProfileRepository;
    private final Map<UserRole, BiConsumer<RegistrationRequest, UserAccount>> profileCreators = new EnumMap<>(UserRole.class);

    public ProfileCreatorFactory(AdminProfileRepository adminProfileRepository,
                                 DistributorProfileRepository distributorProfileRepository,
                                 DriverProfileRepository driverProfileRepository,
                                 RetailerProfileRepository retailerProfileRepository) {
        this.adminProfileRepository = adminProfileRepository;
        this.distributorProfileRepository = distributorProfileRepository;
        this.driverProfileRepository = driverProfileRepository;
        this.retailerProfileRepository = retailerProfileRepository;

        profileCreators.put(UserRole.ROLE_ADMIN, this::createAdminProfile);
        profileCreators.put(UserRole.ROLE_SUPER_ADMIN, this::createAdminProfile);
        profileCreators.put(UserRole.ROLE_DISTRIBUTOR, this::createDistributorProfile);
        profileCreators.put(UserRole.ROLE_RETAILER, this::createRetailerProfile);
        profileCreators.put(UserRole.ROLE_DRIVER, this::createDriverProfile);
    }

    private void createAdminProfile(RegistrationRequest request, UserAccount user) {
        adminProfileRepository.save(new AdminProfile(user, request.designation()));
    }

    private void createDistributorProfile(RegistrationRequest request, UserAccount user) {
        distributorProfileRepository.save(new DistributorProfile(user, request.companyName()));
    }

    private void createRetailerProfile(RegistrationRequest request, UserAccount user) {
        retailerProfileRepository.save(new RetailerProfile(user, request.shopName()));
    }

    private void createDriverProfile(RegistrationRequest request, UserAccount user) {
        driverProfileRepository.save(new DriverProfile(user, request.licenseNumber()));
    }

    public Map<UserRole, BiConsumer<RegistrationRequest, UserAccount>> getProfileCreators() {
        return profileCreators;
    }
}