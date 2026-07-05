package com.localb2b.marketplace.repository.distributor;

import java.util.Collection;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.localb2b.marketplace.entity.user.UserAccount;
import com.localb2b.marketplace.entity.distributor.DistributorProfile;
public interface DistributorProfileRepository extends JpaRepository<DistributorProfile, Long> {
    Optional<DistributorProfile> findByUser(UserAccount user);
    List<DistributorProfile> findByUserIn(Collection<UserAccount> users);
}