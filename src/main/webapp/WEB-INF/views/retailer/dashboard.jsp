<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WholeMart | Retailer Dashboard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/resources/static/css/home.css" />
</head>
<body>

<div class="wm-topbar">
    <div class="wm-topbar-inner">
        <div class="wm-brand"><span class="mark">WM</span> WHOLEMART</div>
        <div class="wm-topbar-right">
            <span class="wm-kicker"><span class="wm-live-dot"></span> RETAILER</span>
            <button class="wm-sidebar-toggle" id="wmSidebarToggle" aria-label="Open menu"><i class="bi bi-list"></i></button>
            <div class="wm-avatar" id="wmAvatarInitial">R</div>
        </div>
    </div>
</div>

<div class="wm-sidebar-backdrop" id="wmSidebarBackdrop"></div>
<nav class="wm-sidebar" id="wmSidebar">
    <div class="wm-sidebar-head">Navigate</div>
    <a href="#"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="#"><i class="bi bi-bag"></i> Orders</a>
    <a href="#"><i class="bi bi-box-seam"></i> Cart & Checkout</a>
    <a href="#"><i class="bi bi-shop"></i> Distributors</a>
    <a href="#"><i class="bi bi-cash-coin"></i> Dues & Ledger</a>
    <a href="#"><i class="bi bi-bar-chart"></i> Reports</a>
    <a href="#"><i class="bi bi-gear"></i> Settings</a>
    <a href="#"><i class="bi bi-box-arrow-right"></i> Logout</a>
</nav>

