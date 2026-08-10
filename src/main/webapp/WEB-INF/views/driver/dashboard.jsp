<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | <fmt:message key="driver.dashboard_title"/></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&family=IBM+Plex+Mono:wght@500;600;700&family=Poppins:wght@600;700;800&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero-carousel.css">

    
</head>

<body class="wm-home">

    <% String wmUserName = session.getAttribute("username") == null ? "Driver" : String.valueOf(session.getAttribute("username")); %>

    <%@ include file="/WEB-INF/common/driver-header.jsp" %>

    <div class="wm-app">
        <main>
            <div class="wm-home-container">

                <!-- ===================================================== -->
                <!-- 1. HERO CAROUSEL BANNER (Theme-matched to home/dist) -->
                <!-- ===================================================== -->
                <section class="wm-home-hero" aria-label="Driver hero">
                    <div class="wm-hero-carousel" data-hero-carousel>
                        <div class="wm-hero-carousel-viewport" data-hero-viewport>
                            <div class="wm-hero-carousel-track" data-hero-track>

                                <!-- Slide 1: Main Welcome & Shift Pulse -->
                                <section class="wm-home-hero-slide" data-hero-slide="0">
                                    <div class="wm-home-hero-grid">
                                        <div class="wm-home-hero-copy">
                                            <span class="wm-kicker"><span class="wm-live-dot"></span> <fmt:message key="nav.driver_workspace"/></span>
                                            <h1 class="wm-home-title"><fmt:message key="driver.hero.welcome"><fmt:param value="<%= wmUserName %>"/></fmt:message></h1>
                                            <p class="wm-home-subtitle"><fmt:message key="driver.hero.subtitle"/></p>
                                            <div class="wm-home-actions">
                                                <a class="home-btn home-btn-primary" href="${pageContext.request.contextPath}/web/driver/deliveries"><i class="bi bi-truck"></i> <fmt:message key="driver.hero.all_deliveries"/></a>
                                                <a class="home-btn home-btn-secondary" href="${pageContext.request.contextPath}/web/driver/earnings"><i class="bi bi-wallet2"></i> <fmt:message key="driver.hero.earnings_report"/></a>
                                                <a class="home-btn home-btn-secondary" href="${pageContext.request.contextPath}/web/driver/ai-chat"><i class="bi bi-stars"></i> <fmt:message key="driver.hero.logistics_ai"/></a>
                                            </div>
                                        </div>

                                        <div class="wm-pulse-card">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <div>
                                                    <span class="wm-pulse-eyebrow"><fmt:message key="driver.hero.shift_performance"/></span>
                                                    <h3><fmt:message key="driver.hero.dispatch_snapshot"/></h3>
                                                </div>
                                                <div class="home-logo">AI</div>
                                            </div>
                                            <div id="driverPerformanceBrief"><fmt:message key="driver.hero.loading_telemetry"/></div>
                                            <hr>
                                            <div class="wm-pulse-stats">
                                                <div>
                                                    <h5 id="heroActiveDeliveries">0</h5>
                                                    <small><fmt:message key="distributor.fulfillment.active_trips"/></small>
                                                </div>
                                                <div>
                                                    <h5 id="heroTodayEarnings">₹0</h5>
                                                    <small><fmt:message key="driver.hero.today_payout"/></small>
                                                </div>
                                                <div>
                                                    <h5 id="heroCompletedTrips">0</h5>
                                                    <small><fmt:message key="status.completed"/></small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>

                                <!-- Slide 2: Route GPS Optimization -->
                                <section class="wm-home-hero-slide" data-hero-slide="1">
                                    <div class="wm-home-hero-grid">
                                        <div class="wm-home-hero-copy">
                                            <span class="wm-kicker"><span class="wm-live-dot"></span> <fmt:message key="driver.hero.gps_tracking"/></span>
                                            <h1 class="wm-home-title"><fmt:message key="driver.hero.optimized_delivery"/></h1>
                                            <p class="wm-home-subtitle"><fmt:message key="driver.hero.optimized_delivery_subtitle"/></p>
                                            <div class="wm-home-actions">
                                                <a class="home-btn home-btn-primary" href="${pageContext.request.contextPath}/web/driver/deliveries"><i class="bi bi-geo-alt"></i> <fmt:message key="driver.hero.view_routes"/></a>
                                                <a class="home-btn home-btn-secondary" href="${pageContext.request.contextPath}/web/driver/orders"><i class="bi bi-box-seam"></i> <fmt:message key="driver.hero.assigned_orders"/></a>
                                            </div>
                                        </div>

                                        <div class="wm-pulse-card">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <div>
                                                    <span class="wm-pulse-eyebrow"><fmt:message key="driver.hero.fleet_status"/></span>
                                                    <h3><fmt:message key="driver.hero.gps_telemetry"/></h3>
                                                </div>
                                                <div class="home-logo">GPS</div>
                                            </div>
                                            <div><fmt:message key="driver.hero.gps_enabled"/></div>
                                            <hr>
                                            <div class="wm-pulse-stats">
                                                <div>
                                                    <h5 id="heroTotalDeliveries">0</h5>
                                                    <small><fmt:message key="driver.kpi.lifetime"/></small>
                                                </div>
                                                <div>
                                                    <h5 id="heroTodayTrips">0</h5>
                                                    <small><fmt:message key="driver.kpi.today_assigned"/></small>
                                                </div>
                                                <div>
                                                    <h5 id="heroTotalEarnings">₹0</h5>
                                                    <small><fmt:message key="driver.kpi.total_balance"/></small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>

                            </div>
                        </div>

                        <div class="wm-hero-carousel-controls" aria-hidden="true">
                            <button type="button" class="wm-hero-carousel-btn" data-hero-prev aria-label="Previous slide"><i class="bi bi-chevron-left"></i></button>
                            <button type="button" class="wm-hero-carousel-btn" data-hero-next aria-label="Next slide"><i class="bi bi-chevron-right"></i></button>
                        </div>

                        <div class="wm-hero-carousel-dots" data-hero-dots aria-label="Hero slide indicators"></div>
                    </div>
                </section>

                <hr>

                <!-- ===================================================== -->
                <!-- 2. LIVE OPERATIONS DASHBOARD HUB (Signature Section) -->
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
                <!-- 3. DRIVER DISPATCH STATUS STRIP -->
                <!-- ===================================================== -->
                <section class="wm-driver-status-card" id="onlineBar">
                    <div class="wm-status-indicator">
                        <div class="wm-pulse-ring" id="onlineDot"></div>
                        <div>
                            <div class="wm-status-label" id="onlineText"><fmt:message key="driver.status.checking"/></div>
                            <div class="wm-status-meta">
                                <span><i class="bi bi-broadcast text-primary"></i> <fmt:message key="driver.status.dispatch_channel"/></span>
                                <span><i class="bi bi-crosshair text-success"></i> <fmt:message key="driver.status.gps_active"/></span>
                                <span class="d-none d-sm-inline"><i class="bi bi-clock-history"></i> <fmt:message key="driver.status.syncing"/></span>
                            </div>
                        </div>
                    </div>
                    <div>
                        <button id="toggleOnlineBtn" class="wm-toggle-btn btn-online">
                            <i class="bi bi-power"></i> <fmt:message key="driver.status.go_online"/>
                        </button>
                    </div>
                </section>

                <!-- ===================================================== -->
                <!-- 4. KPI METRICS OVERVIEW -->
                <!-- ===================================================== -->
                <section class="wm-driver-kpi-grid" aria-label="<fmt:message key="nav.deliveries"/> Statistics">
                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label"><fmt:message key="driver.kpi.total_deliveries"/></div>
                            <div class="wm-driver-kpi-val" id="statTotalDeliveries">0</div>
                            <div class="wm-driver-kpi-sub"><fmt:message key="driver.kpi.lifetime_trips"/></div>
                        </div>
                        <div class="wm-driver-icon-pill icon-dark"><i class="bi bi-truck"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label"><fmt:message key="status.completed"/></div>
                            <div class="wm-driver-kpi-val text-success" id="statCompleted">0</div>
                            <div class="wm-driver-kpi-sub"><fmt:message key="driver.kpi.verified_closed"/></div>
                        </div>
                        <div class="wm-driver-icon-pill"><i class="bi bi-check2-circle"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label"><fmt:message key="ops.active_orders"/></div>
                            <div class="wm-driver-kpi-val text-warning" id="statActive">0</div>
                            <div class="wm-driver-kpi-sub"><fmt:message key="driver.kpi.assigned_in_transit"/></div>
                        </div>
                        <div class="wm-driver-icon-pill icon-amber"><i class="bi bi-hourglass-split"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label"><fmt:message key="driver.kpi.today_trips"/></div>
                            <div class="wm-driver-kpi-val" id="statToday">0</div>
                            <div class="wm-driver-kpi-sub"><fmt:message key="driver.kpi.assigned_today"/></div>
                        </div>
                        <div class="wm-driver-icon-pill icon-dark"><i class="bi bi-calendar2-check"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label"><fmt:message key="driver.kpi.today_earnings"/></div>
                            <div class="wm-driver-kpi-val text-success" id="statEarnings">₹0</div>
                            <div class="wm-driver-kpi-sub"><fmt:message key="driver.kpi.calculated_payout"/></div>
                        </div>
                        <div class="wm-driver-icon-pill"><i class="bi bi-currency-rupee"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label"><fmt:message key="driver.kpi.total_earnings"/></div>
                            <div class="wm-driver-kpi-val" id="statTotalEarnings">₹0</div>
                            <div class="wm-driver-kpi-sub"><fmt:message key="driver.kpi.accumulated_balance"/></div>
                        </div>
                        <div class="wm-driver-icon-pill icon-dark"><i class="bi bi-wallet2"></i></div>
                    </div>
                </section>

                <hr>

                <!-- ===================================================== -->
                <!-- 5. ACTIVE DELIVERIES DISPATCH (Priority Center) -->
                <!-- ===================================================== -->
                <section class="wm-home-ops mb-4">
                    <div class="home-section-head d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <div>
                            <span class="wm-kicker"><span class="wm-live-dot"></span> <fmt:message key="driver.dispatch.live_queue"/></span>
                            <h2><fmt:message key="driver.dispatch.active_assignments"/></h2>
                            <p><fmt:message key="driver.dispatch.subtitle"/></p>
                        </div>
                        <span class="home-pill">REAL-TIME</span>
                    </div>

                    <div class="wm-card">
                        <div class="wm-driver-table-wrap">
                            <table class="wm-table wm-driver-table table table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th><fmt:message key="driver.table.hash"/></th>
                                        <th><fmt:message key="driver.table.order_ref"/></th>
                                        <th><fmt:message key="driver.table.status"/></th>
                                        <th><fmt:message key="driver.table.pickup_otp"/></th>
                                        <th><fmt:message key="driver.table.delivery_otp"/></th>
                                        <th><fmt:message key="driver.table.delivery_fee"/></th>
                                        <th><fmt:message key="driver.table.assigned_at"/></th>
                                        <th class="text-end"><fmt:message key="driver.table.actions"/></th>
                                    </tr>
                                </thead>
                                <tbody id="activeDeliveriesBody">
                                    <tr>
                                        <td colspan="8">
                                            <div class="wm-empty-state">
                                                <div class="spinner-border text-success mb-2" role="status" style="width: 1.8rem; height: 1.8rem;"></div>
                                                <div><fmt:message key="driver.table.loading_active"/></div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>

                <!-- ===================================================== -->
                <!-- 6. RECENT DELIVERY HISTORY -->
                <!-- ===================================================== -->
                <section class="wm-home-ops mb-5">
                    <div class="home-section-head d-flex justify-content-between align-items-center flex-wrap gap-2">
                        <div>
                            <span class="wm-kicker"><fmt:message key="driver.history.ledger_archive"/></span>
                            <h2><fmt:message key="driver.history.title"/></h2>
                            <p><fmt:message key="driver.history.subtitle"/></p>
                        </div>
                        <a href="${pageContext.request.contextPath}/web/driver/deliveries" class="home-btn home-btn-secondary py-1 px-3">
                            <fmt:message key="driver.history.view_full_ledger"/> <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>

                    <div class="wm-card">
                        <div class="wm-driver-table-wrap">
                            <table class="wm-table wm-driver-table table table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th><fmt:message key="driver.table.hash"/></th>
                                        <th><fmt:message key="driver.table.delivery_id"/></th>
                                        <th><fmt:message key="driver.table.order_id"/></th>
                                        <th><fmt:message key="driver.table.status"/></th>
                                        <th><fmt:message key="driver.table.date"/></th>
                                        <th><fmt:message key="driver.table.fee"/></th>
                                    </tr>
                                </thead>
                                <tbody id="recentDeliveriesBody">
                                    <tr>
                                        <td colspan="6">
                                            <div class="wm-empty-state">
                                                <div class="spinner-border text-secondary mb-2" role="status" style="width: 1.8rem; height: 1.8rem;"></div>
                                                <div><fmt:message key="driver.table.loading_recent"/></div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>

            </div>
        </main>

        <%@ include file="/WEB-INF/common/footer.jsp" %>
    </div>

    <!-- ========================================================= -->
    <!-- Delivery Details Review Modal                              -->
    <!-- ========================================================= -->
    <div class="modal fade wm-driver-modal wm-common-modal" id="driverDeliveryModal" tabindex="-1" aria-labelledby="driverDeliveryModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">

                <!-- Header -->
                <div class="modal-header">
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 w-100 me-3">
                        <div>
                            <div class="d-flex align-items-center flex-wrap gap-2 mb-1">
                                <span class="badge bg-primary px-3 py-1 font-monospace fs-6" id="modalAssignmentId">#00000</span>
                                <span class="badge bg-secondary px-3 py-1 font-monospace" id="modalOrderId">#ORD-00000</span>
                                <span class="badge bg-warning text-dark px-3 py-1 rounded-pill font-monospace" id="modalOrderStatus">ASSIGNED</span>
                                <span class="badge bg-light text-dark border px-2 py-1 font-monospace small" id="modalPaymentMode">CASH</span>
                            </div>
                            <div class="d-flex align-items-center gap-2 small text-white-50">
                                <i class="bi bi-shield-check"></i>
                                <span><fmt:message key="driver.modal.review_details"/></span>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="<fmt:message key="btn.close"/>"></button>
                </div>

                <!-- Body -->
                <div class="modal-body">

                    <!-- Route Info (Pickup Hub -> Drop-Off Location) -->
                    <div class="row g-2 g-md-3 mb-3">
                        <div class="col-12 col-md-6">
                            <div class="wm-modal-card wm-pickup-card h-100">
                                <div class="d-flex gap-2.5 gap-md-3 align-items-start">
                                    <div class="wm-modal-icon-badge wm-pickup flex-shrink-0">
                                        <i class="bi bi-building"></i>
                                    </div>
                                    <div class="flex-grow-1 min-w-0">
                                        <span class="badge bg-warning-subtle text-warning-emphasis font-monospace fw-bold px-2 py-1 rounded-pill mb-1" style="font-size: 0.72rem;">
                                            <i class="bi bi-box-arrow-up me-1"></i> <fmt:message key="driver.modal.step1"/>
                                        </span>
                                        <h6 class="fw-bold mb-1 mt-1 text-dark"><fmt:message key="driver.modal.pickup_location"/></h6>
                                        <p class="text-secondary mb-0 small" id="modalFromAddress">Loading...</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 col-md-6">
                            <div class="wm-modal-card wm-dropoff-card h-100">
                                <div class="d-flex gap-2.5 gap-md-3 align-items-start">
                                    <div class="wm-modal-icon-badge wm-dropoff flex-shrink-0">
                                        <i class="bi bi-shop"></i>
                                    </div>
                                    <div class="flex-grow-1 min-w-0">
                                        <span class="badge bg-success-subtle text-success-emphasis font-monospace fw-bold px-2 py-1 rounded-pill mb-1" style="font-size: 0.72rem;">
                                            <i class="bi bi-geo-alt-fill me-1"></i> <fmt:message key="driver.modal.step2"/>
                                        </span>
                                        <h6 class="fw-bold mb-1 mt-1 text-dark"><fmt:message key="driver.modal.dropoff_location"/></h6>
                                        <p class="text-secondary mb-0 small" id="modalToAddress">Loading...</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Metrics Grid (Fee, Total, OTPs - 2x2 on Mobile) -->
                    <div class="row g-2 g-md-3 mb-3">
                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="wm-metric-label"><fmt:message key="driver.modal.driver_fee"/></div>
                                <h3 class="wm-metric-value text-success" id="modalDeliveryFee">₹0</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-wallet2 text-success me-1"></i> <fmt:message key="driver.modal.bank_credit"/></div>
                            </div>
                        </div>

                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="wm-metric-label"><fmt:message key="driver.modal.order_total"/></div>
                                <h3 class="wm-metric-value text-dark" id="modalOrderTotal">₹0</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-credit-card me-1"></i> <fmt:message key="driver.modal.order_bill_value"/></div>
                            </div>
                        </div>

                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="wm-metric-label"><fmt:message key="driver.table.pickup_otp"/></div>
                                <h3 class="wm-metric-value text-dark letter-spacing-1" id="modalPickupOtp">-</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-shield-check text-warning me-1"></i> <fmt:message key="driver.modal.share_at_pickup"/></div>
                            </div>
                        </div>

                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="wm-metric-label"><fmt:message key="driver.table.delivery_otp"/></div>
                                <h3 class="wm-metric-value text-success letter-spacing-1" id="modalDeliveryOtp">-</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-key text-success me-1"></i> <fmt:message key="driver.modal.verify_with_retailer"/></div>
                            </div>
                        </div>
                    </div>

                    <!-- Items Manifest -->
                    <div class="wm-modal-manifest">
                        <div class="wm-modal-manifest-head">
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-box-seam-fill text-primary"></i>
                                <h6 class="fw-bold mb-0 text-dark" style="font-family: var(--font-display);"><fmt:message key="driver.modal.order_manifest"/></h6>
                            </div>
                            <span class="badge bg-dark rounded-pill font-monospace" id="modalItemsCount">0 Items</span>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th><fmt:message key="driver.modal.product"/></th>
                                        <th><fmt:message key="driver.modal.sku"/></th>
                                        <th class="text-center"><fmt:message key="driver.modal.qty"/></th>
                                        <th class="text-end"><fmt:message key="driver.modal.price"/></th>
                                        <th class="text-end"><fmt:message key="driver.modal.total"/></th>
                                        <th><fmt:message key="driver.modal.pack_size"/></th>
                                        <th><fmt:message key="driver.modal.weight"/></th>
                                    </tr>
                                </thead>
                                <tbody id="modalOrderItemsBody">
                                    <tr><td colspan="7" class="text-center py-3 text-muted"><fmt:message key="driver.modal.no_items"/></td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>

                <!-- Footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary rounded-pill px-4 wm-mobile-footer-btn" data-bs-dismiss="modal">
                        <i class="bi bi-x-lg me-1"></i> <fmt:message key="btn.close"/>
                    </button>
                    <div class="d-flex gap-2 w-100-mobile">
                        <button type="button" class="btn btn-outline-danger rounded-pill px-4 fw-semibold wm-mobile-footer-btn flex-grow-1" id="modalRejectBtn">
                            <i class="bi bi-x-circle me-1"></i> <fmt:message key="btn.reject"/>
                        </button>
                        <button type="button" class="btn btn-success rounded-pill px-4 fw-semibold d-inline-flex align-items-center justify-content-center gap-2 wm-mobile-footer-btn flex-grow-1" id="modalAcceptBtn">
                            <i class="bi bi-check2-circle"></i> <fmt:message key="btn.accept"/>
                        </button>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <!-- Script Implementation -->
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        var isOnline = false;
        var latitude = null;
        var longitude = null;
        var activeDeliveries = [];
        var currentDeliveryAssignmentId = null;
        var deliveryModal = null;
        var autoOpenedAssignmentId = null;
        var dismissedAssignments = {};

        var modalElement = document.getElementById('driverDeliveryModal');
        if (modalElement) {
            modalElement.addEventListener('hidden.bs.modal', function() {
                if (currentDeliveryAssignmentId) {
                    dismissedAssignments[currentDeliveryAssignmentId] = true;
                }
            });
        }

        function text(id, val) {
            var el = document.getElementById(id);
            if (el) el.textContent = val;
        }

        function updateOnlineUI(online) {
            isOnline = Boolean(online);
            var dot = document.getElementById("onlineDot");
            var txt = document.getElementById("onlineText");
            var btn = document.getElementById("toggleOnlineBtn");
            if (isOnline) {
                if (dot) dot.className = "wm-pulse-ring online";
                if (txt) txt.textContent = "<fmt:message key="driver.status.online"/>";
                if (btn) {
                    btn.innerHTML = '<i class="bi bi-power"></i> <fmt:message key="driver.status.go_offline"/>';
                    btn.className = "wm-toggle-btn btn-offline";
                }
            } else {
                if (dot) dot.className = "wm-pulse-ring";
                if (txt) txt.textContent = "<fmt:message key="driver.status.offline"/>";
                if (btn) {
                    btn.innerHTML = '<i class="bi bi-power"></i> <fmt:message key="driver.status.go_online"/>';
                    btn.className = "wm-toggle-btn btn-online";
                }
                if (deliveryModal) {
                    try { deliveryModal.hide(); } catch(e) {}
                }
            }
        }

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(pos) {
                    latitude = pos.coords.latitude;
                    longitude = pos.coords.longitude;
                }, function() {
                    latitude = 0;
                    longitude = 0;
                });
            }
        }

        function normalizeAddress(value, fallback) {
            if (!value) {
                return fallback || "Not available";
            }
            var cleaned = value.split(',').map(function(part) {
                return part.trim();
            }).filter(function(part) {
                return part.length > 0;
            }).join(', ');
            return cleaned || (fallback || "Not available");
        }

        // Load stats
        function loadStats() {
            fetch("/api/v1/driver/stats")
                .then(function(r) { return r.json(); })
                .then(function(stats) {
                    text("statTotalDeliveries", stats.totalDeliveries || 0);
                    text("statCompleted", stats.completedDeliveries || 0);
                    text("statActive", stats.activeDeliveries || 0);
                    text("statToday", stats.todayDeliveries || 0);
                    text("statEarnings", "₹" + (stats.todayEarnings || "0.00"));
                    text("statTotalEarnings", "₹" + (stats.totalEarnings || "0.00"));

                    // Hero stats
                    text("heroActiveDeliveries", stats.activeDeliveries || 0);
                    text("heroTodayEarnings", "₹" + (stats.todayEarnings || "0.00"));
                    text("heroCompletedTrips", stats.completedDeliveries || 0);
                    text("heroTotalDeliveries", stats.totalDeliveries || 0);
                    text("heroTodayTrips", stats.todayDeliveries || 0);
                    text("heroTotalEarnings", "₹" + (stats.totalEarnings || "0.00"));

                    var brief = document.getElementById("driverPerformanceBrief");
                    if (brief) {
                        var activeCount = stats.activeDeliveries || 0;
                        var todayEarn = stats.todayEarnings || "0.00";
                        if (activeCount > 0) {
                            brief.innerHTML = "<fmt:message key="driver.brief.active"><fmt:param>" + activeCount + "</fmt:param><fmt:param>" + todayEarn + "</fmt:param></fmt:message>";
                        } else {
                            brief.textContent = "<fmt:message key="driver.brief.clear"/>";
                        }
                    }

                    updateOnlineUI(stats.isOnline || false);
                })
                .catch(function() {
                    text("statTotalDeliveries", 0);
                    text("statCompleted", 0);
                    text("statActive", 0);
                    text("statToday", 0);
                    text("statEarnings", "₹0");
                    text("statTotalEarnings", "₹0");
                });
        }

        window.openDeliveryModal = function(assignmentId, isExplicitClick) {
            if (!isExplicitClick && !isOnline) {
                return;
            }
            currentDeliveryAssignmentId = assignmentId;
            var assignment = activeDeliveries.find(function(d) { return d.id === assignmentId; });
            if (!assignment) {
                if (isExplicitClick) {
                    alert("<fmt:message key="driver.alert.not_found"/>");
                }
                return;
            }
            fetch("/api/v1/orders/" + assignment.orderId)
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error("Unable to load order details");
                    }
                    return response.json();
                })
                .then(function(order) {
                    if (!isExplicitClick && !isOnline) {
                        return;
                    }
                    var modalAssignEl = document.getElementById("modalAssignmentId");
                    if (modalAssignEl) modalAssignEl.textContent = "#DEL-" + String(assignmentId).padStart(5, "0");

                    var modalOrderEl = document.getElementById("modalOrderId");
                    if (modalOrderEl) modalOrderEl.textContent = "#ORD-" + String(order.id).padStart(5, "0");

                    var modalStatusEl = document.getElementById("modalOrderStatus");
                    if (modalStatusEl) modalStatusEl.textContent = order.status || "N/A";

                    var modalPayEl = document.getElementById("modalPaymentMode");
                    if (modalPayEl) modalPayEl.textContent = order.paymentMode || "STANDARD";

                    var modalTotEl = document.getElementById("modalOrderTotal");
                    if (modalTotEl) modalTotEl.textContent = order.totalAmount != null ? "₹" + order.totalAmount : "-";

                    var modalFeeEl = document.getElementById("modalDeliveryFee");
                    if (modalFeeEl) modalFeeEl.textContent = assignment.deliveryFee != null ? "₹" + assignment.deliveryFee : "₹0";

                    var modalPickEl = document.getElementById("modalPickupOtp");
                    if (modalPickEl) modalPickEl.textContent = assignment.pickupOtp || "-";

                    var modalDropEl = document.getElementById("modalDeliveryOtp");
                    if (modalDropEl) modalDropEl.textContent = assignment.deliveryOtp || "-";

                    var modalFromEl = document.getElementById("modalFromAddress");
                    if (modalFromEl) modalFromEl.textContent = normalizeAddress(order.distributorAddress || order.distributorShopName, "Warehouse / Distributor Location");

                    var modalToEl = document.getElementById("modalToAddress");
                    if (modalToEl) modalToEl.textContent = normalizeAddress(order.deliveryAddress || order.retailerLocation, "Retailer Store Location");

                    var itemsBody = document.getElementById("modalOrderItemsBody");
                    if (itemsBody) {
                        itemsBody.innerHTML = order.items && order.items.length
                            ? order.items.map(function(item) {
                                return "<tr>" +
                                    "<td class='fw-semibold'>" + (item.productName || "-") + "</td>" +
                                    "<td class='font-monospace text-muted'>" + (item.sku || "-") + "</td>" +
                                    "<td class='text-center fw-bold'>" + item.quantity + "</td>" +
                                    "<td class='text-end font-monospace'>₹" + (item.unitPrice || "0") + "</td>" +
                                    "<td class='text-end font-monospace fw-bold text-dark'>₹" + (item.lineTotal || "0") + "</td>" +
                                    "<td>" + (item.packSize || "-") + "</td>" +
                                    "<td>" + (item.weightKg != null ? item.weightKg + " kg" : "-") + "</td>" +
                                    "</tr>";
                            }).join("")
                            : "<tr><td colspan='7' class='text-center text-muted py-3'><fmt:message key="driver.modal.no_items"/></td></tr>";
                    }

                    var modalItemsCountEl = document.getElementById("modalItemsCount");
                    if (modalItemsCountEl) modalItemsCountEl.textContent = (order.items ? order.items.length : 0) + " Items";

                    if (!deliveryModal && typeof bootstrap !== 'undefined') {
                        deliveryModal = new bootstrap.Modal(modalElement);
                    }

                    var acceptBtn = document.getElementById('modalAcceptBtn');
                    if (acceptBtn) {
                        acceptBtn.onclick = function() { window.acceptDelivery(assignmentId); };
                    }
                    var rejectBtn = document.getElementById('modalRejectBtn');
                    if (rejectBtn) {
                        rejectBtn.onclick = function() { window.rejectDelivery(assignmentId); };
                    }

                    if (isExplicitClick || isOnline) {
                        if (deliveryModal) deliveryModal.show();
                    }
                })
                .catch(function() {
                    if (isExplicitClick) {
                        alert("<fmt:message key="driver.alert.load_details_failed"/>");
                    }
                });
        };

        window.acceptDelivery = function(assignmentId) {
            var confirmAccept = confirm("<fmt:message key="driver.alert.accept_confirm"/>");
            if (!confirmAccept) {
                return;
            }
            fetch("/api/v1/deliveries/" + assignmentId + "/accept", { method: "POST" })
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error("Failed to accept delivery");
                    }
                    return response.json();
                })
                .then(function() {
                    if (deliveryModal) {
                        try { deliveryModal.hide(); } catch(e) {}
                    }
                    loadStats();
                    loadActiveDeliveries();
                })
                .catch(function() {
                    alert("<fmt:message key="driver.alert.accept_failed"/>");
                });
        };

        window.rejectDelivery = function(assignmentId) {
            var reason = prompt("<fmt:message key="driver.alert.reject_prompt"/>", "<fmt:message key="driver.alert.reject_default_reason"/>");
            if (reason === null) {
                return;
            }
            fetch("/api/v1/deliveries/" + assignmentId + "/reject?reason=" + encodeURIComponent(reason), { method: "POST" })
                .then(function(response) {
                    if (!response.ok) {
                        throw new Error("Failed to reject delivery");
                    }
                    return response.text();
                })
                .then(function() {
                    if (deliveryModal) {
                        try { deliveryModal.hide(); } catch(e) {}
                    }
                    loadStats();
                    loadActiveDeliveries();
                })
                .catch(function() {
                    alert("<fmt:message key="driver.alert.reject_failed"/>");
                });
        };

        // Load active deliveries
        function loadActiveDeliveries() {
            fetch("/api/v1/driver/active-deliveries")
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    var rows = Array.isArray(data) ? data : (data.content || []);
                    activeDeliveries = rows;
                    var body = document.getElementById("activeDeliveriesBody");
                    if (!body) return;
                    if (rows.length === 0) {
                        body.innerHTML = "<tr><td colspan='8'>" +
                            "<div class='wm-empty-state'>" +
                            "  <i class='bi bi-inbox wm-empty-icon'></i>" + "<div class='fw-bold text-dark'><fmt:message key="driver.table.no_active"/></div>" + "<div class='small text-muted'><fmt:message key="driver.table.no_active_subtitle"/></div>" +
                            "</div></td></tr>";
                        return;
                    }
                    body.innerHTML = rows.map(function(d, i) {
                        var canRespond = d.status === 'ASSIGNED';
                        var badgeClass = 'wm-badge-assigned';
                        if (d.status === 'ACCEPTED') badgeClass = 'wm-badge-accepted';
                        else if (d.status === 'DELIVERED') badgeClass = 'wm-badge-delivered';
                        else if (d.status === 'IN_TRANSIT') badgeClass = 'wm-badge-intransit';

                        var actions = canRespond
                            ? "<button class='wm-btn-review' onclick='openDeliveryModal(" + d.id + ", true)'><i class='bi bi-eye'></i> <fmt:message key="btn.review"/></button>"
                            : "<span class='text-muted small font-monospace'><fmt:message key="home.in_progress"/></span>";

                        return "<tr>" +
                            "<td class='wm-col-seq font-monospace text-muted' data-label='#'>" + (i + 1) + "</td>" +
                            "<td class='wm-col-order' data-label='Order Reference'>" +
                                "<button type='button' class='btn btn-link p-0 text-decoration-none fw-bold font-monospace text-primary wm-order-clickable d-inline-flex align-items-center gap-1' onclick=\"showDriverOrderDetails('" + d.orderId + "', '" + d.id + "')\" title='Click to view full order address and details'>" +
                                    "#ORD-" + String(d.orderId).padStart(5, "0") +
                                    "<i class='bi bi-box-arrow-up-right small text-primary'></i>" +
                                "</button>" +
                            "</td>" +
                            "<td class='wm-col-status' data-label='Status'><span class='wm-badge-status " + badgeClass + "'><i class='bi bi-circle-fill' style='font-size:6px;'></i> " + (d.status || "N/A") + "</span></td>" +
                            "<td class='wm-col-pickup-otp' data-label='Pickup OTP'><span class='wm-otp-chip' onclick=\"wmDriverCopy('" + (d.pickupOtp || "") + "', 'Pickup OTP')\" title='Click to copy'>" + (d.pickupOtp || "-") + "</span></td>" +
                            "<td class='wm-col-delivery-otp' data-label='Delivery OTP'><span class='wm-otp-chip' onclick=\"wmDriverCopy('" + (d.deliveryOtp || "") + "', 'Delivery OTP')\" title='Click to copy'>" + (d.deliveryOtp || "-") + "</span></td>" +
                            "<td class='wm-col-fee' data-label='Delivery Fee'><span class='wm-fee-tag'>₹" + (d.deliveryFee || "0") + "</span></td>" +
                            "<td class='wm-col-date text-muted small' data-label='Assigned At'>" + (d.createdAt ? new Date(d.createdAt).toLocaleDateString() : "-") + "</td>" +
                            "<td class='wm-col-actions text-end' data-label='Actions'>" + actions + "</td>" +
                            "</tr>";
                    }).join("");

                    if (isOnline) {
                        var firstAssigned = rows.find(function(d) { return d.status === 'ASSIGNED'; });
                        if (firstAssigned && autoOpenedAssignmentId !== firstAssigned.id && !dismissedAssignments[firstAssigned.id]) {
                            autoOpenedAssignmentId = firstAssigned.id;
                            openDeliveryModal(firstAssigned.id, false);
                        }
                    }
                })
                .catch(function() {
                    var body = document.getElementById("activeDeliveriesBody");
                    if (body) {
                        body.innerHTML = "<tr><td colspan='8' class='text-center py-4 text-danger'><fmt:message key="driver.table.load_active_failed"/></td></tr>";
                    }
                });
        }

        // Load recent deliveries
        function loadRecentDeliveries() {
            fetch("/api/v1/deliveries?page=0&size=10")
                .then(function(r) { return r.json(); })
                .then(function(data) {
                    var rows = Array.isArray(data) ? data : (data.content || []);
                    var body = document.getElementById("recentDeliveriesBody");
                    if (!body) return;
                    if (rows.length === 0) {
                        body.innerHTML = "<tr><td colspan='6'>" +
                            "<div class='wm-empty-state py-4'>" +
                            "  <i class='bi bi-clock-history wm-empty-icon'></i>" + "<div class='fw-bold text-dark'><fmt:message key="driver.table.no_history"/></div>" + "<div class='small text-muted'><fmt:message key="driver.table.no_history_subtitle"/></div>" +
                            "</div></td></tr>";
                        return;
                    }
                    body.innerHTML = rows.map(function(d, i) {
                        var badgeClass = 'wm-badge-assigned';
                        if (d.status === 'ACCEPTED') badgeClass = 'wm-badge-accepted';
                        else if (d.status === 'DELIVERED') badgeClass = 'wm-badge-delivered';
                        else if (d.status === 'IN_TRANSIT') badgeClass = 'wm-badge-intransit';

                        return "<tr>" +
                            "<td class='font-monospace text-muted' data-label='#'>" + (i + 1) + "</td>" +
                            "<td data-label='Delivery ID'>" +
                                "<button type='button' class='btn btn-link p-0 text-decoration-none font-monospace fw-bold text-dark wm-delivery-clickable' onclick=\"showDriverOrderDetails('" + d.orderId + "', '" + d.id + "')\" title='Click to view delivery assignment'>" +
                                    "#DEL-" + String(d.id).padStart(5, "0") +
                                "</button>" +
                            "</td>" +
                            "<td data-label='Order ID'>" +
                                "<button type='button' class='btn btn-link p-0 text-decoration-none fw-bold font-monospace text-primary wm-order-clickable d-inline-flex align-items-center gap-1' onclick=\"showDriverOrderDetails('" + d.orderId + "', '" + d.id + "')\" title='Click to view full order address and details'>" +
                                    "#ORD-" + String(d.orderId).padStart(5, "0") +
                                    "<i class='bi bi-box-arrow-up-right small text-primary'></i>" +
                                "</button>" +
                            "</td>" +
                            "<td data-label='Status'><span class='wm-badge-status " + badgeClass + "'>" + (d.status || "N/A") + "</span></td>" +
                            "<td class='text-muted small' data-label='Date'>" + (d.createdAt ? new Date(d.createdAt).toLocaleDateString() : "-") + "</td>" +
                            "<td data-label='Fee'><span class='wm-fee-tag'>₹" + (d.deliveryFee || "0") + "</span></td>" +
                            "</tr>";
                    }).join("");
                })
                .catch(function() {
                    var body = document.getElementById("recentDeliveriesBody");
                    if (body) {
                        body.innerHTML = "<tr><td colspan='6' class='text-center py-4 text-danger'><fmt:message key="driver.table.load_history_failed"/></td></tr>";
                    }
                });
        }

        // Toggle online/offline
        var toggleBtn = document.getElementById("toggleOnlineBtn");
        if (toggleBtn) {
            toggleBtn.addEventListener("click", function() {
                getLocation();
                var btn = this;
                btn.disabled = true;
                if (isOnline) {
                    fetch("/api/v1/driver/go-offline", { method: "POST" })
                        .then(function() {
                            isOnline = false;
                            updateOnlineUI(false);
                            btn.disabled = false;
                            if (deliveryModal) {
                                try { deliveryModal.hide(); } catch(e) {}
                            }
                        })
                        .catch(function() { btn.disabled = false; });
                } else {
                    var lat = latitude || 0;
                    var lng = longitude || 0;
                    fetch("/api/v1/driver/go-online?latitude=" + lat + "&longitude=" + lng + "&vehicleType=", { method: "POST" })
                        .then(function() {
                            isOnline = true;
                            updateOnlineUI(true);
                            btn.disabled = false;
                        })
                        .catch(function() { btn.disabled = false; });
                }
            });
        }

        /* Hero Carousel Setup */
        function setupHeroCarousel() {
            var carousel = document.querySelector("[data-hero-carousel]");
            if (!carousel) return;

            var viewport = carousel.querySelector("[data-hero-viewport]");
            var track = carousel.querySelector("[data-hero-track]");
            var slides = Array.from(carousel.querySelectorAll("[data-hero-slide]"));
            var btnPrev = carousel.querySelector("[data-hero-prev]");
            var btnNext = carousel.querySelector("[data-hero-next]");
            var dotsEl = carousel.querySelector("[data-hero-dots]");

            if (!viewport || !track || slides.length === 0) return;

            if (dotsEl && dotsEl.children.length === 0) {
                dotsEl.innerHTML = slides.map(function (_, i) {
                    return '<button type="button" class="wm-hero-carousel-dot' + (i === 0 ? " is-active" : "") + '" data-hero-dot="' + i + '" aria-label="<fmt:message key="driver.hero.goto_slide"><fmt:param>' + (i + 1) + '</fmt:param></fmt:message>"></button>';
                }).join("");
            }

            var dots = dotsEl ? Array.from(dotsEl.querySelectorAll("[data-hero-dot]")) : [];
            var currentIndex = 0;
            var autoInterval = null;

            function getSlideWidth() {
                var firstSlide = slides[0];
                return firstSlide ? firstSlide.getBoundingClientRect().width : viewport.clientWidth;
            }

            function setActiveDot(index) {
                dots.forEach(function (d, i) {
                    d.classList.toggle("is-active", i === index);
                });
            }

            function scrollToIndex(index, smooth) {
                if (smooth === void 0) smooth = true;
                if (index < 0) index = slides.length - 1;
                if (index >= slides.length) index = 0;
                currentIndex = index;

                var width = getSlideWidth();
                viewport.scrollTo({
                    left: index * width,
                    behavior: smooth ? "smooth" : "auto"
                });
                setActiveDot(index);
            }

            function nextSlide() {
                scrollToIndex(currentIndex + 1, true);
            }

            function prevSlide() {
                scrollToIndex(currentIndex - 1, true);
            }

            if (btnNext) btnNext.addEventListener("click", function () {
                stopAuto();
                nextSlide();
                startAuto();
            });

            if (btnPrev) btnPrev.addEventListener("click", function () {
                stopAuto();
                prevSlide();
                startAuto();
            });

            dots.forEach(function (dot) {
                dot.addEventListener("click", function () {
                    var idx = parseInt(dot.getAttribute("data-hero-dot"), 10);
                    stopAuto();
                    scrollToIndex(idx, true);
                    startAuto();
                });
            });

            var scrollTimeout;
            viewport.addEventListener("scroll", function () {
                clearTimeout(scrollTimeout);
                scrollTimeout = setTimeout(function () {
                    var width = getSlideWidth();
                    if (!width) return;
                    var newIdx = Math.round(viewport.scrollLeft / width);
                    if (newIdx !== currentIndex && newIdx >= 0 && newIdx < slides.length) {
                        currentIndex = newIdx;
                        setActiveDot(newIdx);
                    }
                }, 80);
            }, { passive: true });

            function startAuto() {
                if (autoInterval) clearInterval(autoInterval);
                autoInterval = setInterval(nextSlide, 7000);
            }

            function stopAuto() {
                if (autoInterval) {
                    clearInterval(autoInterval);
                    autoInterval = null;
                }
            }

            carousel.addEventListener("mouseenter", stopAuto);
            carousel.addEventListener("mouseleave", startAuto);
            carousel.addEventListener("touchstart", stopAuto, { passive: true });
            carousel.addEventListener("touchend", startAuto, { passive: true });

            window.addEventListener("resize", function () {
                scrollToIndex(currentIndex, false);
            });

            startAuto();
        }

        setupHeroCarousel();
        loadStats();
        loadActiveDeliveries();
        loadRecentDeliveries();
        getLocation();

        // Auto-refresh every 15 seconds
        setInterval(function() {
            loadStats();
            loadActiveDeliveries();
        }, 15000);
    });
    </script>
    <%@ include file="/WEB-INF/common/driver-order-modal.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
