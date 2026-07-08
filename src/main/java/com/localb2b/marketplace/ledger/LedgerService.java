package com.localb2b.marketplace.ledger;

import com.localb2b.marketplace.ai.dto.DistributorLedgerSummary;
import java.math.BigDecimal;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
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

    @Transactional(readOnly = true)
    public BigDecimal getTodayCapturedRevenue(Long distributorUserId) {
        ZoneId zoneId = ZoneId.systemDefault();
        Instant start = LocalDate.now(zoneId).atStartOfDay(zoneId).toInstant();
        Instant end = LocalDate.now(zoneId).plusDays(1).atStartOfDay(zoneId).toInstant();
        BigDecimal capturedRevenue = ledgerRepository.sumAmountByDistributorUserIdBetween(distributorUserId, start, end);
        return capturedRevenue == null ? BigDecimal.ZERO : capturedRevenue;
    }
}
