package com.localb2b.marketplace.ai.tools;

import com.localb2b.marketplace.ai.context.CurrentUserProvider;
import com.localb2b.marketplace.ai.context.UserContext;
import com.localb2b.marketplace.ai.dto.DistributorInventorySummary;
import com.localb2b.marketplace.common.dto.DistributorLedgerSummary;
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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ai.tool.annotation.Tool;
import org.springframework.stereotype.Component;

@Component
public class DistributorAiTools {
    private static final Logger log = LoggerFactory.getLogger(DistributorAiTools.class);

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

    @Tool(description = """
            Use this tool when the logged-in distributor asks about today's orders,
            order pipeline, pending orders, accepted orders, completed orders,
            order status, order workload, or daily order summary.

            Natural language examples:
            - "show today's order summary"
            - "aaj ke orders batao"
            - "bhai order ka kya scene hai?"
            - "pending orders kitne hain?"
            - "accepted orders kitne hain?"
            - "aaj order pipeline kya hai?"
            - "orders waiting for review dikhao"

            This returns only the current logged-in distributor's order counts.
            Never use this tool for another distributor.
            """)
    public DistributorOrderSummary getTodayOrderSummary() {
        Long distributorUserId = requireDistributorUserId();
        log.info("Getting today's order summary for distributor {}", distributorUserId);

        return new DistributorOrderSummary(
                orderRepository.countByDistributorUserIdAndStatus(distributorUserId, OrderStatus.PLACED),
                orderRepository.countByDistributorUserIdAndStatus(distributorUserId, OrderStatus.ACCEPTED),
                orderRepository.countByDistributorUserIdAndStatus(distributorUserId, OrderStatus.DELIVERED)
        );
    }

    @Tool(description = """
            Use this tool when the logged-in distributor asks about inventory,
            stock, low stock, expired items, product availability, stock planning,
            inventory attention, or stock health.

            Natural language examples:
            - "show low stock summary"
            - "stock ka kya haal hai?"
            - "low stock dikhao"
            - "inventory summary batao"
            - "kaunse product kam hain?"
            - "stock attention kya hai?"
            - "expired items kitne hain?"
            - "product availability ka scene kya hai?"

            This returns only the current logged-in distributor's inventory summary.
            Never use this tool for another distributor.
            """)
    public DistributorInventorySummary getInventorySummary() {
        Long distributorUserId = requireDistributorUserId();
        log.info("Getting inventory summary for distributor {}", distributorUserId);

        return new DistributorInventorySummary(
                productRepository.countByDistributorUserId(distributorUserId),
                inventoryRepository.countLowStockByDistributorUserId(distributorUserId),
                inventoryRepository.countExpiredItemsByDistributorUserId(distributorUserId)
        );
    }

    @Tool(description = """
            Use this tool when the logged-in distributor asks about total inventory value,
            stock value, inventory amount, total product value, or warehouse value.

            Natural language examples:
            - "total inventory value batao"
            - "stock ki total value kitni hai?"
            - "inventory amount kitna hai?"
            - "mere products ka total value kya hai?"
            - "warehouse stock value batao"

            This calculates total value using product unit price and stock quantity
            for the current logged-in distributor only.
            """)
    public BigDecimal getInventoryValue() {
        Long distributorUserId = requireDistributorUserId();
        log.info("Getting inventory value for distributor {}", distributorUserId);

        return productRepository.findByDistributorUserId(distributorUserId).stream()
                .map(product -> {
                    BigDecimal unitPrice = product.getUnitPrice() == null
                            ? BigDecimal.ZERO
                            : product.getUnitPrice();

                    int stockQuantity = product.getStockQuantity() == null
                            ? 0
                            : product.getStockQuantity();

                    return unitPrice.multiply(BigDecimal.valueOf(stockQuantity));
                })
                .reduce(BigDecimal.ZERO, BigDecimal::add)
                .setScale(2, RoundingMode.HALF_UP);
    }

    @Tool(description = """
            Use this tool when the logged-in distributor asks about ledger,
            payments, dues, pending amount, overdue dues, captured revenue,
            settlements, collections, or retailer payment follow-up.

            Natural language examples:
            - "show payment and dues summary"
            - "payment pending hai kya?"
            - "dues kitna hai?"
            - "ledger summary batao"
            - "payment ka kya scene hai?"
            - "pending settlements kitne hain?"
            - "overdue amount batao"
            - "captured revenue kitna hai?"

            This returns only the current logged-in distributor's ledger and payment summary.
            Never show another distributor's payment or ledger data.
            """)
    public DistributorLedgerSummary getLedgerSummary() {
        Long distributorUserId = requireDistributorUserId();
        log.info("Getting ledger summary for distributor {}", distributorUserId);
        return ledgerService.getDistributorLedgerSummary(distributorUserId);
    }

    @Tool(description = """
            Use this tool when the logged-in distributor asks about today's sale,
            aaj ki sale, daily sales, sales report, today's revenue, or aaj kitni sale hui.

            This returns only today's captured revenue for the current logged-in distributor.
            Never guess a sale amount and never show another distributor's sales.
            """)
    public BigDecimal getTodayCapturedRevenue() {
        Long distributorUserId = requireDistributorUserId();
        log.info("Getting today's captured revenue for distributor {}", distributorUserId);
        return ledgerService.getTodayCapturedRevenue(distributorUserId);
    }

    @Tool(description = """
            Use this tool when the logged-in distributor asks what to do next,
            daily priorities, recommended actions, business suggestions,
            urgent tasks, or first action for today.

            Natural language examples:
            - "What should I do first today?"
            - "aaj kya karna hai?"
            - "bhai aaj priority kya hai?"
            - "suggest next actions"
            - "next action batao"
            - "urgent kaam kya hai?"
            - "dashboard ke hisab se kya karu?"
            - "business priority batao"

            This tool checks current distributor orders, inventory, and ledger
            and returns practical next actions.
            """)
    public List<String> getRecommendedNextActions() {
        Long distributorUserId = requireDistributorUserId();
        log.info("Getting recommended next actions for distributor {}", distributorUserId);

        long openOrders = orderRepository.countByDistributorUserIdAndStatus(
                distributorUserId,
                OrderStatus.PLACED
        );

        long lowStock = inventoryRepository.countLowStockByDistributorUserId(
                distributorUserId
        );

        DistributorLedgerSummary ledgerSummary =
                ledgerService.getDistributorLedgerSummary(distributorUserId);

        List<String> actions = new ArrayList<>();

        if (openOrders > 0) {
            actions.add("Check open order queue: " + openOrders + " orders are waiting for review.");
        }

        if (lowStock > 0) {
            actions.add("Review low stock inventory: " + lowStock + " items need attention.");
        }

        if (ledgerSummary != null
                && ledgerSummary.overdueDues() != null
                && ledgerSummary.overdueDues().compareTo(BigDecimal.ZERO) > 0) {
            actions.add("Follow up overdue retailer dues: Rs. " + ledgerSummary.overdueDues());
        }

        if (actions.isEmpty()) {
            actions.add("No urgent issue right now. Review sales report and update fast-moving stock.");
        }

        return actions;
    }

    private Long requireDistributorUserId() {
        UserContext user = currentUserProvider.getCurrentUser();

        if (user == null || user.role() == null) {
            throw new SecurityException("Authenticated user context is required");
        }

        if (!"ROLE_DISTRIBUTOR".equals(user.role())) {
            throw new SecurityException("Distributor AI tools are only available to distributors");
        }

        if (user.userId() == null) {
            throw new SecurityException("Distributor user id is missing");
        }

        return user.userId();
    }
}
