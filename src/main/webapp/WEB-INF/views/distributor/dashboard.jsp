<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>WholeMart | <fmt:message key="distributor.dashboard_title"/></title>

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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero-carousel.css">

    </head>

    <body class="wm-home">

        <% String wmUserName=session.getAttribute("name")==null ? "Guest" :
            String.valueOf(session.getAttribute("name")); String wmUserInitial=wmUserName.substring(0,1).toUpperCase();
            %>
        <% java.util.List<String> suggestedQuestions = java.util.List.of(
                "Show today's order summary",
                "Show low stock products",
                "Show pending retailer payments"
            ); %>

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
                                                        <span class="wm-kicker"><span class="wm-live-dot"></span> <fmt:message key="nav.distributor_workspace"/></span>
                                                        <h1 class="wm-home-title">Welcome back, <strong>
                                                                <%=wmUserName%>
                                                            </strong></h1>
                                                        <p class="wm-home-subtitle"><fmt:message key="distributor.hero.subtitle"/></p>
                                                        <div class="wm-home-actions">
                                                            <a class="home-btn home-btn-primary"
                                                                href="/web/distributor/orders"><i
                                                                    class="bi bi-box-seam"></i> <fmt:message key="nav.orders"/></a>
                                                            <a class="home-btn home-btn-secondary"
                                                                href="/web/distributor/products"><i
                                                                    class="bi bi-tags"></i> <fmt:message key="nav.products"/></a>
                                                            <a class="home-btn home-btn-secondary"
                                                                href="/web/distributor/delivery"><i
                                                                    class="bi bi-truck"></i> <fmt:message key="nav.deliveries"/></a>
                                                        </div>
                                                    </div>

                                                    <div class="wm-pulse-card">
                                                        <div
                                                            class="d-flex justify-content-between align-items-start mb-2">
                                                            <div>
                                                                <span class="wm-pulse-eyebrow"><fmt:message key="distributor.hero.today_performance"/></span>
                                                                <h3><fmt:message key="snap.title"/></h3>
                                                            </div>
                                                            <div class="home-logo">AI</div>
                                                        </div>

                                                        <div id="performanceBrief"><fmt:message key="distributor.hero.loading_insights"/></div>

                                                        <hr>

                                                        <div class="wm-pulse-stats">
                                                            <div>
                                                                <h5 id="heroTotalOrders">0</h5>
                                                                <small><fmt:message key="nav.orders"/></small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroTotalItems">0</h5>
                                                                <small><fmt:message key="nav.products"/></small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroPendingSettlements">0</h5>
                                                                <small><fmt:message key="status.pending"/></small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Slide 2: Brand-new tile (auto-scroll/snap) -->
                                            <section class="wm-home-hero-slide" data-hero-slide="1">
                                                <div class="wm-home-hero-grid">
                                                    <div class="wm-home-hero-copy">
                                                        <span class="wm-kicker"><span class="wm-live-dot"></span> <fmt:message key="distributor.hero.smart_restock"/></span>
                                                        <h1 class="wm-home-title"><fmt:message key="distributor.hero.restock_title"/></h1>
                                                        <p class="wm-home-subtitle"><fmt:message key="distributor.hero.restock_subtitle"/></p>
                                                        <div class="wm-home-actions">
                                                            <a class="home-btn home-btn-primary"
                                                                href="/web/distributor/products"><i
                                                                    class="bi bi-graph-down-arrow"></i> <fmt:message key="distributor.hero.restock_btn"/></a>
                                                            <a class="home-btn home-btn-secondary"
                                                                href="/web/distributor/reports"><i
                                                                    class="bi bi-bar-chart"></i> <fmt:message key="distributor.hero.analytics_btn"/></a>
                                                        </div>
                                                    </div>

                                                    <div class="wm-pulse-card">
                                                        <div
                                                            class="d-flex justify-content-between align-items-start mb-2">
                                                            <div>
                                                                <span class="wm-pulse-eyebrow"><fmt:message key="distributor.hero.ai_reco"/></span>
                                                                <h3><fmt:message key="ops.low_stock_alerts"/></h3>
                                                            </div>
                                                            <div class="home-logo">AI</div>
                                                        </div>

                                                        <div id="restockBrief"><fmt:message key="distributor.hero.loading_suggestions"/></div>

                                                        <hr>

                                                        <div class="wm-pulse-stats">
                                                            <div>
                                                                <h5 id="heroLowStockCount">0</h5>
                                                                <small><fmt:message key="nav.products"/></small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroRestockCities">0</h5>
                                                                <small><fmt:message key="distributor.hero.areas"/></small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroRestockRisk">0</h5>
                                                                <small><fmt:message key="distributor.hero.risk"/></small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </section>

                                            <!-- Slide 3: Brand-new tile (auto-scroll/snap) -->
                                            <section class="wm-home-hero-slide" data-hero-slide="2">
                                                <div class="wm-home-hero-grid">
                                                    <div class="wm-home-hero-copy">
                                                        <span class="wm-kicker"><span class="wm-live-dot"></span> <fmt:message key="distributor.hero.payments_title"/></span>
                                                        <h1 class="wm-home-title"><fmt:message key="distributor.hero.payments_subtitle"/></h1>
                                                        <p class="wm-home-subtitle"><fmt:message key="distributor.hero.payments_desc"/></p>
                                                        <div class="wm-home-actions">
                                                            <a class="home-btn home-btn-primary"
                                                                href="/web/distributor/dues"><i
                                                                    class="bi bi-cash-coin"></i> <fmt:message key="distributor.hero.open_ledger"/></a>
                                                            <a class="home-btn home-btn-secondary"
                                                                href="/web/distributor/orders"><i
                                                                    class="bi bi-box-seam"></i> <fmt:message key="nav.orders"/></a>
                                                        </div>
                                                    </div>

                                                    
                                                    <div class="wm-pulse-card">
                                                        <div
                                                            class="d-flex justify-content-between align-items-start mb-2">
                                                            <div>
                                                                <span class="wm-pulse-eyebrow"><fmt:message key="distributor.hero.settlement_health"/></span>
                                                                <h3><fmt:message key="distributor.hero.pending_collection"/></h3>
                                                            </div>
                                                            <div class="home-logo">AI</div>
                                                        </div>

                                                        <div id="settlementBrief"><fmt:message key="distributor.hero.loading_payment_health"/></div>

                                                        <hr>

                                                        <div class="wm-pulse-stats">
                                                            <div>
                                                                <h5 id="heroPendingDuesCount">0</h5>
                                                                <small><fmt:message key="nav.retailers"/></small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroPendingDuesAmount">₹ 0.00</h5>
                                                                <small><fmt:message key="distributor.hero.amount"/></small>
                                                            </div>
                                                            <div>
                                                                <h5 id="heroSettlementETA">0</h5>
                                                                <small><fmt:message key="distributor.hero.days"/></small>
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

                            <!-- ===================================================== -->
                            <!-- LIVE OPERATIONS DASHBOARD HUB -->
                            <!-- ===================================================== -->
                            <section id="operations" class="container my-5">
        <div class="wm-operations-hub">
            <div class="wm-operations-hero-wrap">
                <img src="${pageContext.request.contextPath}/images/logo/wholemart-home-hero.png"
                     class="wm-operations-hero-img"
                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/logo/wholemart-home-hero.png';"
                     alt="WholeMart Live Operations Hub showing inventory, orders and delivery van dispatch">
                <div class="wm-operations-overlay">
                    <div>
                        <span class="wm-operations-live-badge mb-2">
                            <span class="wm-live-pulse-dot"></span> <fmt:message key="ops.hub_title"/>
                        </span>
                        <h2 class="wm-operations-title"><fmt:message key="ops.sync_title"/></h2>
                        <p class="wm-operations-subtitle">
                            <fmt:message key="ops.subtitle"/>
                        </p>
                    </div>
                    <div class="d-flex flex-wrap gap-2 mt-3">
                        <span class="badge bg-dark bg-opacity-75 text-light border border-secondary px-3 py-2"><i class="bi bi-check-circle-fill text-success me-1"></i> <fmt:message key="ops.live_inventory"/></span>
                        <span class="badge bg-dark bg-opacity-75 text-light border border-secondary px-3 py-2"><i class="bi bi-arrow-repeat text-info me-1"></i> <fmt:message key="ops.active_orders"/></span>
                        <span class="badge bg-dark bg-opacity-75 text-light border border-secondary px-3 py-2"><i class="bi bi-geo-alt-fill text-warning me-1"></i> <fmt:message key="ops.delivery_status"/></span>
                    </div>
                </div>
            </div>
            
            <div class="wm-operations-telemetry-grid">
                <div class="wm-telemetry-card">
                    <div class="wm-telemetry-icon inventory">
                        <i class="bi bi-boxes"></i>
                    </div>
                    <div class="wm-telemetry-content">
                        <h5><fmt:message key="ops.sku_count"/></h5>
                        <small><fmt:message key="ops.live_inventory"/> • <fmt:message key="ops.in_stock"/></small>
                    </div>
                </div>
                <div class="wm-telemetry-card">
                    <div class="wm-telemetry-icon orders">
                        <i class="bi bi-bag-check"></i>
                    </div>
                    <div class="wm-telemetry-content">
                        <h5><fmt:message key="ops.orders_count"/></h5>
                        <small><fmt:message key="ops.active_orders"/></small>
                    </div>
                </div>
                <div class="wm-telemetry-card">
                    <div class="wm-telemetry-icon delivery">
                        <i class="bi bi-truck"></i>
                    </div>
                    <div class="wm-telemetry-content">
                        <h5><fmt:message key="ops.vans_count"/></h5>
                        <small><fmt:message key="ops.delivery_status"/> • <fmt:message key="ops.avg_time"/></small>
                    </div>
                </div>
            </div>
        </div>
    </section>

                            <!-- ===================================================== -->
                            <!-- BUSINESS INTELLIGENCE + AI ASSISTANT
                 Merged into a single section: report tiles (2x2) on the
                 left, AI assistant on the right. -->
                            <!-- ===================================================== -->
                            <section class="wm-bi-ai-combo mb-4">
                                <div class="home-section-head">
                                    <span class="wm-kicker">ANALYTICS</span>
                                    <h2><fmt:message key="distributor.bi.title"/></h2>
                                    <p><fmt:message key="distributor.bi.subtitle"/></p>
                                </div>

                                <div class="row g-4 align-items-stretch">

                                    <!-- Left: report tiles, 2 per row, 2 rows -->
                                    <div class="col-lg-8">
                                        <div class="row g-4 h-100">

                                            <div class="col-md-6">
                                                <article class="home-role-card wm-report-tile h-100">
                                                    <div class="wm-report-card-head">
                                                        <h3 class="mb-0"><fmt:message key="distributor.bi.inventory_health"/></h3>
                                        <div class="wm-ring is-success" style="--pct:92"><span id="reportInventoryHealthPct">92%</span>
                                                        </div>
                                                    </div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.total_products"/></span><strong
                                                            id="reportTotalItems">0</strong></div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.categories"/></span><strong
                                                            id="reportCategoryCount">0</strong></div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.availability"/></span><strong
                                                            style="color:var(--wm-success)">92%</strong></div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.out_of_stock"/></span><strong
                                                            style="color:var(--wm-danger)">0</strong></div>
                                                </article>
                                            </div>

                                            <div class="col-md-6">
                                                <article class="home-role-card wm-report-tile h-100">
                                                    <div class="wm-report-card-head">
                                                        <h3 class="mb-0"><fmt:message key="distributor.bi.order_performance"/></h3>
                                                        <div class="wm-ring is-success" style="--pct:98"><span>98%</span>
                                                        </div>
                                                    </div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.total_orders"/></span><strong
                                                            id="reportTotalOrders">0</strong></div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.running_orders"/></span><strong
                                                            id="reportActiveOrders">0</strong></div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.success_rate"/></span><strong
                                                            style="color:var(--wm-success)">98.4%</strong></div>
                                                    <div class="wm-report-item"><span><fmt:message key="status.rejected"/></span><strong>0</strong>
                                                    </div>
                                                </article>
                                            </div>

                                            <div class="col-md-6">
                                                <article class="home-role-card wm-report-tile h-100">
                                                    <div class="wm-report-card-head">
                                                        <h3 class="mb-0"><fmt:message key="distributor.bi.business_growth"/></h3>
                                                        <div class="wm-ring" style="--pct:78"><span>78%</span></div>
                                                    </div>
                                                    <div class="wm-report-item"><span><fmt:message key="nav.retailers"/></span><strong>84</strong>
                                                    </div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.revenue_trend"/></span><strong
                                                            style="color:var(--wm-success)">+12%</strong></div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.expansion"/></span><strong>2
                                                            <fmt:message key="distributor.bi.cities"/></strong>
                                                    </div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.target_achievement"/></span><strong>78%</strong></div>
                                                </article>
                                            </div>

                                            <div class="col-md-6">
                                                <article class="home-role-card wm-report-tile h-100">
                                                    <div class="wm-report-card-head">
                                                        <h3 class="mb-0"><fmt:message key="distributor.bi.payment_health"/></h3>
                                                        <div class="wm-ring is-success" style="--pct:88"><span>88%</span>
                                                        </div>
                                                    </div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.pending_settlements"/></span><strong
                                                            id="reportPendingSettlements">0</strong></div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.overdue_amount"/></span><strong
                                                            style="color:var(--wm-danger)">₹0</strong></div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.disputes"/></span><strong>0</strong>
                                                    </div>
                                                    <div class="wm-report-item"><span><fmt:message key="distributor.bi.collection_rate"/></span><strong
                                                            style="color:var(--wm-success)">88%</strong></div>
                                                </article>
                                            </div>

                                        </div>
                                    </div>

                                    <!-- Right: AI Assistant -->
                                    <div class="col-lg-4">
                                        <div class="wm-card wm-ai-panel wm-ai-panel--compact h-100">
                                            <div class="wm-ai-glow"></div>
                                            <div class="wm-ai-header">
                                                <div class="wm-ai-avatar"><i class="bi bi-stars"></i></div>
                                                <div>
                                                    <span class="wm-ai-badge"><span class="wm-live-dot"></span> <fmt:message key="nav.ai_chat"/></span>
                                                    <h2 class="mb-0"><fmt:message key="ai.ask_title"/></h2>
                                                </div>
                                            </div>


                                            <div id="wmDashboardAiResponse" class="wm-ai-response">
                                                <fmt:message key="ai.welcome_message"><fmt:param value="<%= wmUserName %>"/></fmt:message>
                                            </div>

                                            <div id="wmDashboardAiQuickButtons" class="wm-ai-chips mt-3">
                                                <% for (String q : suggestedQuestions) { %>
                                                    <button class="wm-ai-chip" type="button" data-ai-message="<%= q.replace("\"", "\\\"") %>"><%= q %></button>
                                                <% } %>
                                            </div>

                                            <form id="wmDashboardAiForm" class="mt-3">
                                                <div class="input-group">
                                                    <input id="wmDashboardAiMessage" type="text" class="form-control"
                                                        placeholder="<fmt:message key="ai.ask_placeholder"/>">
                                                    <button class="wm-ai-mic-btn" type="button"><i
                                                            class="bi bi-mic-fill"></i></button>
                                                    <button class="wm-ai-send-btn" type="submit"><i
                                                            class="bi bi-send"></i></button>
                                                </div>
                                            </form>

                                            <div id="wmDashboardAiActionBox" class="mt-3"></div>
                                        </div>
                                    </div>

                                </div>
                            </section>

                            <hr>
                            <section id="snapshot" class="mb-4">
                                <div class="home-section-head">
                                    <span class="wm-kicker">ANALYTICS</span>
                                    <h2><fmt:message key="snap.title"/></h2>
                                    <p><fmt:message key="distributor.snapshot.subtitle"/></p>
                                </div>

                                <div class="card shadow-sm border-0 rounded-4">
                                    <div class="card-header bg-white border-0 pt-4"><h4 class="fw-bold text-center"><fmt:message key="snap.title"/></h4></div>
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
                                    <h2><fmt:message key="distributor.priority.title"/></h2>
                                    <p><fmt:message key="distributor.priority.subtitle"/></p>
                                </div>

                                <div class="wm-card">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <div>
                                            <h4 class="mb-1"><fmt:message key="distributor.priority.action_queue"/></h4>
                                            <small class="text-muted"><fmt:message key="distributor.priority.action_queue_subtitle"/></small>
                                        </div>
                                        <span class="home-pill">LIVE</span>
                                    </div>

                                    <div id="wmAttentionList">
                                        <div class="wm-home-ops-row"><div class="wm-ops-icon"><i class="bi bi-hourglass-split"></i></div><div class="wm-ops-body"><strong><fmt:message key="distributor.priority.loading_title"/></strong><span><fmt:message key="distributor.priority.loading_subtitle"/></span></div><span class="home-pill"><fmt:message key="distributor.priority.loading"/></span></div>
                                    </div>
                                </div>
                            </section>

                            <hr>
                            <!-- ========================================= -->
                            <!-- DASHBOARD KPI -->
                            <!-- ========================================= -->
                            <section class="wm-home-impact">
                                <div class="home-section-head">
                                    <h2><fmt:message key="distributor.overview.title"/></h2>
                                    <p><fmt:message key="distributor.overview.subtitle"/></p>
                                </div>

                                <!-- Headline metrics -->
                                <div class="wm-kpi-headline">

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label"><fmt:message key="ops.revenue"/></span>
                                                <strong id="capturedRevenue" class="wm-kpi-value">Rs. 0.00</strong>
                                            </div>
                                            <div class="home-role-mark is-success"><i class="bi bi-currency-rupee"></i>
                                            </div>
                                        </div>
                                        <p class="wm-kpi-foot"><span class="wm-trend-up">+12%</span> <fmt:message key="distributor.overview.vs_last_month"/></p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label"><fmt:message key="ops.active_orders"/></span>
                                                <strong id="bizActiveOrders" class="wm-kpi-value">0</strong>
                                            </div>
                                            <div class="home-role-mark"><i class="bi bi-box-seam"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot"><fmt:message key="distributor.overview.total_orders"/> <strong id="bizTotalOrders">0</strong></p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label"><fmt:message key="distributor.overview.inventory_products"/></span>
                                                <strong id="bizTotalItems" class="wm-kpi-value">0</strong>
                                            </div>
                                            <div class="home-role-mark"><i class="bi bi-tag"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot"><fmt:message key="distributor.overview.active_products"/></p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label"><fmt:message key="distributor.overview.inventory_value"/></span>
                                                <strong id="bizInventoryTotalAmount" class="wm-kpi-value">₹ 0.00</strong>
                                            </div>
                                            <div class="home-role-mark is-success"><i class="bi bi-currency-rupee"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot"><fmt:message key="distributor.overview.total_stock_amount"/></p>
                                    </article>


                                </div>

                                <!-- Secondary metrics — labeled and visually lighter so the
                     four headline numbers above stay the primary read. -->
                                <div class="wm-subsection-label"><fmt:message key="distributor.overview.at_a_glance"/></div>
                                <div class="wm-kpi-secondary">

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label">Fleet</span>
                                                <strong class="wm-kpi-value" id="bizActiveDrivers">0</strong>
                                            </div>
                                            <div class="home-role-mark"><i class="bi bi-truck"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot"><fmt:message key="distributor.overview.active_drivers"/></p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label"><fmt:message key="nav.retailers"/></span>
                                                <strong class="wm-kpi-value" id="bizRetailersCount">0</strong>
                                            </div>
                                            <div class="home-role-mark"><i class="bi bi-shop"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot"><span class="wm-trend-up" id="bizRetailersTrend">0</span> <fmt:message key="distributor.overview.this_week"/></p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label"><fmt:message key="distributor.overview.catalog_health"/></span>
                                                <strong class="wm-kpi-value" id="bizCatalogHealthPct">0%</strong>
                                            </div>
                                            <div class="wm-ring is-success" style="--pct:0"><span id="bizCatalogHealthPctRing">0%</span></div>
                                        </div>
                                        <p class="wm-kpi-foot"><fmt:message key="distributor.overview.products_ready"/></p>
                                    </article>

                                    <article class="wm-kpi-card">
                                        <div class="wm-kpi-top">
                                            <div>
                                                <span class="wm-kpi-label"><fmt:message key="nav.alerts"/></span>
                                                <strong class="wm-kpi-value" id="bizAlertsCount" style="color:var(--wm-danger)">0</strong>
                                            </div>
                                            <div class="home-role-mark is-danger"><i
                                                    class="bi bi-exclamation-triangle"></i></div>
                                        </div>
                                        <p class="wm-kpi-foot" style="color:var(--wm-danger)"><fmt:message key="distributor.overview.immediate_action"/></p>
                                    </article>

                                </div>
                            </section>
                            <hr>

                            <!-- ===================================================== -->
                            <!-- FULFILLMENT & OPERATIONS -->
                            <!-- ===================================================== -->
                            <section class="wm-home-roles mb-4">
                                <div class="home-section-head">
                                    <span class="wm-kicker">OPERATIONS</span>
                                    <h2><fmt:message key="distributor.fulfillment.title"/></h2>
                                    <p><fmt:message key="distributor.fulfillment.subtitle"/></p>
                                </div>

                                <div class="wm-home-role-grid">

                                    <article class="home-role-card">
                                        <div class="home-role-mark"><i class="bi bi-box-seam"></i></div>
                                        <h3><fmt:message key="distributor.fulfillment.order_pipeline"/></h3>
                                        <p><fmt:message key="distributor.fulfillment.order_pipeline_subtitle"/></p>
                                        <div class="mt-4">
                                            <div class="wm-role-metric-row">
                                                <span><fmt:message key="distributor.fulfillment.waiting_review"/></span>
                                                <strong id="ordersWaiting" style="color:var(--wm-danger)">0</strong>
                                            </div>
                                            <div class="wm-role-metric-row">
                                                <span><fmt:message key="distributor.fulfillment.ready_to_pack"/></span>
                                                <strong id="ordersReady">0</strong>
                                            </div>
                                        </div>
                                        <a href="/web/distributor/orders" class="home-btn home-btn-primary mt-4"><fmt:message key="distributor.fulfillment.open_orders"/></a>
                                    </article>

                                    <article class="home-role-card">
                                        <div class="home-role-mark"><i class="bi bi-bar-chart-line"></i></div>
                                        <h3><fmt:message key="distributor.fulfillment.inventory"/></h3>
                                        <p><fmt:message key="distributor.fulfillment.inventory_subtitle"/></p>
                                        <div class="mt-4">
                                            <div class="wm-role-metric-row">
                                                <span><fmt:message key="distributor.bi.categories"/></span>
                                                <strong id="categoryCount">0</strong>
                                            </div>
                                            <div class="wm-role-metric-row">
                                                <span><fmt:message key="distributor.fulfillment.refill_needed"/></span>
                                                <strong id="stockPlanningCount"
                                                    style="color:var(--wm-warning)">0</strong>
                                            </div>
                                        </div>
                                        <a href="/web/distributor/products"
                                            class="home-btn home-btn-primary mt-4"><fmt:message key="distributor.fulfillment.manage_products"/></a>
                                    </article>

                                    <article class="home-role-card">
                                        <div class="home-role-mark"><i class="bi bi-cash-coin"></i></div>
                                        <h3><fmt:message key="feat.credit_title"/></h3>
                                        <p><fmt:message key="distributor.fulfillment.ledger_subtitle"/></p>
                                        <div class="mt-4">
                                            <div class="wm-role-metric-row">
                                                <span><fmt:message key="distributor.bi.overdue_amount"/></span>
                                                <strong style="color:var(--wm-danger)">₹0</strong>
                                            </div>
                                            <div class="wm-role-metric-row">
                                                <span><fmt:message key="distributor.bi.disputes"/></span>
                                                <strong>0</strong>
                                            </div>
                                        </div>
                                        <a href="/web/distributor/dues" class="home-btn home-btn-primary mt-4"><fmt:message key="distributor.hero.open_ledger"/></a>
                                    </article>

                                    <article class="home-role-card">
                                        <div class="home-role-mark"><i class="bi bi-truck"></i></div>
                                        <h3><fmt:message key="distributor.fulfillment.dispatch_hub"/></h3>
                                        <p><fmt:message key="distributor.fulfillment.dispatch_hub_subtitle"/></p>
                                        <div class="mt-4">
                                            <div class="wm-role-metric-row">
                                                <span><fmt:message key="status.completed"/></span>
                                                <strong id="completedDropoffs">0</strong>
                                            </div>
                                            <div class="wm-role-metric-row">
                                                <span><fmt:message key="distributor.fulfillment.active_trips"/></span>
                                                <strong>0</strong>
                                            </div>
                                        </div>
                                        <a href="/web/distributor/delivery"
                                            class="home-btn home-btn-primary mt-4"><fmt:message key="distributor.fulfillment.dispatch_center"/></a>
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
                                                    <span class="wm-kicker"><fmt:message key="distributor.productivity.live_feed"/></span>
                                                    <h3 class="mb-0"><fmt:message key="distributor.productivity.recent_activities"/></h3>
                                                </div>
                                                <span class="home-pill"><fmt:message key="distributor.productivity.today"/></span>
                                            </div>

                                            <div class="wm-timeline">
                                                <div class="wm-timeline-item">
                                                    <div class="wm-timeline-icon is-success"><i
                                                            class="bi bi-check-lg"></i></div>
                                                    <div><strong><fmt:message key="distributor.productivity.activity1_title"/></strong>
                                                        <div class="text-muted"><fmt:message key="distributor.productivity.activity1_time"/></div>
                                                    </div>
                                                </div>
                                                <div class="wm-timeline-item">
                                                    <div class="wm-timeline-icon is-info"><i class="bi bi-box-seam"></i>
                                                    </div>
                                                    <div><strong><fmt:message key="distributor.productivity.activity2_title"/></strong>
                                                        <div class="text-muted"><fmt:message key="distributor.productivity.activity2_desc"/></div>
                                                    </div>
                                                </div>
                                                <div class="wm-timeline-item">
                                                    <div class="wm-timeline-icon is-warning"><i
                                                            class="bi bi-cash-coin"></i></div>
                                                    <div><strong><fmt:message key="distributor.productivity.activity3_title"/></strong>
                                                        <div class="text-muted"><fmt:message key="distributor.productivity.activity3_desc"/></div>
                                                    </div>
                                                </div>
                                                <div class="wm-timeline-item">
                                                    <div class="wm-timeline-icon is-info"><i class="bi bi-truck"></i>
                                                    </div>
                                                    <div><strong><fmt:message key="distributor.productivity.activity4_title"/></strong>
                                                        <div class="text-muted"><fmt:message key="distributor.productivity.activity4_desc"/></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-4">
                                        <div class="wm-card h-100">
                                            <span class="wm-kicker"><fmt:message key="distributor.productivity.shortcuts"/></span>
                                            <h3 class="mb-4"><fmt:message key="distributor.productivity.quick_actions"/></h3>
                                            <div class="wm-quick-actions">
                                                <a href="/web/distributor/add-product"
                                                    class="home-btn home-btn-primary"><i class="bi bi-plus-circle"></i>
                                                    <fmt:message key="nav.add_product"/></a>
                                                <a href="/web/distributor/orders" class="home-btn home-btn-secondary"><i
                                                        class="bi bi-box-seam"></i> Manage Orders</a>
                                                <a href="/web/distributor/delivery"
                                                    class="home-btn home-btn-secondary"><i class="bi bi-truck"></i>
                                                    Delivery Center</a>
                                                <a href="/web/distributor/dues" class="home-btn home-btn-secondary"><i
                                                        class="bi bi-cash-coin"></i> View Payments</a>
                                                <a href="/web/distributor/reports"
                                                    class="home-btn home-btn-secondary"><i class="bi bi-bar-chart"></i>
                                                    <fmt:message key="distributor.hero.analytics_btn"/></a>
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
                                        const quickButtonsContainer = document.getElementById("wmDashboardAiQuickButtons");
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

                                        let currentConversationId = null;

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
                                            renderSecondaryKpis();
                                        }


                                        /* =====================================================
                                           PAYMENTS
                                        ====================================================== */
                                        async function loadPayments() {
                                            const payments = await loadApi("/api/v1/payments");
                                            dashboardState.payments = payments;

                                            const pendingCount = payments.filter(p => p.status === "PENDING").length;
                                            setTextAll(["pendingSettlements", "heroPendingSettlements", "bizPendingSettlements", "reportPendingSettlements"], pendingCount);

                                            renderRecommendedActions();
                                            renderSecondaryKpis();
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
                                           SECONDARY KPIs (At a Glance)
                                        ====================================================== */
                                        function renderSecondaryKpis() {
                                            // Fleet / Alerts / Catalog Health / Retailer trend are currently computed from
                                            // already-loaded page state (orders/products/payments/deliveries) to keep
                                            // everything dynamic without extra APIs.

                                            // Fleet = active trips approximated from deliveries not yet delivered.
                                            if (dashboardState.deliveries) {
                                                const activeTrips = (dashboardState.deliveries || []).filter(d => d.status !== "DELIVERED").length;
                                                setText("bizActiveDrivers", activeTrips);
                                            }

                                            // Alerts = number of items in attention queue.
                                            // (Reuse recommended-action logic without rebuilding DOM.)
                                            // We approximate with: placed orders waiting + pending payments + active deliveries.
                                            const waitingOrders = (dashboardState.orders || []).filter(o => o.status === "PLACED").length;
                                            const pendingPayments = (dashboardState.payments || []).filter(p => p.status === "PENDING").length;
                                            const activeDeliveries = (dashboardState.deliveries || []).filter(d => d.status !== "DELIVERED").length;
                                            const alertCount = waitingOrders + pendingPayments + activeDeliveries;
                                            setText("bizAlertsCount", alertCount);

                                            // Retailers count and trend aren't available in this page's current state.
                                            // We keep this dynamic by deriving retailers from order data when present.
                                            const retailerUserIds = new Set((dashboardState.orders || []).map(o => o.retailerUserId).filter(Boolean));
                                            setText("bizRetailersCount", retailerUserIds.size);

                                            // Catalog Health = percentage of products which appear in inventory with stockQuantity > 0.
                                            // We approximate using the products payload's stockQuantity field.
                                            const products = dashboardState.products || [];
                                            const totalCatalog = products.length;
                                            const readyCount = products.filter(p => Number(p.stockQuantity || 0) > 0).length;
                                            const pct = totalCatalog === 0 ? 0 : Math.round((readyCount / totalCatalog) * 100);
                                            setText("bizCatalogHealthPct", pct + "%" );

                                            const ring = document.getElementById("bizCatalogHealthPctRing");
                                            if (ring) {
                                                ring.textContent = pct + "%";
                                            }
                                            const ringParent = document.getElementById("bizCatalogHealthPctRing");
                                            // style is on .wm-ring sibling; update by querying relative id isn't possible,
                                            // so fallback to nothing if not found.
                                        }

                                        /* =====================================================
                                           INVENTORY TOTAL AMOUNT
                                        ====================================================== */
                                        async function loadInventoryTotalAmount() {
                                            try {
                                                const res = await fetch("/api/v1/products/mine/inventory-total-amount");
                                                if (!res.ok) {
                                                    throw new Error("/api/v1/products/mine/inventory-total-amount");
                                                }
                                                const data = await res.json();
                                                const total = data && data.totalAmount ? data.totalAmount : 0;
                                                setText("bizInventoryTotalAmount", money(total));
                                            } catch (e) {
                                                console.error("Unable to load inventory total amount", e);
                                                setText("bizInventoryTotalAmount", money(0));
                                            }
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

                                            // Ensure we have a conversation to post to.
                                            if (!currentConversationId) {
                                                try {
                                                    const createRes = await fetch("/api/v1/ai/conversations", {
                                                        method: 'POST',
                                                        headers: { 'Content-Type': 'application/json' },
                                                        body: JSON.stringify({ title: 'Dashboard Chat' })
                                                    });
                                                    if (!createRes.ok) throw new Error("Failed to create conversation");
                                                    const createData = await createRes.json();
                                                    if (!createData.conversation || !createData.conversation.id) {
                                                        throw new Error("Invalid response from conversation creation");
                                                    }
                                                    currentConversationId = createData.conversation.id;
                                                } catch (e) {
                                                    console.error("AI conversation creation error:", e);
                                                    responseBox.textContent = "Could not start a new conversation. Please try again.";
                                                    return;
                                                }
                                            }

                                            try {
                                                const res = await fetch("/api/v1/ai/agent/chat", {
                                                    method: "POST",
                                                    headers: { "Content-Type": "application/json" },
                                                    body: JSON.stringify({
                                                        conversationId: currentConversationId,
                                                        message: message
                                                    })
                                                });

                                                if (!res.ok) {
                                                    throw new Error("AI request failed with status " + res.status);
                                                }

                                                const data = await res.json();

                                                // Find the assistant's message from the response, similar to ai-chat.jsp
                                                const messages = (data && data.messages) ? data.messages : null;
                                                const sortedMessages = (messages && messages.length)
                                                    ? messages.slice().sort((a, b) => new Date(a.createdAt || 0) - new Date(b.createdAt || 0))
                                                    : null;
                                                const assistantMessage = (sortedMessages && sortedMessages.length)
                                                    ? sortedMessages.filter(m => (m.role || '').toLowerCase() === 'assistant').pop()
                                                    : null;

                                                const answer = (assistantMessage && assistantMessage.message) 
                                                    ? assistantMessage.message 
                                                    : (data.answer || "Sorry, I could not find an answer.");

                                                responseBox.textContent = answer;

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
                                                '<div class="alert alert-warning mt-3">' + '<b>' + type + '</b>' + '<div class="mt-3">' + '<button class="btn btn-success btn-sm" onclick="confirmAiAction(' + id + ',true)">Confirm</button>' + '<button class="btn btn-secondary btn-sm ms-2" onclick="confirmAiAction(' + id + ',false)">Cancel</button>' + '</div>' + '</div>';
                                        }

                                        // Exposed globally since it's invoked from inline onclick handlers above.
                                        window.confirmAiAction = async function (id, confirmed) {
                                            try {
                                                const res = await fetch("/api/v1/ai/actions/confirm", {
                                                    method: "POST",
                                                    headers: { "Content-Type": "application/json" },
                                                    body: JSON.stringify({ actionId: id, confirmed: confirmed })
                                                });

                                                const data = await res.json();

                                                if (responseBox) {
                                                    responseBox.textContent = data.reply || (confirmed ? "Action confirmed." : "Action cancelled.");
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
                                                loadDeliveries(),
                                                loadInventoryTotalAmount()
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
                                                    return '<button type="button" class="wm-hero-dot" data-hero-goto="' + i + '" aria-label="Go to slide ' + (i + 1) + '">' + '<span></span></button>';
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

                                        quickButtonsContainer.addEventListener("click", function (e) {
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
