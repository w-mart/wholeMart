package com.localb2b.marketplace.users.service.impl;

import java.time.LocalDateTime;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.localb2b.marketplace.users.dto.request.UserRegistrationRequest;
import com.localb2b.marketplace.users.entity.Address;
import com.localb2b.marketplace.users.entity.BusinessProfile;
import com.localb2b.marketplace.users.entity.User;
import com.localb2b.marketplace.users.enums.AccountStatus;
import com.localb2b.marketplace.users.repository.AddressRepository;
import com.localb2b.marketplace.users.repository.BusinessProfileRepository;
import com.localb2b.marketplace.users.repository.UserRepository;
import com.localb2b.marketplace.users.service.RegistrationService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class RegistrationServiceImpl implements RegistrationService {

    private final UserRepository userRepository;
    private final AddressRepository addressRepository;
    private final BusinessProfileRepository businessRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void registerUser(UserRegistrationRequest request) {

        if (userRepository.existsByEmail(request.getPersonalInfo().getEmail())) {
            throw new RuntimeException("Email already registered.");
        }

        if (userRepository.existsByMobileNumber(request.getPersonalInfo().getMobileNumber())) {
            throw new RuntimeException("Mobile number already registered.");
        }

        User user = User.builder()
                .firstName(request.getPersonalInfo().getFirstName())
                .middleName(request.getPersonalInfo().getMiddleName())
                .lastName(request.getPersonalInfo().getLastName())
                .mobileNumber(request.getPersonalInfo().getMobileNumber())
                .email(request.getPersonalInfo().getEmail())
                .password(passwordEncoder.encode(request.getPersonalInfo().getPassword()))
                .role(request.getPersonalInfo().getRole())
                .accountStatus(AccountStatus.PENDING)
                .mobileVerified(false)
                .emailVerified(false)
                .gstVerified(false)
                .kycVerified(false)
                .accountLocked(false)
                .failedLoginAttempts(0)
                .build();

        userRepository.save(user);

        Address address = Address.builder()
                .user(user)
                .country(request.getAddress().getCountry())
                .state(request.getAddress().getState())
                .district(request.getAddress().getDistrict())
                .city(request.getAddress().getCity())
                .area(request.getAddress().getArea())
                .pinCode(request.getAddress().getPinCode())
                .addressLine1(request.getAddress().getAddressLine1())
                .addressLine2(request.getAddress().getAddressLine2())
                .defaultAddress(true)
                .build();

        addressRepository.save(address);

        BusinessProfile business = BusinessProfile.builder()
                .user(user)
                .businessName(request.getBusinessInfo().getBusinessName())
                .shopName(request.getBusinessInfo().getShopName())
                .businessType(request.getBusinessInfo().getBusinessType())
                .gstin(request.getBusinessInfo().getGstin())
                .panNumber(request.getBusinessInfo().getPanNumber())
                .build();

        businessRepository.save(business);

    }
}