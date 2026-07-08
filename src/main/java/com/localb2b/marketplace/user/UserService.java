package com.localb2b.marketplace.user;

import com.localb2b.marketplace.common.CurrentUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Transactional(readOnly = true)
    public UserAccount requireActiveUser(CurrentUser currentUser) {
        UserAccount user = userRepository.findById(currentUser.userId())
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        if (user.getStatus() != UserStatus.ACTIVE) {
            throw new SecurityException("User account is not active");
        }
        if (user.getRole() != currentUser.role()) {
            throw new SecurityException("Authenticated role does not match user account");
        }
        return user;
    }
}
