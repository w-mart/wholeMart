<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Local B2B Marketplace</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:ital,wght@0,700;0,800;1,700&display=swap" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet">
</head>
<body class="wm-home">
<div class="wm-app">
    <%
        // Initialize variables previously handled by the shell
        String wmUri = request.getRequestURI();
        String wmUserName = session.getAttribute("username") == null ? "Guest" : String.valueOf(session.getAttribute("username"));
        String wmUserInitial = wmUserName.isEmpty() ? "?" : wmUserName.substring(0, 1).toUpperCase();
    %>

    <%@ include file="../common/distributor-header.jsp" %>

    <main class="wm-home-main" style="padding-top: 24px; padding-bottom: 24px;">
        <div class="wm-home-container" style="max-width: 1240px; overflow-x: hidden;">

            <!-- 2-Column Hero Section -->
            <section class="wm-home-hero" style="margin-bottom: 24px; padding: 0;">
                <div class="wm-home-hero-grid" style="grid-template-columns: 1.2fr 1fr; gap: 24px; align-items: stretch;">
                    <div class="wm-home-hero-copy">
                        <span class="home-kicker">Operational Center</span>
                        <h1 class="wm-home-title" style="font-size: 32px; margin-bottom: 12px;">Welcome back, <strong><%= wmUserName %></strong>.</h1>
                        <p class="wm-home-subtitle" style="margin-bottom: 20px; max-width: 100%;">
                            Your central operating system for wholesale commerce. Monitor live orders, manage inventory velocity, and coordinate delivery routes from one unified workspace.
                        </p>
                        <div class="wm-home-actions">
                            <a class="home-btn home-btn-primary" href="/web/distributor/orders"><i data-lucide="package" class="lucide"></i> Fulfillment Queue</a>
                            <a class="home-btn home-btn-secondary" href="/web/distributor/products"><i data-lucide="database" class="lucide"></i> Stock Control</a>
                        </div>
                    </div>
                    <div class="home-impact-card home-impact-card-wide shadow-sm" style="margin: 0; min-height: 160px; align-self: stretch; display: flex; flex-direction: column; justify-content: center; padding: 24px; border: 1px solid var(--wm-border);">
                        <span class="mb-2">Live Performance Summary</span>
                        <div id="performanceBrief" style="font-size: 15px; line-height: 1.6; color: var(--wm-brand-dark); font-weight: 500;">
                            Analyzing live distribution metrics...
                        </div>
                    </div>
                </div>
            </section>

            <!-- KPI Metrics (4-Column Grid) -->
            <section class="wm-home-impact" style="padding: 0; background: transparent; border: 0; box-shadow: none; margin-bottom: 32px;">
                <div class="wm-home-impact-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 16px;">
                    <article class="home-impact-card h-100" style="padding: 16px;">
                        <div class="d-flex justify-content-between align-items-center mb-2"><span>Revenue</span><i data-lucide="indian-rupee" class="lucide text-success"></i></div>
                        <strong id="capturedRevenue" style="font-size: 24px; font-weight: 850;">Rs. 0</strong>
                        <p class="small text-success fw-bold mb-0">+12% <span class="text-muted fw-normal">vs last month</span></p>
                    </article>
                    <article class="home-impact-card h-100" style="padding: 16px;">
                        <div class="d-flex justify-content-between align-items-center mb-2"><span>Active Orders</span><i data-lucide="package" class="lucide text-primary"></i></div>
                        <strong id="reportTotalOrders" style="font-size: 24px; font-weight: 850;">0</strong>
                        <p class="small text-muted mb-0">Across all retailer outlets</p>
                    </article>
                    <article class="home-impact-card h-100" style="padding: 16px;">
                        <div class="d-flex justify-content-between align-items-center mb-2"><span>Inventory</span><i data-lucide="database" class="lucide text-warning"></i></div>
                        <strong id="totalItems" style="font-size: 24px; font-weight: 850;">0</strong>
                        <p class="small text-muted mb-0">Unique SKUs in catalog</p>
                    </article>
                    <article class="home-impact-card h-100" style="padding: 16px;">
                        <div class="d-flex justify-content-between align-items-center mb-2"><span>Settlements</span><i data-lucide="landmark" class="lucide text-info"></i></div>
                        <strong id="pendingSettlements" style="font-size: 24px; font-weight: 850;">0</strong>
                        <p class="small text-danger fw-bold mb-0">Action required</p>
                    </article>
                    <article class="home-impact-card h-100" style="padding: 16px;">
                        <div class="d-flex justify-content-between align-items-center mb-2"><span>Fleet</span><i data-lucide="truck" class="lucide text-secondary"></i></div>
                        <strong style="font-size: 24px; font-weight: 850;">12</strong>
                        <p class="small text-muted mb-0">Active drivers on route</p>
                    </article>
                    <article class="home-impact-card h-100" style="padding: 16px;">
                        <div class="d-flex justify-content-between align-items-center mb-2"><span>Retailers</span><i data-lucide="store" class="lucide text-success"></i></div>
                        <strong style="font-size: 24px; font-weight: 850;">84</strong>
                        <p class="small text-success fw-bold mb-0">+4 <span class="text-muted fw-normal">new this week</span></p>
                    </article>
                    <article class="home-impact-card h-100" style="padding: 16px;">
                        <div class="d-flex justify-content-between align-items-center mb-2"><span>Catalog Health</span><i data-lucide="check-circle" class="lucide text-primary"></i></div>
                        <strong style="font-size: 24px; font-weight: 850;">94%</strong>
                        <p class="small text-muted mb-0">Priced and ready to sell</p>
                    </article>
                    <article class="home-impact-card h-100" style="padding: 16px;">
                        <div class="d-flex justify-content-between align-items-center mb-2"><span>Alerts</span><i data-lucide="alert-circle" class="lucide text-danger"></i></div>
                        <strong class="text-danger" style="font-size: 24px; font-weight: 850;">3</strong>
                        <p class="small text-muted mb-0">High priority system tasks</p>
                    </article>
                </div>
            </section>

            <!-- AI Assistant Section (ChatGPT Style) -->
            <section class="wm-card" style="padding: 24px; margin-bottom: 24px; border-radius: 12px;">
                <div class="row g-4 align-items-stretch">
                    <div class="col-lg-8 pe-lg-4 border-end">
                        <div class="d-flex align-items-center gap-2 mb-3">
                            <span class="home-logo" style="width: 28px; height: 28px; font-size: 12px;">AI</span>
                            <h2 class="mb-0" style="font-size: 18px;">WholeMart Assistant</h2>
                        </div>
                        <div class="wm-ai-quick-response" id="wmDashboardAiResponse" style="min-height: 80px; background: var(--wm-brand-soft-2); border-radius: 12px; padding: 16px; margin-bottom: 16px; font-size: 13px;">
                            Ready for your query. Ask about orders, stock, or payments.
                        </div>
                        <form class="d-flex gap-2" id="wmDashboardAiForm">
                            <input class="wm-input" id="wmDashboardAiMessage" placeholder="Ask AI for insights..." style="flex: 1; border-radius: 10px;">
                            <button class="home-btn" id="wmDashboardAiVoice" type="button" style="min-height: 38px; border-radius: 10px;"><i data-lucide="mic" class="lucide" style="width: 16px; height: 16px;"></i></button>
                            <button class="home-btn home-btn-primary" type="submit" style="min-height: 38px;"><i data-lucide="send" class="lucide" style="width: 16px; height: 16px;"></i> Ask</button>
                        </form>
                        <div id="wmDashboardAiActionBox"></div>
                    </div>
                    <div class="col-lg-4 ps-lg-4">
                        <h3 style="font-size: 14px; margin-bottom: 12px; color: var(--wm-text-soft);">Suggested Queries</h3>
                        <div class="wm-action-list d-grid gap-2" id="wmDashboardAiQuickButtons" style="justify-items: start;">
                            <button class="home-btn home-btn-secondary w-100 text-start px-3 py-2" style="justify-content: flex-start;" data-ai-message="What should I do first today?"><i data-lucide="zap" class="lucide" style="width: 16px; height: 16px; margin-right: 8px;"></i> Daily priorities</button>
                            <button class="home-btn home-btn-secondary w-100 text-start px-3 py-2" style="justify-content: flex-start;" data-ai-message="Show today's order summary."><i data-lucide="clipboard-list" class="lucide" style="width: 16px; height: 16px; margin-right: 8px;"></i> Order summary</button>
                            <button class="home-btn home-btn-secondary w-100 text-start px-3 py-2" style="justify-content: flex-start;" data-ai-message="Show low stock summary."><i data-lucide="box" class="lucide" style="width: 16px; height: 16px; margin-right: 8px;"></i> Low stock alerts</button>
                            <button class="home-btn home-btn-secondary w-100 text-start px-3 py-2" style="justify-content: flex-start;" data-ai-message="Suggest next actions."><i data-lucide="trending-up" class="lucide" style="width: 16px; height: 16px; margin-right: 8px;"></i> Expansion tips</button>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Logistics & Operations -->
            <section class="wm-home-roles" style="padding: 0; background: transparent; border: 0; box-shadow: none; margin-bottom: 24px; margin-left: 0; margin-right: 0;">
                <div class="home-section-head" style="margin-bottom: 16px; text-align: left;">
                    <h2 style="font-size: 20px;">Fulfillment & Supply Chain</h2>
                </div>
                <div class="wm-home-role-grid" style="gap: 12px;">
                    <article class="home-role-card" style="padding: 20px;">
                        <div class="home-role-mark" style="background: linear-gradient(135deg, #0f766e, #0d9488); width: 38px; height: 38px;"><i data-lucide="package" style="width: 20px; height: 20px;"></i></div>
                        <h3>Order Pipeline</h3>
                        <p>Real-time demand tracking.</p>
                        <ul class="mb-3 small">
                            <li class="d-flex justify-content-between align-items-center">Waiting Review <strong id="ordersWaiting" class="text-danger">0</strong></li>
                            <li class="d-flex justify-content-between align-items-center">Ready to Pack <strong id="ordersReady">0</strong></li>
                        </ul>
                        <a class="home-btn home-btn-secondary mt-auto" href="/web/distributor/orders">Open Queue</a>
                    </article>
                    <article class="home-role-card" style="padding: 20px;">
                        <div class="home-role-mark" style="background: linear-gradient(135deg, #f59e0b, #d97706); width: 38px; height: 38px;"><i data-lucide="database" style="width: 20px; height: 20px;"></i></div>
                        <h3>Stock Velocity</h3>
                        <p>Inventory health monitoring.</p>
                        <ul class="mb-3 small">
                            <li class="d-flex justify-content-between align-items-center">Active Cats <strong id="categoryCount">0</strong></li>
                            <li class="d-flex justify-content-between align-items-center">Refill Needed <strong id="stockPlanningCount" class="text-warning">0</strong></li>
                        </ul>
                        <a class="home-btn home-btn-secondary mt-auto" href="/web/distributor/products">Refill Stock</a>
                    </article>
                    <article class="home-role-card" style="padding: 20px;">
                        <div class="home-role-mark" style="background: linear-gradient(135deg, #1e40af, #1e3a8a); width: 38px; height: 38px;"><i data-lucide="book-open" style="width: 20px; height: 20px;"></i></div>
                        <h3>Credit Ledger</h3>
                        <p>Dues and collections.</p>
                        <ul class="mb-3 small">
                            <li class="d-flex justify-content-between align-items-center">Overdue <strong class="text-danger">Rs. 0</strong></li>
                            <li class="d-flex justify-content-between align-items-center">Disputes <strong >0</strong></li>
                        </ul>
                        <a class="home-btn home-btn-secondary mt-auto" href="/web/distributor/dues">Ledger</a>
                    </article>
                    <article class="home-role-card" style="padding: 20px;">
                        <div class="home-role-mark" style="background: linear-gradient(135deg, #4b5563, #374151); width: 38px; height: 38px;"><i data-lucide="truck" style="width: 20px; height: 20px;"></i></div>
                        <h3>Dispatch Hub</h3>
                        <p>Driver route coordination.</p>
                        <ul class="mb-3 small">
                            <li class="d-flex justify-content-between align-items-center">Completed <strong id="completedDropoffs">0</strong></li>
                            <li class="d-flex justify-content-between align-items-center">On Route <strong >0</strong></li>
                        </ul>
                        <a class="home-btn home-btn-secondary mt-auto" href="/web/distributor/delivery">Dispatch</a>
                    </article>
                </div>
            </section>

            <!-- Needs Attention Panel -->
            <section class="wm-home-ops" style="padding: 0; margin-bottom: 24px;">
                <div class="home-section-head" style="margin-bottom: 12px; text-align: left;">
                    <h2 style="font-size: 18px;">Priorities</h2>
                </div>
                <div class="home-ops-panel" id="wmAttentionList" style="border-radius: 12px; padding: 8px;">
                    <div class="home-ops-row">
                        <div><strong>Loading priorities...</strong><span>Analyzing live data state.</span></div>
                        <span class="home-pill">System</span>
                    </div>
                </div>
            </section>

            <!-- Business Intelligence Reports -->
            <section style="margin-bottom: 24px;">
                <div class="home-section-head" style="margin-bottom: 12px; text-align: left;">
                    <h2 style="font-size: 18px;">Reports & Insights</h2>
                </div>
                <div class="row g-3 align-items-stretch">
                    <div class="col-md-4">
                        <article class="home-role-card h-100">
                            <h3>Inventory Health</h3>
                            <p>Efficiency Breakdown</p>
                            <div class="mt-3 pt-3 border-top">
                                <div class="d-flex justify-content-between align-items-center mb-2"><span>SKUs</span><strong id="reportTotalItems">0</strong></div>
                                <div class="d-flex justify-content-between align-items-center mb-2"><span>Expired</span><strong class="text-danger">0</strong></div>
                                <div class="d-flex justify-content-between align-items-center"><span>Availability</span><strong class="text-success">92%</strong></div>
                            </div>
                        </article>
                    </div>
                    <div class="col-md-4">
                        <article class="home-role-card h-100">
                            <h3>Fulfillment Rate</h3>
                            <p>Success metrics</p>
                            <div class="mt-3 pt-3 border-top">
                                <div class="d-flex justify-content-between align-items-center mb-2"><span>Active Orders</span><strong id="reportActiveOrders">0</strong></div>
                                <div class="d-flex justify-content-between align-items-center mb-2"><span>Rejected</span><strong>0</strong></div>
                                <div class="d-flex justify-content-between align-items-center"><span>Completion</span><strong class="text-success">98.5%</strong></div>
                            </div>
                        </article>
                    </div>
                    <div class="col-md-4">
                        <article class="home-role-card h-100">
                            <h3>Expansion</h3>
                            <p>Market penetration</p>
                            <div class="mt-3 pt-3 border-top">
                                <div class="d-flex justify-content-between align-items-center mb-2"><span>New Retailers</span><strong>+4</strong></div>
                                <div class="d-flex justify-content-between align-items-center mb-2"><span>New Areas</span><strong>2</strong></div>
                                <div class="d-flex justify-content-between align-items-center"><span>Target Reach</span><strong class="text-warning">78%</strong></div>
                            </div>
                        </article>
                    </div>
                </div>
            </section>

        </div>
    </main>

    <footer class="home-footer" style="margin-top: auto; padding: 24px 0; border-top: 1px solid var(--wm-border);">
        <div class="wm-home-container" style="max-width: 1280px;">
            <div class="home-footer-inner d-flex justify-content-between align-items-center px-3">
                <div class="text-muted small">&copy; 2024 WholeMart Distributor Workspace. All rights reserved.</div>
                <div class="d-flex gap-3">
                    <a href="/web/help" class="small text-muted">Help</a>
                    <a href="/web/terms" class="small text-muted">Terms</a>
                    <a href="/web/privacy" class="small text-muted">Privacy</a>
                </div>
            </div>
        </div>
    </footer>
    

    
        </div>
    </main>
</div>
    <script src="/js/distributor/dashboard.js"></script>
</body></html>
