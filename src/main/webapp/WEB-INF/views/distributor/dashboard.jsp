<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

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
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap" rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">

</head>

<body class="wm-home">

<%
String wmUserName = session.getAttribute("username") == null
        ? "Distributor"
        : String.valueOf(session.getAttribute("username"));
String wmUserInitial = wmUserName.substring(0,1).toUpperCase();
%>

<div class="wm-app">

    <%@ include file="/WEB-INF/common/distributor-header.jsp"%>
    <main>
        <div class="wm-home-container">

            <!-- ========================================= -->
            <!-- HERO -->
            <!-- ========================================= -->
            <section class="wm-home-hero" aria-label="Distributor hero">
                <div class="wm-ledger-divider"></div>
                <div class="wm-home-hero-grid">

                    <div class="wm-home-hero-copy">
                        <span class="wm-kicker"><span class="wm-live-dot"></span> DISTRIBUTOR WORKSPACE</span>
                        <h1 class="wm-home-title">Welcome back, <strong><%=wmUserName%></strong></h1>
                        <p class="wm-home-subtitle">
                            Manage your inventory, retailers, deliveries, payments
                            and AI recommendations from one centralized workspace.
                        </p>
                        <div class="wm-home-actions">
                            <a class="home-btn home-btn-primary" href="/web/distributor/orders"><i class="bi bi-box-seam"></i> Orders</a>
                            <a class="home-btn home-btn-secondary" href="/web/distributor/products"><i class="bi bi-tags"></i> Products</a>
                            <a class="home-btn home-btn-secondary" href="/web/distributor/delivery"><i class="bi bi-truck"></i> Deliveries</a>
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
                    <p>Live operational tasks generated from orders, inventory, payments and deliveries.</p>
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
                                <span>WholeMart is analysing your orders, inventory and deliveries.</span>
                            </div>
                            <span class="home-pill">Loading</span>
                        </div>
                    </div>
                </div>
            </section>

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
                            <div class="home-role-mark is-success"><i class="bi bi-currency-rupee"></i></div>
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
                            <div class="home-role-mark is-danger"><i class="bi bi-exclamation-triangle"></i></div>
                        </div>
                        <p class="wm-kpi-foot" style="color:var(--wm-danger)">Immediate Action</p>
                    </article>

                </div>
            </section>

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
                            Welcome <strong><%= wmUserName %></strong> 👋
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
                            <button type="button" class="wm-ai-chip" data-ai-message="Show today's order summary"><i class="bi bi-box-seam"></i> Today's Orders</button>
                            <button type="button" class="wm-ai-chip" data-ai-message="Show low stock products"><i class="bi bi-graph-down-arrow"></i> Low Stock</button>
                            <button type="button" class="wm-ai-chip" data-ai-message="Show pending retailer payments"><i class="bi bi-cash-coin"></i> Pending Payments</button>
                            <button type="button" class="wm-ai-chip" data-ai-message="Business performance summary"><i class="bi bi-bar-chart"></i> Business Summary</button>
                            <button type="button" class="wm-ai-chip" data-ai-message="Suggest products to reorder"><i class="bi bi-arrow-repeat"></i> Restock Suggestions</button>
                            <button type="button" class="wm-ai-chip" data-ai-message="Today's priorities"><i class="bi bi-lightning-charge"></i> Today's Priorities</button>
                        </div>
                    </div>

                </div>

                <form id="wmDashboardAiForm" class="mt-4">
                    <div class="input-group">
                        <input id="wmDashboardAiMessage" type="text" class="form-control"
                               placeholder="Ask WholeMart AI anything...">
                        <button class="home-btn home-btn-secondary" type="button"><i class="bi bi-mic-fill"></i></button>
                        <button class="home-btn home-btn-primary" type="submit"><i class="bi bi-send"></i> Ask AI</button>
                    </div>
                </form>

                <div id="wmDashboardAiActionBox" class="mt-3"></div>
            </section>

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
                        <a href="/web/distributor/orders" class="home-btn home-btn-primary mt-4">Open Orders</a>
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
                                <strong id="stockPlanningCount" style="color:var(--wm-warning)">0</strong>
                            </div>
                        </div>
                        <a href="/web/distributor/products" class="home-btn home-btn-primary mt-4">Manage Products</a>
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
                        <a href="/web/distributor/dues" class="home-btn home-btn-primary mt-4">Open Ledger</a>
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
                        <a href="/web/distributor/delivery" class="home-btn home-btn-primary mt-4">Dispatch Center</a>
                    </article>

                </div>
            </section>

            <div class="wm-ledger-divider"></div>

            <!-- ===================================================== -->
            <!-- BUSINESS INTELLIGENCE -->
            <!-- ===================================================== -->
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
                            <div class="wm-report-item"><span>Total Products</span><strong id="reportTotalItems">0</strong></div>
                            <div class="wm-report-item"><span>Categories</span><strong id="reportCategoryCount">0</strong></div>
                            <div class="wm-report-item"><span>Availability</span><strong style="color:var(--wm-success)">92%</strong></div>
                            <div class="wm-report-item"><span>Out of Stock</span><strong style="color:var(--wm-danger)">0</strong></div>
                        </article>
                    </div>

                    <div class="col-lg-4">
                        <article class="home-role-card h-100">
                            <div class="wm-report-card-head">
                                <h3 class="mb-0">Order Performance</h3>
                                <div class="wm-ring is-success" style="--pct:98"><span>98%</span></div>
                            </div>
                            <div class="wm-report-item"><span>Total Orders</span><strong id="reportTotalOrders">0</strong></div>
                            <div class="wm-report-item"><span>Running Orders</span><strong id="reportActiveOrders">0</strong></div>
                            <div class="wm-report-item"><span>Success Rate</span><strong style="color:var(--wm-success)">98.4%</strong></div>
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
                            <div class="wm-report-item"><span>Revenue Trend</span><strong style="color:var(--wm-success)">+12%</strong></div>
                            <div class="wm-report-item"><span>Expansion</span><strong>2 Cities</strong></div>
                            <div class="wm-report-item"><span>Target Achievement</span><strong>78%</strong></div>
                        </article>
                    </div>

                </div>
            </section>

            <div class="wm-ledger-divider"></div>

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
                                    <div class="wm-timeline-icon is-success"><i class="bi bi-check-lg"></i></div>
                                    <div><strong>Order #ORD-10025 Accepted</strong><div class="text-muted">5 minutes ago</div></div>
                                </div>
                                <div class="wm-timeline-item">
                                    <div class="wm-timeline-icon is-info"><i class="bi bi-box-seam"></i></div>
                                    <div><strong>Inventory Updated</strong><div class="text-muted">12 products restocked</div></div>
                                </div>
                                <div class="wm-timeline-item">
                                    <div class="wm-timeline-icon is-warning"><i class="bi bi-cash-coin"></i></div>
                                    <div><strong>Payment Pending</strong><div class="text-muted">₹12,500 awaiting settlement</div></div>
                                </div>
                                <div class="wm-timeline-item">
                                    <div class="wm-timeline-icon is-info"><i class="bi bi-truck"></i></div>
                                    <div><strong>Driver Assigned</strong><div class="text-muted">Delivery route optimized</div></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="wm-card h-100">
                            <span class="wm-kicker">SHORTCUTS</span>
                            <h3 class="mb-4">Quick Actions</h3>
                            <div class="wm-quick-actions">
                                <a href="/web/distributor/add-product" class="home-btn home-btn-primary"><i class="bi bi-plus-circle"></i> Add Product</a>
                                <a href="/web/distributor/orders" class="home-btn home-btn-secondary"><i class="bi bi-box-seam"></i> Manage Orders</a>
                                <a href="/web/distributor/delivery" class="home-btn home-btn-secondary"><i class="bi bi-truck"></i> Delivery Center</a>
                                <a href="/web/distributor/dues" class="home-btn home-btn-secondary"><i class="bi bi-cash-coin"></i> View Payments</a>
                                <a href="/web/distributor/reports" class="home-btn home-btn-secondary"><i class="bi bi-bar-chart"></i> Analytics</a>
                            </div>
                        </div>
                    </div>

                </div>
            </section>

<%@ include file="/WEB-INF/common/footer.jsp" %>

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
    }

    initializeDashboard();

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
