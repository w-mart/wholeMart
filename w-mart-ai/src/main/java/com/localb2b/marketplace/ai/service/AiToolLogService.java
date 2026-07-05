package com.localb2b.marketplace.ai.service;

import com.localb2b.marketplace.ai.entity.AiToolLog;
import com.localb2b.marketplace.ai.repository.AiToolLogRepository;
import com.localb2b.marketplace.user.common.CurrentUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AiToolLogService {
    private final AiToolLogRepository aiToolLogRepository;

    public AiToolLogService(AiToolLogRepository aiToolLogRepository) {
        this.aiToolLogRepository = aiToolLogRepository;
    }

    @Transactional
    public void log(CurrentUser currentUser, String toolName, String inputJson) {
        aiToolLogRepository.save(new AiToolLog(currentUser.userId(), toolName, inputJson));
    }
}
