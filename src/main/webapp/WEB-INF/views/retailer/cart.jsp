<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Retailer Cart & Delivery Settlement</title>
    <meta name="description" content="WholeMart Retailer Cart — Review wholesale commodities, calculate distance & weight freight charges, verify credit limits, and dispatch orders.">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
</head>

<body class="wm-home">

    <%@ include file="/WEB-INF/common/retailer-header.jsp" %>

    <div class="wm-app wm-cart-page">
        <main>
            <!-- HERO & DISPATCH LEDGER HEADER -->
            <section class="wm-cart-hero-section" aria-label="Retailer Cart Hero">
                <div class="container-fluid px-lg-5 px-3">
                    <div class="row align-items-center gy-4">
                        <div class="col-lg-8">
                            <span class="badge wm-section-badge">
                                <i class="bi bi-cart-check-fill text-success" aria-hidden="true"></i> Retailer Dispatch Ledger • Active Cart
                            </span>
                            <h1 class="wm-cart-title">Wholesale Cart & Freight Settlement</h1>
                            <p class="wm-cart-subtitle">
                                Review ordered commodities, calculate live distance & weight delivery slabs, verify your B2B credit line, and confirm instant driver dispatch.
                            </p>
                        </div>
                        <div class="col-lg-4 text-lg-end">
                            <div class="d-flex flex-wrap justify-content-lg-end gap-2">
                                <button type="button" class="btn wm-btn-outline" id="openSimTopBtn">
                                    <i class="bi bi-calculator-fill text-warning me-1"></i> Delivery Rate Calculator
                                </button>
                                <a href="${pageContext.request.contextPath}/web/retailer/products" class="btn wm-btn-primary">
                                    <i class="bi bi-plus-circle me-1"></i> Browse Catalog
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- TELEMETRY METRICS RIBBON (Matching Home Operations Hub) -->
                    <div class="wm-cart-telemetry-grid">
                        <div class="wm-telemetry-card">
                            <div class="wm-telemetry-icon inventory">
                                <i class="bi bi-list-task"></i>
                            </div>
                            <div class="wm-telemetry-content">
                                <h5 id="cartLines">0</h5>
                                <small>Commodity Lines</small>
                            </div>
                        </div>

                        <div class="wm-telemetry-card">
                            <div class="wm-telemetry-icon orders">
                                <i class="bi bi-boxes"></i>
                            </div>
                            <div class="wm-telemetry-content">
                                <h5 id="cartQuantity">0 Units</h5>
                                <small>Total Bags / Boxes</small>
                            </div>
                        </div>

                        <div class="wm-telemetry-card">
                            <div class="wm-telemetry-icon delivery">
                                <i class="bi bi-truck"></i>
                            </div>
                            <div class="wm-telemetry-content">
                                <h5 id="cartWeight">0 kg</h5>
                                <small id="cartVolumeCategory">Gross Cargo Mass</small>
                            </div>
                        </div>

                        <div class="wm-telemetry-card">
                            <div class="wm-telemetry-icon credit">
                                <i class="bi bi-currency-rupee"></i>
                            </div>
                            <div class="wm-telemetry-content">
                                <h5 id="cartSubtotalHeader">₹0.00</h5>
                                <small>Merchandise Subtotal</small>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- MAIN CART & SETTLEMENT WORKSPACE -->
            <div class="container-fluid px-lg-5 px-3">

                <!-- STEPS TRACK (Matching Home #how-it-works) -->
                <div class="wm-cart-steps-card">
                    <div class="wm-cart-steps-track">
                        <div class="wm-cart-step active">
                            <div class="wm-step-num">1</div>
                            <div class="wm-step-text">
                                <strong>Cart Manifest</strong>
                                <span>Verify SKUs & Quotas</span>
                            </div>
                        </div>
                        <i class="bi bi-arrow-right wm-step-sep"></i>

                        <div class="wm-cart-step">
                            <div class="wm-step-num">2</div>
                            <div class="wm-step-text">
                                <strong>Freight Rating</strong>
                                <span>Distance & Weight Slabs</span>
                            </div>
                        </div>
                        <i class="bi bi-arrow-right wm-step-sep"></i>

                        <div class="wm-cart-step">
                            <div class="wm-step-num">3</div>
                            <div class="wm-step-text">
                                <strong>Settlement Mode</strong>
                                <span>COD / UPI / 30-Day Khata</span>
                            </div>
                        </div>
                        <i class="bi bi-arrow-right wm-step-sep"></i>

                        <div class="wm-cart-step">
                            <div class="wm-step-num">4</div>
                            <div class="wm-step-text">
                                <strong>Fleet Dispatch</strong>
                                <span>Assigned Driver & OTP</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- NOTIFICATION STATUS BANNER -->
                <div id="cartStatus" class="wm-inline-status" role="alert"></div>

                <div class="row g-4">
                    <!-- LEFT COLUMN: COMMODITY MANIFEST TABLE & ROUTE CONFIGURATION -->
                    <div class="col-lg-8">

                        <!-- COMMODITY MANIFEST CARD -->
                        <div class="wm-ledger-card">
                            <div class="wm-ledger-card-header">
                                <h3 class="wm-ledger-card-title">
                                    <i class="bi bi-receipt-cutoff text-success me-1"></i> COMMODITY MANIFEST
                                </h3>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-dark bg-opacity-75 text-light border border-secondary font-monospace" id="cartItemBadge">
                                        0 Items
                                    </span>
                                    <button type="button" class="btn btn-sm btn-outline-danger font-monospace rounded-pill px-3 py-1" id="clearCartBtn">
                                        <i class="bi bi-trash3 me-1"></i> Clear Cart
                                    </button>
                                </div>
                            </div>

                            <div class="wm-ledger-card-body">
                                <!-- TOOLBAR -->
                                <div class="wm-cart-toolbar">
                                    <div class="wm-cart-search-wrap">
                                        <i class="bi bi-search"></i>
                                        <input id="cartSearch" class="wm-cart-search-input" type="search" placeholder="Search manifest by item name, SKU, or distributor...">
                                    </div>
                                    <a href="${pageContext.request.contextPath}/web/retailer/products" class="btn wm-btn-outline btn-sm">
                                        <i class="bi bi-plus-lg me-1"></i> Add More Items
                                    </a>
                                </div>

                                <!-- TABLE WRAPPER -->
                                <div class="wm-manifest-table-wrap" id="cartTableWrap">
                                    <table class="wm-manifest-table">
                                        <thead>
                                            <tr>
                                                <th style="width: 45px;">#</th>
                                                <th>Commodity Details</th>
                                                <th>Unit Wt</th>
                                                <th>Unit Price</th>
                                                <th style="width: 140px;">Quantity</th>
                                                <th>Line Total</th>
                                                <th style="width: 50px; text-align: center;">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="cartBody">
                                            <tr>
                                                <td colspan="7" class="text-center py-5 text-muted">
                                                    <div class="spinner-border spinner-border-sm text-success me-2" role="status"></div>
                                                    Loading commodity manifest from PostgreSQL...
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- EMPTY CART STATE (HIDDEN WHEN POPULATED) -->
                                <div id="emptyCartView" class="wm-empty-cart d-none">
                                    <div class="wm-empty-icon-outer">
                                        <div class="wm-empty-icon-inner">
                                            <i class="bi bi-cart-x"></i>
                                        </div>
                                    </div>
                                    <h4>Your Cart is Currently Empty</h4>
                                    <p>Browse our catalog of verified wholesale pulses, grains, spices, oils, and FMCG commodities to build your order.</p>
                                    <div class="d-flex justify-content-center gap-2">
                                        <a href="${pageContext.request.contextPath}/web/retailer/products" class="btn wm-btn-primary">
                                            <i class="bi bi-box-seam me-1"></i> Explore Product Catalog
                                        </a>
                                        <button type="button" class="btn wm-btn-outline" id="loadDemoCartBtn">
                                            <i class="bi bi-magic me-1"></i> Add Sample Wholesale Commodities
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- ROUTE & LOGISTICS CONFIGURATION CARD -->
                        <div class="wm-ledger-card">
                            <div class="wm-ledger-card-header">
                                <h3 class="wm-ledger-card-title">
                                    <i class="bi bi-geo-alt-fill text-warning me-1"></i> DISPATCH ROUTE & LOGISTICS PARAMETERS
                                </h3>
                                <span class="badge bg-success bg-opacity-10 text-success border border-success font-monospace">
                                    <span class="wm-live-pulse-dot me-1"></span> Live GPS Slabs Active
                                </span>
                            </div>

                            <div class="wm-ledger-card-body">
                                <div class="wm-route-banner">
                                    <div class="wm-route-hub-icon">
                                        <i class="bi bi-building"></i>
                                    </div>
                                    <div class="wm-route-details">
                                        <strong>Dispatch Origin: Kashipur Central Wholesale Depot</strong>
                                        <span>Plot 12, Phase 1, Kashipur Industrial Area, Kashipur, UK - 244713 • GPS Hub Active</span>
                                    </div>
                                </div>

                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="wm-form-label" for="deliveryCitySelect">
                                            <i class="bi bi-pin-map-fill text-danger me-1"></i> Retail Delivery Destination:
                                        </label>
                                        <select id="deliveryCitySelect" class="wm-form-select">
                                            <option value="Jaspur" selected>Jaspur Main Market (14.8 km Route)</option>
                                            <option value="Kashipur">Kashipur Local Mandi (4.5 km Route)</option>
                                            <option value="Ramnagar">Ramnagar Bazaar (26.4 km Route)</option>
                                            <option value="Rudrapur">Rudrapur Industrial Zone (54.0 km Route)</option>
                                            <option value="Moradabad">Moradabad Mandi (48.2 km Route)</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="wm-form-label" for="vehicleTypeSelect">
                                            <i class="bi bi-truck text-primary me-1"></i> Dedicated Fleet Vehicle:
                                        </label>
                                        <select id="vehicleTypeSelect" class="wm-form-select">
                                            <option value="AUTO_3W" selected>3-Wheeler Auto / E-Loader (1.00x - Standard)</option>
                                            <option value="TATA_ACE">Tata Ace / Chhota Hathi (1.30x - Heavy Bulk)</option>
                                            <option value="PICKUP_1TON">1.5-Ton Pickup Truck (1.50x - Commercial)</option>
                                            <option value="TRUCK_HEAVY">14ft Heavy Commercial Truck (2.00x - Pallets)</option>
                                            <option value="TWO_WHEELER">Two-Wheeler / Cargo Bike (0.85x - Express Small)</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="wm-form-label" for="urgencySelect">
                                            <i class="bi bi-lightning-charge-fill text-warning me-1"></i> Delivery Speed / Urgency:
                                        </label>
                                        <select id="urgencySelect" class="wm-form-select">
                                            <option value="STANDARD" selected>Standard Delivery (24 Hours, 1.00x)</option>
                                            <option value="EXPRESS">Express Same-Day (4 Hours, 1.20x)</option>
                                            <option value="RUSH">Rush Priority (90 Minutes, 1.50x)</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label class="wm-form-label" for="handlingTypeSelect">
                                            <i class="bi bi-box2-heart text-success me-1"></i> Cargo Handling Care:
                                        </label>
                                        <select id="handlingTypeSelect" class="wm-form-select">
                                            <option value="STANDARD" selected>Standard FMCG Staples (+₹0)</option>
                                            <option value="HEAVY_BULK">Heavy Loading Assistance (+₹75)</option>
                                            <option value="FRAGILE">Fragile Glassware / Shock Care (+₹150)</option>
                                            <option value="PERISHABLE">Perishable / Insulated Cold Transit (+₹200)</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- DYNAMIC FREIGHT CALCULATION CONTAINER (Injected via WholeMartDeliveryCalculator) -->
                        <div id="cartDeliveryCalcSection">
                            <!-- Injected live freight breakdown -->
                        </div>

                    </div>

                    <!-- RIGHT COLUMN: DISPATCH BILL & SETTLEMENT LEDGER -->
                    <div class="col-lg-4">
                        <div class="wm-settlement-sheet sticky-top" style="top: 86px; z-index: 10;">
                            <div class="wm-settlement-head">
                                <h3 class="wm-settlement-title">SETTLEMENT LEDGER</h3>
                                <small class="text-muted font-monospace d-block">Tax Invoice & Dispatch Quote</small>
                            </div>

                            <!-- B2B KHATA / CREDIT CARD -->
                            <div class="wm-khata-box">
                                <div class="wm-khata-head">
                                    <span class="wm-khata-label"><i class="bi bi-shield-check me-1"></i> B2B Credit Khata</span>
                                    <span class="wm-khata-amount text-success">₹50,000.00 Available</span>
                                </div>
                                <p class="wm-khata-sub">30-Day zero-interest credit line available for verified retailers.</p>
                            </div>

                            <!-- BILL BREAKDOWN ROWS -->
                            <div class="wm-bill-rows">
                                <div class="wm-bill-row">
                                    <span class="label"><i class="bi bi-box-seam text-secondary"></i> Merchandise Subtotal:</span>
                                    <span class="val" id="summarySubtotal">₹0.00</span>
                                </div>

                                <div class="wm-bill-row">
                                    <span class="label"><i class="bi bi-truck text-warning"></i> Freight Delivery Fee:</span>
                                    <span class="val" id="summaryDeliveryFee">₹0.00</span>
                                </div>

                                <div class="wm-bill-row">
                                    <span class="label"><i class="bi bi-percent text-info"></i> GST / Mandi Tax:</span>
                                    <span class="val text-success" id="summaryTax">Included (0%)</span>
                                </div>

                                <div class="wm-bill-divider"></div>

                                <div class="wm-bill-row total">
                                    <span class="label">Total Payable:</span>
                                    <span class="val" id="summaryGrandTotal">₹0.00</span>
                                </div>
                            </div>

                            <!-- PAYMENT MODE SELECTION -->
                            <div class="mb-3">
                                <label class="wm-form-label mb-2">Select Payment Mode:</label>
                                <div class="wm-payment-grid">
                                    <label class="wm-payment-option selected" id="optCod">
                                        <input type="radio" name="paymentModeRadio" value="PAY_ON_DELIVERY" checked>
                                        <div class="wm-payment-info">
                                            <span class="wm-payment-title"><i class="bi bi-cash-stack text-success"></i> Cash on Delivery (COD)</span>
                                            <span class="wm-payment-desc">Pay upon physical handover at shop</span>
                                        </div>
                                    </label>

                                    <label class="wm-payment-option" id="optUpi">
                                        <input type="radio" name="paymentModeRadio" value="FULL">
                                        <div class="wm-payment-info">
                                            <span class="wm-payment-title"><i class="bi bi-qr-code text-primary"></i> UPI / Online Advance</span>
                                            <span class="wm-payment-desc">Instant confirmation via GPay / PhonePe</span>
                                        </div>
                                    </label>

                                    <label class="wm-payment-option" id="optCredit">
                                        <input type="radio" name="paymentModeRadio" value="PAY_LATER">
                                        <div class="wm-payment-info">
                                            <span class="wm-payment-title"><i class="bi bi-journal-bookmark-fill text-warning"></i> 30-Day Credit (Khata)</span>
                                            <span class="wm-payment-desc">Settle on monthly ledger invoice</span>
                                        </div>
                                    </label>
                                </div>
                            </div>

                            <!-- CHECKOUT BUTTON -->
                            <button type="button" class="wm-checkout-btn" id="placeOrderBtn">
                                <i class="bi bi-bag-check-fill"></i> Settle & Place Order
                            </button>

                            <!-- TRUST RIBBON -->
                            <div class="wm-trust-ribbon">
                                <div class="wm-trust-item">
                                    <i class="bi bi-shield-fill-check"></i> Verified Drivers
                                </div>
                                <div class="wm-trust-item">
                                    <i class="bi bi-key-fill"></i> Secure OTP
                                </div>
                                <div class="wm-trust-item">
                                    <i class="bi bi-box2-fill"></i> 100% Insured
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <!-- CLEAR CART CONFIRMATION MODAL -->
    <div class="modal fade" id="clearCartModal" tabindex="-1" aria-labelledby="clearCartModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4">
                <div class="modal-header border-bottom-0 pb-0">
                    <h5 class="modal-title font-monospace fw-bold text-danger" id="clearCartModalLabel">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> Clear Shopping Cart?
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body py-3">
                    <p class="text-secondary mb-0">Are you sure you want to remove all wholesale commodities from your manifest? This action will reset your active delivery calculations.</p>
                </div>
                <div class="modal-footer border-top-0 pt-0">
                    <button type="button" class="btn btn-light rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger rounded-pill px-4" id="confirmClearCartBtn">Clear Entire Cart</button>
                </div>
            </div>
        </div>
    </div>

    <!-- ORDER SUCCESS MODAL -->
    <div class="modal fade" id="orderSuccessModal" tabindex="-1" aria-labelledby="orderSuccessModalLabel" aria-hidden="true" data-bs-backdrop="static">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="modal-header bg-success text-white border-0 py-3">
                    <h5 class="modal-title font-monospace fw-bold" id="orderSuccessModalLabel">
                        <i class="bi bi-check-circle-fill me-2"></i> Order Successfully Placed!
                    </h5>
                </div>
                <div class="modal-body p-4 text-center">
                    <div class="wm-empty-icon-outer mb-3" style="width: 76px; height: 76px;">
                        <div class="wm-empty-icon-inner text-success" style="border-color: var(--green);">
                            <i class="bi bi-truck fs-1"></i>
                        </div>
                    </div>
                    <h4 class="fw-bold mb-1" id="successOrderCode">ORD-00001</h4>
                    <p class="text-muted small mb-3">Your order has been recorded in PostgreSQL and assigned to our local fulfillment fleet.</p>
                    
                    <div class="bg-light p-3 rounded-3 text-start mb-3 border">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary small">Delivery Reference:</span>
                            <strong class="font-monospace" id="successDelCode">DEL-00001</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary small">Destination Hub:</span>
                            <strong id="successDestination">Jaspur Main Market</strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-secondary small">Gross Payable:</span>
                            <strong class="text-success font-monospace fs-6" id="successAmount">₹0.00</strong>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-secondary small">Delivery Handover OTP:</span>
                            <span class="badge bg-dark font-monospace fs-6 px-3 py-1" id="successOtp">602915</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 bg-light justify-content-center p-3">
                    <a href="${pageContext.request.contextPath}/web/retailer/orders" class="btn wm-btn-primary px-4">
                        <i class="bi bi-box-seam me-1"></i> View Order in Tracker
                    </a>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/common.js"></script>
    <script src="${pageContext.request.contextPath}/js/delivery-calculator.js"></script>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        var cartBody = document.getElementById("cartBody");
        var cartTableWrap = document.getElementById("cartTableWrap");
        var emptyCartView = document.getElementById("emptyCartView");
        var cartSearch = document.getElementById("cartSearch");
        var placeOrderBtn = document.getElementById("placeOrderBtn");
        var clearCartBtn = document.getElementById("clearCartBtn");
        var confirmClearCartBtn = document.getElementById("confirmClearCartBtn");
        var loadDemoCartBtn = document.getElementById("loadDemoCartBtn");
        var openSimTopBtn = document.getElementById("openSimTopBtn");

        var citySelect = document.getElementById("deliveryCitySelect");
        var vehicleSelect = document.getElementById("vehicleTypeSelect");
        var urgencySelect = document.getElementById("urgencySelect");
        var handlingSelect = document.getElementById("handlingTypeSelect");
        var calcContainer = document.getElementById("cartDeliveryCalcSection");

        var clearModalEl = document.getElementById("clearCartModal");
        var clearModal = clearModalEl ? new bootstrap.Modal(clearModalEl) : null;
        var successModalEl = document.getElementById("orderSuccessModal");
        var successModal = successModalEl ? new bootstrap.Modal(successModalEl) : null;

        var items = [];
        var productsById = {};
        var currentFeeCalc = null;

        function money(value) {
            var n = Number(value || 0);
            return "₹" + n.toLocaleString("en-IN", { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }

        function setText(id, value) {
            var el = document.getElementById(id);
            if (el) el.textContent = value;
        }

        function setStatus(message, isError) {
            var banner = document.getElementById("cartStatus");
            if (!banner) return;
            if (!message) {
                banner.className = "wm-inline-status";
                banner.style.display = "none";
                return;
            }
            banner.textContent = message;
            banner.className = "wm-inline-status show " + (isError ? "is-error" : "is-success");
            banner.style.display = "block";
            setTimeout(function () {
                banner.style.display = "none";
            }, 5000);
        }

        function productFor(item) {
            var pId = Number(item.productId);
            if (productsById[pId]) {
                return productsById[pId];
            }
            return {
                id: pId,
                name: item.productName || ("Wholesale Commodity #" + pId),
                unitPrice: item.unitPrice || 400,
                price: item.unitPrice || 400,
                weightKg: 5,
                packSize: "50kg Bag",
                sku: "SKU-" + String(pId).padStart(4, "0"),
                distributorUserId: 1,
                distributorName: "Shree Ganesh Agro Traders"
            };
        }

        function getSelectedPaymentMode() {
            var checked = document.querySelector('input[name="paymentModeRadio"]:checked');
            return checked ? checked.value : "PAY_ON_DELIVERY";
        }

        // Setup Payment mode radio card selection visual state
        var paymentRadios = document.querySelectorAll('input[name="paymentModeRadio"]');
        paymentRadios.forEach(function (r) {
            r.addEventListener("change", function () {
                document.querySelectorAll(".wm-payment-option").forEach(function (opt) {
                    opt.classList.remove("selected");
                });
                var parent = r.closest(".wm-payment-option");
                if (parent) parent.classList.add("selected");
            });
        });

        function recalculateDelivery() {
            if (!items.length) {
                if (calcContainer) calcContainer.innerHTML = "";
                setText("summaryDeliveryFee", "₹0.00");
                updateSettlementSummary(0, 0);
                return;
            }

            var city = citySelect ? citySelect.value : "Jaspur";
            var dropoff = "Shop No. 14, Main Market, " + city + ", Uttarakhand";
            var pickup = "Plot 12, Phase 1, Kashipur Industrial Area, Kashipur, UK";
            var vehicle = vehicleSelect ? vehicleSelect.value : "AUTO_3W";
            var urgency = urgencySelect ? urgencySelect.value : "STANDARD";
            var handling = handlingSelect ? handlingSelect.value : "STANDARD";

            var orderItems = items.map(function (item) {
                var p = productFor(item);
                var qty = Number(item.quantity || 1);
                var w = p.weightKg ? (Number(p.weightKg) * qty) : (qty * 5);
                return {
                    productId: p.id,
                    productName: p.name,
                    quantity: qty,
                    unitPrice: p.unitPrice || p.price,
                    weightKg: w,
                    weightKgIsTotal: true,
                    packSize: p.packSize || "50kg Bag"
                };
            });

            if (typeof WholeMartDeliveryCalculator !== "undefined") {
                currentFeeCalc = WholeMartDeliveryCalculator.calculateFee({
                    items: orderItems,
                    pickupAddress: pickup,
                    dropoffAddress: dropoff,
                    vehicleType: vehicle,
                    urgency: urgency,
                    handlingType: handling
                });

                if (calcContainer) {
                    calcContainer.innerHTML = WholeMartDeliveryCalculator.renderBreakdownHtml(currentFeeCalc);
                }

                var deliveryFee = currentFeeCalc ? currentFeeCalc.totalDeliveryFee : 200;
                setText("summaryDeliveryFee", money(deliveryFee));

                var subtotal = items.reduce(function (tot, item) {
                    var p = productFor(item);
                    return tot + (Number(item.quantity || 0) * Number(p.unitPrice || p.price || 0));
                }, 0);

                updateSettlementSummary(subtotal, deliveryFee);
            }
        }

        function updateSettlementSummary(subtotal, deliveryFee) {
            var grandTotal = subtotal + deliveryFee;
            setText("summarySubtotal", money(subtotal));
            setText("cartSubtotalHeader", money(subtotal));
            setText("summaryGrandTotal", money(grandTotal));
        }

        function render() {
            var query = (cartSearch.value || "").trim().toLowerCase();
            var filtered = items.filter(function (item) {
                var p = productFor(item);
                return !query || [p.name, p.sku, p.category, p.brand, p.packSize, p.distributorName, p.distributorUserId]
                    .join(" ")
                    .toLowerCase()
                    .indexOf(query) !== -1;
            });

            var totalQty = items.reduce(function (sum, item) {
                return sum + Number(item.quantity || 0);
            }, 0);

            var totalWeight = items.reduce(function (sum, item) {
                var p = productFor(item);
                var unitW = p.weightKg ? Number(p.weightKg) : 5;
                return sum + (Number(item.quantity || 0) * unitW);
            }, 0);

            var subtotal = items.reduce(function (sum, item) {
                var p = productFor(item);
                return sum + (Number(item.quantity || 0) * Number(p.unitPrice || p.price || 0));
            }, 0);

            if (items.length > 0) {
                if (cartTableWrap) cartTableWrap.classList.remove("d-none");
                if (emptyCartView) emptyCartView.classList.add("d-none");

                if (filtered.length > 0) {
                    cartBody.innerHTML = filtered.map(function (item, index) {
                        var p = productFor(item);
                        var qty = Number(item.quantity || 1);
                        var price = Number(p.unitPrice || p.price || 0);
                        var lineAmount = qty * price;
                        var sku = p.sku || ("PRD-" + String(p.id || item.productId).padStart(4, "0"));
                        var weightPerUnit = (p.weightKg || 5) + " kg";
                        var pack = p.packSize || "Standard Bag";
                        var distName = p.distributorName || ("Distributor #" + (p.distributorUserId || 1));

                        return "<tr>" +
                            "<td class=\"font-monospace text-muted fw-bold\">" + (index + 1) + "</td>" +
                            "<td>" +
                                "<div class=\"wm-item-cell\">" +
                                    "<div class=\"wm-item-icon-box\">" +
                                        "<i class=\"bi bi-box-seam\"></i>" +
                                    "</div>" +
                                    "<div class=\"wm-item-info\">" +
                                        "<span class=\"wm-item-name\">" + (p.name || item.productName || "Commodity") + "</span>" +
                                        "<div class=\"wm-item-meta\">" +
                                            "<span class=\"wm-meta-pill sku\">" + sku + "</span>" +
                                            "<span class=\"wm-meta-pill pack\"><i class=\"bi bi-bag\"></i> " + pack + "</span>" +
                                            "<span class=\"wm-meta-pill dist\"><i class=\"bi bi-shop\"></i> " + distName + "</span>" +
                                        "</div>" +
                                    "</div>" +
                                "</div>" +
                            "</td>" +
                            "<td><span class=\"badge bg-light text-dark border font-monospace\">" + weightPerUnit + "</span></td>" +
                            "<td><span class=\"wm-mono-price\">" + money(price) + "</span></td>" +
                            "<td>" +
                                "<div class=\"wm-qty-stepper\">" +
                                    "<button type=\"button\" class=\"wm-qty-stepper-btn\" data-cart-action=\"decrease\" data-cart-id=\"" + item.id + "\" aria-label=\"Decrease quantity\">-</button>" +
                                    "<input type=\"number\" class=\"wm-qty-stepper-input\" data-cart-action=\"quantity\" data-cart-id=\"" + item.id + "\" min=\"1\" step=\"1\" value=\"" + qty + "\">" +
                                    "<button type=\"button\" class=\"wm-qty-stepper-btn\" data-cart-action=\"increase\" data-cart-id=\"" + item.id + "\" aria-label=\"Increase quantity\">+</button>" +
                                "</div>" +
                            "</td>" +
                            "<td><span class=\"wm-mono-amount\">" + money(lineAmount) + "</span></td>" +
                            "<td style=\"text-align: center;\">" +
                                "<button type=\"button\" class=\"wm-btn-remove\" data-cart-action=\"remove\" data-cart-id=\"" + item.id + "\" title=\"Remove commodity from manifest\">" +
                                    "<i class=\"bi bi-trash3\"></i>" +
                                "</button>" +
                            "</td>" +
                        "</tr>";
                    }).join("");
                } else {
                    cartBody.innerHTML = "<tr><td colspan=\"7\" class=\"text-center py-4 text-muted\"><i class=\"bi bi-search me-2\"></i>No commodities matching <strong>\"" + query + "\"</strong></td></tr>";
                }
            } else {
                if (cartTableWrap) cartTableWrap.classList.add("d-none");
                if (emptyCartView) emptyCartView.classList.remove("d-none");
            }

            setText("cartLines", items.length);
            setText("cartItemBadge", items.length + (items.length === 1 ? " Item" : " Items"));
            setText("cartQuantity", totalQty + " Units");
            setText("cartWeight", totalWeight.toFixed(1) + " kg");

            var sizeTier = "COMPACT";
            if (totalWeight > 250) sizeTier = "PALLET";
            else if (totalWeight > 100) sizeTier = "LARGE";
            else if (totalWeight > 30) sizeTier = "MEDIUM";
            setText("cartVolumeCategory", sizeTier + " TIER CARGO");

            if (placeOrderBtn) placeOrderBtn.disabled = !items.length;
            if (clearCartBtn) clearCartBtn.disabled = !items.length;

            recalculateDelivery();
        }

        function load() {
            Promise.all([
                fetch("/api/v1/cart").then(function (r) { return r.json(); }),
                fetch("/api/v1/products").then(function (r) { return r.json(); })
            ]).then(function (res) {
                items = Array.isArray(res[0]) ? res[0] : (res[0].rows || []);
                productsById = {};
                var pList = Array.isArray(res[1]) ? res[1] : (res[1].rows || []);
                pList.forEach(function (p) {
                    productsById[p.id] = p;
                });
                render();
            }).catch(function (err) {
                console.error("Cart load error:", err);
                if (cartBody) {
                    cartBody.innerHTML = "<tr><td colspan=\"7\" class=\"text-center text-danger py-4\">Failed to sync live cart. Please refresh or retry.</td></tr>";
                }
            });
        }

        function updateQuantity(cartItemId, qty) {
            if (qty < 1) return;
            fetch("/api/v1/cart/items/" + cartItemId, {
                method: "PUT",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ quantity: qty })
            }).then(function (r) {
                if (!r.ok) throw new Error("Update failed");
                setStatus("Quantity updated.", false);
                load();
            }).catch(function () {
                setStatus("Could not update item quantity.", true);
            });
        }

        // Search and filter events
        if (cartSearch) cartSearch.addEventListener("input", render);
        if (citySelect) citySelect.addEventListener("change", recalculateDelivery);
        if (vehicleSelect) vehicleSelect.addEventListener("change", recalculateDelivery);
        if (urgencySelect) urgencySelect.addEventListener("change", recalculateDelivery);
        if (handlingSelect) handlingSelect.addEventListener("change", recalculateDelivery);

        // Open Rate Calculator Simulator
        if (openSimTopBtn) {
            openSimTopBtn.addEventListener("click", function () {
                if (typeof WholeMartDeliveryCalculator !== "undefined") {
                    var d = currentFeeCalc && currentFeeCalc.measures ? currentFeeCalc.measures.distanceKm : 14.8;
                    var w = currentFeeCalc && currentFeeCalc.measures ? currentFeeCalc.measures.actualWeightKg : 35;
                    var veh = vehicleSelect ? vehicleSelect.value : "AUTO_3W";
                    WholeMartDeliveryCalculator.openSimulator({ distanceKm: d, weightKg: w, vehicleType: veh });
                }
            });
        }

        // Cart table actions (+ / - / remove / change)
        if (cartBody) {
            cartBody.addEventListener("click", function (e) {
                var btn = e.target.closest("[data-cart-action]");
                if (!btn) return;

                var cartItemId = Number(btn.dataset.cartId);
                var item = items.find(function (c) { return Number(c.id) === cartItemId || Number(c.productId) === cartItemId; });
                if (!item) return;

                var action = btn.dataset.cartAction;
                if (action === "increase") {
                    updateQuantity(cartItemId, Number(item.quantity || 1) + 1);
                } else if (action === "decrease") {
                    updateQuantity(cartItemId, Math.max(1, Number(item.quantity || 1) - 1));
                } else if (action === "remove") {
                    fetch("/api/v1/cart/items/" + cartItemId, { method: "DELETE" })
                        .then(function (r) {
                            if (!r.ok) throw new Error("Remove failed");
                            setStatus("Commodity removed from manifest.", false);
                            load();
                        })
                        .catch(function () {
                            setStatus("Unable to remove item.", true);
                        });
                }
            });

            cartBody.addEventListener("change", function (e) {
                var input = e.target.closest("[data-cart-action=\"quantity\"]");
                if (!input) return;
                var val = Math.max(1, parseInt(input.value || 1, 10));
                updateQuantity(Number(input.dataset.cartId), val);
            });
        }

        // Clear cart modal trigger
        if (clearCartBtn) {
            clearCartBtn.addEventListener("click", function () {
                if (!items.length) return;
                if (clearModal) clearModal.show();
            });
        }

        if (confirmClearCartBtn) {
            confirmClearCartBtn.addEventListener("click", function () {
                fetch("/api/v1/cart/all", { method: "DELETE" })
                    .then(function (r) {
                        if (!r.ok) throw new Error("Clear failed");
                        if (clearModal) clearModal.hide();
                        setStatus("Shopping cart cleared.", false);
                        load();
                    })
                    .catch(function () {
                        setStatus("Unable to clear cart.", true);
                    });
            });
        }

        // Add Demo Commodities if empty
        if (loadDemoCartBtn) {
            loadDemoCartBtn.addEventListener("click", function () {
                Promise.all([
                    fetch("/api/v1/cart/items", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ productId: 1, quantity: 2 })
                    }),
                    fetch("/api/v1/cart/items", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({ productId: 2, quantity: 1 })
                    })
                ]).then(function () {
                    setStatus("Sample wholesale commodities added to cart.", false);
                    load();
                }).catch(function () {
                    setStatus("Could not add demo items.", true);
                });
            });
        }

        // Place order flow
        if (placeOrderBtn) {
            placeOrderBtn.addEventListener("click", function () {
                if (!items.length) return;

                var city = citySelect ? citySelect.value : "Jaspur";
                var dropoff = "Shop No. 14, Main Market, " + city + ", Uttarakhand - 244712";
                var vehicle = vehicleSelect ? vehicleSelect.value : "AUTO_3W";
                var urgency = urgencySelect ? urgencySelect.value : "STANDARD";
                var handling = handlingSelect ? handlingSelect.value : "STANDARD";
                var paymentMode = getSelectedPaymentMode();

                var orderItems = items.map(function (item) {
                    var p = productFor(item);
                    var qty = Number(item.quantity || 1);
                    return {
                        productId: p.id,
                        productName: p.name,
                        quantity: qty,
                        unitPrice: p.unitPrice || p.price,
                        weightKg: p.weightKg ? Number(p.weightKg) : 5,
                        packSize: p.packSize || "Standard Bag"
                    };
                });

                var subtotal = items.reduce(function (tot, item) {
                    var p = productFor(item);
                    return tot + (Number(item.quantity || 0) * Number(p.unitPrice || p.price || 0));
                }, 0);

                var deliveryFee = currentFeeCalc ? currentFeeCalc.totalDeliveryFee : 200;
                var totalAmount = subtotal + deliveryFee;

                placeOrderBtn.disabled = true;
                placeOrderBtn.innerHTML = "<span class=\"spinner-border spinner-border-sm me-2\" role=\"status\" aria-hidden=\"true\"></span> Dispatching Order...";

                fetch("/api/v1/orders", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify({
                        distributorUserId: 1,
                        retailerUserId: 3,
                        items: orderItems,
                        totalAmount: totalAmount,
                        deliveryFee: deliveryFee,
                        paymentMode: paymentMode,
                        deliveryAddress: dropoff,
                        vehicleType: vehicle,
                        urgency: urgency,
                        handlingType: handling
                    })
                })
                .then(function (r) {
                    if (!r.ok) throw new Error("Order creation failed");
                    return r.json();
                })
                .then(function (createdOrder) {
                    // Clear cart after successful order placement
                    fetch("/api/v1/cart/all", { method: "DELETE" }).catch(function () {});

                    // Show success modal
                    setText("successOrderCode", createdOrder.orderCode || ("ORD-" + String(createdOrder.id || 1).padStart(5, "0")));
                    setText("successDelCode", createdOrder.deliveryCode || ("DEL-" + String(createdOrder.deliveryId || 1).padStart(5, "0")));
                    setText("successDestination", city + " Main Market");
                    setText("successAmount", money(totalAmount));
                    setText("successOtp", createdOrder.deliveryOtp || "602915");

                    if (successModal) successModal.show();
                })
                .catch(function (err) {
                    console.error("Order error:", err);
                    setStatus("Unable to place order in database. Please check connection.", true);
                    placeOrderBtn.disabled = false;
                    placeOrderBtn.innerHTML = "<i class=\"bi bi-bag-check-fill me-1\"></i> Settle & Place Order";
                });
            });
        }

        load();
    });
    </script>
</body>

</html>
