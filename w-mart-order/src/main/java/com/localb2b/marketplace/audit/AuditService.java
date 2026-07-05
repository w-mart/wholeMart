package com.localb2b.marketplace.audit;

import com.localb2b.marketplace.user.common.CurrentUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AuditService {
    private final AuditEventRepository auditEventRepository;

    public AuditService(AuditEventRepository auditEventRepository) {
        this.auditEventRepository = auditEventRepository;
    }

    @Transactional
    public void record(CurrentUser currentUser, String eventType, String detailsJson) {
        auditEventRepository.save(new AuditEvent(currentUser.userId(), eventType, "APPLICATION", null, detailsJson));
    }
}
