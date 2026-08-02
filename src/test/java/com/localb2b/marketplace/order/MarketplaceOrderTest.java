package com.localb2b.marketplace.order;

import static org.assertj.core.api.Assertions.assertThat;

import java.math.BigDecimal;
import org.junit.jupiter.api.Test;

class MarketplaceOrderTest {

    @Test
    void newOrdersStartAsPlacedAndAcceptTransitionsToAccepted() {
        MarketplaceOrder order = new MarketplaceOrder(1L, 2L, BigDecimal.TEN, OrderPaymentMode.COD);

        assertThat(order.getStatus()).isEqualTo(OrderStatus.PLACED);

        order.distributorAccept();

        assertThat(order.getStatus()).isEqualTo(OrderStatus.ACCEPTED);
    }
}