<div class="wm-app">

    <section class="wm-home-hero" aria-label="Retailer hero">
        <div class="wm-ledger-divider" style="margin-top:0;margin-bottom:32px;"></div>
        <div class="wm-home-hero-grid">
            <div class="wm-home-hero-copy">
                <span class="wm-kicker"><span class="wm-live-dot"></span> RETAILER WORKSPACE</span>
                <h1 class="wm-home-title">Welcome back, <strong id="wmUserNameHero">Retailer</strong></h1>
                <p class="wm-home-subtitle">
                    Find nearby distributors, build carts, place orders,
                    and track dues & deliveries — all in one place.
                </p>
                <div class="wm-home-actions">
                    <a class="home-btn home-btn-primary" href="#"><i class="bi bi-bag"></i> Orders</a>
                    <a class="home-btn home-btn-secondary" href="#"><i class="bi bi-cart"></i> Cart</a>
                    <a class="home-btn home-btn-secondary" href="#"><i class="bi bi-shop"></i> Distributors</a>
                </div>
            </div>

            <div class="wm-pulse-card">
                <div class="d-flex justify-content-between align-items-start mb-2" style="display:flex;justify-content:space-between;">
                    <div>
                        <span class="wm-pulse-eyebrow">Today's Performance</span>
                        <h3>Business Snapshot</h3>
                    </div>
                    <div class="home-logo">AI</div>
                </div>
                <div id="performanceBrief">Loading business insights...</div>
                <hr>
                <div class="wm-pulse-stats">
                    <div><h5 id="heroTotalOrders">0</h5><small>Orders</small></div>
                    <div><h5 id="heroTotalItems">0</h5><small>Products</small></div>
                    <div><h5 id="heroPendingSettlements">0</h5><small>Pending</small></div>
                </div>
            </div>
        </div>
    </section>

    <section class="wm-home-ops mb-4" style="margin-top:36px;">
        <div class="home-section-head">
            <span class="wm-kicker">OPERATIONS</span>
            <h2>Priority Center</h2>
            <p>Live operational tasks generated from orders, cart status, dues and deliveries.</p>
        </div>
        <div class="wm-card">
            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:18px;">
                <div>
                    <h4 style="margin:0 0 2px;">Action Queue</h4>
                    <small class="text-muted" style="color:var(--wm-ink-soft);">Items requiring your immediate attention.</small>
                </div>
                <span class="home-pill">LIVE</span>
            </div>
            <div id="wmAttentionList">
                <div class="wm-home-ops-row">
                    <div class="wm-ops-icon"><i class="bi bi-hourglass-split"></i></div>
                    <div class="wm-ops-body"><strong>Loading operational priorities...</strong>
                        <span>WholeMart is analysing your cart, orders and ledger.</span></div>
                    <span class="home-pill">Loading</span>
                </div>
            </div>
        </div>
    </section>

    <section class="wm-home-impact" style="margin-top:36px;">
        <div class="home-section-head">
            <h2>Business Overview</h2>
            <p>Live operational metrics from your retailer workspace.</p>
        </div>

        <div class="wm-kpi-headline">
            <article class="wm-kpi-card">
                <div class="wm-kpi-top">
                    <div><span class="wm-kpi-label">Revenue</span><strong id="capturedRevenue" class="wm-kpi-value">₹ 0.00</strong></div>
                    <div class="home-role-mark is-success"><i class="bi bi-currency-rupee"></i></div>
                </div>
                <p class="wm-kpi-foot"><span class="wm-trend-up">+6%</span> vs last month</p>
            </article>

            <article class="wm-kpi-card">
                <div class="wm-kpi-top">
                    <div><span class="wm-kpi-label">Active Orders</span><strong id="bizActiveOrders" class="wm-kpi-value">0</strong></div>
                    <div class="home-role-mark"><i class="bi bi-bag"></i></div>
                </div>
                <p class="wm-kpi-foot">Total Orders <strong id="bizTotalOrders">0</strong></p>
            </article>

            <article class="wm-kpi-card">
                <div class="wm-kpi-top">
                    <div><span class="wm-kpi-label">Inventory</span><strong id="bizTotalItems" class="wm-kpi-value">0</strong></div>
                    <div class="home-role-mark"><i class="bi bi-box"></i></div>
                </div>
                <p class="wm-kpi-foot">Products in Cart</p>
            </article>

            <article class="wm-kpi-card">
                <div class="wm-kpi-top">
                    <div><span class="wm-kpi-label">Settlements</span><strong id="bizPendingSettlements" class="wm-kpi-value">0</strong></div>
                    <div class="home-role-mark is-danger"><i class="bi bi-cash-coin"></i></div>
                </div>
                <p class="wm-kpi-foot" style="color:var(--wm-danger)">Pending Collection</p>
            </article>
        </div>

        <div class="wm-subsection-label">At a Glance</div>
        <div class="wm-kpi-secondary">
            <article class="wm-kpi-card">
                <div class="wm-kpi-top">
                    <div><span class="wm-kpi-label">Distributors Nearby</span><strong class="wm-kpi-value" id="nearbyDistributorKpi">0</strong></div>
                    <div class="home-role-mark"><i class="bi bi-shop"></i></div>
                </div>
                <p class="wm-kpi-foot">Available for quick replenishment</p>
            </article>

            <article class="wm-kpi-card">
                <div class="wm-kpi-top">
                    <div><span class="wm-kpi-label">Cart Items</span><strong class="wm-kpi-value" id="cartItemsKpi">0</strong></div>
                    <div class="home-role-mark"><i class="bi bi-cart"></i></div>
                </div>
                <p class="wm-kpi-foot"><span class="wm-trend-up">+1</span> ready to checkout</p>
            </article>

            <article class="wm-kpi-card">
                <div class="wm-kpi-top">
                    <div><span class="wm-kpi-label">Catalog Match</span><strong id="catalogHealthKpi" class="wm-kpi-value">92%</strong></div>
                    <div class="wm-ring is-success" style="--pct:92"><span>92%</span></div>
                </div>
                <p class="wm-kpi-foot">Products likely to fit demand</p>
            </article>

            <article class="wm-kpi-card">
                <div class="wm-kpi-top">
                    <div><span class="wm-kpi-label">Alerts</span><strong id="retailerAlertsKpi" class="wm-kpi-value" style="color:var(--wm-danger)">0</strong></div>
                    <div class="home-role-mark is-danger"><i class="bi bi-exclamation-triangle"></i></div>
                </div>
                <p class="wm-kpi-foot" style="color:var(--wm-danger)">Immediate Action</p>
            </article>
        </div>
    </section>

    <section class="wm-card wm-ai-panel mb-4" style="margin-top:44px;">
        <div class="wm-ai-header">
            <div class="wm-ai-avatar">AI</div>
            <div>
                <h2 style="margin:0 0 4px;">WholeMart AI Assistant</h2>
                <p class="text-muted" style="margin:0;">Ask anything about orders, products, payments, distributors, deliveries or your business performance.</p>
            </div>
        </div>

        <div class="row g-4 align-items-start" style="display:flex;gap:24px;flex-wrap:wrap;">
            <div style="flex:1 1 420px;">
                <div id="wmDashboardAiResponse" class="wm-ai-response">
                    Welcome <strong id="wmUserNameAi">Retailer</strong> 👋
                    <br><br>I'm ready to help you keep your shop stocked.
                    <br><br>You can ask things like:
                    <ul>
                        <li>Show my active orders</li>
                        <li>What should I reorder soon?</li>
                        <li>Any pending dues?</li>
                        <li>Suggest products for top categories</li>
                        <li>Delivery status overview</li>
                    </ul>
                </div>
            </div>
            <div style="flex:1 1 280px;">
                <h5 style="margin:0 0 12px;">Suggested Questions</h5>
                <div id="wmDashboardAiQuickButtons" class="wm-ai-chips">
                    <button type="button" class="wm-ai-chip" data-ai-message="Show my active orders"><i class="bi bi-bag"></i> Active Orders</button>
                    <button type="button" class="wm-ai-chip" data-ai-message="What products should I reorder soon?"><i class="bi bi-graph-down-arrow"></i> Low Stock</button>
                    <button type="button" class="wm-ai-chip" data-ai-message="Show pending dues and ledger summary"><i class="bi bi-cash-coin"></i> Pending Dues</button>
                    <button type="button" class="wm-ai-chip" data-ai-message="Delivery status overview"><i class="bi bi-truck"></i> Deliveries</button>
                    <button type="button" class="wm-ai-chip" data-ai-message="Suggest best products to buy today"><i class="bi bi-stars"></i> Suggestions</button>
                    <button type="button" class="wm-ai-chip" data-ai-message="Retailer business performance summary"><i class="bi bi-bar-chart"></i> Business Summary</button>
                </div>
            </div>
        </div>

        <form id="wmDashboardAiForm" style="margin-top:22px;">
            <input id="wmDashboardAiMessage" type="text" class="form-control" placeholder="Ask WholeMart AI anything...">
            <button class="home-btn wm-ai-mic" type="button"><i class="bi bi-mic-fill"></i></button>
            <button class="home-btn home-btn-primary" type="submit"><i class="bi bi-send"></i> Ask AI</button>
        </form>
        <div id="wmDashboardAiActionBox" style="margin-top:12px;"></div>
    </section>

    <section class="wm-home-roles mb-4" style="margin-top:44px;">
        <div class="home-section-head">
            <span class="wm-kicker">OPERATIONS</span>
            <h2>Fulfillment & Ordering Flow</h2>
            <p>Track order pipeline, cart readiness, payment follow-ups and delivery milestones.</p>
        </div>

        <div class="wm-home-role-grid">
            <article class="home-role-card">
                <div class="home-role-mark"><i class="bi bi-bag"></i></div>
                <h3>Order Pipeline</h3>
                <p>What’s pending, approved and on the way.</p>
                <div style="margin-top:16px;">
                    <div class="wm-role-metric-row"><span>Processing</span><strong id="ordersWaiting" style="color:var(--wm-warning)">0</strong></div>
                    <div class="wm-role-metric-row"><span>Ready for Delivery</span><strong id="ordersReady">0</strong></div>
                </div>
                <a href="#" class="home-btn home-btn-primary" style="margin-top:18px;">Open Orders</a>
            </article>

            <article class="home-role-card">
                <div class="home-role-mark"><i class="bi bi-cart"></i></div>
                <h3>Cart Health</h3>
                <p>Items you planned to buy.</p>
                <div style="margin-top:16px;">
                    <div class="wm-role-metric-row"><span>Cart Items</span><strong id="cartItemsInRoles">0</strong></div>
                    <div class="wm-role-metric-row"><span>Checkout Ready</span><strong id="checkoutReadyCount" style="color:var(--wm-success)">0</strong></div>
                </div>
                <a href="#" class="home-btn home-btn-primary" style="margin-top:18px;">Review Cart</a>
            </article>

            <article class="home-role-card">
                <div class="home-role-mark"><i class="bi bi-cash-coin"></i></div>
                <h3>Credit Ledger</h3>
                <p>Track dues for previous orders.</p>
                <div style="margin-top:16px;">
                    <div class="wm-role-metric-row"><span>Pending Collection</span><strong id="overdueAmountKpi" style="color:var(--wm-danger)">₹0</strong></div>
                    <div class="wm-role-metric-row"><span>Disputes</span><strong id="disputesCount">0</strong></div>
                </div>
                <a href="#" class="home-btn home-btn-primary" style="margin-top:18px;">Open Ledger</a>
            </article>

            <article class="home-role-card">
                <div class="home-role-mark"><i class="bi bi-truck"></i></div>
                <h3>Delivery Status</h3>
                <p>Milestones for your incoming deliveries.</p>
                <div style="margin-top:16px;">
                    <div class="wm-role-metric-row"><span>Delivered</span><strong id="completedDropoffs">0</strong></div>
                    <div class="wm-role-metric-row"><span>In Transit</span><strong id="activeTripsCount">0</strong></div>
                </div>
                <a href="#" class="home-btn home-btn-primary" style="margin-top:18px;">Delivery Center</a>
            </article>
        </div>
    </section>

    <div class="wm-ledger-divider"></div>

    <section class="wm-home-reports mb-4">
        <div class="home-section-head">
            <span class="wm-kicker">ANALYTICS</span>
            <h2>Reports & Business Intelligence</h2>
            <p>Real-time insights into your ordering patterns and shop needs.</p>
        </div>

        <div class="row g-4" style="display:flex;gap:18px;flex-wrap:wrap;">
            <div style="flex:1 1 300px;">
                <article class="home-role-card" style="height:100%;">
                    <div class="wm-report-card-head"><h3 style="margin:0;">Inventory Readiness</h3><div class="wm-ring is-success" style="--pct:88"><span>88%</span></div></div>
                    <div class="wm-report-item"><span>Cart Items</span><strong id="reportTotalItems">0</strong></div>
                    <div class="wm-report-item"><span>Top Categories</span><strong id="reportCategoryCount">0</strong></div>
                    <div class="wm-report-item"><span>Availability</span><strong style="color:var(--wm-success)">88%</strong></div>
                    <div class="wm-report-item"><span>Needs Refill</span><strong style="color:var(--wm-danger)" id="outOfStockCount">0</strong></div>
                </article>
            </div>

            <div style="flex:1 1 300px;">
                <article class="home-role-card" style="height:100%;">
                    <div class="wm-report-card-head"><h3 style="margin:0;">Order Performance</h3><div class="wm-ring is-success" style="--pct:96"><span>96%</span></div></div>
                    <div class="wm-report-item"><span>Total Orders</span><strong id="reportTotalOrders">0</strong></div>
                    <div class="wm-report-item"><span>Processing Orders</span><strong id="reportActiveOrders">0</strong></div>
                    <div class="wm-report-item"><span>Success Rate</span><strong style="color:var(--wm-success)">96.2%</strong></div>
                    <div class="wm-report-item"><span>Rejected</span><strong id="rejectedOrdersCount">0</strong></div>
                </article>
            </div>

            <div style="flex:1 1 300px;">
                <article class="home-role-card" style="height:100%;">
                    <div class="wm-report-card-head"><h3 style="margin:0;">Buying Patterns</h3><div class="wm-ring" style="--pct:74"><span>74%</span></div></div>
                    <div class="wm-report-item"><span>Distributors</span><strong id="reportDistributorsCount">0</strong></div>
                    <div class="wm-report-item"><span>Cart Trend</span><strong style="color:var(--wm-success)" id="cartTrendText">+0%</strong></div>
                    <div class="wm-report-item"><span>Repeat Rate</span><strong id="repeatRateText">0%</strong></div>
                    <div class="wm-report-item"><span>Target Achievement</span><strong id="targetAchievementText">74%</strong></div>
                </article>
            </div>
        </div>
    </section>

    <div class="wm-ledger-divider"></div>

    <section class="mb-4">
        <div class="row g-4" style="display:flex;gap:20px;flex-wrap:wrap;">
            <div style="flex:2 1 480px;">
                <div class="wm-card" style="height:100%;">
                    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
                        <div><span class="wm-kicker">LIVE FEED</span><h3 style="margin:4px 0 0;">Recent Activities</h3></div>
                        <span class="home-pill">Today</span>
                    </div>
                    <div class="wm-timeline">
                        <div class="wm-timeline-item">
                            <div class="wm-timeline-icon is-success"><i class="bi bi-check-lg"></i></div>
                            <div><strong>Order Placed</strong><div class="text-muted">Just now</div></div>
                        </div>
                        <div class="wm-timeline-item">
                            <div class="wm-timeline-icon is-info"><i class="bi bi-box-seam"></i></div>
                            <div><strong>Cart Updated</strong><div class="text-muted">New items added</div></div>
                        </div>
                        <div class="wm-timeline-item">
                            <div class="wm-timeline-icon is-warning"><i class="bi bi-cash-coin"></i></div>
                            <div><strong>Payment Reminder</strong><div class="text-muted">Awaiting settlement</div></div>
                        </div>
                        <div class="wm-timeline-item">
                            <div class="wm-timeline-icon is-info"><i class="bi bi-truck"></i></div>
                            <div><strong>Delivery Scheduled</strong><div class="text-muted">Route optimized</div></div>
                        </div>
                    </div>
                </div>
            </div>

            <div style="flex:1 1 260px;">
                <div class="wm-card" style="height:100%;">
                    <span class="wm-kicker">SHORTCUTS</span>
                    <h3 style="margin:6px 0 18px;">Quick Actions</h3>
                    <div class="wm-quick-actions">
                        <a href="#" class="home-btn home-btn-primary"><i class="bi bi-plus-circle"></i> Add to Cart</a>
                        <a href="#" class="home-btn home-btn-secondary"><i class="bi bi-bag"></i> Manage Orders</a>
                        <a href="#" class="home-btn home-btn-secondary"><i class="bi bi-shop"></i> Browse Distributors</a>
                        <a href="#" class="home-btn home-btn-secondary"><i class="bi bi-cash-coin"></i> View Ledger</a>
                        <a href="#" class="home-btn home-btn-secondary"><i class="bi bi-bar-chart"></i> Analytics</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="wm-footer">
        <span>WHOLEMART &copy; 2026 — Retailer Workspace</span>
        <span>LEDGER SYNCED · <span id="wmFooterTime"></span></span>
    </div>

