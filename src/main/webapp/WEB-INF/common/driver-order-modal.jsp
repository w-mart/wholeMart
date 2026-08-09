<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- WholeMart Driver Order & Delivery Details Modal Component -->
<div class="modal fade wm-driver-order-modal wm-common-modal" id="driverOrderDetailsModal" tabindex="-1" aria-labelledby="driverOrderDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            
            <!-- Modal Header -->
            <div class="modal-header">
                <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center w-100 gap-2 me-2">
                    <div class="d-flex flex-column gap-1">
                        <div class="d-flex align-items-center flex-wrap gap-2">
                            <span class="badge bg-primary px-2.5 py-1 font-monospace fw-bold fs-6" id="modalDisplayOrderCode">#ORD-00000</span>
                            <span class="badge bg-secondary px-2.5 py-1 font-monospace" id="modalDisplayDelCode">#DEL-00000</span>
                            <span id="modalStatusBadgeContainer">
                                <span class="badge bg-warning text-dark px-2.5 py-1 rounded-pill font-monospace fw-bold">ASSIGNED</span>
                            </span>
                        </div>
                        <div class="d-flex align-items-center gap-2 small text-white-50 flex-wrap">
                            <span class="d-inline-flex align-items-center gap-1"><i class="bi bi-clock-history"></i> <strong id="modalOrderDate" class="text-white">Today</strong></span>
                            <span class="d-none d-sm-inline">•</span>
                            <span class="d-none d-sm-inline">WholeMart Logistics</span>
                        </div>
                    </div>
                    <div class="d-flex align-items-center gap-2 mt-1 mt-sm-0">
                        <button type="button" class="btn btn-outline-warning btn-sm rounded-pill px-3 font-monospace wm-mobile-touch-btn" id="modalOpenCalcBtn" title="Simulate / Check Delivery Charge Breakdown">
                            <i class="bi bi-calculator me-1"></i> Fee Breakdown
                        </button>
                        <button type="button" class="btn btn-outline-light btn-sm rounded-pill px-3 font-monospace wm-mobile-touch-btn" id="modalCopyFullBtn" title="Copy entire order & route summary">
                            <i class="bi bi-clipboard me-1"></i> Copy Details
                        </button>
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">

                <!-- Loading State -->
                <div id="wmOrderModalSpinner" class="text-center py-5 d-none">
                    <div class="spinner-border text-success mb-3" role="status" style="width: 2.5rem; height: 2.5rem;"></div>
                    <h6 class="fw-bold text-dark mb-1" style="font-family: var(--font-display);">Retrieving Order & Delivery Address...</h6>
                    <p class="text-muted small mb-0">Fetching live route coordinates, retailer contacts, and package manifest from database.</p>
                </div>

                <!-- Main Content Container -->
                <div id="wmOrderModalContent">

                    <!-- Section: Route & Location Addresses -->
                    <div class="row g-2 g-md-3 mb-3">
                        
                        <!-- 1. Pickup Warehouse (Distributor) -->
                        <div class="col-12 col-md-6">
                            <div class="wm-modal-card wm-pickup-card h-100">
                                <div class="d-flex gap-2.5 gap-md-3 align-items-start">
                                    <div class="wm-modal-icon-badge wm-pickup flex-shrink-0">
                                        <i class="bi bi-building"></i>
                                    </div>
                                    <div class="flex-grow-1 min-w-0">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="badge bg-warning-subtle text-warning-emphasis font-monospace fw-bold px-2 py-1 rounded-pill" style="font-size: 0.72rem;">
                                                <i class="bi bi-box-arrow-up me-1"></i> STEP 1: PICKUP HUB
                                            </span>
                                            <button type="button" class="btn btn-sm btn-outline-secondary py-1 px-2.5 rounded-pill font-monospace small" id="modalCopyPickupAddrBtn" title="Copy Pickup Address">
                                                <i class="bi bi-copy me-1"></i> Copy
                                            </button>
                                        </div>
                                        <h5 class="fw-bold text-dark mb-1 text-truncate" id="modalPickupShopName">Apex Wholesale Depot #4</h5>
                                        <div class="d-flex align-items-start gap-1 text-secondary small mb-2.5">
                                            <i class="bi bi-geo-alt mt-1 text-danger flex-shrink-0"></i>
                                            <p class="mb-0 fw-medium" id="modalPickupAddress">Plot 12, Phase 1, Kashipur Industrial Area, Uttarakhand - 244713</p>
                                        </div>
                                        <div class="d-flex flex-wrap align-items-center justify-content-between pt-2 border-top gap-2">
                                            <div class="d-flex align-items-center gap-1.5 small">
                                                <i class="bi bi-telephone text-primary"></i>
                                                <span class="text-muted">Depot:</span>
                                                <a href="tel:+918218463411" id="modalPickupPhone" class="fw-bold text-dark text-decoration-none font-monospace">+91 82184 63411</a>
                                            </div>
                                            <div class="d-flex align-items-center gap-1.5">
                                                <a href="tel:+918218463411" id="modalPickupCallBtn" class="btn btn-sm btn-outline-primary py-1 px-2.5 rounded-pill font-monospace small d-inline-flex align-items-center gap-1">
                                                    <i class="bi bi-telephone-fill"></i> Call Depot
                                                </a>
                                                <button type="button" class="btn btn-sm btn-light border p-1 rounded-circle text-muted" id="modalCopyPickupPhoneBtn" title="Copy Phone">
                                                    <i class="bi bi-clipboard"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 2. Drop-off Destination (Retailer Storefront) -->
                        <div class="col-12 col-md-6">
                            <div class="wm-modal-card wm-dropoff-card h-100">
                                <div class="d-flex gap-2.5 gap-md-3 align-items-start">
                                    <div class="wm-modal-icon-badge wm-dropoff flex-shrink-0">
                                        <i class="bi bi-shop"></i>
                                    </div>
                                    <div class="flex-grow-1 min-w-0">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <span class="badge bg-success-subtle text-success-emphasis font-monospace fw-bold px-2 py-1 rounded-pill" style="font-size: 0.72rem;">
                                                <i class="bi bi-geo-alt-fill me-1"></i> STEP 2: DROP-OFF
                                            </span>
                                            <div class="d-flex gap-1">
                                                <button type="button" class="btn btn-sm btn-outline-secondary py-1 px-2.5 rounded-pill font-monospace small" id="modalCopyDropoffAddrBtn" title="Copy Delivery Address">
                                                    <i class="bi bi-copy me-1"></i> Copy
                                                </button>
                                                <button type="button" class="btn btn-sm btn-success py-1 px-2.5 rounded-pill font-monospace small" id="modalOpenMapsBtn" title="Navigate with Google Maps">
                                                    <i class="bi bi-compass-fill me-1"></i> Maps
                                                </button>
                                            </div>
                                        </div>
                                        <h5 class="fw-bold text-dark mb-1 text-truncate" id="modalDropoffShopName">Shree Ganesh General Store</h5>
                                        <div class="d-flex align-items-start gap-1 text-secondary small mb-2.5">
                                            <i class="bi bi-geo-alt-fill mt-1 text-success flex-shrink-0"></i>
                                            <p class="mb-0 fw-semibold text-dark" id="modalDropoffAddress">Shop No. 14, Main Market, Near Clock Tower, Jaspur, Uttarakhand - 244712</p>
                                        </div>
                                        <div class="d-flex flex-wrap align-items-center justify-content-between pt-2 border-top gap-2">
                                            <div class="d-flex align-items-center gap-1.5 small">
                                                <i class="bi bi-telephone text-success"></i>
                                                <span class="text-muted">Retailer:</span>
                                                <a href="tel:+919876543210" id="modalDropoffPhone" class="fw-bold text-dark text-decoration-none font-monospace">+91 98765 43210</a>
                                            </div>
                                            <div class="d-flex align-items-center gap-1.5">
                                                <a href="tel:+919876543210" id="modalDropoffCallBtn" class="btn btn-sm btn-outline-success py-1 px-2.5 rounded-pill font-monospace small d-inline-flex align-items-center gap-1">
                                                    <i class="bi bi-telephone-fill"></i> Call Retailer
                                                </a>
                                                <button type="button" class="btn btn-sm btn-light border p-1 rounded-circle text-muted" id="modalCopyDropoffPhoneBtn" title="Copy Phone">
                                                    <i class="bi bi-clipboard"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Section: Key Shipment Metrics & OTPs (2x2 Grid on Mobile) -->
                    <div class="row g-2 g-md-3 mb-3">
                        
                        <!-- Driver Fee -->
                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="wm-metric-label">Driver Fee</div>
                                <div class="d-flex align-items-baseline gap-1">
                                    <h3 class="wm-metric-value text-success" id="modalFeeValue">₹250.00</h3>
                                    <span class="small text-muted font-monospace d-none d-sm-inline">/trip</span>
                                </div>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-wallet2 text-success me-1"></i> Bank credit</div>
                            </div>
                        </div>

                        <!-- Order Total & Mode -->
                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="d-flex justify-content-between align-items-start">
                                    <span class="wm-metric-label">Order Total</span>
                                    <span class="badge bg-light text-dark border font-monospace small px-1.5 py-0.5" id="modalPayModeBadge" style="font-size: 0.68rem;">COD</span>
                                </div>
                                <h3 class="wm-metric-value text-dark" id="modalTotalValue">₹7,124.00</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-credit-card me-1"></i> Collect if COD</div>
                            </div>
                        </div>

                        <!-- Pickup OTP -->
                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="wm-metric-label">Pickup OTP</span>
                                    <button type="button" class="btn btn-sm btn-link p-0 text-muted" id="modalCopyPickupOtpBtn" title="Copy Pickup OTP">
                                        <i class="bi bi-clipboard"></i>
                                    </button>
                                </div>
                                <h3 class="wm-metric-value text-dark letter-spacing-1" id="modalPickupOtpValue">062877</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-shield-check text-warning me-1"></i> At pickup hub</div>
                            </div>
                        </div>

                        <!-- Delivery OTP -->
                        <div class="col-6 col-md-3">
                            <div class="wm-modal-metric h-100">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="wm-metric-label">Delivery OTP</span>
                                    <button type="button" class="btn btn-sm btn-link p-0 text-muted" id="modalCopyDeliveryOtpBtn" title="Copy Delivery OTP">
                                        <i class="bi bi-clipboard"></i>
                                    </button>
                                </div>
                                <h3 class="wm-metric-value text-success letter-spacing-1" id="modalDeliveryOtpValue">602915</h3>
                                <div class="small text-muted text-truncate mt-1"><i class="bi bi-key text-success me-1"></i> With retailer</div>
                            </div>
                        </div>

                    </div>

                    <!-- Section: Dynamic Delivery Charge Calculation Breakdown -->
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-receipt-cutoff text-success"></i>
                                <h6 class="fw-bold mb-0 text-dark" style="font-family: var(--font-display);">Delivery Charge Breakdown & Rate Card</h6>
                            </div>
                            <button type="button" class="btn btn-sm btn-outline-success rounded-pill font-monospace small px-2.5" id="modalSimulateBtn">
                                <i class="bi bi-sliders me-1"></i> Rate Simulator
                            </button>
                        </div>
                        <div id="modalDeliveryCalcContainer">
                            <!-- Injected by driver-order-modal.js using WholeMartDeliveryCalculator -->
                        </div>
                    </div>

                    <!-- Section: Package Manifest & Order Items -->
                    <div class="wm-modal-manifest">
                        <div class="wm-modal-manifest-head">
                            <div class="d-flex align-items-center gap-2">
                                <i class="bi bi-box-seam-fill text-primary"></i>
                                <h6 class="fw-bold mb-0 text-dark" style="font-family: var(--font-display);">Shipment Package Manifest</h6>
                                <span class="badge bg-dark rounded-pill font-monospace" id="modalItemsBadge">0 Items</span>
                            </div>
                            <div class="small text-muted font-monospace d-none d-sm-block" id="modalItemsTotalWeight">
                                Total Packages: 0 | Est. Weight: 0 kg
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0 wm-modal-items-table">
                                <thead>
                                    <tr>
                                        <th style="width: 35px;">#</th>
                                        <th>Product / Commodity</th>
                                        <th class="text-center">Qty</th>
                                        <th class="text-end">Unit Price</th>
                                        <th class="text-end">Total Amount</th>
                                        <th>Pack Size</th>
                                        <th>Est. Weight</th>
                                    </tr>
                                </thead>
                                <tbody id="modalItemsTableBody">
                                    <tr><td colspan="7" class="text-center py-4 text-muted">Loading package items...</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>

            </div>

            <!-- Modal Footer (Mobile-Sticky Bottom Action Bar) -->
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary rounded-pill px-4 wm-mobile-footer-btn" data-bs-dismiss="modal">
                    <i class="bi bi-x-lg me-1"></i> Close
                </button>
                <div class="d-flex gap-2 w-100-mobile">
                    <button type="button" class="btn btn-success rounded-pill px-4 fw-semibold d-inline-flex align-items-center justify-content-center gap-2 wm-mobile-footer-btn flex-grow-1" id="modalFooterMapsBtn">
                        <i class="bi bi-compass-fill"></i> Get Directions (Google Maps)
                    </button>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- Floating Toast Notification for Copy / Actions -->
<div id="wmDriverToast" class="toast align-items-center text-bg-dark border-0 position-fixed bottom-0 start-50 translate-middle-x mb-3 shadow-lg d-none" role="alert" aria-live="assertive" aria-atomic="true" style="z-index: 1100; border-radius: 12px; min-width: 280px; max-width: 90vw;">
    <div class="d-flex p-2">
        <div class="toast-body d-flex align-items-center gap-2">
            <i id="wmDriverToastIcon" class="bi bi-check-circle-fill text-success fs-5"></i>
            <span id="wmDriverToastMsg" class="fw-medium">Copied to clipboard!</span>
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close" onclick="document.getElementById('wmDriverToast').classList.add('d-none');"></button>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/delivery-calculator.js"></script>
<script src="${pageContext.request.contextPath}/js/driver-order-modal.js"></script>

