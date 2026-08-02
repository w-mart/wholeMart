package com.localb2b.marketplace.ledger;

import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.common.CurrentUserProvider;
import com.localb2b.marketplace.user.UserRole;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/ledger")
public class LedgerApiController {
    private final LedgerRepository ledgerRepository;
    private final CurrentUserProvider currentUserProvider;

    public LedgerApiController(LedgerRepository ledgerRepository, CurrentUserProvider currentUserProvider) {
        this.ledgerRepository = ledgerRepository;
        this.currentUserProvider = currentUserProvider;
    }

    @GetMapping
    public List<LedgerEntryDto> mine() {
        CurrentUser currentUser = currentUserProvider.requireCurrentUser();
        if (currentUser.role() == UserRole.ROLE_DISTRIBUTOR) {
            return ledgerRepository.findByDistributorUserId(currentUser.userId()).stream().map(this::toDto).toList();
        }
        return ledgerRepository.findByRetailerUserId(currentUser.userId()).stream().map(this::toDto).toList();
    }

    private LedgerEntryDto toDto(LedgerEntry entry) {
        return new LedgerEntryDto(entry.getId(), entry.getRetailerUserId(), entry.getDistributorUserId(),
                entry.getAmount(), entry.getReason(), entry.getType(), entry.getOrderId(), entry.getBalanceAfter(), entry.getCreatedAt());
    }
}
