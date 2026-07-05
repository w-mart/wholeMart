package com.localb2b.marketplace.repository.user;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.localb2b.marketplace.entity.user.UserAccount;

public interface UserAccountRepository extends JpaRepository<UserAccount, Long> {
    Optional<UserAccount> findByUsername(String username);
    Optional<UserAccount> findByEmail(String email);
    Boolean existsByUsername(String username);
    Boolean existsByEmail(String email);
}