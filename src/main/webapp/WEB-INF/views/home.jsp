<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Local B2B Marketplace</title>
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
    <!-- Removed non-existent style.css (home page already has home.css/common.css/header.css/login.css/footer.css) -->
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
                    <span class="badge wm-section-badge"><i class="bi bi-stars" aria-hidden="true"></i> AI Powered Local B2B Marketplace</span>
                    <h1 class="wm-hero-title">Wholesale ordering that keeps local commerce moving.</h1>
                    <p class="wm-hero-subtitle">
                        WholeMart connects retailers, distributors, drivers and
                        administrators into one intelligent operating platform
                        for ordering, inventory, delivery, credit and AI powered
                        business decisions &mdash; built for how wholesale actually runs.
                    </p>
                    <div class="d-flex flex-wrap gap-3 mt-4">
                        <a href="${pageContext.request.contextPath}/web/auth/login" class="btn wm-btn-primary">Start Now</a>
                        <a href="#roles" class="btn wm-btn-outline">Choose Workspace</a>
                    </div>                   
                </div>
                <div class="col-lg-6">
                    <div class="wm-hero-image">
                        <img src="${pageContext.request.contextPath}/images/logo/wholemart-home-hero.png"
                             class="img-fluid"
                             alt="WholeMart operations dashboard showing live inventory, orders and delivery status">
                        <div class="wm-mini-card-container">
                    <div class="wm-mini-card">
                        <h6><i class="bi bi-arrow-repeat" aria-hidden="true"></i> Inventory Sync</h6>
                        <small>Real-time stock updates across all branches.</small>
                    </div>
                    <div class="wm-mini-card">
                        <h6><i class="bi bi-signpost-split" aria-hidden="true"></i> Smart Logistics</h6>
                        <small>AI-optimized delivery routes for faster dispatch.</small>
                    </div>
                    <div class="wm-mini-card">
                        <h6><i class="bi bi-graph-up-arrow" aria-hidden="true"></i> Actionable Insights</h6>
                        <small>AI-powered sales analytics and demand forecasting.</small>
                    </div>
                    </div>
                </div>
            </div>            
        </div>
    </section>
    <section id="how-it-works">
        <div class="how-card">
            <div class="how-head">
                <span class="eyebrow">How It Works</span>
                <h2>Simple Steps to Scale Your Business</h2>
                <p>Whether you're buying, selling, or delivering — WholeMart simplifies every step of your wholesale business.</p>
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
                    <h4>Register</h4>
                    <p>Create your account and select your business role.</p>
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
                    <h4>Connect</h4>
                    <p>Browse distributors, discover products and establish trusted relationships.</p>
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
                    <h4>Order</h4>
                    <p>Place wholesale orders, monitor payments and receive AI recommendations.</p>
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
                    <h4>Deliver</h4>
                    <p>Drivers deliver orders while customers receive live updates.</p>
                </div>

            </div>
        </div>
    </section>
    <section id="snapshot">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="card shadow-sm border-0 rounded-4">
                        <div class="card-header bg-white border-0 pt-4">
                            <h4 class="fw-bold text-center">
                                Business Snapshot
                            </h4>
                        </div>
                        <div class="card-body px-lg-4">
                            <div class="row g-4">
                                <div class="col-lg-3 col-md-6">
                                    <canvas id="salesDoughnutChart" role="img" aria-label="Sales channel breakdown: online vs offline sales"></canvas>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <canvas id="salesTrendChart" role="img" aria-label="Monthly sales trend, January through June"></canvas>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <canvas id="activityBarChart" role="img" aria-label="Activity count across distributors, retailers, cities covered, orders fulfilled and new retailers"></canvas>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <canvas id="expiryManagementChart" role="img" aria-label="AI expiry management: value saved versus value at risk"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="roles">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge">ROLE BASED EXPERIENCE</span>
                <h2 class="wm-section-title">One Platform. Four Powerful Workspaces.</h2>
                <p class="wm-section-subtitle">
                    Every user gets a personalized dashboard designed for
                    their daily work&mdash;from ordering inventory to managing
                    deliveries and monitoring marketplace operations.
                </p>
            </div>

            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="wm-role-card h-100">
                        <h4>Admin</h4>
                        <p>Manage approvals, monitor activity, verify, control users and keep the marketplace healthy.</p>
                        <a href="${pageContext.request.contextPath}/web/auth/login?role=admin" class="btn wm-btn-primary w-100 mt-4">Admin Login</a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="wm-role-card h-100">
                        <h4>Retailer</h4>
                        <p>Search distributors, compare prices, place wholesale orders and monitor dues.</p>
                        <a href="${pageContext.request.contextPath}/web/auth/login?role=retailer" class="btn wm-btn-primary w-100 mt-4">Retailer Login</a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="wm-role-card h-100">
                        <h4>Distributor</h4>
                        <p>Manage products, inventory, wholesale pricing, payments and delivery requests.</p>
                        <a href="${pageContext.request.contextPath}/web/auth/login?role=distributor" class="btn wm-btn-primary w-100 mt-4">Distributor Login</a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <div class="wm-role-card h-100">
                        <h4>Driver</h4>
                        <p>View assigned deliveries, update order status, optimize delivery routes and track earnings.</p>
                        <a href="${pageContext.request.contextPath}/web/auth/login?role=driver" class="btn wm-btn-primary w-100 mt-4">Driver Login</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- OPERATIONS -->
    <!-- ===================================================== -->
    <section id="operations">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge">DAILY OPERATIONS</span>
                <h2 class="wm-section-title">Built For The Work After The Order Is Placed</h2>
                <p class="wm-section-subtitle">
                    WholeMart keeps inventory, approvals, payments,
                    deliveries and AI recommendations connected
                    inside one operational dashboard.
                </p>
            </div>

            <div class="row g-4">
                <div class="col-lg-7">
                    <div class="wm-dashboard h-100">
                        <div class="wm-dashboard-header">
                            <h4>Today's Operations</h4>
                            <span class="badge bg-transparent text-dark fw-normal"><span class="badge bg-success text-white">LIVE</span></span>
                        </div>
                        <div class="wm-dashboard-item">
                            <div class="wm-dashboard-icon"><i class="bi bi-box-seam" aria-hidden="true"></i></div>
                            <div class="wm-dashboard-content">
                                <h5>Low Stock Products <small class="text-muted fw-normal">(17 items)</small></h5>
                            </div>
                            <span class="badge bg-warning">Inventory</span>
                        </div>
                        <div class="wm-dashboard-item">
                            <div class="wm-dashboard-icon"><i class="bi bi-person-check" aria-hidden="true"></i></div>
                            <div class="wm-dashboard-content">
                                <h5>Distributor Approval <small class="text-muted fw-normal">(5 pending)</small></h5>
                            </div>
                            <span class="badge bg-info">Pending</span>
                        </div>
                        <div class="wm-dashboard-item">
                            <div class="wm-dashboard-icon"><i class="bi bi-credit-card" aria-hidden="true"></i></div>
                            <div class="wm-dashboard-content">
                                <h5>Retailer Payments <small class="text-muted fw-normal">(₹2.8L due)</small></h5>
                            </div>
                            <span class="badge bg-primary">Finance</span>
                        </div>
                        <div class="wm-dashboard-item">
                            <div class="wm-dashboard-icon"><i class="bi bi-truck" aria-hidden="true"></i></div>
                            <div class="wm-dashboard-content">
                                <h5>Driver Deliveries <small class="text-muted fw-normal">(38 in progress)</small></h5>
                            </div>
                            <span class="badge bg-success">Delivery</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5">
                    <div class="wm-ai-panel h-100">
                        <div class="wm-ai-header">
                            <i class="bi bi-robot" aria-hidden="true"></i>
                            <h4>AI Assistant</h4>
                            <span class="live-indicator" aria-hidden="true"></span>
                        </div>
                        <p>WholeMart AI continuously monitors your marketplace and recommends actions.</p>

                        <div class="wm-ai-priority high"><i class="bi bi-fire" aria-hidden="true"></i> High Priority</div>
                        <a href="#" class="wm-ai-card text-decoration-none text-white">
                            <i class="bi bi-box-seam fs-4" aria-hidden="true"></i>
                            <div class="wm-ai-card-content">
                                <div>Recommend reorder for 17 products</div>
                                <small class="wm-ai-card-action">Generate Purchase Order &rarr;</small>
                            </div>
                        </a>
                        <a href="#" class="wm-ai-card text-decoration-none text-white mt-2">
                            <i class="bi bi-sign-merge-right fs-4" aria-hidden="true"></i>
                            <div class="wm-ai-card-content">
                                <div>Optimize tomorrow's delivery routes</div>
                                <small class="wm-ai-card-action">Open Route Planner &rarr;</small>
                            </div>
                        </a>

                        <div class="wm-ai-stats row g-3 text-center mt-4">
                            <div class="col-6 col-md-3 wm-ai-stat">
                                <h6>94%</h6>
                                <small class="text-white-50">AI Health</small>
                            </div>
                            <div class="col-6 col-md-3 wm-ai-stat">
                                <h6>96%</h6>
                                <small class="text-white-50">Forecast Accuracy</small>
                            </div>
                            <div class="col-6 col-md-3 wm-ai-stat">
                                <h6>24</h6>
                                <small class="text-white-50">Recommendations</small>
                            </div>
                            <div class="col-6 col-md-3 wm-ai-stat">
                                <h6>&#8377;3.4L</h6>
                                <small class="text-white-50">Inventory Saved</small>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/web/auth/login" class="btn btn-light w-100 mt-4">Open AI Workspace</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- FEATURES & PROCESS -->
    <!-- ===================================================== -->
    <section id="features" class="bg-light">
        <div class="container">
            <div id="features-content">
                <!-- WHY WHOLEMART -->
                <div id="why-content">
                    <div class="text-center mb-5">
                        <h2 class="wm-section-title">The Complete Wholesale Operating System</h2>
                        <p class="wm-section-subtitle">Powerful tools built for retailers, distributors, delivery partners and administrators to manage the complete wholesale lifecycle.</p>
                    </div>
                    <div class="row g-4">
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon"><i class="bi bi-box-seam" aria-hidden="true"></i></div>
                                <h4>Smart Inventory</h4>
                                <p>AI predicts inventory shortages, recommends reorder quantities and prevents stock-outs before they happen.</p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Low stock alerts</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Auto reorder suggestions</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Product forecasting</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon bg-success-subtle"><i class="bi bi-wallet2" aria-hidden="true"></i></div>
                                <h4>Digital Credit Ledger</h4>
                                <p>Keep retailer dues, distributor collections, and payment history synchronized automatically.</p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Credit tracking</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Payment reminders</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Digital statements</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon bg-warning-subtle"><i class="bi bi-truck" aria-hidden="true"></i></div>
                                <h4>Smart Delivery</h4>
                                <p>Assign deliveries, optimize routes and track every shipment in real time.</p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Live tracking</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Driver assignment</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Route optimization</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon icon-lavender"><i class="bi bi-cart-check" aria-hidden="true"></i></div>
                                <h4>Order Management</h4>
                                <p>From quote to dispatch &mdash; approvals, revisions and order history stay in one thread instead of scattered calls.</p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Bulk order builder</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Approval workflows</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Full order history</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon icon-pink"><i class="bi bi-diagram-3" aria-hidden="true"></i></div>
                                <h4>Multi-Branch Support</h4>
                                <p>Run several outlets or godowns under one account with branch-level stock, staff and pricing control.</p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Branch-wise inventory</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Role-based staff access</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Consolidated reporting</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <div class="wm-card h-100">
                                <div class="wm-feature-icon icon-mint"><i class="bi bi-graph-up-arrow" aria-hidden="true"></i></div>
                                <h4>Business Intelligence</h4>
                                <p>Understand demand, margins and slow-moving stock with reports built for wholesale, not generic retail.</p>
                                <ul class="wm-feature-list">
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Sales &amp; margin trends</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Slow-mover flags</li>
                                    <li><i class="bi bi-check-circle-fill" aria-hidden="true"></i> Exportable reports</li>
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
    <section id="distributor-benefits" class="bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge">DISTRIBUTOR ADVANTAGE</span>
                <h2 class="wm-section-title">Grow Your Distribution Network Faster</h2>
                <p class="wm-section-subtitle">
                    See how joining WholeMart helps distributors expand their reach, increase sales, and streamline operations.
                </p>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-lg-4 col-md-6">
                    <div class="wm-stat-card h-100">
                        <span class="wm-stat-label">Wider Market Reach</span>
                        <h3>Connect with 800+ Retailers Instantly</h3>
                        <div class="wm-snapshot-bar-bg"><div class="wm-snapshot-bar bar-blue" style="--w: 70;"></div></div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="wm-stat-card h-100">
                        <span class="wm-stat-label">Up to 25% Sales Growth</span>
                        <h3>Increase Your Order Volume</h3>
                        <div class="wm-snapshot-bar-bg"><div class="wm-snapshot-bar bar-green" style="--w: 85;"></div></div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="wm-stat-card h-100">
                        <span class="wm-stat-label">Faster Payment Cycles</span>
                        <h3>Reduce Credit Reconciliation Time</h3>
                        <div class="wm-snapshot-bar-bg"><div class="wm-snapshot-bar bar-red" style="--w: 60;"></div></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- TESTIMONIALS -->
    <!-- ===================================================== -->
    <section id="testimonials" class="bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge">FROM THE FLOOR</span>
                <h2 class="wm-section-title">What Running On WholeMart Looks Like</h2>
                <p class="wm-section-subtitle">Real day-to-day moments from the four roles WholeMart is built around.</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="wm-testimonial-card h-100 shadow-sm">
                        <i class="bi bi-quote" aria-hidden="true"></i>
                        <p>Month-end reconciliation used to take three days of matching bahi-khata entries. Now the ledger is already settled by the time I sit down.</p>
                        <div class="wm-testimonial-who">
                            <div class="wm-testimonial-avatar bg-success-subtle text-success"><i class="bi bi-shop" aria-hidden="true"></i></div>
                            <div><strong>Retailer</strong><span>Kirana store owner, 3 branches</span></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="wm-testimonial-card h-100 shadow-sm">
                        <i class="bi bi-quote" aria-hidden="true"></i>
                        <p>The AI flagged a stock-out on a fast-moving SKU three days before it would have cost us a repeat order. That alone paid for the switch.</p>
                        <div class="wm-testimonial-who">
                            <div class="wm-testimonial-avatar bg-warning-subtle text-warning"><i class="bi bi-box-seam" aria-hidden="true"></i></div>
                            <div><strong>Distributor</strong><span>Regional FMCG supplier</span></div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="wm-testimonial-card h-100 shadow-sm">
                        <i class="bi bi-quote" aria-hidden="true"></i>
                        <p>My route is already planned before I start the engine, and updating a delivery status takes one tap, not a phone call back to the office.</p>
                        <div class="wm-testimonial-who">
                            <div class="wm-testimonial-avatar bg-danger-subtle text-danger"><i class="bi bi-truck" aria-hidden="true"></i></div>
                            <div><strong>Driver</strong><span>Local delivery partner</span></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================== -->
    <!-- FAQ -->
    <!-- ===================================================== -->
    <section id="faq">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge">FREQUENTLY ASKED QUESTIONS</span>
                <h2 class="wm-section-title">Everything You Need To Know</h2>
                <p class="wm-section-subtitle">
                    Find answers to common questions about WholeMart,
                    onboarding, ordering, delivery and AI-powered operations.
                </p>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-9">
                    <div class="accordion" id="faqAccordion">

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button" data-bs-toggle="collapse" data-bs-target="#faq1" aria-expanded="true" aria-controls="faq1">
                                    Who can use WholeMart?
                                </button>
                            </h2>
                            <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">WholeMart is designed for retailers, distributors, delivery partners and marketplace administrators.</div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq2" aria-expanded="false" aria-controls="faq2">
                                    Can retailers buy from multiple distributors?
                                </button>
                            </h2>
                            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">Yes. Retailers can compare distributors, prices and availability before placing wholesale orders.</div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq3" aria-expanded="false" aria-controls="faq3">
                                    Does WholeMart support AI recommendations?
                                </button>
                            </h2>
                            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">Yes. AI helps predict demand, optimize inventory, recommend reorders and improve delivery efficiency.</div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq4" aria-expanded="false" aria-controls="faq4">
                                    Is delivery tracking available?
                                </button>
                            </h2>
                            <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">Yes. Drivers can update delivery status while retailers and distributors can track orders in real time.</div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq5" aria-expanded="false" aria-controls="faq5">
                                    How is my business data kept secure?
                                </button>
                            </h2>
                            <div id="faq5" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">All data is encrypted in transit and at rest, access is role-based, and every critical action is recorded in an audit log.</div>
                            </div>
                        </div>

                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq6" aria-expanded="false" aria-controls="faq6">
                                    Can I run more than one branch or godown under one account?
                                </button>
                            </h2>
                            <div id="faq6" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">Yes. Multi-branch support keeps stock, staff access and pricing separate per location while reporting rolls up to one account.</div>
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
    <section class="wm-security-section bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <span class="badge wm-section-badge">ENTERPRISE GRADE</span>
                <h2 class="wm-section-title">Secure, Compliant, and Reliable</h2>
                <p class="wm-section-subtitle">Built on a foundation of trust and security to protect your business data and operations.</p>
            </div>
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <div class="wm-security-tile">
                        <div class="icon"><i class="bi bi-shield-lock" aria-hidden="true"></i></div>
                        <h6>Role-Based Access</h6>
                        <p class="text-muted small">Ensure users only see data and tools relevant to their role.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="wm-security-tile">
                        <div class="icon"><i class="bi bi-key" aria-hidden="true"></i></div>
                        <h6>Data Encryption</h6>
                        <p class="text-muted small">All data is encrypted at rest and in transit using industry standards.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="wm-security-tile">
                        <div class="icon"><i class="bi bi-journal-check" aria-hidden="true"></i></div>
                        <h6>Audit Logs</h6>
                        <p class="text-muted small">Maintain a complete, immutable record of all critical platform activities.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="wm-security-tile">
                        <div class="icon"><i class="bi bi-cloud-arrow-up" aria-hidden="true"></i></div>
                        <h6>99.9% Uptime SLA</h6>
                        <p class="text-muted small">Rely on a highly available platform backed by a service-level agreement.</p>
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
                <h2>Ready To Modernize Your Wholesale Business?</h2>
                <p>Join retailers, distributors and delivery partners using WholeMart to simplify operations and grow faster.</p>
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/web/auth/login" class="btn wm-btn-primary btn-lg">Continue To Login</a>
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
<script>
    // --- Login Form Submission Logic ---
    const loginModal = document.getElementById('loginModal');

    function openLoginPopup() {
        if (loginModal) {
            loginModal.style.display = 'flex';
        }
    }

    function closeLoginPopup() {
        if (loginModal) {
            loginModal.style.display = 'none';
        }
    }

    // Close modal if user clicks outside of the modal content
    window.onclick = function(event) {
        if (event.target == loginModal) {
            closeLoginPopup();
        }
    }
    const loginPopupForm = document.getElementById('loginPopupForm');
    if (loginPopupForm) {
        loginPopupForm.addEventListener('submit', async function(e) {
        e.preventDefault();
        const loginData = {
            email: document.getElementById('popup_email').value,
            password: document.getElementById('popup_password').value
        };
        const popupMessageArea = document.getElementById('popup_message-area');
        popupMessageArea.textContent = '';
        popupMessageArea.className = 'message';

        try {
            const response = await fetch('/api/v1/login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(loginData),
            });
            const responseData = await response.json();
            if (response.ok && responseData.token) {
                localStorage.setItem('jwt_token', responseData.token);
                window.location.href = '/dashboard'; // Redirect to dashboard on success
            } else {
                const errorMessage = responseData.message || 'Invalid credentials';
                popupMessageArea.textContent = `Error: ${errorMessage}`;
                popupMessageArea.classList.add('error');
            }
        } catch (error) {
            console.error('Login failed:', error);
            popupMessageArea.textContent = 'Login failed. Please try again later.';
            popupMessageArea.classList.add('error');
        }
    });
    }

    // Doughnut Chart for Sales Breakdown
    const doughnutCtx = document.getElementById('salesDoughnutChart');
    new Chart(doughnutCtx, {
        type: 'doughnut',
        data: {
            labels: [
                'Online Sales',
                'Offline Sales'
            ],
            datasets: [{
                label: 'Monetary Value',
                data: [
                    12.5,
                    5.9
                ],
                backgroundColor: [
                    '#1F6D46',
                    '#2E5AA8'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'bottom'
                },
                title: {
                    display: true,
                    text: 'Sales Channels (in ₹L)'
                }
            },
            cutout: '65%'
        }
    });

    // Line Chart for Sales Trend
    const lineCtx = document.getElementById('salesTrendChart');
    new Chart(lineCtx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Sales (in L)',
                data: [12.5, 14.2, 15.1, 17.3, 16.9, 18.4],
                fill: false,
                borderColor: '#C2410C',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                },
                title: {
                    display: true,
                    text: 'Monthly Sales Trend'
                }
            },
            scales: {
                y: {
                    beginAtZero: false,
                    ticks: {
                        callback: function(value) {
                            return '₹' + value + 'L';
                        }
                    }
                }
            }
        }
    });

    // Bar Chart for Orders & Retailers
    const barCtx = document.getElementById('activityBarChart');
    new Chart(barCtx, {
        type: 'bar',
        data: {
            labels: [
                'Distributors',
                'Retailers',
                'Cities Covered',
                'Orders Fulfilled',
                'New Retailers'
            ],
            datasets: [{
                label: 'Count',
                data: [
                    150,
                    800,
                    25,
                    3240,
                    86
                ],
                backgroundColor: [
                    '#2E5AA8',
                    '#1F6D46',
                    '#E3A73B',
                    '#154F34',
                    '#C2410C'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false // Hide legend as it's self-explanatory
                },
                title: {
                    display: true,
                    text: 'Activity Count'
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0
                    }
                }
            }
        }
    });

    // Doughnut Chart for Expiry Management
    const expiryCtx = document.getElementById('expiryManagementChart');
    new Chart(expiryCtx, {
        type: 'doughnut',
        data: {
            labels: [
                'Value Saved (₹)',
                'At Risk (₹)'
            ],
            datasets: [{
                label: 'Amount',
                data: [
                    45000,
                    8500
                ],
                backgroundColor: [
                    '#1F6D46',
                    '#E3A73B'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'bottom' },
                title: { display: true, text: 'Expiry Management (AI)' }
            },
            cutout: '65%'
        }
    });
</script>
</body>
</html>
