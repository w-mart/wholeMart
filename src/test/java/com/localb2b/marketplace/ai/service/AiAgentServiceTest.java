package com.localb2b.marketplace.ai.service;

import com.localb2b.marketplace.ai.context.CurrentUserProvider;
import com.localb2b.marketplace.ai.context.UserContext;
import com.localb2b.marketplace.ai.dto.AiChatRequest;
import com.localb2b.marketplace.ai.dto.DistributorInventorySummary;
import com.localb2b.marketplace.ai.repository.AiConversationRepository;
import com.localb2b.marketplace.ai.repository.AiMessageRepository;
import com.localb2b.marketplace.ai.tools.AdminAiTools;
import com.localb2b.marketplace.ai.tools.DistributorAiTools;
import com.localb2b.marketplace.ai.tools.DriverAiTools;
import com.localb2b.marketplace.ai.tools.RetailerAiTools;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentMatchers;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.ai.chat.client.ChatClient;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class AiAgentServiceTest {

    @Mock
    private ObjectProvider<ChatClient.Builder> chatClientBuilderProvider;

    @Mock
    private CurrentUserProvider currentUserProvider;

    @Mock
    private AiConversationRepository aiConversationRepository;

    @Mock
    private AiMessageRepository aiMessageRepository;

    @Mock
    private RetailerAiTools retailerAiTools;

    @Mock
    private DistributorAiTools distributorAiTools;

    @Mock
    private DriverAiTools driverAiTools;

    @Mock
    private AdminAiTools adminAiTools;

    private AiAgentService service;

    @BeforeEach
    void setUp() {
        when(chatClientBuilderProvider.getIfAvailable()).thenReturn(null);
        service = new AiAgentService(chatClientBuilderProvider,
                currentUserProvider,
                aiConversationRepository,
                aiMessageRepository,
                retailerAiTools,
                distributorAiTools,
                driverAiTools,
                adminAiTools);
    }

    @Test
    void shouldReturnLiveDistributorOrderSummaryWhenAskedForOrders() {
        CurrentUser currentUser = new CurrentUser(1L, UserRole.ROLE_DISTRIBUTOR, "9999999999");
        when(currentUserProvider.getCurrentUser()).thenReturn(new UserContext(
                1L,
                UserRole.ROLE_DISTRIBUTOR.name(),
                null,
                10L,
                null,
                "Test Distributor"));
        when(aiConversationRepository.save(ArgumentMatchers.any())).thenAnswer(invocation -> invocation.getArgument(0));
        when(distributorAiTools.getTodayOrderSummary()).thenReturn(new com.localb2b.marketplace.ai.dto.DistributorOrderSummary(5, 2, 3));
        when(distributorAiTools.getInventorySummary()).thenReturn(new DistributorInventorySummary(120, 10, 1));
        when(distributorAiTools.getLedgerSummary()).thenReturn(new com.localb2b.marketplace.ai.dto.DistributorLedgerSummary(
                BigDecimal.valueOf(250000.00),
                BigDecimal.valueOf(42000.00),
                BigDecimal.valueOf(7800.00)));

        var response = service.chat(currentUser, new AiChatRequest(null, "Show today's order summary."));

        assertThat(response.answer()).contains("Distribution Status");
        assertThat(response.answer()).contains("For orders, 5 are waiting, 2 are accepted, and 3 are delivered.");
        assertThat(response.answer()).contains("You can ask me to check open orders, review inventory, view ledger and dues, plan delivery, or answer another question.");
        assertThat(response.answer()).doesNotContain("Please select an option:");
        assertThat(response.requiresConfirmation()).isFalse();
        assertThat(response.actionId()).isNull();
    }

    @Test
    void shouldReturnNotWorkingMessageForSmallTalkWhenNoAiModelIsAvailable() {
        CurrentUser currentUser = new CurrentUser(1L, UserRole.ROLE_DISTRIBUTOR, "9999999999");
        when(currentUserProvider.getCurrentUser()).thenReturn(new UserContext(
                1L,
                UserRole.ROLE_DISTRIBUTOR.name(),
                null,
                10L,
                null,
                "Test Distributor"));
        when(aiConversationRepository.save(ArgumentMatchers.any())).thenAnswer(invocation -> invocation.getArgument(0));

        var response = service.chat(currentUser, new AiChatRequest(null, "Hi"));

        assertThat(response.answer()).contains("AI is not working");
        assertThat(response.requiresConfirmation()).isFalse();
        verifyNoInteractions(distributorAiTools);
    }

    @Test
    void shouldReturnLiveInventoryWhenAskedForInventory() {
        CurrentUser currentUser = new CurrentUser(1L, UserRole.ROLE_DISTRIBUTOR, "9999999999");
        when(currentUserProvider.getCurrentUser()).thenReturn(new UserContext(
                1L,
                UserRole.ROLE_DISTRIBUTOR.name(),
                null,
                10L,
                null,
                "Test Distributor"));
        when(aiConversationRepository.save(ArgumentMatchers.any())).thenAnswer(invocation -> invocation.getArgument(0));
        when(distributorAiTools.getInventoryValue()).thenReturn(BigDecimal.valueOf(12500.00));

        var response = service.chat(currentUser, new AiChatRequest(null, "inventory value in rupees"));

        assertThat(response.answer()).contains("Inventory value: Your current inventory is worth Rs. 12500.0.");
        assertThat(response.answer()).contains("Review high-value stock, refill fast-moving products, and check low-stock items before accepting large orders.");
        assertThat(response.answer()).doesNotContain("Suggested Actions:");
        assertThat(response.requiresConfirmation()).isFalse();
    }

    @Test
    void shouldReturnLiveTodaySalesForDistributorSalesQuestion() {
        CurrentUser currentUser = new CurrentUser(1L, UserRole.ROLE_DISTRIBUTOR, "9999999999");
        when(currentUserProvider.getCurrentUser()).thenReturn(new UserContext(
                1L,
                UserRole.ROLE_DISTRIBUTOR.name(),
                null,
                10L,
                null,
                "Test Distributor"));
        when(aiConversationRepository.save(ArgumentMatchers.any())).thenAnswer(invocation -> invocation.getArgument(0));
        when(distributorAiTools.getTodayCapturedRevenue()).thenReturn(BigDecimal.valueOf(2750.00));

        var response = service.chat(currentUser, new AiChatRequest(null, "mere aaj sale kitni hui"));

        assertThat(response.answer()).contains("Today's sales: Rs. 2750.0 has been captured so far.");
        assertThat(response.answer()).doesNotContain("1,50,000");
        assertThat(response.answer()).doesNotContain("Suggested Actions:");
        assertThat(response.requiresConfirmation()).isFalse();
    }

    @Test
    void shouldReturnLiveNextActionsWithoutAiToolCalling() {
        CurrentUser currentUser = new CurrentUser(1L, UserRole.ROLE_DISTRIBUTOR, "9999999999");
        when(currentUserProvider.getCurrentUser()).thenReturn(new UserContext(
                1L,
                UserRole.ROLE_DISTRIBUTOR.name(),
                null,
                10L,
                null,
                "Test Distributor"));
        when(aiConversationRepository.save(ArgumentMatchers.any())).thenAnswer(invocation -> invocation.getArgument(0));
        when(distributorAiTools.getRecommendedNextActions()).thenReturn(List.of("Review 2 open orders."));

        var response = service.chat(currentUser, new AiChatRequest(null, "Suggest next actions"));

        assertThat(response.answer()).contains("Recommended next action: Review 2 open orders.");
        assertThat(response.answer()).contains("You can also ask for today's order summary, low-stock details, or payment and dues status.");
        assertThat(response.answer()).doesNotContain("Quick Options:");
        assertThat(response.requiresConfirmation()).isFalse();
    }
}
