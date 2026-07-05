package com.localb2b.marketplace.repository.admin;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.localb2b.marketplace.entity.user.UserAccount;
import com.localb2b.marketplace.entity.admin.AdminProfile;

public interface AdminProfileRepository extends JpaRepository<AdminProfile, Long> {
    Optional<AdminProfile> findByUser(UserAccount user);
}