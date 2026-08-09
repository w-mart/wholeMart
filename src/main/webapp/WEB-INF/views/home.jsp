<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><fmt:message key="app.title"/></title>
    <meta name="description" content="WholeMart connects retailers, distributors, drivers and administrators on one AI-powered platform for wholesale ordering, inventory, credit and delivery.">
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
</head>
<body class="wm-home">
<%@ include file="/WEB-INF/common/header.jsp"%>
<main>

    <!-- ===================================================== -->
    <!-- HERO -->
    <!-- ===================================================== -->
    <section class="wm-hero">
        <div class="container">
            <div class="row align-items-center gy-5">
                <div class="col-lg-6">
                    <span class="badge wm-section-badge"><i class="bi bi-stars" aria-hidden="true"></i> <fmt:message key="hero.badge"/></span>
                    <h1 class="wm-hero-title"><fmt:message key="hero.title"/></h1>
                    <p class="wm-hero-subtitle">
                        <fmt:message key="hero.subtitle"/>
                    </p>
                    <div class="d-flex flex-wrap gap-3 mt-4">
                        <a href="${pageContext.request.contextPath}/web/auth/login" class="btn wm-btn-primary"><fmt:message key="hero.start_now"/></a>
                        <a href="#roles" class="btn wm-btn-outline"><fmt:message key="hero.choose_workspace"/></a>
                    </div>                   
                </div>
                
                <div class="col-lg-6">
                    <div class="wm-hero-image shadow-lg rounded-4 overflow-hidden border border-1 border-secondary-subtle">
                        <img src="${pageContext.request.contextPath}/images/wholemart_operations.jpg"
                             class="img-fluid w-100 object-fit-cover"
                             style="max-height: 420px; display: block;"
                             referrerpolicy="no-referrer"
                             onerror="this.onerror=null;this.src='/images/wholemart_operations.jpg';"
                             alt="WholeMart operations dashboard showing live inventory, orders and delivery status">
                        <div class="wm-mini-card-container">
                            <div class="wm-mini-card">
                                <h6><i class="bi bi-boxes text-success" aria-hidden="true"></i> <fmt:message key="ops.live_inventory"/></h6>
                                <small><fmt:message key="hero.live_inventory_desc"/></small>
                            </div>
                            <div class="wm-mini-card">
                                <h6><i class="bi bi-cart-check text-primary" aria-hidden="true"></i> <fmt:message key="ops.active_orders"/></h6>
                                <small><fmt:message key="hero.active_orders_desc"/></small>
                            </div>
                            <div class="wm-mini-card">
                                <h6><i class="bi bi-truck text-warning" aria-hidden="true"></i> <fmt:message key="ops.delivery_status"/></h6>
                                <small><fmt:message key="hero.delivery_status_desc"/></small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                        
        </div>
    </section>

    <!-- LIVE OPERATIONS HUB SECTION -->
    <section id="operations" class="container my-5">
        <div class="wm-operations-hub">
            <div class="wm-operations-hero-wrap">
                <img src="${pageContext.request.contextPath}/images/wholemart_operations.jpg" 
                     class="wm-operations-hero-img" 
                     referrerpolicy="no-referrer"
                     onerror="this.onerror=null;this.src='/images/wholemart_operations.jpg';"
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

    <hr>
    <!-- HOW IT WORKS -->
    <section id="how-it-works">
        <div class="how-card">
            <div class="how-head">
                <span class="eyebrow"><fmt:message key="how.eyebrow"/></span>
                <h2><fmt:message key="how.title"/></h2>
                <p><fmt:message key="how.subtitle"/></p>
            </div>

            <div class="steps-track">

                <div class="step-col step-blue">
                    <div class="icon-outer">
                        <span class="step-badge">1</span>
                        <div class="icon-inner">
                            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><line x1="19" y1="8" x2="19" y2="14"/><line x1="22" y1="11" x2="16" y2="11"/>
                            </svg>
                        </div>
                    </div>
                    <h4><fmt:message key="how.step1_title"/></h4>
                    <p><fmt:message key="how.step1_desc"/></p>
                </div>

                <div class="connector">
                    <svg viewBox="0 0 60 22" preserveAspectRatio="none" aria-hidden="true">
                        <line x1="0" y1="11" x2="50" y2="11"/>
                        <polygon points="48,5 60,11 48,17"/>
                    </svg>
                </div>

                <div class="step-col step-green">
                    <div class="icon-outer">
                        <span class="step-badge">2</span>
                        <div class="icon-inner">
                            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <path d="M3 9l1.5-5h15L21 9"/><path d="M3 9h18v10a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V9z"/><path d="M9 22V13h6v9"/>
                            </svg>
                        </div>
                    </div>
                    <h4><fmt:message key="how.step2_title"/></h4>
                    <p><fmt:message key="how.step2_desc"/></p>
                </div>

                <div class="connector">
                    <svg viewBox="0 0 60 22" preserveAspectRatio="none" aria-hidden="true">
                        <line x1="0" y1="11" x2="50" y2="11"/>
                        <polygon points="48,5 60,11 48,17"/>
                    </svg>
                </div>

                <div class="step-col step-orange">
                    <div class="icon-outer">
                        <span class="step-badge">3</span>
                        <div class="icon-inner">
                            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.7 13.4a2 2 0 0 0 2 1.6h9.7a2 2 0 0 0 2-1.6L23 6H6"/>
                            </svg>
                        </div>
                    </div>
                    <h4><fmt:message key="how.step3_title"/></h4>
                    <p><fmt:message key="how.step3_desc"/></p>
                </div>

                <div class="connector">
                    <svg viewBox="0 0 60 22" preserveAspectRatio="none" aria-hidden="true">
                        <line x1="0" y1="11" x2="50" y2="11"/>
                        <polygon points="48,5 60,11 48,17"/>
                    </svg>
                </div>

                <div class="step-col step-red">
                    <div class="icon-outer">
                        <span class="step-badge">4</span>
                        <div class="icon-inner">
                            <svg viewBox="0 0 24 24" fill="none" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                                <rect x="1" y="6" width="15" height="12" rx="1"/><path d="M16 10h4l3 3v5h-7z"/><circle cx="6" cy="20" r="2"/><circle cx="18" cy="20" r="2"/>
                            </svg>
                        </div>
                    </div>
                    <h4><fmt:message key="how.step4_title"/></h4>
                    <p><fmt:message key="how.step4_desc"/></p>
                </div>

            </div>
        </div>
    </section>

    <!-- SNAPSHOT -->
    <section id="snapshot">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="card shadow-sm border-0 rounded-4">
                        <div class="card-header bg-white border-0 pt-4">
                            <h4 class="fw-bold text-center">
                                <fmt:message key="snap.title"/>
                            </h4>
                        </div>
                        <div class="card-body px-lg-4">
                            <div class="row g-4">
                                <div class="col-lg-3 col-md-6">
                                    <canvas id="salesDoughnutChart" role="img" aria-label="Sales channel breakdown"></canvas>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <canvas id="salesTrendChart" role="img" aria-label="Monthly sales trend"></canvas>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <canvas id="activityBarChart" role="img" aria-label="Activity count"></canvas>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <canvas id="expiryManagementChart" role="img" aria-label="AI expiry management"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ROLES -->
    <section id="roles">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge"><fmt:message key="roles.badge"/></span>
                <h2 class="wm-section-title"><fmt:message key="roles.title"/></h2>
                <p class="wm-section-subtitle">
                    <fmt:message key="roles.subtitle"/>
                </p>
            </div>

            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="wm-role-card h-100">
                        <h4><fmt:message key="roles.admin_title"/></h4>
                        <p><fmt:message key="roles.admin_desc"/></p>
                        <a href="${pageContext.request.contextPath}/web/auth/login?role=admin" class="btn wm-btn-primary w-100 mt-4"><fmt:message key="roles.admin_login"/></a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="wm-role-card h-100">
                        <h4><fmt:message key="roles.retailer_title"/></h4>
                        <p><fmt:message key="roles.retailer_desc"/></p>
                        <a href="${pageContext.request.contextPath}/web/auth/login?role=retailer" class="btn wm-btn-primary w-100 mt-4"><fmt:message key="roles.retailer_login"/></a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="wm-role-card h-100">
                        <h4><fmt:message key="roles.distributor_title"/></h4>
                        <p><fmt:message key="roles.distributor_desc"/></p>
                        <a href="${pageContext.request.contextPath}/web/auth/login?role=distributor" class="btn wm-btn-primary w-100 mt-4"><fmt:message key="roles.distributor_login"/></a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="wm-role-card h-100">
                        <h4><fmt:message key="roles.driver_title"/></h4>
                        <p><fmt:message key="roles.driver_desc"/></p>
                        <a href="${pageContext.request.contextPath}/web/auth/login?role=driver" class="btn wm-btn-primary w-100 mt-4"><fmt:message key="roles.driver_login"/></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- DAILY OPERATIONS -->
    <!-- ===================================================== -->
    <section id="operations-detail" class="my-5">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge"><fmt:message key="ops.today_ops"/></span>
                <h2 class="wm-section-title"><fmt:message key="ops.built_for_work"/></h2>
                <p class="wm-section-subtitle">
                    <fmt:message key="app.short_desc"/>
                </p>
            </div>

            <div class="row g-4">
                <div class="col-lg-7">
                    <div class="wm-dashboard h-100">
                        <div class="wm-dashboard-header">
                            <h4><fmt:message key="ops.today_ops"/></h4>
                            <span class="badge bg-transparent text-dark fw-normal"><span class="badge bg-success text-white">LIVE</span></span>
                        </div>
                        <div class="wm-dashboard-item">
                            <div class="wm-dashboard-icon"><i class="bi bi-box-seam" aria-hidden="true"></i></div>
                            <div class="wm-dashboard-content">
                                <h5><fmt:message key="ops.low_stock_prods"/> <small class="text-muted fw-normal">(17 items)</small></h5>
                            </div>
                            <span class="badge bg-warning"><fmt:message key="nav.products"/></span>
                        </div>
                        <div class="wm-dashboard-item">
                            <div class="wm-dashboard-icon"><i class="bi bi-person-check" aria-hidden="true"></i></div>
                            <div class="wm-dashboard-content">
                                <h5><fmt:message key="ops.dist_approval"/> <small class="text-muted fw-normal">(5 pending)</small></h5>
                            </div>
                            <span class="badge bg-info"><fmt:message key="status.pending"/></span>
                        </div>
                        <div class="wm-dashboard-item">
                            <div class="wm-dashboard-icon"><i class="bi bi-credit-card" aria-hidden="true"></i></div>
                            <div class="wm-dashboard-content">
                                <h5><fmt:message key="ops.ret_payments"/> <small class="text-muted fw-normal">(₹2.8L due)</small></h5>
                            </div>
                            <span class="badge bg-primary"><fmt:message key="nav.payments"/></span>
                        </div>
                        <div class="wm-dashboard-item">
                            <div class="wm-dashboard-icon"><i class="bi bi-truck" aria-hidden="true"></i></div>
                            <div class="wm-dashboard-content">
                                <h5><fmt:message key="ops.driver_deliv"/> <small class="text-muted fw-normal">(38 in progress)</small></h5>
                            </div>
                            <span class="badge bg-success"><fmt:message key="nav.deliveries"/></span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="wm-ai-panel h-100">
                        <div class="wm-ai-header">
                            <i class="bi bi-robot" aria-hidden="true"></i>
                            <h4><fmt:message key="nav.ai_chat"/></h4>
                            <span class="live-indicator" aria-hidden="true"></span>
                        </div>
                        <p><fmt:message key="ai.ask_placeholder"/></p>

                        <div class="wm-ai-priority high"><i class="bi bi-fire" aria-hidden="true"></i> High Priority</div>
                        <a href="#" class="wm-ai-card text-decoration-none text-white">
                            <i class="bi bi-box-seam fs-4" aria-hidden="true"></i>
                            <div class="wm-ai-card-content">
                                <div><fmt:message key="ai.quick_query1"/></div>
                                <small class="wm-ai-card-action"><fmt:message key="btn.order_now"/> &rarr;</small>
                            </div>
                        </a>
                        <a href="#" class="wm-ai-card text-decoration-none text-white mt-2">
                            <i class="bi bi-sign-merge-right fs-4" aria-hidden="true"></i>
                            <div class="wm-ai-card-content">
                                <div><fmt:message key="ai.quick_query2"/></div>
                                <small class="wm-ai-card-action"><fmt:message key="btn.track"/> &rarr;</small>
                            </div>
                        </a>

                        <div class="wm-ai-stats row g-3 text-center mt-4">
                            <div class="col-6 col-md-3 wm-ai-stat">
                                <h6>94%</h6>
                                <small class="text-white-50">AI Health</small>
                            </div>
                            <div class="col-6 col-md-3 wm-ai-stat">
                                <h6>96%</h6>
                                <small class="text-white-50">Forecast</small>
                            </div>
                            <div class="col-6 col-md-3 wm-ai-stat">
                                <h6>24</h6>
                                <small class="text-white-50">Alerts</small>
                            </div>
                            <div class="col-6 col-md-3 wm-ai-stat">
                                <h6>₹3.4L</h6>
                                <small class="text-white-50">Saved</small>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/web/auth/login" class="btn btn-light w-100 mt-4"><fmt:message key="ai.ai_studio"/></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- FEATURES & PROCESS -->
    <!-- ===================================================== -->
    <section id="features" class="bg-light py-5">
        <div class="container">
            <div id="features-content">
                <div id="why-content">
                    <div class="text-center mb-5">
                        <h2 class="wm-section-title"><fmt:message key="feat.title"/></h2>
                        <p class="wm-section-subtitle"><fmt:message key="feat.subtitle"/></p>
                    </div>
                    <div class="row g-4">
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon"><i class="bi bi-box-seam" aria-hidden="true"></i></div>
                                <h4><fmt:message key="feat.smart_inv_title"/></h4>
                                <p><fmt:message key="feat.smart_inv_desc"/></p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.smart_inv_item1"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.smart_inv_item2"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.smart_inv_item3"/></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon bg-success-subtle"><i class="bi bi-wallet2" aria-hidden="true"></i></div>
                                <h4><fmt:message key="feat.credit_title"/></h4>
                                <p><fmt:message key="feat.credit_desc"/></p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.credit_item1"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.credit_item2"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.credit_item3"/></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon bg-warning-subtle"><i class="bi bi-truck" aria-hidden="true"></i></div>
                                <h4><fmt:message key="feat.delivery_title"/></h4>
                                <p><fmt:message key="feat.delivery_desc"/></p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.delivery_item1"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.delivery_item2"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.delivery_item3"/></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon icon-lavender"><i class="bi bi-cart-check" aria-hidden="true"></i></div>
                                <h4><fmt:message key="feat.order_mgmt_title"/></h4>
                                <p><fmt:message key="feat.order_mgmt_desc"/></p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.order_mgmt_item1"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.order_mgmt_item2"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.order_mgmt_item3"/></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon icon-pink"><i class="bi bi-diagram-3" aria-hidden="true"></i></div>
                                <h4><fmt:message key="feat.branch_title"/></h4>
                                <p><fmt:message key="feat.branch_desc"/></p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.branch_item1"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.branch_item2"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.branch_item3"/></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon icon-mint"><i class="bi bi-graph-up-arrow" aria-hidden="true"></i></div>
                                <h4><fmt:message key="feat.bi_title"/></h4>
                                <p><fmt:message key="feat.bi_desc"/></p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.bi_item1"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.bi_item2"/></li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> <fmt:message key="feat.bi_item3"/></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- DISTRIBUTOR BENEFITS -->
    <!-- ===================================================== -->
    <section id="distributor-benefits" class="bg-light py-5">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge"><fmt:message key="dist_adv.badge"/></span>
                <h2 class="wm-section-title"><fmt:message key="dist_adv.title"/></h2>
                <p class="wm-section-subtitle">
                    <fmt:message key="dist_adv.subtitle"/>
                </p>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-lg-4 col-md-6">
                    <div class="wm-stat-card h-100">
                        <span class="wm-stat-label"><fmt:message key="dist_adv.card1_label"/></span>
                        <h3><fmt:message key="dist_adv.card1_title"/></h3>
                        <div class="wm-snapshot-bar-bg"><div class="wm-snapshot-bar bar-blue" style="--w: 70;"></div></div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="wm-stat-card h-100">
                        <span class="wm-stat-label"><fmt:message key="dist_adv.card2_label"/></span>
                        <h3><fmt:message key="dist_adv.card2_title"/></h3>
                        <div class="wm-snapshot-bar-bg"><div class="wm-snapshot-bar bar-green" style="--w: 85;"></div></div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="wm-stat-card h-100">
                        <span class="wm-stat-label"><fmt:message key="dist_adv.card3_label"/></span>
                        <h3><fmt:message key="dist_adv.card3_title"/></h3>
                        <div class="wm-snapshot-bar-bg"><div class="wm-snapshot-bar bar-red" style="--w: 60;"></div></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- TESTIMONIALS -->
    <!-- ===================================================== -->
    <section id="testimonials" class="bg-light py-5">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge"><fmt:message key="test.badge"/></span>
                <h2 class="wm-section-title"><fmt:message key="test.title"/></h2>
                <p class="wm-section-subtitle"><fmt:message key="test.subtitle"/></p>
            </div>
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="wm-testimonial-card h-100 shadow-sm">
                        <i class="bi bi-quote" aria-hidden="true"></i>
                        <p><fmt:message key="test.ret_quote"/></p>
                        <div class="wm-testimonial-who">
                            <div class="wm-testimonial-avatar bg-success-subtle text-success"><i class="bi bi-shop" aria-hidden="true"></i></div>
                            <div><strong><fmt:message key="roles.retailer_title"/></strong><span><fmt:message key="test.ret_role"/></span></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="wm-testimonial-card h-100 shadow-sm">
                        <i class="bi bi-quote" aria-hidden="true"></i>
                        <p><fmt:message key="test.dist_quote"/></p>
                        <div class="wm-testimonial-who">
                            <div class="wm-testimonial-avatar bg-warning-subtle text-warning"><i class="bi bi-box-seam" aria-hidden="true"></i></div>
                            <div><strong><fmt:message key="roles.distributor_title"/></strong><span><fmt:message key="test.dist_role"/></span></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="wm-testimonial-card h-100 shadow-sm">
                        <i class="bi bi-quote" aria-hidden="true"></i>
                        <p><fmt:message key="test.driver_quote"/></p>
                        <div class="wm-testimonial-who">
                            <div class="wm-testimonial-avatar bg-danger-subtle text-danger"><i class="bi bi-truck" aria-hidden="true"></i></div>
                            <div><strong><fmt:message key="roles.driver_title"/></strong><span><fmt:message key="test.driver_role"/></span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- FAQ -->
    <!-- ===================================================== -->
    <section id="faq" class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge"><fmt:message key="faq.badge"/></span>
                <h2 class="wm-section-title"><fmt:message key="faq.title"/></h2>
                <p class="wm-section-subtitle">
                    <fmt:message key="faq.subtitle"/>
                </p>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-9">
                    <div class="accordion" id="faqAccordion">

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#faq1" aria-expanded="true" aria-controls="faq1">
                                    <fmt:message key="faq.q1"/>
                                </button>
                            </h2>
                            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                                <div class="accordion-body"><fmt:message key="faq.a1"/></div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq2" aria-expanded="false" aria-controls="faq2">
                                    <fmt:message key="faq.q2"/>
                                </button>
                            </h2>
                            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body"><fmt:message key="faq.a2"/></div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq3" aria-expanded="false" aria-controls="faq3">
                                    <fmt:message key="faq.q3"/>
                                </button>
                            </h2>
                            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body"><fmt:message key="faq.a3"/></div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq4" aria-expanded="false" aria-controls="faq4">
                                    <fmt:message key="faq.q4"/>
                                </button>
                            </h2>
                            <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body"><fmt:message key="faq.a4"/></div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq5" aria-expanded="false" aria-controls="faq5">
                                    <fmt:message key="faq.q5"/>
                                </button>
                            </h2>
                            <div id="faq5" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body"><fmt:message key="faq.a5"/></div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq6" aria-expanded="false" aria-controls="faq6">
                                    <fmt:message key="faq.q6"/>
                                </button>
                            </h2>
                            <div id="faq6" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body"><fmt:message key="faq.a6"/></div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- SECURITY / COMPLIANCE -->
    <!-- ===================================================== -->
    <section id="security" class="wm-security-section bg-light py-5">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge"><fmt:message key="sec.badge"/></span>
                <h2 class="wm-section-title"><fmt:message key="sec.title"/></h2>
                <p class="wm-section-subtitle"><fmt:message key="sec.subtitle"/></p>
            </div>
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <div class="wm-security-tile">
                        <div class="icon"><i class="bi bi-shield-lock" aria-hidden="true"></i></div>
                        <h6><fmt:message key="sec.role_access"/></h6>
                        <p class="text-muted small"><fmt:message key="sec.role_access_desc"/></p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="wm-security-tile">
                        <div class="icon"><i class="bi bi-key" aria-hidden="true"></i></div>
                        <h6><fmt:message key="sec.encryption"/></h6>
                        <p class="text-muted small"><fmt:message key="sec.encryption_desc"/></p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="wm-security-tile">
                        <div class="icon"><i class="bi bi-journal-check" aria-hidden="true"></i></div>
                        <h6><fmt:message key="sec.audit_logs"/></h6>
                        <p class="text-muted small"><fmt:message key="sec.audit_logs_desc"/></p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="wm-security-tile">
                        <div class="icon"><i class="bi bi-cloud-arrow-up" aria-hidden="true"></i></div>
                        <h6><fmt:message key="sec.uptime"/></h6>
                        <p class="text-muted small"><fmt:message key="sec.uptime_desc"/></p>
                    </div>
                </div>
            </div>

        </div>
    </section>

    <!-- ===================================================== -->
    <!-- CALL TO ACTION -->
    <!-- ===================================================== -->
    <section class="wm-cta">
        <div class="container">
            <div class="wm-cta-box">
                <h2><fmt:message key="cta.title"/></h2>
                <p><fmt:message key="cta.subtitle"/></p>
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/web/auth/login" class="btn wm-btn-primary btn-lg"><fmt:message key="cta.btn"/></a>
                </div>
            </div>
        </div>
    </section>

</main>

<!-- Login Popup Modal -->
<div id="loginModal" class="modal-overlay" role="dialog" aria-modal="true" aria-label="Log in to WholeMart">
    <div class="modal-content">
        <button class="close-button" onclick="closeLoginPopup()" aria-label="Close login form">&times;</button>
        <%@ include file="/WEB-INF/views/home/_loginForm.jsp" %>
    </div>
</div>

<%@ include file="/WEB-INF/common/footer.jsp"%>
<script src="${pageContext.request.contextPath}/js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
<script src="${pageContext.request.contextPath}/js/home-charts.js"></script>

</body>
</html>
