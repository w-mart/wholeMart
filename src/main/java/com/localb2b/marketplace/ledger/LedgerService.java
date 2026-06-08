package com.localb2b.marketplace.ledger;

import com.localb2b.marketplace.ai.dto.DistributorLedgerSummary;
import java.math.BigDecimal;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LedgerService {
    private final LedgerRepository ledgerRepository;

    public LedgerService(LedgerRepository ledgerRepository) {
        this.ledgerRepository = ledgerRepository;
    }

    @Transactional(readOnly = true)
    public DistributorLedgerSummary getDistributorLedgerSummary(Long distributorUserId) {
        BigDecimal capturedRevenue = ledgerRepository.sumAmountByDistributorUserId(distributorUserId);
        if (capturedRevenue == null) {
            capturedRevenue = BigDecimal.ZERO;
        }
        return new DistributorLedgerSummary(capturedRevenue, BigDecimal.ZERO, BigDecimal.ZERO);
    }
}
