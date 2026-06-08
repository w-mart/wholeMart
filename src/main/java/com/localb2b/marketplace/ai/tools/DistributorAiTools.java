package com.localb2b.marketplace.ai.tools;

import com.localb2b.marketplace.ai.context.CurrentUserProvider;
import com.localb2b.marketplace.ai.context.UserContext;
import com.localb2b.marketplace.ai.dto.DistributorInventorySummary;
import com.localb2b.marketplace.ai.dto.DistributorLedgerSummary;
import com.localb2b.marketplace.ai.dto.DistributorOrderSummary;
import com.localb2b.marketplace.inventory.InventoryRepository;
import com.localb2b.marketplace.ledger.LedgerService;
import com.localb2b.marketplace.order.OrderRepository;
import com.localb2b.marketplace.order.OrderStatus;
import com.localb2b.marketplace.product.ProductRepository;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import org.springframework.ai.tool.annotation.Tool;
import org.springframework.stereotype.Component;

@Component
public class DistributorAiTools {
    private final CurrentUserProvider currentUserProvider;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;
    private final InventoryRepository inventoryRepository;
    private final LedgerService ledgerService;

    public DistributorAiTools(CurrentUserProvider currentUserProvider,
                              OrderRepository orderRepository,
                              ProductRepository productRepository,
                              InventoryRepository inventoryRepository,
                              LedgerService ledgerService) {
        this.currentUserProvider = currentUserProvider;
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
        this.inventoryRepository = inventoryRepository;
        this.ledgerService = ledgerService;
    }

    @Tool(description = "Get today's order summary for the current logged-in distributor")
    public DistributorOrderSummary getTodayOrderSummary() {
        Long distributorUserId = requireDistributorUserId();
        return new DistributorOrderSummary(
                orderRepository.countByDistributorUserIdAndStatus(distributorUserId, OrderStatus.PLACED),
                orderRepository.countByDistributorUserIdAndStatus(distributorUserId, OrderStatus.ACCEPTED),
                orderRepository.countByDistributorUserIdAndStatus(distributorUserId, OrderStatus.DELIVERED)
        );
    }

    @Tool(description = "Get inventory summary for the current logged-in distributor")
    public DistributorInventorySummary getInventorySummary() {
        Long distributorUserId = requireDistributorUserId();
        return new DistributorInventorySummary(
                productRepository.countByDistributorUserId(distributorUserId),
                inventoryRepository.countLowStockByDistributorUserId(distributorUserId),
                inventoryRepository.countExpiredItemsByDistributorUserId(distributorUserId)
        );
    }

    @Tool(description = "Get total inventory value in rupees for the current logged-in distributor")
    public BigDecimal getInventoryValue() {
        Long distributorUserId = requireDistributorUserId();
        return productRepository.findByDistributorUserId(distributorUserId).stream()
                .map(product -> product.getUnitPrice().multiply(BigDecimal.valueOf(product.getStockQuantity() == null ? 0 : product.getStockQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add)
                .setScale(2, RoundingMode.HALF_UP);
    }

    @Tool(description = "Get ledger and payment summary for the current logged-in distributor")
    public DistributorLedgerSummary getLedgerSummary() {
        return ledgerService.getDistributorLedgerSummary(requireDistributorUserId());
    }

    @Tool(description = "Get recommended next actions for the current logged-in distributor")
    public List<String> getRecommendedNextActions() {
        Long distributorUserId = requireDistributorUserId();
        long openOrders = orderRepository.countByDistributorUserIdAndStatus(distributorUserId, OrderStatus.PLACED);
        long lowStock = inventoryRepository.countLowStockByDistributorUserId(distributorUserId);
        DistributorLedgerSummary ledgerSummary = ledgerService.getDistributorLedgerSummary(distributorUserId);

        List<String> actions = new ArrayList<>();
        if (openOrders > 0) {
            actions.add("Check open order queue");
        }
        if (lowStock > 0) {
            actions.add("Review low stock inventory");
        }
        if (ledgerSummary.overdueDues().compareTo(BigDecimal.ZERO) > 0) {
            actions.add("Follow up overdue retailer dues");
        }
        if (actions.isEmpty()) {
            actions.add("No urgent issue. Review sales report and update fast-moving stock.");
        }
        return actions;
    }

    private Long requireDistributorUserId() {
        UserContext user = currentUserProvider.getCurrentUser();
        if (!"ROLE_DISTRIBUTOR".equals(user.role())) {
            throw new SecurityException("Distributor AI tools are only available to distributors");
        }
        return user.userId();
    }
}
