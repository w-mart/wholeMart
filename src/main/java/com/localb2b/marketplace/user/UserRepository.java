package com.localb2b.marketplace.user;

import java.util.Optional;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<UserAccount, Long> {
    Optional<UserAccount> findByMobile(String mobile);

    List<UserAccount> findByRole(UserRole role);
}
