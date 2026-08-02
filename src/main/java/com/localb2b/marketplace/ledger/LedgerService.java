package com.localb2b.marketplace.ledger;

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

    @Transactional
    public LedgerEntry recordEntry(Long retailerUserId, Long distributorUserId, BigDecimal amount,
                                   String reason, LedgerEntryType type, Long orderId) {
        BigDecimal debits = ledgerRepository.sumDebitsByDistributorUserId(distributorUserId);
        BigDecimal credits = ledgerRepository.sumCreditsByDistributorUserId(distributorUserId);
        BigDecimal balanceAfter = credits.subtract(debits);
        if (type == LedgerEntryType.DEBIT) {
            balanceAfter = balanceAfter.subtract(amount);
        } else {
            balanceAfter = balanceAfter.add(amount);
        }

        LedgerEntry entry = new LedgerEntry(retailerUserId, distributorUserId, amount, reason, type, orderId, balanceAfter);
        return ledgerRepository.save(entry);
    }

    @Transactional
    public LedgerEntry payDues(Long retailerUserId, Long distributorUserId, BigDecimal amount, Long orderId) {
        return recordEntry(retailerUserId, distributorUserId, amount, "Dues payment", LedgerEntryType.DEBIT, orderId);
    }

    @Transactional(readOnly = true)
    public BigDecimal getOutstandingAmount(Long distributorUserId, Long retailerUserId) {
        BigDecimal debits = ledgerRepository.sumDebitsByRetailerUserId(retailerUserId);
        BigDecimal credits = ledgerRepository.sumCreditsByRetailerUserId(retailerUserId);
        return credits.subtract(debits);
    }

    @Transactional(readOnly = true)
    public BigDecimal getDistributorOutstanding(Long distributorUserId) {
        BigDecimal debits = ledgerRepository.sumDebitsByDistributorUserId(distributorUserId);
        BigDecimal credits = ledgerRepository.sumCreditsByDistributorUserId(distributorUserId);
        return credits.subtract(debits);
    }

    @Transactional(readOnly = true)
    public BigDecimal getOpeningBalance(Long distributorUserId, LocalDate date) {
        ZoneId zoneId = ZoneId.systemDefault();
        Instant startOfDay = date.atStartOfDay(zoneId).toInstant();
        BigDecimal creditsBefore = ledgerRepository.sumAmountByDistributorUserIdBetween(distributorUserId, Instant.EPOCH, startOfDay);
        return creditsBefore == null ? BigDecimal.ZERO : creditsBefore;
    }

    @Transactional(readOnly = true)
    public BigDecimal getClosingBalance(Long distributorUserId, LocalDate date) {
        ZoneId zoneId = ZoneId.systemDefault();
        Instant startOfDay = date.atStartOfDay(zoneId).toInstant();
        Instant endOfDay = date.plusDays(1).atStartOfDay(zoneId).toInstant();
        BigDecimal creditsUpTo = ledgerRepository.sumAmountByDistributorUserIdBetween(distributorUserId, Instant.EPOCH, endOfDay);
        return creditsUpTo == null ? BigDecimal.ZERO : creditsUpTo;
    }

    @Transactional(readOnly = true)
    public DistributorLedgerSummary getDistributorLedgerSummary(Long distributorUserId) {
        BigDecimal capturedRevenue = ledgerRepository.sumAmountByDistributorUserId(distributorUserId);
        if (capturedRevenue == null) {
            capturedRevenue = BigDecimal.ZERO;
        }
        BigDecimal totalOutstanding = getDistributorOutstanding(distributorUserId);
        LocalDate today = LocalDate.now();
        BigDecimal openingBalance = getOpeningBalance(distributorUserId, today);
        BigDecimal closingBalance = getClosingBalance(distributorUserId, today);
        return new DistributorLedgerSummary(capturedRevenue, BigDecimal.ZERO, BigDecimal.ZERO, totalOutstanding, openingBalance, closingBalance);
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
