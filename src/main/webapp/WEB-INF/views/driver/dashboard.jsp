<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Driver Logistics & Dispatch Hub</title>

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

    <style>
        *, *::before, *::after {
            scrollbar-width: none !important;
            -ms-overflow-style: none !important;
        }

        *::-webkit-scrollbar,
        ::-webkit-scrollbar,
        html::-webkit-scrollbar,
        body::-webkit-scrollbar,
        div::-webkit-scrollbar,
        main::-webkit-scrollbar,
        section::-webkit-scrollbar,
        aside::-webkit-scrollbar,
        nav::-webkit-scrollbar,
        .wm-driver-table-wrap::-webkit-scrollbar,
        .table-responsive::-webkit-scrollbar {
            display: none !important;
            width: 0 !important;
            height: 0 !important;
            max-width: 0 !important;
            max-height: 0 !important;
            background: transparent !important;
            opacity: 0 !important;
            visibility: hidden !important;
        }

        /* Driver Dispatch Strip */
        .wm-driver-status-card {
            background: var(--wm-paper, #FFFDF7);
            border: 1px solid var(--wm-line, #D8D0B8);
            border-radius: var(--wm-radius, 6px);
            padding: 16px 22px;
            box-shadow: var(--wm-shadow);
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }

        .wm-status-indicator {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .wm-pulse-ring {
            width: 14px;
            height: 14px;
            border-radius: 50%;
            background: #94a3b8;
            position: relative;
            flex-shrink: 0;
        }

        .wm-pulse-ring.online {
            background: #10b981;
            box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7);
            animation: wm-status-pulse 2s infinite cubic-bezier(0.66, 0, 0, 1);
        }

        @keyframes wm-status-pulse {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7); }
            70% { box-shadow: 0 0 0 10px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        .wm-status-label {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--wm-ink, #20261F);
        }

        .wm-status-meta {
            font-size: 0.78rem;
            color: var(--wm-ink-soft, #5B6158);
            display: flex;
            gap: 14px;
            margin-top: 3px;
        }

        .wm-toggle-btn {
            font-family: var(--wm-font-mono, 'IBM Plex Mono', monospace);
            font-weight: 700;
            font-size: 0.85rem;
            padding: 10px 22px;
            border-radius: var(--wm-radius, 4px);
            border: 1px solid transparent;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .wm-toggle-btn.btn-online {
            background: var(--wm-dark, #1A2420);
            color: var(--wm-mint, #BFD8C4);
            box-shadow: 0 4px 14px rgba(26, 36, 32, 0.2);
        }

        .wm-toggle-btn.btn-online:hover {
            background: var(--wm-dark-soft, #26332C);
            transform: translateY(-1px);
        }

        .wm-toggle-btn.btn-offline {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }

        .wm-toggle-btn.btn-offline:hover {
            background: #fecaca;
        }

        /* KPI Bento Grid */
        .wm-driver-kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .wm-driver-kpi-card {
            background: var(--wm-paper, #FFFDF7);
            border: 1px solid var(--wm-line, #D8D0B8);
            border-radius: var(--wm-radius, 6px);
            padding: 18px 20px;
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            box-shadow: var(--wm-shadow);
            position: relative;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
        }

        .wm-driver-kpi-card:hover {
            transform: translateY(-2px);
            border-color: var(--wm-mint-deep, #4F8F6B);
        }

        .wm-driver-kpi-label {
            font-size: 0.74rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--wm-ink-soft, #5B6158);
            margin-bottom: 4px;
            font-family: var(--wm-font-mono, monospace);
        }

        .wm-driver-kpi-val {
            font-family: var(--wm-font-mono, monospace);
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--wm-ink, #20261F);
            line-height: 1.15;
            margin-bottom: 3px;
        }

        .wm-driver-kpi-sub {
            font-size: 0.74rem;
            color: var(--wm-ink-soft, #5B6158);
        }

        .wm-driver-icon-pill {
            width: 38px;
            height: 38px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            flex-shrink: 0;
            background: var(--wm-mint-pale, #E4EEE1);
            color: var(--wm-mint-deep, #4F8F6B);
        }

        .wm-driver-icon-pill.icon-dark {
            background: var(--wm-dark, #1A2420);
            color: var(--wm-mint, #BFD8C4);
        }

        .wm-driver-icon-pill.icon-amber {
            background: #fef3c7;
            color: #b45309;
        }

        /* OTP Chip & Status Tags */
        .wm-otp-chip {
            font-family: var(--wm-font-mono, monospace);
            font-weight: 700;
            font-size: 0.86rem;
            letter-spacing: 0.08em;
            padding: 4px 10px;
            border-radius: 4px;
            background: #f1f5f9;
            color: #0f172a;
            border: 1px solid #cbd5e1;
            display: inline-block;
        }

        .wm-fee-tag {
            font-family: var(--wm-font-mono, monospace);
            font-weight: 700;
            font-size: 0.95rem;
            color: var(--wm-success, #3F7D53);
        }

        .wm-badge-status {
            font-family: var(--wm-font-mono, monospace);
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 4px 10px;
            border-radius: 9999px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .wm-badge-assigned { background: #fef3c7; color: #b45309; border: 1px solid #fde68a; }
        .wm-badge-accepted { background: #dbeafe; color: #1d4ed8; border: 1px solid #bfdbfe; }
        .wm-badge-intransit { background: #e0e7ff; color: #4338ca; border: 1px solid #c7d2fe; }
        .wm-badge-delivered { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; }

        .wm-btn-review {
            font-family: var(--wm-font-mono, monospace);
            font-size: 0.8rem;
            font-weight: 700;
            background: var(--wm-dark, #1A2420);
            color: #ffffff;
            border: 1px solid transparent;
            padding: 6px 14px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.15s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .wm-btn-review:hover {
            background: var(--wm-dark-soft, #26332C);
            color: var(--wm-mint, #BFD8C4);
            transform: translateY(-1px);
        }

        /* Modal Styles */
        .wm-driver-modal .modal-content {
            border-radius: 12px;
            border: 1px solid var(--wm-line, #D8D0B8);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            background: var(--wm-paper, #FFFDF7);
        }

        .wm-driver-modal .modal-header {
            background: var(--wm-cream, #F6F2E7);
            border-bottom: 1px solid var(--wm-line, #D8D0B8);
            padding: 20px 24px;
        }

        .wm-driver-modal .modal-body {
            padding: 24px;
            background: var(--wm-paper, #FFFDF7);
        }

        .wm-route-card {
            background: #ffffff;
            border-radius: 8px;
            border: 1px solid var(--wm-line, #D8D0B8);
            padding: 16px;
            height: 100%;
        }

        .wm-route-icon-box {
            width: 38px;
            height: 38px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
            flex-shrink: 0;
        }

        .wm-route-pickup { background: #eff6ff; color: #2563eb; }
        .wm-route-dropoff { background: #ecfdf5; color: #16a34a; }

        .wm-info-pill-box {
            background: #ffffff;
            border: 1px solid var(--wm-line, #D8D0B8);
            border-radius: 8px;
            padding: 14px;
            text-align: center;
        }

        .wm-driver-modal .modal-footer {
            background: var(--wm-cream, #F6F2E7);
            border-top: 1px solid var(--wm-line, #D8D0B8);
            padding: 16px 24px;
        }

        .wm-btn-accept {
            background: var(--wm-success, #3F7D53);
            color: #ffffff;
            border: none;
            font-family: var(--wm-font-mono, monospace);
            font-weight: 700;
            padding: 10px 24px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.15s ease;
        }

        .wm-btn-accept:hover {
            background: #2e613f;
            transform: translateY(-1px);
        }

        .wm-btn-reject {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fca5a5;
            font-family: var(--wm-font-mono, monospace);
            font-weight: 600;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.15s ease;
        }

        .wm-btn-reject:hover {
            background: #fecaca;
        }

        .wm-empty-state {
            padding: 40px 20px;
            text-align: center;
            color: var(--wm-ink-soft, #5B6158);
        }

        .wm-empty-icon {
            font-size: 2.4rem;
            color: var(--wm-line, #D8D0B8);
            margin-bottom: 10px;
        }

        /* Mobile Card view for tables */
        @media (max-width: 768px) {
            .wm-driver-table-wrap {
                overflow: visible !important;
            }
            .wm-driver-table {
                display: block !important;
                width: 100% !important;
                border: none !important;
            }
            .wm-driver-table thead {
                display: none !important;
            }
            .wm-driver-table tbody {
                display: flex !important;
                flex-direction: column !important;
                gap: 14px !important;
                width: 100% !important;
            }
            .wm-driver-table tbody tr {
                display: block !important;
                width: 100% !important;
                background: #ffffff !important;
                border: 1px solid var(--wm-line, #D8D0B8) !important;
                border-radius: 8px !important;
                padding: 14px 16px !important;
                box-shadow: 0 2px 8px rgba(0,0,0,0.03) !important;
            }
            .wm-driver-table tbody td {
                display: flex !important;
                align-items: center !important;
                justify-content: space-between !important;
                padding: 8px 0 !important;
                border-bottom: 1px dashed var(--wm-line, #D8D0B8) !important;
                font-size: 0.88rem !important;
            }
            .wm-driver-table tbody td::before {
                content: attr(data-label);
                font-family: var(--wm-font-mono, monospace);
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                color: var(--wm-ink-soft, #5B6158);
            }
            .wm-driver-table tbody td:last-child {
                border-bottom: none !important;
                padding-top: 12px !important;
            }
            .wm-driver-table tbody td.wm-col-actions .wm-btn-review {
                width: 100% !important;
                justify-content: center !important;
                padding: 9px 16px !important;
            }
            .wm-driver-table tbody tr td[colspan] {
                display: block !important;
                border: none !important;
            }
            .wm-driver-table tbody tr td[colspan]::before {
                display: none !important;
            }
        }
    </style>
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
                                            <span class="wm-kicker"><span class="wm-live-dot"></span> DRIVER DISPATCH WORKSPACE</span>
                                            <h1 class="wm-home-title">Welcome back, <strong><%= wmUserName %></strong></h1>
                                            <p class="wm-home-subtitle">
                                                Monitor live delivery routes, accept incoming distributor assignments, verify customer OTPs, and track your daily payouts in real time.
                                            </p>
                                            <div class="wm-home-actions">
                                                <a class="home-btn home-btn-primary" href="${pageContext.request.contextPath}/web/driver/deliveries"><i class="bi bi-truck"></i> All Deliveries</a>
                                                <a class="home-btn home-btn-secondary" href="${pageContext.request.contextPath}/web/driver/earnings"><i class="bi bi-wallet2"></i> Earnings Report</a>
                                                <a class="home-btn home-btn-secondary" href="${pageContext.request.contextPath}/web/driver/ai-chat"><i class="bi bi-stars"></i> Logistics AI</a>
                                            </div>
                                        </div>

                                        <div class="wm-pulse-card">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <div>
                                                    <span class="wm-pulse-eyebrow">Driver Shift Performance</span>
                                                    <h3>Dispatch Snapshot</h3>
                                                </div>
                                                <div class="home-logo">AI</div>
                                            </div>
                                            <div id="driverPerformanceBrief">Loading active shift telemetries...</div>
                                            <hr>
                                            <div class="wm-pulse-stats">
                                                <div>
                                                    <h5 id="heroActiveDeliveries">0</h5>
                                                    <small>Active Trips</small>
                                                </div>
                                                <div>
                                                    <h5 id="heroTodayEarnings">₹0</h5>
                                                    <small>Today Payout</small>
                                                </div>
                                                <div>
                                                    <h5 id="heroCompletedTrips">0</h5>
                                                    <small>Completed</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </section>

                                <!-- Slide 2: Route GPS Optimization -->
                                <section class="wm-home-hero-slide" data-hero-slide="1">
                                    <div class="wm-home-hero-grid">
                                        <div class="wm-home-hero-copy">
                                            <span class="wm-kicker"><span class="wm-live-dot"></span> GPS ROUTE TRACKING</span>
                                            <h1 class="wm-home-title">Optimized Multi-Stop Delivery.</h1>
                                            <p class="wm-home-subtitle">
                                                Fast warehouse pickups from distributors and direct doorstep store deliveries with GPS navigation support.
                                            </p>
                                            <div class="wm-home-actions">
                                                <a class="home-btn home-btn-primary" href="${pageContext.request.contextPath}/web/driver/deliveries"><i class="bi bi-geo-alt"></i> View Routes</a>
                                                <a class="home-btn home-btn-secondary" href="${pageContext.request.contextPath}/web/driver/orders"><i class="bi bi-box-seam"></i> Assigned Orders</a>
                                            </div>
                                        </div>

                                        <div class="wm-pulse-card">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <div>
                                                    <span class="wm-pulse-eyebrow">Fleet Route Status</span>
                                                    <h3>GPS Telemetry</h3>
                                                </div>
                                                <div class="home-logo">GPS</div>
                                            </div>
                                            <div>Live satellite route mapping and real-time transit status enabled.</div>
                                            <hr>
                                            <div class="wm-pulse-stats">
                                                <div>
                                                    <h5 id="heroTotalDeliveries">0</h5>
                                                    <small>Lifetime</small>
                                                </div>
                                                <div>
                                                    <h5 id="heroTodayTrips">0</h5>
                                                    <small>Today Assigned</small>
                                                </div>
                                                <div>
                                                    <h5 id="heroTotalEarnings">₹0</h5>
                                                    <small>Total Balance</small>
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
                                        <span class="wm-live-pulse-dot"></span> Live Fleet Dispatch Hub
                                    </span>
                                    <h2 class="wm-operations-title">Driver Logistics & Delivery Route Tracking</h2>
                                    <p class="wm-operations-subtitle">
                                        Real-time GPS route optimization, instant pickup at distributor warehouses, and secure OTP verification at retailer stores.
                                    </p>
                                </div>
                                <div class="d-flex flex-wrap gap-2 mt-3">
                                    <a href="${pageContext.request.contextPath}/web/driver/deliveries" class="btn btn-sm btn-success fw-semibold"><i class="bi bi-truck me-1"></i> Active Deliveries</a>
                                    <a href="${pageContext.request.contextPath}/web/driver/earnings" class="btn btn-sm btn-primary fw-semibold"><i class="bi bi-wallet2 me-1"></i> View Payouts</a>
                                    <a href="${pageContext.request.contextPath}/web/driver/ai-chat" class="btn btn-sm btn-warning text-dark fw-semibold"><i class="bi bi-stars me-1"></i> Logistics AI Assistant</a>
                                </div>
                            </div>
                        </div>
                        
                        <div class="wm-operations-telemetry-grid">
                            <div class="wm-telemetry-card">
                                <div class="wm-telemetry-icon inventory">
                                    <i class="bi bi-boxes"></i>
                                </div>
                                <div class="wm-telemetry-content">
                                    <h5>Warehouse Pickups</h5>
                                    <small>Ready at Distributor Hubs</small>
                                </div>
                            </div>
                            <div class="wm-telemetry-card">
                                <div class="wm-telemetry-icon orders">
                                    <i class="bi bi-geo-alt"></i>
                                </div>
                                <div class="wm-telemetry-content">
                                    <h5>GPS Route Nav</h5>
                                    <small>Optimized Multi-Stop Delivery</small>
                                </div>
                            </div>
                            <div class="wm-telemetry-card">
                                <div class="wm-telemetry-icon delivery">
                                    <i class="bi bi-check-circle"></i>
                                </div>
                                <div class="wm-telemetry-content">
                                    <h5>OTP Verified</h5>
                                    <small>Instant Secure Handover</small>
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
                            <div class="wm-status-label" id="onlineText">Checking dispatch channel status...</div>
                            <div class="wm-status-meta">
                                <span><i class="bi bi-broadcast text-primary"></i> Dispatch Channel</span>
                                <span><i class="bi bi-crosshair text-success"></i> GPS Tracker Active</span>
                                <span class="d-none d-sm-inline"><i class="bi bi-clock-history"></i> Syncing every 15s</span>
                            </div>
                        </div>
                    </div>
                    <div>
                        <button id="toggleOnlineBtn" class="wm-toggle-btn btn-online">
                            <i class="bi bi-power"></i> Go Online
                        </button>
                    </div>
                </section>

                <!-- ===================================================== -->
                <!-- 4. KPI METRICS OVERVIEW -->
                <!-- ===================================================== -->
                <section class="wm-driver-kpi-grid" aria-label="Delivery Statistics">
                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label">Total Deliveries</div>
                            <div class="wm-driver-kpi-val" id="statTotalDeliveries">0</div>
                            <div class="wm-driver-kpi-sub">Lifetime Trips</div>
                        </div>
                        <div class="wm-driver-icon-pill icon-dark"><i class="bi bi-truck"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label">Completed</div>
                            <div class="wm-driver-kpi-val text-success" id="statCompleted">0</div>
                            <div class="wm-driver-kpi-sub">Verified & Closed</div>
                        </div>
                        <div class="wm-driver-icon-pill"><i class="bi bi-check2-circle"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label">Active Orders</div>
                            <div class="wm-driver-kpi-val text-warning" id="statActive">0</div>
                            <div class="wm-driver-kpi-sub">Assigned / In Transit</div>
                        </div>
                        <div class="wm-driver-icon-pill icon-amber"><i class="bi bi-hourglass-split"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label">Today's Trips</div>
                            <div class="wm-driver-kpi-val" id="statToday">0</div>
                            <div class="wm-driver-kpi-sub">Assigned Today</div>
                        </div>
                        <div class="wm-driver-icon-pill icon-dark"><i class="bi bi-calendar2-check"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label">Today's Earnings</div>
                            <div class="wm-driver-kpi-val text-success" id="statEarnings">₹0</div>
                            <div class="wm-driver-kpi-sub">Calculated Payout</div>
                        </div>
                        <div class="wm-driver-icon-pill"><i class="bi bi-currency-rupee"></i></div>
                    </div>

                    <div class="wm-driver-kpi-card">
                        <div>
                            <div class="wm-driver-kpi-label">Total Earnings</div>
                            <div class="wm-driver-kpi-val" id="statTotalEarnings">₹0</div>
                            <div class="wm-driver-kpi-sub">Accumulated Balance</div>
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
                            <span class="wm-kicker"><span class="wm-live-dot"></span> LIVE DISPATCH QUEUE</span>
                            <h2>Active Delivery Assignments</h2>
                            <p>Live incoming assignments requiring your acceptance, pickup, or delivery OTP.</p>
                        </div>
                        <span class="home-pill">REAL-TIME</span>
                    </div>

                    <div class="wm-card">
                        <div class="wm-driver-table-wrap">
                            <table class="wm-table wm-driver-table table table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Order Reference</th>
                                        <th>Status</th>
                                        <th>Pickup OTP</th>
                                        <th>Delivery OTP</th>
                                        <th>Delivery Fee</th>
                                        <th>Assigned At</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="activeDeliveriesBody">
                                    <tr>
                                        <td colspan="8">
                                            <div class="wm-empty-state">
                                                <div class="spinner-border text-success mb-2" role="status" style="width: 1.8rem; height: 1.8rem;"></div>
                                                <div>Loading active deliveries...</div>
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
                            <span class="wm-kicker">LEDGER ARCHIVE</span>
                            <h2>Recent Delivery History</h2>
                            <p>Recent trip completions, assigned tasks, and settlement verifications.</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/web/driver/deliveries" class="home-btn home-btn-secondary py-1 px-3">
                            View Full Ledger <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>

                    <div class="wm-card">
                        <div class="wm-driver-table-wrap">
                            <table class="wm-table wm-driver-table table table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Delivery ID</th>
                                        <th>Order ID</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                        <th>Fee</th>
                                    </tr>
                                </thead>
                                <tbody id="recentDeliveriesBody">
                                    <tr>
                                        <td colspan="6">
                                            <div class="wm-empty-state">
                                                <div class="spinner-border text-secondary mb-2" role="status" style="width: 1.8rem; height: 1.8rem;"></div>
                                                <div>Loading recent deliveries...</div>
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
                                <span>Review pickup warehouse and drop-off retailer details before accepting</span>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
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
                                            <i class="bi bi-box-arrow-up me-1"></i> STEP 1: PICKUP HUB
                                        </span>
                                        <h6 class="fw-bold mb-1 mt-1 text-dark">Distributor / Warehouse</h6>
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
                                            <i class="bi bi-geo-alt-fill me-1"></i> STEP 2: DROP-OFF LOCATION
                                        </span>
                                        <h6 class="fw-bold mb-1 mt-1 text-dark">Retailer / Storefront</h6>
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
                                <div class="wm-metric-label">Driver Fee</div>
                                <h3 class="wm-metric-value text-success" id="modalDeliveryFee">₹0</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-wallet2 text-success me-1"></i> Direct bank credit</div>
                            </div>
                        </div>

                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="wm-metric-label">Order Total</div>
                                <h3 class="wm-metric-value text-dark" id="modalOrderTotal">₹0</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-credit-card me-1"></i> Order bill value</div>
                            </div>
                        </div>

                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="wm-metric-label">Pickup OTP</div>
                                <h3 class="wm-metric-value text-dark letter-spacing-1" id="modalPickupOtp">-</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-shield-check text-warning me-1"></i> Share at pickup</div>
                            </div>
                        </div>

                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="wm-metric-label">Delivery OTP</div>
                                <h3 class="wm-metric-value text-success letter-spacing-1" id="modalDeliveryOtp">-</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-key text-success me-1"></i> Verify with retailer</div>
                            </div>
                        </div>
                    </div>

                    <!-- Items Manifest -->
                    <div class="wm-modal-manifest">
                        <div class="wm-modal-manifest-head">
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-box-seam-fill text-primary"></i>
                                <h6 class="fw-bold mb-0 text-dark" style="font-family: var(--font-display);">
                                    Order Manifest & Packages
                                </h6>
                            </div>
                            <span class="badge bg-dark rounded-pill font-monospace" id="modalItemsCount">0 Items</span>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th>Product</th>
                                        <th>SKU</th>
                                        <th class="text-center">Qty</th>
                                        <th class="text-end">Price</th>
                                        <th class="text-end">Total</th>
                                        <th>Pack Size</th>
                                        <th>Weight</th>
                                    </tr>
                                </thead>
                                <tbody id="modalOrderItemsBody">
                                    <tr><td colspan="7" class="text-center py-3 text-muted">No item details available.</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>

                <!-- Footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary rounded-pill px-4 wm-mobile-footer-btn" data-bs-dismiss="modal">
                        <i class="bi bi-x-lg me-1"></i> Close
                    </button>
                    <div class="d-flex gap-2 w-100-mobile">
                        <button type="button" class="btn btn-outline-danger rounded-pill px-4 fw-semibold wm-mobile-footer-btn flex-grow-1" id="modalRejectBtn">
                            <i class="bi bi-x-circle me-1"></i> Reject Order
                        </button>
                        <button type="button" class="btn btn-success rounded-pill px-4 fw-semibold d-inline-flex align-items-center justify-content-center gap-2 wm-mobile-footer-btn flex-grow-1" id="modalAcceptBtn">
                            <i class="bi bi-check2-circle"></i> Accept Delivery
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
                if (txt) txt.textContent = "You are ONLINE - Ready to receive delivery assignments";
                if (btn) {
                    btn.innerHTML = '<i class="bi bi-power"></i> Go Offline';
                    btn.className = "wm-toggle-btn btn-offline";
                }
            } else {
                if (dot) dot.className = "wm-pulse-ring";
                if (txt) txt.textContent = "You are OFFLINE - Not receiving new delivery requests";
                if (btn) {
                    btn.innerHTML = '<i class="bi bi-power"></i> Go Online';
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
                            brief.textContent = "You have " + activeCount + " active delivery in queue. Today's payout is ₹" + todayEarn + ".";
                        } else {
                            brief.textContent = "All queues clear. Keep your status Online to receive automatic distributor assignments.";
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
                    alert("Delivery assignment not found.");
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
                            : "<tr><td colspan='7' class='text-center text-muted py-3'>No item details available.</td></tr>";
                    }

                    var modalItemsCountEl = document.getElementById("modalItemsCount");
                    if (modalItemsCountEl) modalItemsCountEl.textContent = (order.items ? order.items.length : 0) + " Items";

                    if (!deliveryModal && typeof bootstrap !== 'undefined') {
                        deliveryModal = new bootstrap.Modal(document.getElementById('driverDeliveryModal'));
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
                        alert("Unable to load delivery details. Please try again.");
                    }
                });
        };

        window.acceptDelivery = function(assignmentId) {
            var confirmAccept = confirm("Accept this delivery assignment and start routing?");
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
                    alert("Unable to accept delivery. Please try again.");
                });
        };

        window.rejectDelivery = function(assignmentId) {
            var reason = prompt("Enter rejection reason (optional):", "Vehicle unavailable / Route busy");
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
                    alert("Unable to reject delivery. Please try again.");
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
                            "  <i class='bi bi-inbox wm-empty-icon'></i>" +
                            "  <div class='fw-bold text-dark'>No active deliveries in queue</div>" +
                            "  <div class='small text-muted'>Keep your status set to ONLINE to receive automatic dispatch assignments.</div>" +
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
                            ? "<button class='wm-btn-review' onclick='openDeliveryModal(" + d.id + ", true)'><i class='bi bi-eye'></i> Review</button>"
                            : "<span class='text-muted small font-monospace'>In Progress</span>";

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
                        body.innerHTML = "<tr><td colspan='8' class='text-center py-4 text-danger'>Unable to load active deliveries from database.</td></tr>";
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
                            "  <i class='bi bi-clock-history wm-empty-icon'></i>" +
                            "  <div class='fw-bold text-dark'>No historical deliveries yet</div>" +
                            "  <div class='small text-muted'>Completed and logged deliveries will be cataloged here.</div>" +
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
                        body.innerHTML = "<tr><td colspan='6' class='text-center py-4 text-danger'>Unable to load delivery history.</td></tr>";
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
                    return '<button type="button" class="wm-hero-carousel-dot' + (i === 0 ? " is-active" : "") + '" data-hero-dot="' + i + '" aria-label="Go to slide ' + (i + 1) + '"></button>';
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
