<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Retailer Dashboard</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero-carousel.css">

</head>

<body class="wm-home">

    <%@ include file="/WEB-INF/common/retailer-header.jsp" %>

            <div class="wm-app">

                <main>
                    <div class="wm-home-container">

                        <section class="wm-home-hero" aria-label="Retailer hero">
                            <div class="wm-hero-carousel" data-hero-carousel>
                                <div class="wm-hero-carousel-viewport" data-hero-viewport>
                                    <div class="wm-hero-carousel-track" data-hero-track>
                                        <section class="wm-home-hero-slide" data-hero-slide="0">
                                            <div class="wm-home-hero-grid">
                                                <div class="wm-home-hero-copy">
                                                    <span class="wm-kicker"><span class="wm-live-dot"></span> RETAILER WORKSPACE</span>
                                                    <h1 class="wm-home-title">Welcome back, <strong><%=wmUserNameHeader%></strong></h1>
                                                    <p class="wm-home-subtitle">
                                                        Find distributors, build carts, place orders, and track dues from one centralized workspace.
                                                    </p>
                                                    <div class="wm-home-actions">
                                                        <a class="home-btn home-btn-primary" href="/web/retailer/orders"><i class="bi bi-bag"></i> My Orders</a>
                                                        <a class="home-btn home-btn-secondary" href="/web/retailer/cart"><i class="bi bi-cart"></i> View Cart</a>
                                                        <a class="home-btn home-btn-secondary" href="/web/retailer/distributors"><i class="bi bi-shop"></i> Distributors</a>
                                                    </div>
                                                </div>

                                                <div class="wm-pulse-card">
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <div>
                                                            <span class="wm-pulse-eyebrow">Today's Performance</span>
                                                            <h3>Business Snapshot</h3>
                                                        </div>
                                                        <div class="home-logo">AI</div>
                                                    </div>
                                                    <div id="performanceBrief">Loading business insights...</div>
                                                    <hr>
                                                    <div class="wm-pulse-stats">
                                                        <div>
                                                            <h5 id="heroTotalOrders">0</h5><small>Active Orders</small></div>
                                                        <div>
                                                            <h5 id="heroTotalItems">0</h5><small>Items in Cart</small></div>
                                                        <div>
                                                            <h5 id="heroPendingSettlements">0</h5><small>Pending Dues</small></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </section>
                                    </div>
                                </div>
                            </div>
                        </section>
                        <hr>

                        <section class="wm-operations-section mb-4">
                            <div class="wm-operations-hub">
                                <div class="wm-operations-hero-wrap">
                                    <img src="${pageContext.request.contextPath}/images/wholemart_operations.jpg" 
                                         class="wm-operations-hero-img" 
                                         referrerpolicy="no-referrer"
                                         onerror="this.onerror=null;this.src='/images/wholemart_operations.jpg';"
                                         alt="WholeMart Operations Dashboard showing live inventory, orders and delivery status">
                                    <div class="wm-operations-overlay">
                                        <div>
                                            <span class="wm-operations-live-badge mb-2">
                                                <span class="wm-live-pulse-dot"></span> Live Fulfillment Status
                                            </span>
                                            <h2 class="wm-operations-title">Wholesale Operations & Delivery Dispatch</h2>
                                            <p class="wm-operations-subtitle">
                                                Track live distributor product inventory, active order status, and driver van dispatches straight to your retail store.
                                            </p>
                                        </div>
                                        <div class="d-flex flex-wrap gap-2 mt-3">
                                            <a href="/web/retailer/products" class="btn btn-sm btn-success fw-semibold"><i class="bi bi-shop me-1"></i> Browse Live Inventory</a>
                                            <a href="/web/retailer/orders" class="btn btn-sm btn-primary fw-semibold"><i class="bi bi-bag-check me-1"></i> Track Orders</a>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="wm-operations-telemetry-grid">
                                    <div class="wm-telemetry-card">
                                        <div class="wm-telemetry-icon inventory">
                                            <i class="bi bi-boxes"></i>
                                        </div>
                                        <div class="wm-telemetry-content">
                                            <h5>Live Stock</h5>
                                            <small>Distributor Stock Updated Live</small>
                                        </div>
                                    </div>
                                    <div class="wm-telemetry-card">
                                        <div class="wm-telemetry-icon orders">
                                            <i class="bi bi-cart-check"></i>
                                        </div>
                                        <div class="wm-telemetry-content">
                                            <h5>Active Orders</h5>
                                            <small>Instant Order Dispatch</small>
                                        </div>
                                    </div>
                                    <div class="wm-telemetry-card">
                                        <div class="wm-telemetry-icon delivery">
                                            <i class="bi bi-truck"></i>
                                        </div>
                                        <div class="wm-telemetry-content">
                                            <h5>Doorstep Delivery</h5>
                                            <small>Live GPS Driver Route</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <section class="wm-home-ops mb-4">
                            <div class="home-section-head">
                                <span class="wm-kicker">OPERATIONS</span>
                                <h2>Priority Center</h2>
                                <p>Live operational tasks generated from your cart, orders, and payments.</p>
                            </div>

                            <div class="wm-card">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div>
                                        <h4 class="mb-1">Action Queue</h4>
                                        <small class="text-muted">Items requiring your immediate attention.</small>
                                    </div>
                                    <span class="home-pill">LIVE</span>
                                </div>

                                <div id="wmAttentionList">
                                    <div class="wm-home-ops-row">
                                        <div class="wm-ops-icon"><i class="bi bi-hourglass-split"></i></div>
                                        <div class="wm-ops-body">
                                            <strong>Loading operational priorities...</strong>
                                            <span>WholeMart is analysing your cart, orders and payments.</span>
                                        </div>
                                        <span class="home-pill">Loading</span>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <hr>

                        <section class="wm-home-impact">
                            <div class="home-section-head">
                                <h2>Business Overview</h2>
                                <p>Live operational metrics from your retailer workspace.</p>
                            </div>

                            <div class="wm-kpi-headline">
                                <article class="wm-kpi-card">
                                    <div class="wm-kpi-top">
                                        <div>
                                            <span class="wm-kpi-label">Total Spent</span>
                                            <strong id="capturedRevenue" class="wm-kpi-value">Rs. 0.00</strong>
                                        </div>
                                        <div class="home-role-mark is-success"><i class="bi bi-currency-rupee"></i></div>
                                    </div>
                                    <p class="wm-kpi-foot"><span class="wm-trend-up">+0%</span> vs last month</p>
                                </article>

                                <article class="wm-kpi-card">
                                    <div class="wm-kpi-top">
                                        <div>
                                            <span class="wm-kpi-label">Active Orders</span>
                                            <strong id="bizActiveOrders" class="wm-kpi-value">0</strong>
                                        </div>
                                        <div class="home-role-mark"><i class="bi bi-bag"></i></div>
                                    </div>
                                    <p class="wm-kpi-foot">Total Orders <strong id="bizTotalOrders">0</strong></p>
                                </article>

                                <article class="wm-kpi-card">
                                    <div class="wm-kpi-top">
                                        <div>
                                            <span class="wm-kpi-label">Cart</span>
                                            <strong id="bizTotalItems" class="wm-kpi-value">0</strong>
                                        </div>
                                        <div class="home-role-mark"><i class="bi bi-cart"></i></div>
                                    </div>
                                    <p class="wm-kpi-foot">Items ready to order</p>
                                </article>

                                <article class="wm-kpi-card">
                                    <div class="wm-kpi-top">
                                        <div>
                                            <span class="wm-kpi-label">Pending Dues</span>
                                            <strong id="bizPendingSettlements" class="wm-kpi-value">0</strong>
                                        </div>
                                        <div class="home-role-mark is-danger"><i class="bi bi-cash-coin"></i></div>
                                    </div>
                                    <p class="wm-kpi-foot" style="color:var(--wm-danger)">Payment Required</p>
                                </article>
                            </div>
                        </section>
                        <hr>

                        <section class="wm-card wm-ai-panel mb-4 mt-5">
                            <div class="wm-ai-header">
                                <div class="wm-ai-avatar">AI</div>
                                <div>
                                    <h2 class="mb-1">WholeMart AI Assistant</h2>
                                    <p class="text-muted mb-0">
                                        Ask anything about orders, products, payments, distributors, or deliveries.
                                    </p>
                                </div>
                            </div>

                            <div class="row g-4 align-items-start">
                                <div class="col-lg-7">
                                    <div id="wmDashboardAiResponse" class="wm-ai-response">
                                        Welcome <strong><%= wmUserNameHeader %></strong> 👋
                                        <br><br>
                                        I'm ready to help you keep your shop stocked.
                                        <br><br>
                                        You can ask things like:
                                        <ul class="mb-0 mt-2">
                                            <li>Show my active orders</li>
                                            <li>What should I reorder soon?</li>
                                            <li>Any pending dues?</li>
                                            <li>Find nearby distributors</li>
                                            <li>Delivery status overview</li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="col-lg-5">
                                    <h5 class="mb-3">Suggested Questions</h5>
                                    <div id="wmDashboardAiQuickButtons" class="wm-ai-chips">
                                        <button type="button" class="wm-ai-chip" data-ai-message="Show my active orders"><i class="bi bi-bag"></i> Active Orders</button>
                                        <button type="button" class="wm-ai-chip" data-ai-message="What products should I reorder soon?"><i class="bi bi-graph-down-arrow"></i> Reorder Ideas</button>
                                        <button type="button" class="wm-ai-chip" data-ai-message="Show pending dues and ledger summary"><i class="bi bi-cash-coin"></i> Pending Dues</button>
                                        <button type="button" class="wm-ai-chip" data-ai-message="Find distributors near me"><i class="bi bi-shop"></i> Find Distributors</button>
                                        <button type="button" class="wm-ai-chip" data-ai-message="Delivery status overview"><i class="bi bi-truck"></i> Deliveries</button>
                                        <button type="button" class="wm-ai-chip" data-ai-message="What are my top priorities today?"><i class="bi bi-lightning-charge"></i> Today's Priorities</button>
                                    </div>
                                </div>
                            </div>

                            <form id="wmDashboardAiForm" class="mt-4">
                                <div class="input-group">
                                    <input id="wmDashboardAiMessage" type="text" class="form-control" placeholder="Ask WholeMart AI anything...">
                                    <button class="home-btn home-btn-secondary" type="button"><i class="bi bi-mic-fill"></i></button>
                                    <button class="home-btn home-btn-primary" type="submit"><i class="bi bi-send"></i> Ask AI</button>
                                </div>
                            </form>

                            <div id="wmDashboardAiActionBox" class="mt-3"></div>
                        </section>

                        <hr>

                        <section class="wm-home-roles mb-4">
                            <div class="home-section-head">
                                <span class="wm-kicker">OPERATIONS</span>
                                <h2>Fulfillment & Ordering Flow</h2>
                                <p>Track your order pipeline, cart readiness, and payment follow-ups.</p>
                            </div>

                            <div class="wm-home-role-grid">
                                <article class="home-role-card">
                                    <div class="home-role-mark"><i class="bi bi-bag"></i></div>
                                    <h3>Order Pipeline</h3>
                                    <p>What’s pending, approved, and on the way.</p>
                                    <div class="mt-4">
                                        <div class="wm-role-metric-row">
                                            <span>Processing</span>
                                            <strong id="ordersWaiting" style="color:var(--wm-warning)">0</strong>
                                        </div>
                                        <div class="wm-role-metric-row">
                                            <span>In Transit</span>
                                            <strong id="ordersReady">0</strong>
                                        </div>
                                    </div>
                                    <a href="/web/retailer/orders" class="home-btn home-btn-primary mt-4">My Orders</a>
                                </article>

                                <article class="home-role-card">
                                    <div class="home-role-mark"><i class="bi bi-cart"></i></div>
                                    <h3>Cart Health</h3>
                                    <p>Items you've saved to buy.</p>
                                    <div class="mt-4">
                                        <div class="wm-role-metric-row">
                                            <span>Items</span>
                                            <strong id="cartItemsInRoles">0</strong>
                                        </div>
                                        <div class="wm-role-metric-row">
                                            <span>Ready to Order</span>
                                            <strong id="checkoutReadyCount" style="color:var(--wm-success)">0</strong>
                                        </div>
                                    </div>
                                    <a href="/web/retailer/cart" class="home-btn home-btn-primary mt-4">Review Cart</a>
                                </article>

                                <article class="home-role-card">
                                    <div class="home-role-mark"><i class="bi bi-cash-coin"></i></div>
                                    <h3>Credit Ledger</h3>
                                    <p>Track your dues for previous orders.</p>
                                    <div class="mt-4">
                                        <div class="wm-role-metric-row">
                                            <span>Pending Dues</span>
                                            <strong id="overdueAmountKpi" style="color:var(--wm-danger)">₹0</strong>
                                        </div>
                                        <div class="wm-role-metric-row">
                                            <span>Disputes</span>
                                            <strong>0</strong>
                                        </div>
                                    </div>
                                    <a href="/web/retailer/dues" class="home-btn home-btn-primary mt-4">Open Ledger</a>
                                </article>

                                <article class="home-role-card">
                                    <div class="home-role-mark"><i class="bi bi-shop"></i></div>
                                    <h3>Distributors</h3>
                                    <p>Find and connect with suppliers.</p>
                                    <div class="mt-4">
                                        <div class="wm-role-metric-row">
                                            <span>Nearby</span>
                                            <strong id="nearbyDistributorsCount">0</strong>
                                        </div>
                                        <div class="wm-role-metric-row">
                                            <span>Connected</span>
                                            <strong id="connectedDistributorsCount">0</strong>
                                        </div>
                                    </div>
                                    <a href="/web/retailer/distributors" class="home-btn home-btn-primary mt-4">Browse Suppliers</a>
                                </article>
                            </div>
                        </section>

                        <%@ include file="/WEB-INF/common/footer.jsp" %>

                    </div>
                </main>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>
                document.addEventListener("DOMContentLoaded", function() {

                    /* =====================================================
                       DOM REFERENCES
                    ====================================================== */
                    const form = document.getElementById("wmDashboardAiForm");
                    const input = document.getElementById("wmDashboardAiMessage");
                    const responseBox = document.getElementById("wmDashboardAiResponse");
                    const actionBox = document.getElementById("wmDashboardAiActionBox");
                    const quickButtons = document.getElementById("wmDashboardAiQuickButtons");
                    const performanceBrief = document.getElementById("performanceBrief");
                    const attentionList = document.getElementById("wmAttentionList");

                    /* =====================================================
                       DASHBOARD STATE
                    ====================================================== */
                    const dashboardState = {
                        orders: [],
                        cart: [],
                        productsById: {},
                        payments: [],
                        distributors: []
                    };

                    if (!form || !input) {
                        return;
                    }

                    /* =====================================================
                       COMMON HELPERS
                    ====================================================== */
                    function setText(id, value) {
                        const element = document.getElementById(id);
                        if (element) {
                            element.textContent = value;
                        }
                    }

                    function setTextAll(ids, value) {
                        ids.forEach(id => setText(id, value));
                    }

                    function money(value) {
                        return "₹ " + Number(value || 0).toLocaleString("en-IN", {
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        });
                    }

                    function normalizeRows(data) {
                        if (window.wmRows) {
                            return window.wmRows(data);
                        }
                        return Array.isArray(data) ? data : [];
                    }

                    /* =====================================================
                       API HELPER
                    ====================================================== */
                    async function loadApi(url) {
                        try {
                            const response = await fetch(url);
                            if (!response.ok) {
                                throw new Error(url);
                            }
                            const data = await response.json();
                            return normalizeRows(data);
                        } catch (e) {
                            console.error("Unable to load:", url, e);
                            return [];
                        }
                    }

                    /* =====================================================
                       DATA LOADERS
                    ====================================================== */
                    async function loadOrders() {
                        const orders = await loadApi("/api/v1/orders");
                        dashboardState.orders = orders;

                        setTextAll(["bizTotalOrders"], orders.length);

                        const activeCount = orders.filter(o => o.status !== "DELIVERED" && o.status !== "REJECTED" && o.status !== "CANCELLED").length;
                        const processingCount = orders.filter(o => o.status === 'PLACED' || o.status === 'ACCEPTED').length;

                        setTextAll(["bizActiveOrders", "heroTotalOrders"], activeCount);
                        setText("ordersWaiting", processingCount);

                        setTextAll(["bizActiveOrders", "heroTotalOrders", "ordersWaiting"], activeCount);

                        const inTransitCount = orders.filter(o => o.status === "SHIPPED").length;
                        setText("ordersReady", inTransitCount);

                        const totalSpent = orders.reduce((t, o) => t + Number(o.totalAmount || 0), 0);
                        setText("capturedRevenue", money(totalSpent));

                        renderPerformanceBrief();
                        renderRecommendedActions();
                    }

                    async function loadCart() {
                        const cartItems = await loadApi("/api/v1/cart");
                        dashboardState.cart = cartItems;

                        const itemCount = cartItems.reduce((sum, item) => sum + (item.quantity || 0), 0);
                        setTextAll(["bizTotalItems", "heroTotalItems", "cartItemsInRoles"], itemCount);
                        setText("checkoutReadyCount", itemCount > 0 ? "Yes" : "No");

                        renderRecommendedActions();
                    }

                    async function loadProducts() {
                        const products = await loadApi("/api/v1/products");
                        dashboardState.productsById = products.reduce((map, p) => {
                            map[p.id] = p;
                            return map;
                        }, {});
                    }

                    async function loadPayments() {
                        const payments = await loadApi("/api/v1/payments");
                        dashboardState.payments = payments;

                        const pendingCount = payments.filter(p => p.status === "PENDING").length;
                        setTextAll(["bizPendingSettlements", "heroPendingSettlements"], pendingCount);

                        const pendingAmount = payments
                            .filter(p => p.status === "PENDING")
                            .reduce((sum, p) => sum + Number(p.amount || p.totalAmount || 0), 0);
                        setText("overdueAmountKpi", money(pendingAmount));

                        renderRecommendedActions();
                    }

                    async function loadDistributors() {
                        const distributors = await loadApi("/api/v1/distributors/nearby");
                        dashboardState.distributors = distributors;
                        setText("nearbyDistributorsCount", distributors.length);
                        // Placeholder for connected
                        setText("connectedDistributorsCount", Math.floor(distributors.length / 2));
                        renderRecommendedActions();
                    }


                    /* =====================================================
                       PERFORMANCE & PRIORITY RENDERING
                    ====================================================== */
                    function renderPerformanceBrief() {
                        if (!performanceBrief) return;
                        const activeOrders = dashboardState.orders.filter(o => o.status !== "DELIVERED" && o.status !== "REJECTED").length;
                        const cartValue = dashboardState.cart.reduce((sum, item) => {
                            const product = dashboardState.productsById[item.productId];
                            const price = product ? (product.unitPrice || 0) : 0;
                            return sum + (price * (item.quantity || 0));
                        }, 0);

                        performanceBrief.innerHTML =
                            "You have <strong>" + activeOrders + "</strong> active order(s) and " +
                            "a cart value of <strong>" + money(cartValue) + "</strong>. " +
                            "Keep your shop stocked by placing regular orders.";
                    }

                    function renderRecommendedActions() {
                        if (!attentionList) return;

                        const items = [];

                        const cartItemCount = dashboardState.cart.reduce((sum, item) => sum + (item.quantity || 0), 0);
                        if (cartItemCount > 0) {
                            items.push({
                                icon: "bi-cart-check",
                                title: cartItemCount + " item(s) in your cart",
                                detail: "Review your cart and proceed to checkout to restock your inventory.",
                                tag: "Cart",
                                tone: "is-success"
                            });
                        }

                        const pendingPayments = dashboardState.payments.filter(p => p.status === "PENDING").length;
                        if (pendingPayments > 0) {
                            items.push({
                                icon: "bi-cash-coin",
                                title: pendingPayments + " payment(s) are due",
                                detail: "Clear your dues with distributors to maintain a good relationship.",
                                tag: "Payments",
                                tone: "is-danger"
                            });
                        }

                        const processingOrders = dashboardState.orders.filter(o => o.status === 'PLACED' || o.status === 'ACCEPTED').length;
                        if (processingOrders > 0) {
                            items.push({
                                icon: "bi-bag",
                                title: processingOrders + " order(s) are being processed",
                                detail: "Your distributor is preparing your items for delivery.",
                                tag: "Orders",
                                tone: "is-warning"
                            });
                        }

                        if (items.length === 0) {
                            attentionList.innerHTML =
                                '<div class="wm-home-ops-row">' +
                                '<div class="wm-ops-icon"><i class="bi bi-check-circle"></i></div>' +
                                '<div class="wm-ops-body"><strong>All caught up</strong>' +
                                '<span>No urgent operational items right now.</span></div>' +
                                '<span class="home-pill">Clear</span>' +
                                '</div>';
                            return;
                        }

                        attentionList.innerHTML = items.map(function(item) {
                            return (
                                '<div class="wm-home-ops-row">' +
                                '<div class="wm-ops-icon"><i class="bi ' + item.icon + '"></i></div>' +
                                '<div class="wm-ops-body"><strong>' + item.title + '</strong>' +
                                '<span>' + item.detail + '</span></div>' +
                                '<span class="home-pill ' + item.tone + '">' + item.tag + '</span>' +
                                '</div>'
                            );
                        }).join("");
                    }

                    /* =====================================================
                       AI ASSISTANT
                    ====================================================== */
                    async function askAi() {
                        const message = input.value.trim();
                        if (!message || !responseBox) return;

                        responseBox.textContent = "Thinking...";

                        try {
                            const res = await fetch("/api/v1/ai/agent/chat", {
                                method: "POST",
                                headers: {
                                    "Content-Type": "application/json"
                                },
                                body: JSON.stringify({
                                    message: message
                                })
                            });

                            if (!res.ok) throw new Error("AI request failed");

                            const data = await res.json();
                            responseBox.textContent = data.answer || "Sorry, I couldn't find an answer for that.";

                        } catch (e) {
                            console.error("AI request error:", e);
                            responseBox.textContent = "Something went wrong reaching the AI assistant. Please try again.";
                        } finally {
                            input.value = "";
                        }
                    }

                    /* =====================================================
                       INITIALIZE
                     ====================================================== */
                    async function initializeDashboard() {
                        await Promise.all([
                            loadProducts(),
                            loadOrders(),
                            loadCart(),
                            loadPayments(),
                            loadDistributors()
                        ]);
                    }

                    initializeDashboard();

                    form.addEventListener("submit", function(e) {
                        e.preventDefault();
                        askAi();
                    });

                    quickButtons.addEventListener("click", function(e) {
                        const btn = e.target.closest("[data-ai-message]");
                        if (!btn) return;
                        input.value = btn.dataset.aiMessage;
                        askAi();
                    });

                });
            </script>

</body>

</html>
