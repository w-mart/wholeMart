package com.localb2b.marketplace.repository.admin;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import com.localb2b.marketplace.entity.user.UserAccount;
import com.localb2b.marketplace.entity.user.Address;

public interface AddressRepository extends JpaRepository<Address, Long> {
    List<Address> findByUser(UserAccount user);
}