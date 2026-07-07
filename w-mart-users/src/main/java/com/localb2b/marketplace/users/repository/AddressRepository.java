package com.localb2b.marketplace.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.localb2b.marketplace.users.entity.Address;

@Repository
public interface AddressRepository extends JpaRepository<Address, Long> {

}