</div>

<script>
document.addEventListener("DOMContentLoaded", function () {

    /* ---------- sidebar (off-canvas, all breakpoints) ---------- */
    const sidebar = document.getElementById("wmSidebar");
    const backdrop = document.getElementById("wmSidebarBackdrop");
    const toggle = document.getElementById("wmSidebarToggle");

    function openSidebar(){ sidebar.classList.add("is-open"); backdrop.classList.add("is-open"); }
    function closeSidebar(){ sidebar.classList.remove("is-open"); backdrop.classList.remove("is-open"); }

    toggle.addEventListener("click", function(){
        sidebar.classList.contains("is-open") ? closeSidebar() : openSidebar();
    });
    backdrop.addEventListener("click", closeSidebar);
    document.addEventListener("keydown", function(e){
        if (e.key === "Escape") closeSidebar();
    });

    /* ---------- footer clock ---------- */
    document.getElementById("wmFooterTime").textContent = new Date().toLocaleString("en-IN");

    /* ---------- user name ---------- */
    const userName = "Retailer";
    document.getElementById("wmUserNameHero").textContent = userName;
    document.getElementById("wmUserNameAi").textContent = userName;
    document.getElementById("wmAvatarInitial").textContent = userName.charAt(0).toUpperCase();

    const dashboardState = {
        orders: [],
        cartItems: 0,
        nearbyDistributors: 0,
        pendingDuesCount: 0,
        deliveries: []
    };

    function setText(id, value){ const el = document.getElementById(id); if (el) el.textContent = value; }
    function setTextAll(ids, value){ ids.forEach(id => setText(id, value)); }

    function safeNum(v){ return Number(v || 0); }

    function wmRows(data){
        // keep compatibility with existing retailer page's helper (if defined in common.js)
        if (Array.isArray(data)) return data;
        if (data && Array.isArray(data.rows)) return data.rows;
        return [];
    }

    function renderFromApi(){
        // KPI wiring — uses endpoints that already existed in your legacy retailer page.
        // Other KPIs remain placeholders until corresponding backend endpoints are wired.

        fetch("/api/v1/distributors/nearby/summary")
            .then(r => r.json())
            .then(data => {
                dashboardState.nearbyDistributors = safeNum(data.total);
                setText("nearbyDistributorKpi", dashboardState.nearbyDistributors);
            })
            .catch(() => setText("nearbyDistributorKpi", 0));

        fetch("/api/v1/cart")
            .then(r => r.json())
            .then(data => {
                const rows = wmRows(data);
                dashboardState.cartItems = rows.reduce((sum, item) => sum + safeNum(item.quantity), 0);
                setText("cartItemsKpi", dashboardState.cartItems);
                setText("cartItemsInRoles", dashboardState.cartItems);
                setText("reportTotalItems", dashboardState.cartItems);
                // quick heuristic
                setText("checkoutReadyCount", Math.max(0, dashboardState.cartItems));
            })
            .catch(() => {
                setTextAll(["cartItemsKpi","cartItemsInRoles","reportTotalItems"], 0);
                setText("checkoutReadyCount", 0);
            });

        fetch("/api/v1/orders")
            .then(r => r.json())
            .then(data => {
                const rows = wmRows(data);
                dashboardState.orders = rows;
                setText("reportTotalOrders", rows.length);
                setText("bizTotalOrders", rows.length);

                // If status field exists, mark "processing" as non-completed.
                const processing = rows.filter(o => {
                    const s = (o.status || "").toUpperCase();
                    return !["DELIVERED","CANCELLED","REJECTED"].includes(s);
                }).length;

                setText("bizActiveOrders", processing);
                setText("ordersWaiting", processing);
                setText("reportActiveOrders", processing);

                // placeholder deliveries
                setText("ordersReady", Math.max(0, rows.length - processing));
                setText("completedDropoffs", rows.filter(o => (o.status||"").toUpperCase()==="DELIVERED").length);
                setText("activeTripsCount", processing);
            })
            .catch(() => {
                setTextAll(["reportTotalOrders","bizTotalOrders","bizActiveOrders","ordersWaiting","reportActiveOrders","ordersReady"], 0);
                setTextAll(["completedDropoffs","activeTripsCount"], 0);
            });

        // pending dues endpoint not wired yet; keep as 0.
        setText("bizPendingSettlements", dashboardState.pendingDuesCount);
        setText("heroPendingSettlements", dashboardState.pendingDuesCount);
        setText("overdueAmountKpi", "₹0");
    }

    function renderPriorityQueue(){
        const box = document.getElementById("wmAttentionList");
        const items = [];

        const pendingOrders = safeNum(document.getElementById("ordersWaiting")?.textContent);
        if (pendingOrders > 0){
            items.push({
                icon:"bi-bag",
                title: pendingOrders + " order(s) processing",
                detail:"Follow up to keep delivery timelines on track.",
                tag:"Orders",
                tone:"is-warning"
            });
        }

        const cartItems = safeNum(document.getElementById("cartItemsInRoles")?.textContent);
        if (cartItems > 0){
            items.push({
                icon:"bi-cart",
                title: cartItems + " cart item(s) ready to checkout",
                detail:"Confirm quantities and proceed to place your order.",
                tag:"Cart",
                tone:""
            });
        }

        if (items.length === 0){
            box.innerHTML = '<div class="wm-home-ops-row"><div class="wm-ops-icon"><i class="bi bi-check-circle"></i></div>' +
                '<div class="wm-ops-body"><strong>All caught up</strong><span>No urgent operational items right now.</span></div>' +
                '<span class="home-pill">Clear</span></div>';
            return;
        }

        box.innerHTML = items.map(item =>
            '<div class="wm-home-ops-row">' +
                '<div class="wm-ops-icon"><i class="bi ' + item.icon + '"></i></div>' +
                '<div class="wm-ops-body"><strong>' + item.title + '</strong><span>' + item.detail + '</span></div>' +
                '<span class="home-pill ' + (item.tone || "") + '">' + item.tag + '</span>' +
            '</div>'
        ).join("");
    }

    /* ================= AI (mocked, like your distributor page) ================= */
    const form = document.getElementById("wmDashboardAiForm");
    const input = document.getElementById("wmDashboardAiMessage");
    const responseBox = document.getElementById("wmDashboardAiResponse");

    function mockReply(message){
        const m = message.toLowerCase();
        const ordersWaiting = safeNum(document.getElementById("ordersWaiting")?.textContent);
        const cartItems = safeNum(document.getElementById("cartItemsInRoles")?.textContent);

        if (m.includes("order")) return "You have " + ordersWaiting + " order(s) currently processing.";
        if (m.includes("cart")) return "Your cart has " + cartItems + " item(s). Proceed when you’re ready to checkout.";
        if (m.includes("due") || m.includes("payment") || m.includes("ledger")) return "Your ledger shows 0 pending dues right now.";
        if (m.includes("reorder") || m.includes("low")) return "Top reorder tip: review your most frequently purchased categories, then add quantities to cover the next 7–10 days.";
        if (m.includes("delivery")) return "Delivery status is up-to-date. Keep an eye on processing orders to get delivered soon.";
        return "Here’s a quick retailer summary: your cart is ready, orders are moving, and you have no urgent dues at the moment.";
    }

    function askAi(){
        const message = input.value.trim();
        if (!message) return;
        responseBox.textContent = "Thinking...";
        setTimeout(function(){
            responseBox.textContent = mockReply(message);
            input.value = "";
        }, 400);
    }

    form.addEventListener("submit", function(e){ e.preventDefault(); askAi(); });
    document.getElementById("wmDashboardAiQuickButtons").addEventListener("click", function(e){
        const btn = e.target.closest("[data-ai-message]");
        if (!btn) return;
        input.value = btn.dataset.aiMessage;
        askAi();
    });

    // initial render
    renderFromApi();

    // update hero numbers (best-effort from what we loaded)
    setTimeout(function(){
        const totalOrders = safeNum(document.getElementById("bizTotalOrders")?.textContent);
        const cartItems = safeNum(document.getElementById("cartItemsInRoles")?.textContent);
        setText("heroTotalOrders", totalOrders);
        setText("heroTotalItems", cartItems);
        renderPriorityQueue();
    }, 600);
});
</script>

</body>
</html>

