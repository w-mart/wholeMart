<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>WholeMart | Distributor Dashboard</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
            rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero-carousel.css">

    </head>

    <body class="wm-home">

        <% String wmUserName=session.getAttribute("name")==null ? "Guest" :
            String.valueOf(session.getAttribute("name")); String wmUserInitial=wmUserName.substring(0,1).toUpperCase();
            %>

            <%@ include file="/WEB-INF/common/distributor-header.jsp" %>

                <div class="wm-app">

                    <main>
                        <div class="wm-home-container">

                            <!-- ========================================= -->
                            <!-- HERO CAROUSEL -->
                            <!-- ========================================= -->
                            <section class="wm-home-hero" aria-label="Distributor hero">
                                <div class="wm-hero-carousel" data-hero-carousel>
                                    <div class="wm-hero-carousel-viewport" data-hero-viewport>
                                        <div class="wm-hero-carousel-track" data-hero-track>
                                            <!-- Slide 1: Your existing hero -->
                                            <section class="wm-home-hero-slide" data-hero-slide="0">
                                                <div class="wm-home-hero-grid">
                                                    <div class="wm-home-hero-copy">
                                                        <span class="wm-kicker"><span class="wm-live-dot"></span>
                                                            DISTRIBUTOR WORKSPACE</span>
                                                        <h1 class="wm-home-title">Welcome back, <strong>
                                                                <%=wmUserName%>
                                                            </strong></h1>
                                                        <p class="wm-home-subtitle">
                                                            Manage your inventory, retailers, deliveries, payments
                                                            and AI recommendations from one centralized workspace.
                                                        </p>
                                                        <div class="wm-home-actions">
                                                            <a class="home-btn home-btn-primary"
                                                                href="/web/distributor/orders"><i
                                                                    class="bi bi-box-seam"></i> Orders</a>
                                                            <a class="home-btn home-btn-secondary"
                                                                href="/web/distributor/products"><i
                                                                    class="bi bi-tags"></i> Products</a>
                                                            <a class="home-btn home-btn-secondary"
                                                                href="/web/distributor/delivery"><i
                                                                    class="bi bi-truck"></i> Deliveries</a>
                                                        </div>
                                                    </div>

                                                    <div class="wm-pulse-card">
                                                        <div
                                                            class="d-flex justify-content-between align-items-start mb-2">
                                                            <div>
                                                                <span class="wm-pulse-eyebrow">Today's
                                                                    Performance</span>
                                                                <h3>Business Snapshot</h3>
                                                            </div>
                                                            <div class="home-logo">AI</div>
                                                        </div>

                                                        <div id="performanceBrief">Loading business insights...</div>

                                                        <hr>

                                                        <div class="wm-pulse-stats">
                                                            <div>
                                                                <h5 id="heroTotalOrders">0</h5>
                                                                <small>Orders</small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroTotalItems">0</h5>
                                                                <small>Products</small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroPendingSettlements">0</h5>
                                                                <small>Pending</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Slide 2: Brand-new tile (auto-scroll/snap) -->
                                            <section class="wm-home-hero-slide" data-hero-slide="1">
                                                <div class="wm-home-hero-grid">
                                                    <div class="wm-home-hero-copy">
                                                        <span class="wm-kicker"><span class="wm-live-dot"></span> SMART
                                                            RESTOCK</span>
                                                        <h1 class="wm-home-title">Run lean, stay in stock</h1>
                                                        <p class="wm-home-subtitle">
                                                            Get AI suggestions for low-stock products and recommended
                                                            replenishment quantities.
                                                            Reduce cancellations and keep your retailers happy.
                                                        </p>
                                                        <div class="wm-home-actions">
                                                            <a class="home-btn home-btn-primary"
                                                                href="/web/distributor/products"><i
                                                                    class="bi bi-graph-down-arrow"></i> Restock</a>
                                                            <a class="home-btn home-btn-secondary"
                                                                href="/web/distributor/reports"><i
                                                                    class="bi bi-bar-chart"></i> Analytics</a>
                                                        </div>
                                                    </div>

                                                    <div class="wm-pulse-card">
                                                        <div
                                                            class="d-flex justify-content-between align-items-start mb-2">
                                                            <div>
                                                                <span class="wm-pulse-eyebrow">AI Recommendations</span>
                                                                <h3>Low Stock Alerts</h3>
                                                            </div>
                                                            <div class="home-logo">AI</div>
                                                        </div>

                                                        <div id="restockBrief">Loading suggestions...</div>

                                                        <hr>

                                                        <div class="wm-pulse-stats">
                                                            <div>
                                                                <h5 id="heroLowStockCount">0</h5>
                                                                <small>Products</small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroRestockCities">0</h5>
                                                                <small>Areas</small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroRestockRisk">0</h5>
                                                                <small>Risk</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Slide 3: Brand-new tile (auto-scroll/snap) -->
                                            <section class="wm-home-hero-slide" data-hero-slide="2">
                                                <div class="wm-home-hero-grid">
                                                    <div class="wm-home-hero-copy">
                                                        <span class="wm-kicker"><span class="wm-live-dot"></span>
                                                            PAYMENTS & SETTLEMENTS</span>
                                                        <h1 class="wm-home-title">Clear dues. Stay profitable.</h1>
                                                        <p class="wm-home-subtitle">
                                                            Track pending settlements, monitor payment health, and get
                                                            reminders before dues turn overdue.
                                                        </p>
                                                        <div class="wm-home-actions">
                                                            <a class="home-btn home-btn-primary"
                                                                href="/web/distributor/dues"><i
                                                                    class="bi bi-cash-coin"></i> Open Ledger</a>
                                                            <a class="home-btn home-btn-secondary"
                                                                href="/web/distributor/orders"><i
                                                                    class="bi bi-box-seam"></i> Orders</a>
                                                        </div>
                                                    </div>

                                                    <div class="wm-pulse-card">
                                                        <div
                                                            class="d-flex justify-content-between align-items-start mb-2">
                                                            <div>
                                                                <span class="wm-pulse-eyebrow">Settlement Health</span>
                                                                <h3>Pending Collection</h3>
                                                            </div>
                                                            <div class="home-logo">AI</div>
                                                        </div>

                                                        <div id="settlementBrief">Loading payment health...</div>

                                                        <hr>

                                                        <div class="wm-pulse-stats">
                                                            <div>
                                                                <h5 id="heroPendingDuesCount">0</h5>
                                                                <small>Retailers</small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroPendingDuesAmount">₹ 0.00</h5>
                                                                <small>Amount</small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroSettlementETA">0</h5>
                                                                <small>Days</small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>
                                        </div>
                                    </div>

                                    <div class="wm-hero-carousel-controls" aria-hidden="true">
                                        <button type="button" class="wm-hero-carousel-btn" data-hero-prev
                                            aria-label="Previous slide"><i class="bi bi-chevron-left"></i></button>
                                        <button type="button" class="wm-hero-carousel-btn" data-hero-next
                                            aria-label="Next slide"><i class="bi bi-chevron-right"></i></button>
                                    </div>

                                    <div class="wm-hero-carousel-dots" data-hero-dots
                                        aria-label="Hero slide indicators"></div>
                                </div>
                            </section>
                            <hr>
                            <section class="wm-home-reports mb-4">
                                <div class="home-section-head">
                                    <span class="wm-kicker">ANALYTICS</span>
                                    <h2>Reports & Business Intelligence</h2>
                                    <p>Real-time insights into inventory, fulfillment and business growth.</p>
                                </div>

                                <div class="row g-4">

                                    <div class="col-lg-4">
                                        <article class="home-role-card h-100">
                                            <div class="wm-report-card-head">
                                                <h3 class="mb-0">Inventory Health</h3>
                                                <div class="wm-ring is-success" style="--pct:92"><span>92%</span></div>
                                            </div>
                                            <div class="wm-report-item"><span>Total Products</span><strong
                                                    id="reportTotalItems">0</strong></div>
                                            <div class="wm-report-item"><span>Categories</span><strong
                                                    id="reportCategoryCount">0</strong></div>
                                            <div class="wm-report-item"><span>Availability</span><strong
                                                    style="color:var(--wm-success)">92%</strong></div>
                                            <div class="wm-report-item"><span>Out of Stock</span><strong
                                                    style="color:var(--wm-danger)">0</strong></div>
                                        </article>
                                    </div>

                                    <div class="col-lg-4">
                                        <article class="home-role-card h-100">
                                            <div class="wm-report-card-head">
                                                <h3 class="mb-0">Order Performance</h3>
                                                <div class="wm-ring is-success" style="--pct:98"><span>98%</span></div>
                                            </div>
                                            <div class="wm-report-item"><span>Total Orders</span><strong
                                                    id="reportTotalOrders">0</strong></div>
                                            <div class="wm-report-item"><span>Running Orders</span><strong
                                                    id="reportActiveOrders">0</strong></div>
                                            <div class="wm-report-item"><span>Success Rate</span><strong
                                                    style="color:var(--wm-success)">98.4%</strong></div>
                                            <div class="wm-report-item"><span>Rejected</span><strong>0</strong></div>
                                        </article>
                                    </div>

                                    <div class="col-lg-4">
                                        <article class="home-role-card h-100">
                                            <div class="wm-report-card-head">
                                                <h3 class="mb-0">Business Growth</h3>
                                                <div class="wm-ring" style="--pct:78"><span>78%</span></div>
                                            </div>
                                            <div class="wm-report-item"><span>Retailers</span><strong>84</strong></div>
                                            <div class="wm-report-item"><span>Revenue Trend</span><strong
                                                    style="color:var(--wm-success)">+12%</strong></div>
                                            <div class="wm-report-item"><span>Expansion</span><strong>2 Cities</strong>
                                            </div>
                                            <div class="wm-report-item"><span>Target
                                                    Achievement</span><strong>78%</strong></div>
                                        </article>
                                    </div>

                                </div>
                            </section>

                            <hr>
                            <section id="snapshot" class="mb-4">
                                <div class="home-section-head">
                                    <span class="wm-kicker">ANALYTICS</span>
                                    <h2>Business Snapshot</h2>
                                    <p>A live ledger view of your orders, revenue trend, activity and payment health.
                                    </p>
                                </div>

                                <div class="card shadow-sm border-0 rounded-4">
                                    <div class="card-header bg-white border-0 pt-4">
                                        <h4 class="fw-bold text-center">Business Snapshot</h4>
                                    </div>
                                    <div class="card-body px-lg-4">
                                        <div class="row g-4">
                                            <div class="col-lg-3 col-md-6">
                                                <canvas id="distOrderStatusChart" role="img"
                                                    aria-label="Order status breakdown"></canvas>
                                            </div>
                                            <div class="col-lg-3 col-md-6">
                                                <canvas id="distRevenueTrendChart" role="img"
                                                    aria-label="Revenue trend, last 6 months"></canvas>
                                            </div>
                                            <div class="col-lg-3 col-md-6">
                                                <canvas id="distActivityBarChart" role="img"
                                                    aria-label="Activity count across products, orders, deliveries and payments"></canvas>
                                            </div>
                                            <div class="col-lg-3 col-md-6">
                                                <canvas id="distPaymentLedgerChart" role="img"
                                                    aria-label="Payment ledger: collected vs pending"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <hr>

                            <!-- ===================================================== -->
                            <!-- PRIORITY CENTER
                 Moved directly under the hero: "what needs my attention
                 right now" is more actionable above the fold than raw
                 KPI counts, and it's what the AI panel below will end
                 up talking about anyway. -->
                            <!-- ===================================================== -->
                            <section class="wm-home-ops mb-4">
                                <div class="home-section-head">
                                    <span class="wm-kicker">OPERATIONS</span>
                                    <h2>Priority Center</h2>
                                    <p>Live operational tasks generated from orders, inventory, payments and deliveries.
                                    </p>
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
                                                <span>WholeMart is analysing your orders, inventory and
                                                    deliveries.</span>
                                            </div>
                                            <span class="home-pill">Loading</span>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <hr>
                            <!-- ========================================= -->
                            <!-- DASHBOARD KPI -->
                            <!-- ========================================= -->
                            <section class="wm-home-impact">
                                <div class="home-section-head">
                                    <h2>Business Overview</h2>
                                    <p>Live operational metrics from your distributor workspace.</p>
                                </div>

                                <!-- Headline metrics -->
                                <div class="wm-kpi-headline">

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label">Revenue</span>
                                                <strong id="capturedRevenue" class="wm-kpi-value">Rs. 0.00</strong>
                                            </div>
                                            <div class="home-role-mark is-success"><i class="bi bi-currency-rupee"></i>
                                            </div>
                                        </div>
                                        <p class="wm-kpi-foot"><span class="wm-trend-up">+12%</span> vs last month</p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label">Active Orders</span>
                                                <strong id="bizActiveOrders" class="wm-kpi-value">0</strong>
                                            </div>
                                            <div class="home-role-mark"><i class="bi bi-box-seam"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot">Total Orders <strong id="bizTotalOrders">0</strong></p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label">Inventory</span>
                                                <strong id="bizTotalItems" class="wm-kpi-value">0</strong>
                                            </div>
                                            <div class="home-role-mark"><i class="bi bi-tag"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot">Active Products</p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label">Settlements</span>
                                                <strong id="bizPendingSettlements" class="wm-kpi-value">0</strong>
                                            </div>
                                            <div class="home-role-mark is-danger"><i class="bi bi-cash-coin"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot" style="color:var(--wm-danger)">Pending Collection</p>
                                    </article>

                                </div>

                                <!-- Secondary metrics — labeled and visually lighter so the
                     four headline numbers above stay the primary read. -->
                                <div class="wm-subsection-label">At a Glance</div>
                                <div class="wm-kpi-secondary">

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label">Fleet</span>
                                                <strong class="wm-kpi-value">12</strong>
                                            </div>
                                            <div class="home-role-mark"><i class="bi bi-truck"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot">Active Drivers</p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label">Retailers</span>
                                                <strong class="wm-kpi-value">84</strong>
                                            </div>
                                            <div class="home-role-mark"><i class="bi bi-shop"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot"><span class="wm-trend-up">+4</span> this week</p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label">Catalog Health</span>
                                                <strong class="wm-kpi-value">94%</strong>
                                            </div>
                                            <div class="wm-ring is-success" style="--pct:94"><span>94%</span></div>
                                        </div>
                                        <p class="wm-kpi-foot">Products Ready</p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label">Alerts</span>
                                                <strong class="wm-kpi-value" style="color:var(--wm-danger)">3</strong>
                                            </div>
                                            <div class="home-role-mark is-danger"><i
                                                    class="bi bi-exclamation-triangle"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot" style="color:var(--wm-danger)">Immediate Action</p>
                                    </article>

                                </div>
                            </section>
                            <hr>

                            <!-- ===================================================== -->
                            <!-- BUSINESS SNAPSHOT (LEDGER) -->
                            <!-- ===================================================== -->

                            <!-- ===================================================== -->
                            <!-- WHOLEMART AI ASSISTANT -->
                            <!-- ===================================================== -->
                            <section class="wm-card wm-ai-panel mb-4 mt-5">
                                <div class="wm-ai-header">
                                    <div class="wm-ai-avatar">AI</div>
                                    <div>
                                        <h2 class="mb-1">WholeMart AI Assistant</h2>
                                        <p class="text-muted mb-0">
                                            Ask anything about orders, products, payments,
                                            retailers, deliveries or business performance.
                                        </p>
                                    </div>
                                </div>

                                <div class="row g-4 align-items-start">
                                    <div class="col-lg-7">
                                        <div id="wmDashboardAiResponse" class="wm-ai-response">
                                            Welcome <strong>
                                                <%= wmUserName %>
                                            </strong> 👋
                                            <br><br>
                                            I'm ready to help you with your distributor business.
                                            <br><br>
                                            You can ask things like:
                                            <ul class="mb-0 mt-2">
                                                <li>Show today's orders</li>
                                                <li>Which products are running low?</li>
                                                <li>Pending retailer payments</li>
                                                <li>Suggest products to restock</li>
                                                <li>Business performance summary</li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="col-lg-5">
                                        <h5 class="mb-3">Suggested Questions</h5>
                                        <div id="wmDashboardAiQuickButtons" class="wm-ai-chips">
                                            <button type="button" class="wm-ai-chip"
                                                data-ai-message="Show today's order summary"><i
                                                    class="bi bi-box-seam"></i> Today's Orders</button>
                                            <button type="button" class="wm-ai-chip"
                                                data-ai-message="Show low stock products"><i
                                                    class="bi bi-graph-down-arrow"></i> Low Stock</button>
                                            <button type="button" class="wm-ai-chip"
                                                data-ai-message="Show pending retailer payments"><i
                                                    class="bi bi-cash-coin"></i> Pending Payments</button>
                                            <button type="button" class="wm-ai-chip"
                                                data-ai-message="Business performance summary"><i
                                                    class="bi bi-bar-chart"></i> Business Summary</button>
                                            <button type="button" class="wm-ai-chip"
                                                data-ai-message="Suggest products to reorder"><i
                                                    class="bi bi-arrow-repeat"></i> Restock Suggestions</button>
                                            <button type="button" class="wm-ai-chip"
                                                data-ai-message="Today's priorities"><i
                                                    class="bi bi-lightning-charge"></i> Today's Priorities</button>
                                        </div>
                                    </div>

                                </div>

                                <form id="wmDashboardAiForm" class="mt-4">
                                    <div class="input-group">
                                        <input id="wmDashboardAiMessage" type="text" class="form-control"
                                            placeholder="Ask WholeMart AI anything...">
                                        <button class="home-btn home-btn-secondary" type="button"><i
                                                class="bi bi-mic-fill"></i></button>
                                        <button class="home-btn home-btn-primary" type="submit"><i
                                                class="bi bi-send"></i> Ask AI</button>
                                    </div>
                                </form>

                                <div id="wmDashboardAiActionBox" class="mt-3"></div>
                            </section>

                            <hr>
                            <!-- ===================================================== -->
                            <!-- FULFILLMENT & OPERATIONS -->
                            <!-- ===================================================== -->
                            <section class="wm-home-roles mb-4">
                                <div class="home-section-head">
                                    <span class="wm-kicker">OPERATIONS</span>
                                    <h2>Fulfillment & Supply Chain</h2>
                                    <p>Monitor every operational stage from order placement to successful delivery.</p>
                                </div>

                                <div class="wm-home-role-grid">

                                    <article class="home-role-card">
                                        <div class="home-role-mark"><i class="bi bi-box-seam"></i></div>
                                        <h3>Order Pipeline</h3>
                                        <p>Live order fulfillment queue.</p>
                                        <div class="mt-4">
                                            <div class="wm-role-metric-row">
                                                <span>Waiting Review</span>
                                                <strong id="ordersWaiting" style="color:var(--wm-danger)">0</strong>
                                            </div>
                                            <div class="wm-role-metric-row">
                                                <span>Ready to Pack</span>
                                                <strong id="ordersReady">0</strong>
                                            </div>
                                        </div>
                                        <a href="/web/distributor/orders" class="home-btn home-btn-primary mt-4">Open
                                            Orders</a>
                                    </article>

                                    <article class="home-role-card">
                                        <div class="home-role-mark"><i class="bi bi-bar-chart-line"></i></div>
                                        <h3>Inventory</h3>
                                        <p>Stock availability across catalog.</p>
                                        <div class="mt-4">
                                            <div class="wm-role-metric-row">
                                                <span>Categories</span>
                                                <strong id="categoryCount">0</strong>
                                            </div>
                                            <div class="wm-role-metric-row">
                                                <span>Refill Needed</span>
                                                <strong id="stockPlanningCount"
                                                    style="color:var(--wm-warning)">0</strong>
                                            </div>
                                        </div>
                                        <a href="/web/distributor/products"
                                            class="home-btn home-btn-primary mt-4">Manage Products</a>
                                    </article>

                                    <article class="home-role-card">
                                        <div class="home-role-mark"><i class="bi bi-cash-coin"></i></div>
                                        <h3>Credit Ledger</h3>
                                        <p>Retailer dues & settlements.</p>
                                        <div class="mt-4">
                                            <div class="wm-role-metric-row">
                                                <span>Overdue Amount</span>
                                                <strong style="color:var(--wm-danger)">₹0</strong>
                                            </div>
                                            <div class="wm-role-metric-row">
                                                <span>Disputes</span>
                                                <strong>0</strong>
                                            </div>
                                        </div>
                                        <a href="/web/distributor/dues" class="home-btn home-btn-primary mt-4">Open
                                            Ledger</a>
                                    </article>

                                    <article class="home-role-card">
                                        <div class="home-role-mark"><i class="bi bi-truck"></i></div>
                                        <h3>Dispatch Hub</h3>
                                        <p>Delivery planning & fleet tracking.</p>
                                        <div class="mt-4">
                                            <div class="wm-role-metric-row">
                                                <span>Completed</span>
                                                <strong id="completedDropoffs">0</strong>
                                            </div>
                                            <div class="wm-role-metric-row">
                                                <span>Active Trips</span>
                                                <strong>0</strong>
                                            </div>
                                        </div>
                                        <a href="/web/distributor/delivery"
                                            class="home-btn home-btn-primary mt-4">Dispatch Center</a>
                                    </article>

                                </div>
                            </section>

                            <hr>

                            <!-- ===================================================== -->
                            <!-- PRODUCTIVITY CENTER -->
                            <!-- ===================================================== -->
                            <section class="mb-4">
                                <div class="row g-4">

                                    <div class="col-lg-8">
                                        <div class="wm-card h-100">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <div>
                                                    <span class="wm-kicker">LIVE FEED</span>
                                                    <h3 class="mb-0">Recent Activities</h3>
                                                </div>
                                                <span class="home-pill">Today</span>
                                            </div>

                                            <div class="wm-timeline">
                                                <div class="wm-timeline-item">
                                                    <div class="wm-timeline-icon is-success"><i
                                                            class="bi bi-check-lg"></i></div>
                                                    <div><strong>Order #ORD-10025 Accepted</strong>
                                                        <div class="text-muted">5 minutes ago</div>
                                                    </div>
                                                </div>
                                                <div class="wm-timeline-item">
                                                    <div class="wm-timeline-icon is-info"><i class="bi bi-box-seam"></i>
                                                    </div>
                                                    <div><strong>Inventory Updated</strong>
                                                        <div class="text-muted">12 products restocked</div>
                                                    </div>
                                                </div>
                                                <div class="wm-timeline-item">
                                                    <div class="wm-timeline-icon is-warning"><i
                                                            class="bi bi-cash-coin"></i></div>
                                                    <div><strong>Payment Pending</strong>
                                                        <div class="text-muted">₹12,500 awaiting settlement</div>
                                                    </div>
                                                </div>
                                                <div class="wm-timeline-item">
                                                    <div class="wm-timeline-icon is-info"><i class="bi bi-truck"></i>
                                                    </div>
                                                    <div><strong>Driver Assigned</strong>
                                                        <div class="text-muted">Delivery route optimized</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-4">
                                        <div class="wm-card h-100">
                                            <span class="wm-kicker">SHORTCUTS</span>
                                            <h3 class="mb-4">Quick Actions</h3>
                                            <div class="wm-quick-actions">
                                                <a href="/web/distributor/add-product"
                                                    class="home-btn home-btn-primary"><i class="bi bi-plus-circle"></i>
                                                    Add Product</a>
                                                <a href="/web/distributor/orders" class="home-btn home-btn-secondary"><i
                                                        class="bi bi-box-seam"></i> Manage Orders</a>
                                                <a href="/web/distributor/delivery"
                                                    class="home-btn home-btn-secondary"><i class="bi bi-truck"></i>
                                                    Delivery Center</a>
                                                <a href="/web/distributor/dues" class="home-btn home-btn-secondary"><i
                                                        class="bi bi-cash-coin"></i> View Payments</a>
                                                <a href="/web/distributor/reports"
                                                    class="home-btn home-btn-secondary"><i class="bi bi-bar-chart"></i>
                                                    Analytics</a>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </section>

                            <%@ include file="/WEB-INF/common/footer.jsp" %>

                                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                                <script>
                                    document.addEventListener("DOMContentLoaded", function () {

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
                                           CHART INSTANCES (Business Snapshot)
                                        ====================================================== */
                                        let distOrderStatusChart, distRevenueTrendChart,
                                            distActivityBarChart, distPaymentLedgerChart;

                                        /* =====================================================
                                           DASHBOARD STATE
                                        ====================================================== */
                                        const dashboardState = {
                                            orders: [],
                                            products: [],
                                            payments: [],
                                            deliveries: []
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

                                        // Update several id's with the same value in one call, since several
                                        // cards on this page show the same underlying metric.
                                        function setTextAll(ids, value) {
                                            ids.forEach(function (id) {
                                                setText(id, value);
                                            });
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

                                        function startOfDay(date) {
                                            return new Date(date.getFullYear(), date.getMonth(), date.getDate());
                                        }

                                        function daysAgo(days) {
                                            const date = startOfDay(new Date());
                                            date.setDate(date.getDate() - days);
                                            return date;
                                        }

                                        function percentChange(current, previous) {
                                            if (!previous) {
                                                return current ? "New" : "0%";
                                            }
                                            const value = ((current - previous) / previous) * 100;
                                            return (value >= 0 ? "+" : "-") + Math.abs(value).toFixed(1) + "%";
                                        }

                                        /* =====================================================
                                           ORDER CALCULATIONS
                                        ====================================================== */
                                        function sumOrders(orders, from, to) {
                                            return orders.reduce(function (total, order) {
                                                const created = order.createdAt ? new Date(order.createdAt) : null;
                                                if (!created) {
                                                    return total;
                                                }
                                                if (created < from || created >= to) {
                                                    return total;
                                                }
                                                return total + Number(order.totalAmount || 0);
                                            }, 0);
                                        }

                                        function countOrders(orders, from, to) {
                                            return orders.filter(function (order) {
                                                const created = order.createdAt ? new Date(order.createdAt) : null;
                                                return created && created >= from && created < to;
                                            }).length;
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
                                           ORDERS
                                        ====================================================== */
                                        async function loadOrders() {
                                            const orders = await loadApi("/api/v1/orders");

                                            dashboardState.orders = orders;

                                            setTextAll(["reportTotalOrders", "heroTotalOrders", "bizTotalOrders"], orders.length);

                                            const activeCount = orders.filter(o =>
                                                o.status !== "DELIVERED" &&
                                                o.status !== "REJECTED" &&
                                                o.status !== "CANCELLED"
                                            ).length;
                                            setTextAll(["reportActiveOrders", "bizActiveOrders"], activeCount);

                                            setText("ordersWaiting", orders.filter(o => o.status === "PLACED").length);
                                            setText("ordersReady", orders.filter(o => o.status === "ACCEPTED").length);

                                            const revenue = orders.reduce((t, o) => t + Number(o.totalAmount || 0), 0);
                                            setText("capturedRevenue", money(revenue));

                                            renderPerformanceBrief(orders);
                                            renderRecommendedActions();
                                        }

                                        /* =====================================================
                                           PRODUCTS
                                        ====================================================== */
                                        async function loadProducts() {
                                            const products = await loadApi("/api/v1/products/mine");
                                            dashboardState.products = products;

                                            const categories = new Set(products.map(p => p.category)).size;

                                            setTextAll(["totalItems", "heroTotalItems", "bizTotalItems", "reportTotalItems"], products.length);
                                            setTextAll(["categoryCount", "reportCategoryCount"], categories);
                                            setText("stockPlanningCount", categories);

                                            renderRecommendedActions();
                                        }

                                        /* =====================================================
                                           PAYMENTS
                                        ====================================================== */
                                        async function loadPayments() {
                                            const payments = await loadApi("/api/v1/payments");
                                            dashboardState.payments = payments;

                                            const pendingCount = payments.filter(p => p.status === "PENDING").length;
                                            setTextAll(["pendingSettlements", "heroPendingSettlements", "bizPendingSettlements"], pendingCount);

                                            renderRecommendedActions();
                                        }

                                        /* =====================================================
                                           DELIVERIES
                                        ====================================================== */
                                        async function loadDeliveries() {
                                            const deliveries = await loadApi("/api/v1/deliveries");
                                            dashboardState.deliveries = deliveries;

                                            setText("completedDropoffs", deliveries.filter(d => d.status === "DELIVERED").length);

                                            renderRecommendedActions();
                                        }

                                        /* =====================================================
                                           PERFORMANCE BRIEF (hero card summary text)
                                        ====================================================== */
                                        function renderPerformanceBrief(orders) {
                                            if (!performanceBrief) {
                                                return;
                                            }

                                            const today = startOfDay(new Date());
                                            const tomorrow = new Date(today);
                                            tomorrow.setDate(tomorrow.getDate() + 1);
                                            const yesterday = daysAgo(1);

                                            const todayRevenue = sumOrders(orders, today, tomorrow);
                                            const yesterdayRevenue = sumOrders(orders, yesterday, today);
                                            const todayOrders = countOrders(orders, today, tomorrow);

                                            performanceBrief.innerHTML =
                                                "Today: <strong>" + todayOrders + "</strong> orders, " +
                                                "<strong>" + money(todayRevenue) + "</strong> revenue " +
                                                "(" + percentChange(todayRevenue, yesterdayRevenue) + " vs yesterday).";
                                        }

                                        /* =====================================================
                                           PRIORITY / RECOMMENDED ACTIONS
                                        ====================================================== */
                                        function renderRecommendedActions() {
                                            if (!attentionList) {
                                                return;
                                            }

                                            const items = [];

                                            const waitingOrders = dashboardState.orders.filter(o => o.status === "PLACED").length;
                                            if (waitingOrders > 0) {
                                                items.push({
                                                    icon: "bi-box-seam",
                                                    title: waitingOrders + " order(s) waiting review",
                                                    detail: "New orders need to be accepted or rejected.",
                                                    tag: "Orders",
                                                    tone: "is-warning"
                                                });
                                            }

                                            const pendingPayments = dashboardState.payments.filter(p => p.status === "PENDING").length;
                                            if (pendingPayments > 0) {
                                                items.push({
                                                    icon: "bi-cash-coin",
                                                    title: pendingPayments + " payment(s) pending settlement",
                                                    detail: "Follow up with retailers on outstanding dues.",
                                                    tag: "Payments",
                                                    tone: "is-danger"
                                                });
                                            }

                                            const activeDeliveries = dashboardState.deliveries.filter(d => d.status !== "DELIVERED").length;
                                            if (activeDeliveries > 0) {
                                                items.push({
                                                    icon: "bi-truck",
                                                    title: activeDeliveries + " delivery(ies) in progress",
                                                    detail: "Track dispatch status for active trips.",
                                                    tag: "Delivery",
                                                    tone: ""
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

                                            attentionList.innerHTML = items.map(function (item) {
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
                                           BUSINESS SNAPSHOT CHARTS
                                        ====================================================== */
                                        function renderSnapshotCharts() {

                                            const orders = dashboardState.orders || [];
                                            const products = dashboardState.products || [];
                                            const payments = dashboardState.payments || [];
                                            const deliveries = dashboardState.deliveries || [];

                                            /* ---------- 1. Order status doughnut ---------- */
                                            const statusCounts = {
                                                Placed: orders.filter(o => o.status === "PLACED").length,
                                                Accepted: orders.filter(o => o.status === "ACCEPTED").length,
                                                Delivered: orders.filter(o => o.status === "DELIVERED").length,
                                                "Rejected/Cancelled": orders.filter(o => o.status === "REJECTED" || o.status === "CANCELLED").length
                                            };

                                            const statusCtx = document.getElementById("distOrderStatusChart");
                                            if (statusCtx) {
                                                if (distOrderStatusChart) distOrderStatusChart.destroy();
                                                distOrderStatusChart = new Chart(statusCtx, {
                                                    type: "doughnut",
                                                    data: {
                                                        labels: Object.keys(statusCounts),
                                                        datasets: [{
                                                            data: Object.values(statusCounts),
                                                            backgroundColor: ["#2E5AA8", "#E3A73B", "#1F6D46", "#C2410C"],
                                                            borderWidth: 2
                                                        }]
                                                    },
                                                    options: {
                                                        responsive: true,
                                                        plugins: {
                                                            legend: { position: "bottom" },
                                                            title: { display: true, text: "Order Status" }
                                                        },
                                                        cutout: "65%"
                                                    }
                                                });
                                            }

                                            /* ---------- 2. Revenue trend (last 6 months) ---------- */
                                            const monthLabels = [];
                                            const monthTotals = [];
                                            const now = new Date();

                                            for (let i = 5; i >= 0; i--) {
                                                const monthStart = new Date(now.getFullYear(), now.getMonth() - i, 1);
                                                const monthEnd = new Date(now.getFullYear(), now.getMonth() - i + 1, 1);
                                                monthLabels.push(monthStart.toLocaleString("en-IN", { month: "short" }));

                                                const total = orders.reduce((sum, o) => {
                                                    const created = o.createdAt ? new Date(o.createdAt) : null;
                                                    if (created && created >= monthStart && created < monthEnd) {
                                                        return sum + Number(o.totalAmount || 0);
                                                    }
                                                    return sum;
                                                }, 0);
                                                monthTotals.push(Math.round(total / 1000) / 100); // in Lakhs
                                            }

                                            const trendCtx = document.getElementById("distRevenueTrendChart");
                                            if (trendCtx) {
                                                if (distRevenueTrendChart) distRevenueTrendChart.destroy();
                                                distRevenueTrendChart = new Chart(trendCtx, {
                                                    type: "line",
                                                    data: {
                                                        labels: monthLabels,
                                                        datasets: [{
                                                            label: "Revenue (in L)",
                                                            data: monthTotals,
                                                            fill: false,
                                                            borderColor: "#C2410C",
                                                            tension: 0.1
                                                        }]
                                                    },
                                                    options: {
                                                        responsive: true,
                                                        plugins: {
                                                            legend: { display: false },
                                                            title: { display: true, text: "Monthly Revenue Trend" }
                                                        },
                                                        scales: {
                                                            y: {
                                                                beginAtZero: false,
                                                                ticks: { callback: v => "₹" + v + "L" }
                                                            }
                                                        }
                                                    }
                                                });
                                            }

                                            /* ---------- 3. Activity bar chart ---------- */
                                            const activityLabels = ["Products", "Active Orders", "Delivered", "Pending Payments"];
                                            const activeOrders = orders.filter(o =>
                                                o.status !== "DELIVERED" && o.status !== "REJECTED" && o.status !== "CANCELLED"
                                            ).length;
                                            const deliveredCount = deliveries.filter(d => d.status === "DELIVERED").length;
                                            const pendingPayments = payments.filter(p => p.status === "PENDING").length;

                                            const activityData = [products.length, activeOrders, deliveredCount, pendingPayments];

                                            const barCtx = document.getElementById("distActivityBarChart");
                                            if (barCtx) {
                                                if (distActivityBarChart) distActivityBarChart.destroy();
                                                distActivityBarChart = new Chart(barCtx, {
                                                    type: "bar",
                                                    data: {
                                                        labels: activityLabels,
                                                        datasets: [{
                                                            label: "Count",
                                                            data: activityData,
                                                            backgroundColor: ["#2E5AA8", "#1F6D46", "#154F34", "#C2410C"],
                                                            borderWidth: 1
                                                        }]
                                                    },
                                                    options: {
                                                        responsive: true,
                                                        plugins: {
                                                            legend: { display: false },
                                                            title: { display: true, text: "Activity Count" }
                                                        },
                                                        scales: {
                                                            y: { beginAtZero: true, ticks: { precision: 0 } }
                                                        }
                                                    }
                                                });
                                            }

                                            /* ---------- 4. Payment ledger doughnut ---------- */
                                            const collected = payments
                                                .filter(p => p.status !== "PENDING")
                                                .reduce((sum, p) => sum + Number(p.amount || p.totalAmount || 0), 0);
                                            const pending = payments
                                                .filter(p => p.status === "PENDING")
                                                .reduce((sum, p) => sum + Number(p.amount || p.totalAmount || 0), 0);

                                            const ledgerCtx = document.getElementById("distPaymentLedgerChart");
                                            if (ledgerCtx) {
                                                if (distPaymentLedgerChart) distPaymentLedgerChart.destroy();
                                                distPaymentLedgerChart = new Chart(ledgerCtx, {
                                                    type: "doughnut",
                                                    data: {
                                                        labels: ["Collected (₹)", "Pending (₹)"],
                                                        datasets: [{
                                                            data: [collected, pending],
                                                            backgroundColor: ["#1F6D46", "#E3A73B"],
                                                            borderWidth: 2
                                                        }]
                                                    },
                                                    options: {
                                                        responsive: true,
                                                        plugins: {
                                                            legend: { position: "bottom" },
                                                            title: { display: true, text: "Payment Ledger" }
                                                        },
                                                        cutout: "65%"
                                                    }
                                                });
                                            }
                                        }

                                        /* =====================================================
                                           AI ASSISTANT
                                        ====================================================== */
                                        async function askAi() {
                                            const message = input.value.trim();
                                            if (!message || !responseBox) {
                                                return;
                                            }

                                            responseBox.textContent = "Thinking...";

                                            try {
                                                const res = await fetch("/api/v1/ai/query", {
                                                    method: "POST",
                                                    headers: { "Content-Type": "application/json" },
                                                    body: JSON.stringify({ message: message })
                                                });

                                                if (!res.ok) {
                                                    throw new Error("AI request failed");
                                                }

                                                const data = await res.json();

                                                responseBox.textContent = data.reply || "Sorry, I couldn't find an answer for that.";

                                                if (data.requiresConfirmation && data.actionId) {
                                                    showAiConfirmation(data.actionId, data.actionType || "Confirm action");
                                                } else if (actionBox) {
                                                    actionBox.innerHTML = "";
                                                }
                                            } catch (e) {
                                                console.error("AI request error:", e);
                                                responseBox.textContent = "Something went wrong reaching the AI assistant. Please try again.";
                                            } finally {
                                                input.value = "";
                                            }
                                        }

                                        function showAiConfirmation(id, type) {
                                            if (!actionBox) {
                                                return;
                                            }
                                            actionBox.innerHTML =
                                                '<div class="alert alert-warning mt-3">' +
                                                '<b>' + type + '</b>' +
                                                '<div class="mt-3">' +
                                                '<button class="btn btn-success btn-sm" onclick="confirmAiAction(' + id + ',true)">Confirm</button>' +
                                                '<button class="btn btn-secondary btn-sm ms-2" onclick="confirmAiAction(' + id + ',false)">Cancel</button>' +
                                                '</div>' +
                                                '</div>';
                                        }

                                        // Exposed globally since it's invoked from inline onclick handlers above.
                                        window.confirmAiAction = async function (id, confirmed) {
                                            try {
                                                const res = await fetch("/api/v1/ai/confirm-action", {
                                                    method: "POST",
                                                    headers: { "Content-Type": "application/json" },
                                                    body: JSON.stringify({ actionId: id, confirmed: confirmed })
                                                });

                                                const data = await res.json();

                                                if (responseBox) {
                                                    responseBox.textContent = data.reply ||
                                                        (confirmed ? "Action confirmed." : "Action cancelled.");
                                                }
                                            } catch (e) {
                                                console.error("Confirm action error:", e);
                                            } finally {
                                                if (actionBox) {
                                                    actionBox.innerHTML = "";
                                                }
                                            }
                                        };

                                        /* =====================================================
                                           INITIALIZE
                                         ====================================================== */
                                        async function initializeDashboard() {
                                            await Promise.all([
                                                loadOrders(),
                                                loadProducts(),
                                                loadPayments(),
                                                loadDeliveries()
                                            ]);
                                            renderSnapshotCharts();
                                        }

                                        /* =====================================================
                                           HERO CAROUSEL (auto + prev/next + snap scroll)
                                        ====================================================== */
                                        function setupHeroCarousel() {
                                            const carousel = document.querySelector("[data-hero-carousel]");
                                            if (!carousel) return;

                                            const viewport = carousel.querySelector("[data-hero-viewport]");
                                            const track = carousel.querySelector("[data-hero-track]");
                                            const slides = Array.from(carousel.querySelectorAll("[data-hero-slide]"));
                                            const btnPrev = carousel.querySelector("[data-hero-prev]");
                                            const btnNext = carousel.querySelector("[data-hero-next]");
                                            const dotsEl = carousel.querySelector("[data-hero-dots]");

                                            if (!viewport || !track || slides.length === 0) return;

                                            // Build dots if missing
                                            if (dotsEl && dotsEl.children.length === 0) {
                                                dotsEl.innerHTML = slides.map(function (_, i) {
                                                    return '<button type="button" class="wm-hero-dot" data-hero-goto="' + i + '" aria-label="Go to slide ' + (i + 1) + '">' +
                                                        '<span></span></button>';
                                                }).join("");
                                            }

                                            const dots = dotsEl ? Array.from(dotsEl.querySelectorAll("[data-hero-goto]")) : [];

                                            let currentIndex = 0;
                                            let timer = null;
                                            const intervalMs = 6000;

                                            function setActive(index) {
                                                currentIndex = index;
                                                slides.forEach(function (s, i) {
                                                    s.classList.toggle("is-active", i === currentIndex);
                                                });
                                                dots.forEach(function (d) {
                                                    const i = Number(d.dataset.heroGoto);
                                                    d.classList.toggle("is-active", i === currentIndex);
                                                    d.setAttribute("aria-current", String(i === currentIndex));
                                                });
                                            }

                                            function goTo(index, { silent } = { silent: false }) {
                                                if (slides.length === 0) return;
                                                const safe = (index + slides.length) % slides.length;
                                                const slideEl = slides[safe];
                                                if (!slideEl) return;

                                                const left = slideEl.offsetLeft;
                                                viewport.scrollTo({ left: left, behavior: silent ? "auto" : "smooth" });
                                                setActive(safe);
                                            }

                                            function next() { goTo(currentIndex + 1); }
                                            function prev() { goTo(currentIndex - 1); }

                                            function start() {
                                                stop();
                                                timer = window.setInterval(function () {
                                                    next();
                                                }, intervalMs);
                                            }

                                            function stop() {
                                                if (timer) {
                                                    window.clearInterval(timer);
                                                    timer = null;
                                                }
                                            }

                                            // Sync active index from scroll
                                            let scrollRaf = null;
                                            viewport.addEventListener("scroll", function () {
                                                if (scrollRaf) return;
                                                scrollRaf = window.requestAnimationFrame(function () {
                                                    scrollRaf = null;
                                                    // Determine closest slide
                                                    let best = 0;
                                                    let bestDist = Number.POSITIVE_INFINITY;
                                                    slides.forEach(function (s, i) {
                                                        const dist = Math.abs(s.offsetLeft - viewport.scrollLeft);
                                                        if (dist < bestDist) {
                                                            bestDist = dist;
                                                            best = i;
                                                        }
                                                    });
                                                    setActive(best);
                                                });
                                            });

                                            // Pause auto on hover/focus/interaction
                                            const pauseEvents = ["mouseenter", "mouseleave", "focusin", "touchstart", "pointerdown", "wheel", "mousedown"];
                                            pauseEvents.forEach(function (evt) {
                                                carousel.addEventListener(evt, function (e) {
                                                    if (evt === "mouseleave") {
                                                        start();
                                                    } else {
                                                        stop();
                                                    }
                                                }, { passive: true });
                                            });

                                            btnPrev && btnPrev.addEventListener("click", function () { prev(); });
                                            btnNext && btnNext.addEventListener("click", function () { next(); });

                                            dotsEl && dotsEl.addEventListener("click", function (e) {
                                                const target = e.target.closest("[data-hero-goto]");
                                                if (!target) return;
                                                const i = Number(target.dataset.heroGoto);
                                                goTo(i);
                                            });

                                            // Initialize
                                            setActive(0);
                                            goTo(0, { silent: true });
                                            start();
                                        }

                                        // Initialize (important: initialize dashboard first, then hero carousel)
                                        initializeDashboard().finally(function () {
                                            setupHeroCarousel();
                                        });


                                        form.addEventListener("submit", function (e) {
                                            e.preventDefault();
                                            askAi();
                                        });

                                        quickButtons.addEventListener("click", function (e) {
                                            const btn = e.target.closest("[data-ai-message]");
                                            if (!btn) return;
                                            input.value = btn.dataset.aiMessage;
                                            askAi();
                                        });

                                    });
                                </script>

                        </div>
    </body>

    </html>