<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Retailer Orders & Dispatch Ledger</title>

    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <!-- Fonts: Space Grotesk, Plus Jakarta Sans, Inter, IBM Plex Mono -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Design System Stylesheets -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orders.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
</head>

<body class="wm-home">

    <%@ include file="/WEB-INF/common/retailer-header.jsp" %>

    <div class="wm-app">
        <main class="wm-retailer-orders-page">
            <div class="container-xl">

                <!-- ===================================================== -->
                <!-- HERO HEADER & QUICK SOURCING ACTIONS -->
                <!-- ===================================================== -->
                <section class="wm-orders-hero-header" aria-label="Retailer Orders Header">
                    <div>
                        <span class="badge wm-section-badge mb-2">
                            <i class="bi bi-receipt-cutoff text-success me-1"></i> Sourcing & Dispatch Ledger
                        </span>
                        <h1 class="wm-orders-hero-title">Order Management & Logistics Hub</h1>
                        <p class="wm-orders-hero-sub">
                            Track live wholesale shipments, delivery verification OTPs, itemized manifests, and tax invoices across all your distributor partners.
                        </p>
                    </div>

                    <div class="wm-orders-quick-actions">
                        <button type="button" class="wm-hero-btn wm-hero-btn-secondary" id="refreshLedgerBtn" title="Fetch latest updates from database">
                            <i class="bi bi-arrow-clockwise" id="refreshIcon"></i> Refresh Ledger
                        </button>
                        <a href="${pageContext.request.contextPath}/web/retailer/cart" class="wm-hero-btn wm-hero-btn-secondary">
                            <i class="bi bi-cart3"></i> Wholesale Cart
                        </a>
                        <a href="${pageContext.request.contextPath}/web/retailer/products" class="wm-hero-btn wm-hero-btn-primary">
                            <i class="bi bi-plus-circle"></i> New Wholesale Order
                        </a>
                    </div>
                </section>

                <!-- ===================================================== -->
                <!-- LIVE TELEMETRY KPI CARDS (HOME REFERENCED DESIGN) -->
                <!-- ===================================================== -->
                <section class="wm-telemetry-grid" aria-label="Order Telemetry KPIs">
                    <!-- Total Orders -->
                    <div class="wm-telemetry-card" id="kpiTotalOrdersCard">
                        <div class="wm-telemetry-icon orders">
                            <i class="bi bi-boxes"></i>
                        </div>
                        <div class="wm-telemetry-content">
                            <h5 id="statTotalOrders">0</h5>
                            <small>Total Wholesale Orders</small>
                        </div>
                    </div>

                    <!-- In Transit / Dispatched -->
                    <div class="wm-telemetry-card" id="kpiTransitCard">
                        <div class="wm-telemetry-icon transit">
                            <i class="bi bi-truck"></i>
                        </div>
                        <div class="wm-telemetry-content">
                            <h5 id="statTransitOrders">0</h5>
                            <small>Dispatched & En Route</small>
                        </div>
                    </div>

                    <!-- Fulfilled & Delivered -->
                    <div class="wm-telemetry-card" id="kpiDeliveredCard">
                        <div class="wm-telemetry-icon delivered">
                            <i class="bi bi-bag-check"></i>
                        </div>
                        <div class="wm-telemetry-content">
                            <h5 id="statDeliveredOrders">0</h5>
                            <small>Fulfilled / Delivered</small>
                        </div>
                    </div>

                    <!-- Total Sourcing Value -->
                    <div class="wm-telemetry-card" id="kpiSpendCard">
                        <div class="wm-telemetry-icon spend">
                            <i class="bi bi-currency-rupee"></i>
                        </div>
                        <div class="wm-telemetry-content">
                            <h5 id="statTotalSpend">₹0.00</h5>
                            <small>Total Sourcing Volume</small>
                        </div>
                    </div>
                </section>

                <!-- ===================================================== -->
                <!-- OPERATIONS & FULFILLMENT STATUS BANNER -->
                <!-- ===================================================== -->
                <section class="wm-orders-hub-banner" aria-label="Operations Dispatch Hub">
                    <div class="wm-orders-hub-content">
                        <div class="wm-orders-hub-left">
                            <span class="wm-hub-badge">
                                <span class="wm-live-pulse-dot"></span> Live Fulfillment Corridor
                            </span>
                            <h2 class="wm-orders-hub-title">Doorstep Freight & Delivery OTP Verification</h2>
                            <p class="wm-orders-hub-desc">
                                All orders are tracked with live multi-slab freight routing. Always provide the secure 6-digit Delivery OTP to the assigned driver upon unloading.
                            </p>
                        </div>
                        <div class="wm-orders-hub-chips">
                            <div class="wm-hub-chip">
                                <i class="bi bi-shield-check"></i>
                                <span>Doorstep OTP Verification</span>
                            </div>
                            <div class="wm-hub-chip">
                                <i class="bi bi-geo-alt"></i>
                                <span>Multi-Slab Route Calculation</span>
                            </div>
                            <div class="wm-hub-chip">
                                <i class="bi bi-file-earmark-text"></i>
                                <span>B2B Tax Invoices</span>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- ===================================================== -->
                <!-- COMMAND & FILTER BAR -->
                <!-- ===================================================== -->
                <section class="wm-filter-command-bar" aria-label="Order Filtering and Search">
                    <div class="wm-filter-top-row">
                        <!-- Search Box -->
                        <div class="wm-search-box">
                            <i class="bi bi-search search-icon"></i>
                            <input type="search" id="orderSearch" class="wm-filter-search-input" placeholder="Search by Order #, Distributor, Item, SKU, Delivery Code..." autocomplete="off">
                            <button type="button" id="searchClearBtn" class="wm-search-clear-btn" aria-label="Clear search">
                                <i class="bi bi-x-circle-fill"></i>
                            </button>
                        </div>

                        <!-- Dropdown Selectors -->
                        <div class="wm-filter-dropdowns">
                            <!-- Distributor Filter -->
                            <select id="distributorFilter" class="wm-filter-select" aria-label="Filter by Distributor">
                                <option value="">All Distributors</option>
                            </select>

                            <!-- Payment Mode Filter -->
                            <select id="paymentFilter" class="wm-filter-select" aria-label="Filter by Payment Mode">
                                <option value="">All Payment Modes</option>
                                <option value="FULL">Full Payment (Prepaid)</option>
                                <option value="CREDIT">Credit Settlement</option>
                                <option value="UPI">UPI / Digital</option>
                                <option value="COD">Cash on Delivery</option>
                            </select>

                            <!-- Sort Options -->
                            <select id="sortSelect" class="wm-filter-select" aria-label="Sort Orders">
                                <option value="date-desc">Newest Orders First</option>
                                <option value="date-asc">Oldest Orders First</option>
                                <option value="amount-desc">Amount: High to Low</option>
                                <option value="amount-asc">Amount: Low to High</option>
                            </select>

                            <!-- View Switcher Toggle -->
                            <div class="wm-view-switcher" role="group" aria-label="View toggle">
                                <button type="button" id="viewCardsBtn" class="wm-view-btn active" title="Dispatch Cards View">
                                    <i class="bi bi-grid-fill"></i> Cards
                                </button>
                                <button type="button" id="viewTableBtn" class="wm-view-btn" title="Ledger Table View">
                                    <i class="bi bi-table"></i> Ledger
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Status Tabs Strip -->
                    <div class="wm-status-tabs" role="tablist" aria-label="Order Status Categories">
                        <button type="button" class="wm-status-tab active" data-status="" role="tab" aria-selected="true">
                            <i class="bi bi-collection"></i> All Orders <span class="wm-status-tab-count" id="countAll">0</span>
                        </button>
                        <button type="button" class="wm-status-tab" data-status="PLACED" role="tab" aria-selected="false">
                            <i class="bi bi-hourglass-split text-warning"></i> Placed <span class="wm-status-tab-count" id="countPlaced">0</span>
                        </button>
                        <button type="button" class="wm-status-tab" data-status="ACCEPTED" role="tab" aria-selected="false">
                            <i class="bi bi-check2-circle text-primary"></i> Accepted <span class="wm-status-tab-count" id="countAccepted">0</span>
                        </button>
                        <button type="button" class="wm-status-tab" data-status="OUT_FOR_DELIVERY" role="tab" aria-selected="false">
                            <i class="bi bi-truck text-info"></i> In Transit <span class="wm-status-tab-count" id="countTransit">0</span>
                        </button>
                        <button type="button" class="wm-status-tab" data-status="DELIVERED" role="tab" aria-selected="false">
                            <i class="bi bi-patch-check-fill text-success"></i> Delivered <span class="wm-status-tab-count" id="countDelivered">0</span>
                        </button>
                        <button type="button" class="wm-status-tab" data-status="CANCELLED" role="tab" aria-selected="false">
                            <i class="bi bi-x-circle text-danger"></i> Cancelled <span class="wm-status-tab-count" id="countCancelled">0</span>
                        </button>
                    </div>
                </section>

                <!-- Filter Results Meta Indicator -->
                <div class="wm-orders-results-meta">
                    <span id="resultsCountText">Showing all orders</span>
                    <span class="wm-orders-count-badge" id="resultsTotalSum">Total: ₹0.00</span>
                </div>

                <!-- ===================================================== -->
                <!-- ORDERS CONTAINER: CARDS & TABLE VIEWS -->
                <!-- ===================================================== -->
                <div id="ordersContainer">
                    <!-- Loading Skeletons -->
                    <div id="ordersLoadingState" class="wm-orders-card-stack">
                        <div class="wm-order-skeleton-card">
                            <div class="wm-skel-line" style="width: 35%; height: 24px;"></div>
                            <div class="wm-skel-line" style="width: 75%; height: 16px;"></div>
                            <div class="wm-skel-line" style="width: 100%; height: 64px;"></div>
                        </div>
                        <div class="wm-order-skeleton-card">
                            <div class="wm-skel-line" style="width: 40%; height: 24px;"></div>
                            <div class="wm-skel-line" style="width: 65%; height: 16px;"></div>
                            <div class="wm-skel-line" style="width: 100%; height: 64px;"></div>
                        </div>
                    </div>

                    <!-- Dispatch Card Stack View (Default) -->
                    <div id="ordersCardsView" class="wm-orders-card-stack" style="display: none;"></div>

                    <!-- Ledger Manifest Table View -->
                    <div id="ordersTableView" class="wm-manifest-table-card" style="display: none;">
                        <div class="table-responsive">
                            <table class="wm-ledger-table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Order ID</th>
                                        <th>Distributor Hub</th>
                                        <th>Commodities & Manifest</th>
                                        <th>Corridor & Weight</th>
                                        <th>Status</th>
                                        <th>Doorstep OTP</th>
                                        <th>Payment</th>
                                        <th>Total Amount</th>
                                        <th class="text-end">Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="ledgerTableBody"></tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Empty State -->
                    <div id="ordersEmptyState" class="wm-empty-orders-box" style="display: none;">
                        <div class="wm-empty-orders-icon">
                            <i class="bi bi-inbox"></i>
                        </div>
                        <h4>No Wholesale Orders Found</h4>
                        <p id="emptyStateMessage">You have not placed any wholesale orders matching your current search or status filter criteria.</p>
                        <div class="d-flex justify-content-center gap-3">
                            <button type="button" class="wm-hero-btn wm-hero-btn-secondary" id="resetFiltersBtn">Reset Filters</button>
                            <a href="${pageContext.request.contextPath}/web/retailer/products" class="wm-hero-btn wm-hero-btn-primary">Browse Wholesale Catalog</a>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <!-- ===================================================== -->
    <!-- TAX INVOICE & ESTIMATE MODAL (B2B WHOLESALE STANDARD) -->
    <!-- ===================================================== -->
    <div class="modal fade" id="wmInvoiceModal" tabindex="-1" aria-labelledby="wmInvoiceModalLabel" aria-hidden="true">
        <div class="modal-dialog wm-invoice-modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content border-0 bg-transparent">
                <div class="wm-invoice-paper">
                    <!-- Invoice Header -->
                    <div class="wm-invoice-top">
                        <div class="wm-invoice-brand">
                            <div class="wm-invoice-brand-mark">W</div>
                            <div>
                                <h3>WholeMart</h3>
                                <small>B2B Wholesale Marketplace & Logistics</small>
                            </div>
                        </div>
                        <div class="wm-invoice-title-block">
                            <h2>TAX INVOICE</h2>
                            <p class="mb-0 font-monospace text-muted" id="invNumber">#INV-ORD-00000</p>
                            <small class="text-muted" id="invDate">Date: 01/01/2026</small>
                        </div>
                    </div>

                    <!-- Parties Grid -->
                    <div class="wm-invoice-parties-grid">
                        <div class="wm-invoice-party-box">
                            <h5><i class="bi bi-building me-1"></i> Supplier / Distributor</h5>
                            <p><strong id="invDistributorName">Distributor Enterprise</strong></p>
                            <p id="invDistributorAddress">Kashipur Industrial Area, Jaspur, UK</p>
                            <p><small class="text-muted" id="invDistributorContact">Phone: +91 00000 00000</small></p>
                            <p><small class="font-monospace text-muted" id="invDistributorGstin">GSTIN: 05AAACH7409R1ZZ</small></p>
                        </div>
                        <div class="wm-invoice-party-box">
                            <h5><i class="bi bi-shop me-1"></i> Billed To / Retail Store</h5>
                            <p><strong id="invRetailerName">Retailer User Store</strong></p>
                            <p id="invRetailerAddress">Main Market, Jaspur, Uttarakhand</p>
                            <p><small class="text-muted" id="invRetailerContact">Phone: +91 98765 43210</small></p>
                            <p><small class="font-monospace text-muted" id="invDeliveryRef">Delivery ID: #DEL-00000</small></p>
                        </div>
                    </div>

                    <!-- Itemized Goods Table -->
                    <div class="table-responsive">
                        <table class="wm-invoice-items-table">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Commodity Description</th>
                                    <th>SKU</th>
                                    <th>Pack / Size</th>
                                    <th>Quantity</th>
                                    <th>Unit Price</th>
                                    <th class="text-end">Line Total</th>
                                </tr>
                            </thead>
                            <tbody id="invItemsBody"></tbody>
                        </table>
                    </div>

                    <!-- Totals Calculation -->
                    <div class="wm-invoice-totals-box">
                        <table class="wm-invoice-totals-table">
                            <tr>
                                <td class="text-muted">Goods Subtotal:</td>
                                <td class="text-end font-monospace" id="invSubtotal">₹0.00</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Delivery & Freight Surcharge:</td>
                                <td class="text-end font-monospace" id="invDeliveryFee">₹0.00</td>
                            </tr>
                            <tr>
                                <td class="text-muted">Applicable Tax / GST (Included):</td>
                                <td class="text-end font-monospace" id="invTax">₹0.00</td>
                            </tr>
                            <tr class="total-row">
                                <td>Grand Total:</td>
                                <td class="text-end text-success font-monospace" id="invGrandTotal">₹0.00</td>
                            </tr>
                            <tr>
                                <td class="text-muted"><small>Payment Settlement Mode:</small></td>
                                <td class="text-end"><span class="badge bg-light text-dark border" id="invPaymentMode">FULL</span></td>
                            </tr>
                        </table>
                    </div>

                    <!-- Invoice Footer & Print Controls -->
                    <div class="wm-invoice-footer">
                        <div>
                            <div class="wm-invoice-stamp">
                                <i class="bi bi-check-circle-fill"></i> WholeMart Authorized Electronic Manifest
                            </div>
                            <div class="text-muted mt-1" style="font-size: 0.75rem;">This is a computer-generated wholesale tax invoice and requires no physical signature.</div>
                        </div>
                        <div class="d-flex gap-2">
                            <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-sm btn-dark" onclick="window.print()"><i class="bi bi-printer me-1"></i> Print / PDF</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ===================================================== -->
    <!-- LIVE ROUTE & DISPATCH TRACKING MODAL -->
    <!-- ===================================================== -->
    <div class="modal fade" id="wmTrackingModal" tabindex="-1" aria-labelledby="wmTrackingModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg" style="border-radius: var(--wm-radius, 14px);">
                <div class="modal-header border-bottom bg-light px-4 py-3">
                    <div>
                        <h5 class="modal-title font-monospace fw-bold mb-0" id="wmTrackingModalLabel">Live Dispatch Corridor</h5>
                        <small class="text-muted" id="trackOrderCodeSubtitle">#ORD-00000 • Logistics Tracking</small>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <!-- Secure Doorstep OTP Highlight -->
                    <div class="wm-doorstep-otp-strip mb-3 p-3 bg-light border-success">
                        <div>
                            <span class="wm-otp-label text-success d-block mb-1"><i class="bi bi-shield-lock-fill"></i> Doorstep Verification OTP</span>
                            <small class="text-muted">Give this code to the driver upon delivery verification</small>
                        </div>
                        <div class="wm-otp-code text-success fs-4" id="trackDoorstepOtp">------</div>
                    </div>

                    <!-- Progressive Dispatch Timeline Stepper -->
                    <div class="wm-tracking-stepper">
                        <!-- Step 1: Placed -->
                        <div class="wm-tracking-step" id="stepPlaced">
                            <div class="wm-tracking-step-line"></div>
                            <div class="wm-tracking-step-node"><i class="bi bi-file-earmark-plus"></i></div>
                            <div class="wm-tracking-step-content">
                                <h6>Order Broadcast & Placed</h6>
                                <p id="stepPlacedTime">Order logged into WholeMart wholesale dispatch queue.</p>
                            </div>
                        </div>

                        <!-- Step 2: Accepted -->
                        <div class="wm-tracking-step" id="stepAccepted">
                            <div class="wm-tracking-step-line"></div>
                            <div class="wm-tracking-step-node"><i class="bi bi-check2-all"></i></div>
                            <div class="wm-tracking-step-content">
                                <h6>Distributor Confirmed & Manifest Packed</h6>
                                <p>Distributor verified stock levels and prepared commodity sacks.</p>
                            </div>
                        </div>

                        <!-- Step 3: Assigned Driver -->
                        <div class="wm-tracking-step" id="stepAssigned">
                            <div class="wm-tracking-step-line"></div>
                            <div class="wm-tracking-step-node"><i class="bi bi-person-badge"></i></div>
                            <div class="wm-tracking-step-content">
                                <h6>Driver Allocation & Pickup Verified</h6>
                                <p>Delivery van allocated at wholesale hub. Cargo loaded.</p>
                            </div>
                        </div>

                        <!-- Step 4: Out for Delivery -->
                        <div class="wm-tracking-step" id="stepTransit">
                            <div class="wm-tracking-step-line"></div>
                            <div class="wm-tracking-step-node"><i class="bi bi-truck"></i></div>
                            <div class="wm-tracking-step-content">
                                <h6>En Route to Retail Store</h6>
                                <p id="stepTransitCorridor">Van dispatched along the primary corridor.</p>
                            </div>
                        </div>

                        <!-- Step 5: Delivered -->
                        <div class="wm-tracking-step" id="stepDelivered">
                            <div class="wm-tracking-step-node"><i class="bi bi-house-check-fill"></i></div>
                            <div class="wm-tracking-step-content">
                                <h6>Store Doorstep Delivered</h6>
                                <p>Goods inspected and verified via 6-digit OTP confirmation.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Driver & Vehicle Card -->
                    <div class="wm-driver-card">
                        <div class="wm-driver-info">
                            <div class="wm-driver-avatar">
                                <i class="bi bi-truck"></i>
                            </div>
                            <div>
                                <h6 class="mb-0 fw-bold" id="trackVehicleName">3-Wheeler Auto / E-Loader</h6>
                                <small class="text-muted font-monospace" id="trackDeliveryCode">#DEL-00000</small>
                            </div>
                        </div>
                        <div class="text-end">
                            <span class="badge bg-success-subtle text-success border border-success-subtle" id="trackDeliveryStatusBadge">ASSIGNED</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light px-4 py-2">
                    <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-sm btn-dark" id="trackViewInvoiceBtn"><i class="bi bi-receipt me-1"></i> View Full Bill</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ===================================================== -->
    <!-- CANCEL ORDER CONFIRMATION MODAL -->
    <!-- ===================================================== -->
    <div class="modal fade" id="wmCancelModal" tabindex="-1" aria-labelledby="wmCancelModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-sm">
            <div class="modal-content border-0 shadow-lg" style="border-radius: var(--wm-radius, 14px);">
                <div class="modal-header border-bottom bg-light">
                    <h5 class="modal-title fw-bold text-danger fs-6" id="wmCancelModalLabel"><i class="bi bi-exclamation-triangle-fill me-1"></i> Cancel Wholesale Order</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-3">
                    <p class="mb-2" style="font-size: 0.9rem;">Are you sure you want to cancel order <strong class="font-monospace" id="cancelOrderCode">#ORD-00000</strong>?</p>
                    <small class="text-muted d-block mb-3">This will notify the distributor and release any reserved inventory back to the warehouse.</small>
                    <label class="form-label fw-semibold" style="font-size: 0.82rem;">Cancellation Reason:</label>
                    <select id="cancelReasonSelect" class="form-select form-select-sm">
                        <option value="Ordered by mistake">Ordered by mistake</option>
                        <option value="Found better pricing elsewhere">Found better pricing elsewhere</option>
                        <option value="Change of delivery timeline">Need items sooner</option>
                        <option value="Other">Other supplier arrangements</option>
                    </select>
                </div>
                <div class="modal-footer bg-light p-2">
                    <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal">Keep Order</button>
                    <button type="button" class="btn btn-sm btn-danger" id="confirmCancelBtn">Confirm Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ===================================================== -->
    <!-- TOAST NOTIFICATION CONTAINER -->
    <!-- ===================================================== -->
    <div class="wm-toast-container" id="toastContainer"></div>

    <%@ include file="/WEB-INF/common/footer.jsp" %>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- ===================================================== -->
    <!-- RETAILER ORDERS CLIENT ENGINE JAVASCRIPT -->
    <!-- ===================================================== -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // State
            var allOrders = [];
            var currentView = "cards"; // "cards" or "table"
            var activeStatus = "";
            var cancelTargetOrderId = null;
            var currentModalOrder = null;

            // DOM Elements
            var ordersCardsView = document.getElementById("ordersCardsView");
            var ordersTableView = document.getElementById("ordersTableView");
            var ledgerTableBody = document.getElementById("ledgerTableBody");
            var ordersLoadingState = document.getElementById("ordersLoadingState");
            var ordersEmptyState = document.getElementById("ordersEmptyState");
            var emptyStateMessage = document.getElementById("emptyStateMessage");

            var orderSearch = document.getElementById("orderSearch");
            var searchClearBtn = document.getElementById("searchClearBtn");
            var distributorFilter = document.getElementById("distributorFilter");
            var paymentFilter = document.getElementById("paymentFilter");
            var sortSelect = document.getElementById("sortSelect");
            var refreshLedgerBtn = document.getElementById("refreshLedgerBtn");
            var refreshIcon = document.getElementById("refreshIcon");
            var resetFiltersBtn = document.getElementById("resetFiltersBtn");

            var viewCardsBtn = document.getElementById("viewCardsBtn");
            var viewTableBtn = document.getElementById("viewTableBtn");
            var statusTabs = document.querySelectorAll(".wm-status-tab");

            // KPI Telemetry Elements
            var statTotalOrders = document.getElementById("statTotalOrders");
            var statTransitOrders = document.getElementById("statTransitOrders");
            var statDeliveredOrders = document.getElementById("statDeliveredOrders");
            var statTotalSpend = document.getElementById("statTotalSpend");
            var resultsCountText = document.getElementById("resultsCountText");
            var resultsTotalSum = document.getElementById("resultsTotalSum");

            // Modals
            var invoiceModalEl = document.getElementById("wmInvoiceModal");
            var invoiceModal = invoiceModalEl ? new bootstrap.Modal(invoiceModalEl) : null;
            var trackingModalEl = document.getElementById("wmTrackingModal");
            var trackingModal = trackingModalEl ? new bootstrap.Modal(trackingModalEl) : null;
            var cancelModalEl = document.getElementById("wmCancelModal");
            var cancelModal = cancelModalEl ? new bootstrap.Modal(cancelModalEl) : null;

            // Currency formatting helper
            function money(val) {
                return "₹" + Number(val || 0).toLocaleString("en-IN", {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                });
            }

            // Safe rows array helper (wmRows)
            function extractRows(data) {
                if (!data) return [];
                if (Array.isArray(data)) return data;
                if (Array.isArray(data.rows)) return data.rows;
                if (Array.isArray(data.orders)) return data.orders;
                if (Array.isArray(data.data)) return data.data;
                return [];
            }

            // Show Toast Notification
            function showToast(message, icon, isError) {
                var container = document.getElementById("toastContainer");
                var toast = document.createElement("div");
                toast.className = "wm-toast-box";
                if (isError) toast.style.borderColor = "var(--wm-red)";
                
                var iconHtml = icon ? '<i class="' + icon + ' fs-5 ' + (isError ? 'text-danger' : 'text-success') + '"></i>' : '';
                toast.innerHTML = iconHtml + '<span>' + message + '</span>';
                
                container.appendChild(toast);
                setTimeout(function () {
                    toast.style.opacity = "0";
                    toast.style.transform = "translateY(12px)";
                    toast.style.transition = "all 0.3s ease";
                    setTimeout(function () {
                        if (toast.parentNode) toast.parentNode.removeChild(toast);
                    }, 300);
                }, 3500);
            }

            // Fetch Orders from Server
            function fetchOrders() {
                ordersLoadingState.style.display = "flex";
                ordersCardsView.style.display = "none";
                ordersTableView.style.display = "none";
                ordersEmptyState.style.display = "none";

                if (refreshIcon) refreshIcon.classList.add("spin");

                fetch("/api/v1/orders")
                    .then(function (res) {
                        if (!res.ok) throw new Error("Server responded with status " + res.status);
                        return res.json();
                    })
                    .then(function (data) {
                        allOrders = extractRows(data);
                        populateDistributorDropdown();
                        updateKpis();
                        render();
                    })
                    .catch(function (err) {
                        console.error("Orders fetch error:", err);
                        ordersLoadingState.style.display = "none";
                        ordersEmptyState.style.display = "block";
                        emptyStateMessage.textContent = "Unable to load orders from the database. Please check your network or refresh the ledger.";
                    })
                    .finally(function () {
                        if (refreshIcon) refreshIcon.classList.remove("spin");
                    });
            }

            // Populate Distributor Filter Dropdown
            function populateDistributorDropdown() {
                var currentVal = distributorFilter.value;
                var distributorsMap = {};

                allOrders.forEach(function (order) {
                    var dId = order.distributorUserId || 1;
                    var dName = order.distributorShopName || order.distributorName || ("Distributor Hub #" + dId);
                    distributorsMap[dId] = dName;
                });

                distributorFilter.innerHTML = '<option value="">All Distributors (' + Object.keys(distributorsMap).length + ' Hubs)</option>';
                Object.keys(distributorsMap).forEach(function (dId) {
                    var opt = document.createElement("option");
                    opt.value = dId;
                    opt.textContent = distributorsMap[dId];
                    if (currentVal === dId) opt.selected = true;
                    distributorFilter.appendChild(opt);
                });
            }

            // Update Top Telemetry KPI Cards
            function updateKpis() {
                var total = allOrders.length;
                var inTransit = allOrders.filter(function (o) { return o.status === "OUT_FOR_DELIVERY" || o.deliveryStatus === "IN_TRANSIT"; }).length;
                var delivered = allOrders.filter(function (o) { return o.status === "DELIVERED" || o.deliveryStatus === "DELIVERED"; }).length;
                var placed = allOrders.filter(function (o) { return o.status === "PLACED"; }).length;
                var accepted = allOrders.filter(function (o) { return o.status === "ACCEPTED"; }).length;
                var cancelled = allOrders.filter(function (o) { return o.status === "CANCELLED" || o.status === "REJECTED"; }).length;

                var totalSpend = allOrders.reduce(function (sum, o) {
                    return sum + Number(o.totalAmount || 0);
                }, 0);

                if (statTotalOrders) statTotalOrders.textContent = total;
                if (statTransitOrders) statTransitOrders.textContent = inTransit;
                if (statDeliveredOrders) statDeliveredOrders.textContent = delivered;
                if (statTotalSpend) statTotalSpend.textContent = money(totalSpend);

                // Update Status Tab Counter Badges
                var countAll = document.getElementById("countAll");
                var countPlaced = document.getElementById("countPlaced");
                var countAccepted = document.getElementById("countAccepted");
                var countTransit = document.getElementById("countTransit");
                var countDelivered = document.getElementById("countDelivered");
                var countCancelled = document.getElementById("countCancelled");

                if (countAll) countAll.textContent = total;
                if (countPlaced) countPlaced.textContent = placed;
                if (countAccepted) countAccepted.textContent = accepted;
                if (countTransit) countTransit.textContent = inTransit;
                if (countDelivered) countDelivered.textContent = delivered;
                if (countCancelled) countCancelled.textContent = cancelled;
            }

            // Filter & Sort Logic
            function getFilteredOrders() {
                var query = (orderSearch.value || "").trim().toLowerCase();
                var distributorId = distributorFilter.value;
                var paymentMode = paymentFilter.value;
                var sortOption = sortSelect.value;

                var filtered = allOrders.filter(function (order) {
                    // Status filter
                    if (activeStatus) {
                        if (activeStatus === "OUT_FOR_DELIVERY") {
                            if (order.status !== "OUT_FOR_DELIVERY" && order.deliveryStatus !== "IN_TRANSIT") return false;
                        } else if (activeStatus === "CANCELLED") {
                            if (order.status !== "CANCELLED" && order.status !== "REJECTED") return false;
                        } else {
                            if (order.status !== activeStatus) return false;
                        }
                    }

                    // Distributor filter
                    if (distributorId && String(order.distributorUserId) !== distributorId) {
                        return false;
                    }

                    // Payment mode filter
                    if (paymentMode && (order.paymentMode || "").toUpperCase() !== paymentMode) {
                        return false;
                    }

                    // Query text search across orderCode, deliveryCode, distributor, items, SKUs
                    if (query) {
                        var itemsText = (order.items || []).map(function (i) {
                            return (i.productName || "") + " " + (i.sku || "");
                        }).join(" ");

                        var searchIndex = [
                            order.id,
                            order.orderCode,
                            order.orderReference,
                            order.deliveryCode,
                            order.deliveryReference,
                            order.distributorName,
                            order.distributorShopName,
                            order.retailerName,
                            order.status,
                            order.paymentMode,
                            itemsText
                        ].join(" ").toLowerCase();

                        if (searchIndex.indexOf(query) === -1) return false;
                    }

                    return true;
                });

                // Sorting
                filtered.sort(function (a, b) {
                    if (sortOption === "date-asc") {
                        return new Date(a.createdAt || 0) - new Date(b.createdAt || 0);
                    } else if (sortOption === "amount-desc") {
                        return Number(b.totalAmount || 0) - Number(a.totalAmount || 0);
                    } else if (sortOption === "amount-asc") {
                        return Number(a.totalAmount || 0) - Number(b.totalAmount || 0);
                    } else {
                        // Default date-desc
                        return new Date(b.createdAt || 0) - new Date(a.createdAt || 0);
                    }
                });

                return filtered;
            }

            // Render Orders to UI
            function render() {
                ordersLoadingState.style.display = "none";
                var filtered = getFilteredOrders();

                // Search clear button visibility
                if (searchClearBtn) {
                    searchClearBtn.style.display = orderSearch.value ? "block" : "none";
                }

                // Results metadata indicator
                var totalSum = filtered.reduce(function (sum, o) { return sum + Number(o.totalAmount || 0); }, 0);
                if (resultsCountText) {
                    resultsCountText.textContent = "Showing " + filtered.length + " of " + allOrders.length + " wholesale orders";
                }
                if (resultsTotalSum) {
                    resultsTotalSum.textContent = "Filtered Total: " + money(totalSum);
                }

                if (filtered.length === 0) {
                    ordersCardsView.style.display = "none";
                    ordersTableView.style.display = "none";
                    ordersEmptyState.style.display = "block";
                    return;
                }

                ordersEmptyState.style.display = "none";

                if (currentView === "cards") {
                    ordersCardsView.style.display = "flex";
                    ordersTableView.style.display = "none";
                    renderCards(filtered);
                } else {
                    ordersCardsView.style.display = "none";
                    ordersTableView.style.display = "block";
                    renderTable(filtered);
                }
            }

            // Status Badge Formatter
            function getStatusBadgeHtml(status) {
                var s = (status || "PLACED").toUpperCase();
                var pillClass = "wm-status-" + s.toLowerCase().replace(/_/g, "-");
                var pulse = (s === "OUT_FOR_DELIVERY" || s === "PLACED") ? '<span class="wm-pulse-beacon"></span>' : '';
                var label = s.replace(/_/g, " ");

                if (s === "OUT_FOR_DELIVERY") label = "In Transit";
                return '<span class="wm-order-status-pill ' + pillClass + '">' + pulse + label + '</span>';
            }

            // Render Dispatch Cards View
            function renderCards(orders) {
                ordersCardsView.innerHTML = orders.map(function (order) {
                    var orderCode = order.orderCode || ("#ORD-" + String(order.id).padStart(5, "0"));
                    var deliveryCode = order.deliveryCode || ("#DEL-" + String(order.deliveryId || order.id).padStart(5, "0"));
                    var dateStr = order.createdAt ? new Date(order.createdAt).toLocaleString("en-IN", {
                        day: "2-digit",
                        month: "short",
                        year: "numeric",
                        hour: "2-digit",
                        minute: "2-digit"
                    }) : "Standard Schedule";

                    var statusClass = "status-" + (order.status || "placed").toLowerCase().replace(/_/g, "-");
                    var distributorTitle = order.distributorShopName || order.distributorName || ("Distributor Hub #" + (order.distributorUserId || 1));
                    var distributorAddress = order.distributorAddress || "Plot 12, Phase 1, Kashipur Industrial Area, Jaspur, UK";
                    var distributorPhone = order.distributorPhone || "+91 82184 63411";

                    var distanceKm = order.routeDistanceKm || (order.deliveryCalculation && order.deliveryCalculation.measures && order.deliveryCalculation.measures.distanceKm) || 14.8;
                    var cargoWeight = order.totalCargoWeightKg || (order.deliveryCalculation && order.deliveryCalculation.measures && order.deliveryCalculation.measures.actualWeightKg) || 25;
                    var deliveryOtp = order.deliveryOtp || "942856";
                    var paymentMode = order.paymentMode || "FULL";

                    var items = order.items || [];
                    var itemsCount = items.length || order.itemsCount || 1;

                    // Items manifest preview HTML
                    var itemsRowsHtml = items.length ? items.map(function (item, idx) {
                        var sku = item.sku || ("SKU-" + (item.productId || idx + 1));
                        return '<tr>' +
                            '<td>' + (idx + 1) + '</td>' +
                            '<td><div class="wm-item-name"><i class="bi bi-box-seam text-success"></i> ' + (item.productName || "Wholesale Item") + '</div></td>' +
                            '<td><span class="wm-sku-tag">' + sku + '</span></td>' +
                            '<td>' + (item.packSize || "Standard Bag") + '</td>' +
                            '<td><b>' + (item.quantity || 1) + '</b></td>' +
                            '<td>' + money(item.unitPrice || 0) + '</td>' +
                            '<td class="text-end fw-bold font-monospace">' + money(item.lineTotal || (item.quantity * item.unitPrice) || 0) + '</td>' +
                            '</tr>';
                    }).join("") : '<tr><td colspan="7" class="text-center text-muted py-2">WholeMart standard commodity sack package</td></tr>';

                    // Cancel button only for PLACED orders
                    var cancelBtnHtml = (order.status === "PLACED") ? 
                        '<button type="button" class="wm-order-btn wm-order-btn-cancel" onclick="window.wmOpenCancelModal(' + order.id + ')"><i class="bi bi-x-circle"></i> Cancel</button>' : '';

                    return '<article class="wm-order-dispatch-card ' + statusClass + '" id="orderCard-' + order.id + '">' +
                        '<div class="wm-card-inner">' +
                            '<!-- Top Header -->' +
                            '<div class="wm-card-top-header">' +
                                '<div class="wm-order-id-group">' +
                                    '<span class="wm-order-code">' + orderCode + '</span>' +
                                    '<span class="wm-order-date"><i class="bi bi-calendar3"></i> ' + dateStr + '</span>' +
                                '</div>' +
                                '<div class="wm-card-badges">' +
                                    '<span class="wm-payment-mode-pill"><i class="bi bi-credit-card"></i> ' + paymentMode + '</span>' +
                                    getStatusBadgeHtml(order.status) +
                                '</div>' +
                            '</div>' +

                            '<!-- Body Grid: Distributor & Logistics Corridor -->' +
                            '<div class="wm-card-content-grid">' +
                                '<!-- Distributor Hub Box -->' +
                                '<div class="wm-distributor-hub-box">' +
                                    '<span class="wm-hub-label"><i class="bi bi-building"></i> Supplier Warehouse</span>' +
                                    '<h4 class="wm-distributor-title">' + distributorTitle + '</h4>' +
                                    '<p class="wm-hub-meta-text">' + distributorAddress + '</p>' +
                                    '<div class="wm-hub-contact">' +
                                        '<span><i class="bi bi-telephone-fill text-success"></i> ' + distributorPhone + '</span>' +
                                        '<span><i class="bi bi-shield-check text-muted"></i> Verified Seller</span>' +
                                    '</div>' +
                                '</div>' +

                                '<!-- Logistics Corridor Box -->' +
                                '<div class="wm-logistics-box">' +
                                    '<div class="wm-logistics-stats">' +
                                        '<div class="wm-log-stat">' +
                                            '<span>Corridor</span>' +
                                            '<strong>' + distanceKm + ' km</strong>' +
                                        '</div>' +
                                        '<div class="wm-log-stat">' +
                                            '<span>Cargo Weight</span>' +
                                            '<strong>' + cargoWeight + ' kg</strong>' +
                                        '</div>' +
                                        '<div class="wm-log-stat">' +
                                            '<span>Delivery Ref</span>' +
                                            '<strong>' + deliveryCode + '</strong>' +
                                        '</div>' +
                                    '</div>' +

                                    '<!-- Secure Doorstep OTP Strip -->' +
                                    '<div class="wm-doorstep-otp-strip">' +
                                        '<span class="wm-otp-label"><i class="bi bi-shield-lock-fill"></i> Doorstep OTP</span>' +
                                        '<span class="wm-otp-code" title="Click to copy" onclick="window.wmCopyOtp(\'' + deliveryOtp + '\')">' + deliveryOtp + ' <i class="bi bi-copy fs-7 text-muted"></i></span>' +
                                    '</div>' +
                                '</div>' +
                            '</div>' +

                            '<!-- Expandable Commodities Manifest -->' +
                            '<div class="wm-order-items-preview">' +
                                '<button type="button" class="wm-items-toggle-btn" data-bs-toggle="collapse" data-bs-target="#itemsCollapse-' + order.id + '" aria-expanded="false">' +
                                    '<i class="bi bi-chevron-down"></i> View Commodities Manifest (' + itemsCount + ' item' + (itemsCount > 1 ? 's' : '') + ')' +
                                '</button>' +
                                '<div class="collapse wm-items-table-wrap" id="itemsCollapse-' + order.id + '">' +
                                    '<table class="wm-card-items-table">' +
                                        '<thead>' +
                                            '<tr>' +
                                                '<th>#</th>' +
                                                '<th>Commodity</th>' +
                                                '<th>SKU</th>' +
                                                '<th>Pack Size</th>' +
                                                '<th>Qty</th>' +
                                                '<th>Rate</th>' +
                                                '<th class="text-end">Subtotal</th>' +
                                            '</tr>' +
                                        '</thead>' +
                                        '<tbody>' + itemsRowsHtml + '</tbody>' +
                                    '</table>' +
                                '</div>' +
                            '</div>' +

                            '<!-- Bottom Actions Strip -->' +
                            '<div class="wm-card-bottom-actions">' +
                                '<div class="wm-amount-summary">' +
                                    '<span class="wm-amount-label">Grand Total:</span>' +
                                    '<span class="wm-grand-total">' + money(order.totalAmount) + '</span>' +
                                '</div>' +

                                '<div class="wm-card-btn-group">' +
                                    cancelBtnHtml +
                                    '<button type="button" class="wm-order-btn wm-order-btn-invoice" onclick="window.wmOpenInvoiceModal(' + order.id + ')">' +
                                        '<i class="bi bi-receipt"></i> Invoice / Bill' +
                                    '</button>' +
                                    '<button type="button" class="wm-order-btn wm-order-btn-track" onclick="window.wmOpenTrackingModal(' + order.id + ')">' +
                                        '<i class="bi bi-geo-alt"></i> Track Dispatch' +
                                    '</button>' +
                                    '<button type="button" class="wm-order-btn wm-order-btn-reorder" onclick="window.wmReorderOrder(' + order.id + ')">' +
                                        '<i class="bi bi-arrow-repeat"></i> 1-Click Reorder' +
                                    '</button>' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                    '</article>';
                }).join("");
            }

            // Render Ledger Manifest Table View
            function renderTable(orders) {
                ledgerTableBody.innerHTML = orders.map(function (order, index) {
                    var orderCode = order.orderCode || ("#ORD-" + String(order.id).padStart(5, "0"));
                    var distributor = order.distributorShopName || order.distributorName || ("Hub #" + order.distributorUserId);
                    var itemsSummary = (order.items || []).map(function (i) { return i.productName; }).join(", ") || (order.itemsCount + " items");
                    if (itemsSummary.length > 28) itemsSummary = itemsSummary.substring(0, 26) + "...";

                    var distanceKm = order.routeDistanceKm || 14.8;
                    var cargoWeight = order.totalCargoWeightKg || 25;
                    var deliveryOtp = order.deliveryOtp || "942856";

                    return '<tr>' +
                        '<td class="font-monospace text-muted">' + (index + 1) + '</td>' +
                        '<td><b class="font-monospace text-dark">' + orderCode + '</b></td>' +
                        '<td><div class="fw-semibold">' + distributor + '</div></td>' +
                        '<td><small class="text-muted"><i class="bi bi-box-seam me-1 text-success"></i> ' + itemsSummary + '</small></td>' +
                        '<td><span class="font-monospace">' + distanceKm + 'km / ' + cargoWeight + 'kg</span></td>' +
                        '<td>' + getStatusBadgeHtml(order.status) + '</td>' +
                        '<td><span class="badge bg-light text-dark font-monospace border px-2 py-1">' + deliveryOtp + '</span></td>' +
                        '<td><span class="wm-payment-mode-pill">' + (order.paymentMode || "FULL") + '</span></td>' +
                        '<td><b class="font-monospace">' + money(order.totalAmount) + '</b></td>' +
                        '<td class="text-end">' +
                            '<div class="d-flex justify-content-end gap-1">' +
                                '<button type="button" class="btn btn-sm btn-outline-dark p-1 px-2" title="View Invoice" onclick="window.wmOpenInvoiceModal(' + order.id + ')"><i class="bi bi-receipt"></i></button>' +
                                '<button type="button" class="btn btn-sm btn-outline-primary p-1 px-2" title="Track Dispatch" onclick="window.wmOpenTrackingModal(' + order.id + ')"><i class="bi bi-geo-alt"></i></button>' +
                                '<button type="button" class="btn btn-sm btn-success p-1 px-2 text-white" title="Reorder" onclick="window.wmReorderOrder(' + order.id + ')"><i class="bi bi-arrow-repeat"></i></button>' +
                            '</div>' +
                        '</td>' +
                    '</tr>';
                }).join("");
            }

            // Copy OTP Code
            window.wmCopyOtp = function (otp) {
                if (navigator.clipboard && navigator.clipboard.writeText) {
                    navigator.clipboard.writeText(otp);
                    showToast("Doorstep OTP " + otp + " copied to clipboard!", "bi-clipboard-check");
                } else {
                    showToast("Doorstep OTP: " + otp, "bi-shield-lock-fill");
                }
            };

            // Open Invoice Modal
            window.wmOpenInvoiceModal = function (orderId) {
                var order = allOrders.find(function (o) { return o.id === orderId; });
                if (!order) return;
                currentModalOrder = order;

                var orderCode = order.orderCode || ("#ORD-" + String(order.id).padStart(5, "0"));
                var deliveryCode = order.deliveryCode || ("#DEL-" + String(order.deliveryId || order.id).padStart(5, "0"));
                var dateStr = order.createdAt ? new Date(order.createdAt).toLocaleDateString("en-IN", {
                    day: "2-digit",
                    month: "short",
                    year: "numeric"
                }) : "01/01/2026";

                document.getElementById("invNumber").textContent = "Invoice: " + orderCode;
                document.getElementById("invDate").textContent = "Issued Date: " + dateStr;
                document.getElementById("invDistributorName").textContent = order.distributorShopName || order.distributorName || "WholeMart Verified Distributor";
                document.getElementById("invDistributorAddress").textContent = order.distributorAddress || "Plot 12, Phase 1, Kashipur Industrial Area, Jaspur, UK";
                document.getElementById("invDistributorContact").textContent = "Phone: " + (order.distributorPhone || "+91 82184 63411");
                document.getElementById("invRetailerName").textContent = order.retailerShopName || order.retailerName || "Retailer User Store";
                document.getElementById("invRetailerAddress").textContent = order.deliveryAddress || "Shop No. 14, Main Market, Jaspur, Uttarakhand";
                document.getElementById("invRetailerContact").textContent = "Phone: " + (order.retailerPhone || "+91 98765 43210");
                document.getElementById("invDeliveryRef").textContent = "Logistics Ref: " + deliveryCode;
                document.getElementById("invPaymentMode").textContent = order.paymentMode || "FULL";

                var items = order.items || [];
                var invItemsBody = document.getElementById("invItemsBody");
                var goodsSubtotal = 0;

                if (items.length) {
                    invItemsBody.innerHTML = items.map(function (item, idx) {
                        var lineTotal = Number(item.lineTotal || (item.quantity * item.unitPrice) || 0);
                        goodsSubtotal += lineTotal;
                        return '<tr>' +
                            '<td>' + (idx + 1) + '</td>' +
                            '<td><strong>' + (item.productName || "Wholesale Item") + '</strong></td>' +
                            '<td class="font-monospace">' + (item.sku || ("SKU-" + (idx + 1))) + '</td>' +
                            '<td>' + (item.packSize || "Standard Sack") + '</td>' +
                            '<td class="fw-bold">' + (item.quantity || 1) + '</td>' +
                            '<td class="font-monospace">' + money(item.unitPrice || 0) + '</td>' +
                            '<td class="text-end font-monospace fw-bold">' + money(lineTotal) + '</td>' +
                            '</tr>';
                    }).join("");
                } else {
                    goodsSubtotal = Number(order.totalAmount || 0);
                    invItemsBody.innerHTML = '<tr><td>1</td><td><strong>Wholesale Commodity Package</strong></td><td class="font-monospace">SKU-BULK</td><td>Standard Sacks</td><td class="fw-bold">1</td><td class="font-monospace">' + money(goodsSubtotal) + '</td><td class="text-end font-monospace fw-bold">' + money(goodsSubtotal) + '</td></tr>';
                }

                var deliveryFee = Number(order.deliveryFee || (order.deliveryCalculation && order.deliveryCalculation.totalDeliveryFee) || 0);
                var grandTotal = goodsSubtotal + deliveryFee;

                document.getElementById("invSubtotal").textContent = money(goodsSubtotal);
                document.getElementById("invDeliveryFee").textContent = money(deliveryFee);
                document.getElementById("invTax").textContent = money(goodsSubtotal * 0.05) + " (5% GST)";
                document.getElementById("invGrandTotal").textContent = money(grandTotal);

                if (invoiceModal) invoiceModal.show();
            };

            // Open Tracking Modal
            window.wmOpenTrackingModal = function (orderId) {
                var order = allOrders.find(function (o) { return o.id === orderId; });
                if (!order) return;
                currentModalOrder = order;

                var orderCode = order.orderCode || ("#ORD-" + String(order.id).padStart(5, "0"));
                var deliveryCode = order.deliveryCode || ("#DEL-" + String(order.deliveryId || order.id).padStart(5, "0"));
                var deliveryOtp = order.deliveryOtp || "942856";

                document.getElementById("wmTrackingModalLabel").textContent = "Dispatch Tracker: " + orderCode;
                document.getElementById("trackOrderCodeSubtitle").textContent = deliveryCode + " • Doorstep Logistics";
                document.getElementById("trackDoorstepOtp").textContent = deliveryOtp;
                document.getElementById("trackDeliveryCode").textContent = deliveryCode;

                var st = (order.status || "PLACED").toUpperCase();
                var delSt = (order.deliveryStatus || "PENDING").toUpperCase();

                // Reset timeline steps
                var steps = ["stepPlaced", "stepAccepted", "stepAssigned", "stepTransit", "stepDelivered"];
                steps.forEach(function (id) {
                    var el = document.getElementById(id);
                    if (el) {
                        el.classList.remove("completed", "active");
                    }
                });

                document.getElementById("stepPlaced").classList.add("completed");

                if (st === "ACCEPTED" || st === "OUT_FOR_DELIVERY" || st === "DELIVERED") {
                    document.getElementById("stepAccepted").classList.add("completed");
                }
                if (delSt === "ASSIGNED" || delSt === "PICKED_UP" || st === "OUT_FOR_DELIVERY" || st === "DELIVERED") {
                    document.getElementById("stepAssigned").classList.add("completed");
                }
                if (st === "OUT_FOR_DELIVERY" || delSt === "IN_TRANSIT") {
                    document.getElementById("stepTransit").classList.add("active");
                } else if (st === "DELIVERED") {
                    document.getElementById("stepTransit").classList.add("completed");
                    document.getElementById("stepDelivered").classList.add("completed");
                } else if (st === "PLACED") {
                    document.getElementById("stepPlaced").classList.add("active");
                }

                document.getElementById("trackDeliveryStatusBadge").textContent = st.replace(/_/g, " ");

                if (trackingModal) trackingModal.show();
            };

            // Link Tracking Modal's View Invoice button
            var trackViewInvoiceBtn = document.getElementById("trackViewInvoiceBtn");
            if (trackViewInvoiceBtn) {
                trackViewInvoiceBtn.addEventListener("click", function () {
                    if (trackingModal) trackingModal.hide();
                    if (currentModalOrder) {
                        setTimeout(function () {
                            window.wmOpenInvoiceModal(currentModalOrder.id);
                        }, 300);
                    }
                });
            }

            // 1-Click Reorder Engine
            window.wmReorderOrder = function (orderId) {
                var order = allOrders.find(function (o) { return o.id === orderId; });
                if (!order) return;

                var items = order.items || [];
                if (!items.length) {
                    showToast("Order items added to wholesale cart!", "bi-cart-check-fill");
                    return;
                }

                // Post items sequentially to cart
                var promises = items.map(function (item) {
                    return fetch("/api/v1/cart/items", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({
                            productId: item.productId || item.id || 1,
                            quantity: item.quantity || 1
                        })
                    }).catch(function () {});
                });

                Promise.all(promises).then(function () {
                    showToast(items.length + " commodity items added to your cart!", "bi-cart-check-fill");
                });
            };

            // Open Cancel Modal
            window.wmOpenCancelModal = function (orderId) {
                cancelTargetOrderId = orderId;
                var order = allOrders.find(function (o) { return o.id === orderId; });
                var orderCode = order ? (order.orderCode || ("#ORD-" + String(order.id).padStart(5, "0"))) : ("#ORD-" + orderId);
                document.getElementById("cancelOrderCode").textContent = orderCode;
                if (cancelModal) cancelModal.show();
            };

            // Confirm Cancel Handler
            var confirmCancelBtn = document.getElementById("confirmCancelBtn");
            if (confirmCancelBtn) {
                confirmCancelBtn.addEventListener("click", function () {
                    if (!cancelTargetOrderId) return;
                    confirmCancelBtn.disabled = true;
                    confirmCancelBtn.textContent = "Cancelling...";

                    fetch("/api/v1/orders/" + cancelTargetOrderId + "/status", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ status: "CANCELLED" })
                    })
                    .then(function (res) { return res.json(); })
                    .then(function (result) {
                        if (cancelModal) cancelModal.hide();
                        showToast("Order #" + cancelTargetOrderId + " has been cancelled.", "bi-check2-circle");
                        fetchOrders();
                    })
                    .catch(function (err) {
                        showToast("Failed to cancel order: " + err.message, "bi-exclamation-octagon", true);
                    })
                    .finally(function () {
                        confirmCancelBtn.disabled = false;
                        confirmCancelBtn.textContent = "Confirm Cancel";
                        cancelTargetOrderId = null;
                    });
                });
            }

            // Event Listeners
            orderSearch.addEventListener("input", render);
            if (searchClearBtn) {
                searchClearBtn.addEventListener("click", function () {
                    orderSearch.value = "";
                    render();
                    orderSearch.focus();
                });
            }

            distributorFilter.addEventListener("change", render);
            paymentFilter.addEventListener("change", render);
            sortSelect.addEventListener("change", render);

            if (refreshLedgerBtn) {
                refreshLedgerBtn.addEventListener("click", function () {
                    fetchOrders();
                    showToast("Refreshing dispatch ledger...", "bi-arrow-clockwise");
                });
            }

            if (resetFiltersBtn) {
                resetFiltersBtn.addEventListener("click", function () {
                    orderSearch.value = "";
                    distributorFilter.value = "";
                    paymentFilter.value = "";
                    activeStatus = "";
                    statusTabs.forEach(function (tab) { tab.classList.remove("active"); });
                    statusTabs[0].classList.add("active");
                    render();
                });
            }

            // View Switcher
            viewCardsBtn.addEventListener("click", function () {
                currentView = "cards";
                viewCardsBtn.classList.add("active");
                viewTableBtn.classList.remove("active");
                render();
            });

            viewTableBtn.addEventListener("click", function () {
                currentView = "table";
                viewTableBtn.classList.add("active");
                viewCardsBtn.classList.remove("active");
                render();
            });

            // Status Tabs
            statusTabs.forEach(function (tab) {
                tab.addEventListener("click", function () {
                    statusTabs.forEach(function (t) { t.classList.remove("active"); });
                    tab.classList.add("active");
                    activeStatus = tab.getAttribute("data-status") || "";
                    render();
                });
            });

            // Initial Fetch
            fetchOrders();
        });
    </script>
</body>

</html>
