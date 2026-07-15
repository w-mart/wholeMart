package com.localb2b.marketplace.ai.action;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AiPendingActionRepository extends JpaRepository<AiPendingAction, Long> {

    List<AiPendingAction> findByRequestedByUserIdOrderByCreatedAtDesc(Long requestedByUserId);

}

