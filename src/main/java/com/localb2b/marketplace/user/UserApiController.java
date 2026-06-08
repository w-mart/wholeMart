package com.localb2b.marketplace.user;

import com.localb2b.marketplace.common.CurrentUserProvider;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
public class UserApiController {
    private final UserRepository userRepository;
    private final CurrentUserProvider currentUserProvider;

    public UserApiController(UserRepository userRepository, CurrentUserProvider currentUserProvider) {
        this.userRepository = userRepository;
        this.currentUserProvider = currentUserProvider;
    }

    @GetMapping("/drivers")
    public List<UserDto> drivers() {
        UserRole role = currentUserProvider.requireCurrentUser().role();
        if (role != UserRole.ROLE_ADMIN && role != UserRole.ROLE_DISTRIBUTOR) {
            throw new SecurityException("Only admins and distributors can list drivers");
        }
        return userRepository.findByRole(UserRole.ROLE_DRIVER).stream()
                .map(this::toDto)
                .toList();
    }

    private UserDto toDto(UserAccount user) {
        return new UserDto(user.getId(), user.getName(), user.getMobile(), user.getRole(), user.getStatus(), user.getCreatedAt());
    }
}
