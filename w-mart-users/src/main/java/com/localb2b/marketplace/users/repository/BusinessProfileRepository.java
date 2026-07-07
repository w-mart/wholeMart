package com.localb2b.marketplace.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.localb2b.marketplace.users.entity.BusinessProfile;

@Repository
public interface BusinessProfileRepository extends JpaRepository<BusinessProfile, Long> {

    boolean existsByGstin(String gstin);

}