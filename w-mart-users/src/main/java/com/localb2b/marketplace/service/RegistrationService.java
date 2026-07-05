package com.localb2b.marketplace.service;

import com.localb2b.marketplace.dto.request.RegistrationRequest;
import com.localb2b.marketplace.dto.response.RegistrationResponse;
import com.localb2b.marketplace.entity.user.UserAccount;
import com.localb2b.marketplace.entity.user.UserRole;
import com.localb2b.marketplace.enums.UserStatus;
import com.localb2b.marketplace.repository.user.UserAccountRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.function.BiConsumer;

@Service
public class RegistrationService {

    private final UserAccountRepository userAccountRepository;
    private final PasswordEncoder passwordEncoder;
    private final Map<UserRole, BiConsumer<RegistrationRequest, UserAccount>> profileCreators;

    public RegistrationService(UserAccountRepository userAccountRepository,
                               PasswordEncoder passwordEncoder,
                               ProfileCreatorFactory profileCreatorFactory) {
        this.userAccountRepository = userAccountRepository;
        this.passwordEncoder = passwordEncoder;
        this.profileCreators = profileCreatorFactory.getProfileCreators();
    }

    @Transactional
    public RegistrationResponse registerUser(RegistrationRequest request) {
        if (userAccountRepository.existsByUsername(request.username())) {
            throw new IllegalArgumentException("Username is already taken!");
        }
        if (userAccountRepository.existsByEmail(request.email())) {
            throw new IllegalArgumentException("Email is already in use!");
        }

        UserAccount userAccount = new UserAccount();
        userAccount.setFirstName(request.firstName());
        userAccount.setLastName(request.lastName());
        userAccount.setUsername(request.username());
        userAccount.setEmail(request.email());
        userAccount.setMobile(request.mobile());
        userAccount.setPassword(passwordEncoder.encode(request.password()));
        userAccount.setRole(request.role());
        userAccount.setStatus(UserStatus.PENDING);

        UserAccount savedUser = userAccountRepository.save(userAccount);

        BiConsumer<RegistrationRequest, UserAccount> profileCreator = profileCreators.get(savedUser.getRole());
        if (profileCreator != null) {
            profileCreator.accept(request, savedUser);
        }

        return new RegistrationResponse(savedUser.getUuid(), savedUser.getUsername(), savedUser.getRole(), savedUser.getStatus());
    }
}