package com.localb2b.marketplace.ai.service;

import com.localb2b.marketplace.ai.context.CurrentUserProvider;
import com.localb2b.marketplace.ai.context.UserContext;
import com.localb2b.marketplace.ai.dto.AiChatRequest;
import com.localb2b.marketplace.ai.dto.DistributorInventorySummary;
import com.localb2b.marketplace.ai.dto.DistributorLedgerSummary;
import com.localb2b.marketplace.ai.dto.DistributorOrderSummary;
import com.localb2b.marketplace.ai.repository.AiConversationRepository;
import com.localb2b.marketplace.ai.repository.AiMessageRepository;
import com.localb2b.marketplace.ai.tools.AdminAiTools;
import com.localb2b.marketplace.ai.tools.DistributorAiTools;
import com.localb2b.marketplace.ai.tools.DriverAiTools;
import com.localb2b.marketplace.ai.tools.RetailerAiTools;
import com.localb2b.marketplace.common.CurrentUser;
import com.localb2b.marketplace.user.UserRole;
import java.math.BigDecimal;
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
    private AiActionService aiActionService;

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
                aiActionService,
                aiConversationRepository,
                aiMessageRepository,
                retailerAiTools,
                distributorAiTools,
                driverAiTools,
                adminAiTools);
    }

    @Test
    void shouldReturnDistributorFallbackOrderSummaryWhenNoAiModelIsAvailable() {
        CurrentUser currentUser = new CurrentUser(1L, UserRole.ROLE_DISTRIBUTOR, "9999999999");
        when(currentUserProvider.getCurrentUser()).thenReturn(new UserContext(
                1L,
                UserRole.ROLE_DISTRIBUTOR.name(),
                null,
                10L,
                null,
                "Test Distributor"));
        when(aiConversationRepository.save(ArgumentMatchers.any())).thenAnswer(invocation -> invocation.getArgument(0));
        when(distributorAiTools.getTodayOrderSummary()).thenReturn(new DistributorOrderSummary(5, 2, 3));
        when(distributorAiTools.getInventorySummary()).thenReturn(new DistributorInventorySummary(120, 10, 1));
        when(distributorAiTools.getLedgerSummary()).thenReturn(new DistributorLedgerSummary(
                BigDecimal.valueOf(250000.00),
                BigDecimal.valueOf(42000.00),
                BigDecimal.valueOf(7800.00)));
        var response = service.chat(currentUser, new AiChatRequest(null, "Show today's order summary."));

        assertThat(response.answer()).contains("Order summary:");
        assertThat(response.requiresConfirmation()).isFalse();
        assertThat(response.actionId()).isNull();
    }

    @Test
    void shouldAnswerSmallTalkWithoutCallingBusinessTools() {
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

        assertThat(response.answer()).contains("Hi Test Distributor");
        assertThat(response.answer()).contains("distributor account");
        assertThat(response.requiresConfirmation()).isFalse();
        verifyNoInteractions(distributorAiTools);
    }

    @Test
    void shouldReturnDistributorInventoryValueWhenAskedInRupees() {
        CurrentUser currentUser = new CurrentUser(1L, UserRole.ROLE_DISTRIBUTOR, "9999999999");
        when(currentUserProvider.getCurrentUser()).thenReturn(new UserContext(
                1L,
                UserRole.ROLE_DISTRIBUTOR.name(),
                null,
                10L,
                null,
                "Test Distributor"));
        when(aiConversationRepository.save(ArgumentMatchers.any())).thenAnswer(invocation -> invocation.getArgument(0));
        when(distributorAiTools.getTodayOrderSummary()).thenReturn(new DistributorOrderSummary(0, 0, 0));
        when(distributorAiTools.getInventorySummary()).thenReturn(new DistributorInventorySummary(2, 0, 0));
        when(distributorAiTools.getLedgerSummary()).thenReturn(new DistributorLedgerSummary(
                BigDecimal.ZERO,
                BigDecimal.ZERO,
                BigDecimal.ZERO));
        when(distributorAiTools.getInventoryValue()).thenReturn(BigDecimal.valueOf(12500.00));

        var response = service.chat(currentUser, new AiChatRequest(null, "inventory value in rupees"));

        assertThat(response.answer()).contains("Inventory value:");
        assertThat(response.answer()).contains("Rs. 12500.0");
        assertThat(response.requiresConfirmation()).isFalse();
    }
}
