<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Regional Wholesale Distributors</title>
    <meta name="description" content="Explore verified regional B2B wholesale distributors, compare delivery times, minimum orders, and browse direct commodity catalogs.">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@500;600;700;800&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@500;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
</head>

<body class="wm-home wm-distributors-page">

    <%@ include file="/WEB-INF/common/retailer-header.jsp" %>

    <div class="wm-app">
        <main class="wm-distributors-hub">
            <!-- Hero Header with Live Telemetry -->
            <section class="wm-dist-hero-card" id="distributorsHero" aria-label="Wholesale Network Overview">
                <div class="d-flex flex-wrap align-items-center justify-content-between gap-3 mb-2">
                    <div>
                        <div class="wm-dist-hero-badge">
                            <span class="wm-live-dot"></span> B2B Wholesale Network &bull; Verified Hubs
                        </div>
                        <h1 class="wm-dist-hero-title">Regional Wholesale Distributors</h1>
                        <p class="wm-dist-hero-subtitle">
                            Connect directly with accredited regional suppliers. Compare minimum order thresholds, delivery SLAs, and explore live wholesale catalogs for instant store fulfillment.
                        </p>
                    </div>
                    <div class="d-flex align-items-center gap-2">
                        <a href="${pageContext.request.contextPath}/web/retailer/products" class="btn btn-outline-light rounded-pill px-3 py-2 fw-semibold fs-7 shadow-sm">
                            <i class="bi bi-boxes me-1"></i> Full Catalog
                        </a>
                        <a href="${pageContext.request.contextPath}/web/retailer/cart" class="btn btn-light rounded-pill px-3 py-2 fw-bold text-dark fs-7 shadow-sm">
                            <i class="bi bi-cart3 me-1"></i> View Cart
                        </a>
                    </div>
                </div>

                <!-- Telemetry Metrics Strip -->
                <div class="wm-dist-telemetry-grid" id="distributorsTelemetry">
                    <div class="wm-dist-telemetry-item" id="telemetryHubs">
                        <div class="wm-dist-telemetry-icon hubs">
                            <i class="bi bi-building"></i>
                        </div>
                        <div class="wm-dist-telemetry-body">
                            <h4 id="statTotalDistributors">--</h4>
                            <small>Active Wholesale Hubs</small>
                        </div>
                    </div>

                    <div class="wm-dist-telemetry-item" id="telemetryVerified">
                        <div class="wm-dist-telemetry-icon verified">
                            <i class="bi bi-patch-check-fill"></i>
                        </div>
                        <div class="wm-dist-telemetry-body">
                            <h4 id="statVerifiedDistributors">--</h4>
                            <small>100% KYC &amp; GST Verified</small>
                        </div>
                    </div>

                    <div class="wm-dist-telemetry-item" id="telemetrySpeed">
                        <div class="wm-dist-telemetry-icon speed">
                            <i class="bi bi-lightning-charge-fill"></i>
                        </div>
                        <div class="wm-dist-telemetry-body">
                            <h4>2 - 4 Hrs</h4>
                            <small>Express Regional Dispatch</small>
                        </div>
                    </div>

                    <div class="wm-dist-telemetry-item" id="telemetryCatalog">
                        <div class="wm-dist-telemetry-icon catalog">
                            <i class="bi bi-tags-fill"></i>
                        </div>
                        <div class="wm-dist-telemetry-body">
                            <h4>18% - 35%</h4>
                            <small>Trade Margins vs MRP</small>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Control & Filter Toolbar -->
            <section class="wm-dist-toolbar" id="distributorsToolbar" aria-label="Search and Filter Distributors">
                <div class="row g-3 align-items-center">
                    <div class="col-lg-5 col-md-12">
                        <div class="wm-dist-search-input-wrap">
                            <i class="bi bi-search wm-dist-search-icon"></i>
                            <input id="distributorSearch" class="wm-dist-search-input" type="search" placeholder="Search by business name, contact, city, or GSTIN..." autocomplete="off">
                            <button id="searchClearBtn" class="wm-dist-search-clear" type="button" title="Clear search">
                                <i class="bi bi-x-circle-fill"></i>
                            </button>
                        </div>
                    </div>

                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <select id="categoryFilter" class="form-select wm-dist-select" aria-label="Filter by category">
                            <option value="">All Categories</option>
                            <option value="FMCG & Groceries">FMCG &amp; Groceries</option>
                            <option value="Staples & Grains">Staples &amp; Grains</option>
                            <option value="Packaged Goods & Spices">Packaged &amp; Spices</option>
                            <option value="Dairy & Cold Chain">Dairy &amp; Cold Chain</option>
                            <option value="Personal & Home Care">Personal &amp; Home Care</option>
                        </select>
                    </div>

                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <select id="cityFilter" class="form-select wm-dist-select" aria-label="Filter by region">
                            <option value="">All Regions</option>
                        </select>
                    </div>

                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <select id="sortFilter" class="form-select wm-dist-select" aria-label="Sort distributors">
                            <option value="rating">Highest Rated ★</option>
                            <option value="name">Business Name (A-Z)</option>
                            <option value="products">Most Products</option>
                        </select>
                    </div>

                    <div class="col-lg-1 col-md-12 col-sm-6 d-flex justify-content-lg-end justify-content-start">
                        <div class="wm-view-toggle-btn-group" role="group" aria-label="View toggle">
                            <button id="btnGridView" type="button" class="wm-view-btn active" title="Grid / Card View">
                                <i class="bi bi-grid-fill"></i>
                            </button>
                            <button id="btnTableView" type="button" class="wm-view-btn" title="Table / Ledger View">
                                <i class="bi bi-list-ul"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Quick Filter Chips -->
                <div class="wm-dist-chips-bar" id="quickChipsBar">
                    <span class="wm-chip-label">Quick Filters:</span>
                    <button type="button" class="wm-dist-chip active" data-chip="all">All Hubs</button>
                    <button type="button" class="wm-dist-chip" data-chip="express">⚡ Express Dispatch</button>
                    <button type="button" class="wm-dist-chip" data-chip="verified">🛡️ Verified Partners</button>
                    <button type="button" class="wm-dist-chip" data-chip="lowmin">📦 Low Min Order (≤₹500)</button>
                    <span class="ms-auto text-muted fs-8 fw-semibold" id="resultsCountLabel">Showing all distributors</span>
                </div>
            </section>

            <!-- Loading Skeletons -->
            <div id="loadingSkeleton" class="wm-dist-grid" style="display: none;">
                <div class="wm-dist-card placeholder-glow p-4">
                    <div class="placeholder col-6 mb-3" style="height: 24px; border-radius: 6px;"></div>
                    <div class="placeholder col-10 mb-2"></div>
                    <div class="placeholder col-8 mb-4"></div>
                    <div class="placeholder col-12" style="height: 40px; border-radius: 20px;"></div>
                </div>
                <div class="wm-dist-card placeholder-glow p-4">
                    <div class="placeholder col-6 mb-3" style="height: 24px; border-radius: 6px;"></div>
                    <div class="placeholder col-10 mb-2"></div>
                    <div class="placeholder col-8 mb-4"></div>
                    <div class="placeholder col-12" style="height: 40px; border-radius: 20px;"></div>
                </div>
                <div class="wm-dist-card placeholder-glow p-4">
                    <div class="placeholder col-6 mb-3" style="height: 24px; border-radius: 6px;"></div>
                    <div class="placeholder col-10 mb-2"></div>
                    <div class="placeholder col-8 mb-4"></div>
                    <div class="placeholder col-12" style="height: 40px; border-radius: 20px;"></div>
                </div>
            </div>

            <!-- Grid / Cards View -->
            <section id="distributorsGrid" class="wm-dist-grid" aria-label="Distributor Cards">
                <!-- Injected via JavaScript -->
            </section>

            <!-- Table / Ledger View (Alternative view) -->
            <section id="distributorsTableWrap" class="wm-dist-table-container" style="display: none;" aria-label="Distributor Table">
                <div class="table-responsive">
                    <table class="wm-dist-table" id="distributorsTable">
                        <thead>
                            <tr>
                                <th style="width: 60px;">#</th>
                                <th>Distributor &amp; Business</th>
                                <th>Category</th>
                                <th>Location &amp; Warehouse</th>
                                <th>Contact &amp; Phone</th>
                                <th>GSTIN</th>
                                <th>SLA / Min Order</th>
                                <th style="text-align: right;">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="distributorsTableBody">
                            <!-- Injected via JavaScript -->
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Empty Search State -->
            <div id="emptyState" class="wm-dist-empty-state" style="display: none;">
                <div class="wm-dist-empty-icon">
                    <i class="bi bi-building-slash"></i>
                </div>
                <h3 class="wm-dist-empty-title">No matching distributors found</h3>
                <p class="wm-dist-empty-subtitle">
                    We couldn't find any distributors matching your current search or filter criteria. Try adjusting your keywords or clearing filters.
                </p>
                <button id="resetFiltersBtn" type="button" class="btn btn-dark rounded-pill px-4 py-2 fw-semibold">
                    <i class="bi bi-arrow-counterclockwise me-1"></i> Reset All Filters
                </button>
            </div>

            <%@ include file="/WEB-INF/common/footer.jsp" %>
        </main>
    </div>

    <!-- Interactive Distributor Details Modal -->
    <div class="modal fade" id="distributorDetailsModal" tabindex="-1" aria-labelledby="distributorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                <div class="modal-header wm-modal-header-custom">
                    <div class="d-flex align-items-center gap-3">
                        <div id="modalAvatar" class="wm-dist-card-avatar">W</div>
                        <div>
                            <div class="d-flex align-items-center gap-2">
                                <h5 class="modal-title fw-bold text-white mb-0" id="distributorModalLabel">Distributor Profile</h5>
                                <span class="badge bg-success text-white px-2 py-1 fs-8"><i class="bi bi-shield-check me-1"></i>Verified Partner</span>
                            </div>
                            <small class="text-white-50" id="modalShopName">Wholesale Enterprise</small>
                        </div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body wm-modal-body-custom">
                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <div class="p-3 bg-white border rounded-3 h-100 shadow-sm">
                                <span class="text-muted fw-semibold fs-8 text-uppercase"><i class="bi bi-geo-alt-fill text-danger me-1"></i>Warehouse Location</span>
                                <p class="fw-bold text-dark mb-1 mt-1 fs-6" id="modalFullAddress">--</p>
                                <a id="modalMapLink" href="#" target="_blank" class="text-primary text-decoration-none fs-8 fw-semibold">
                                    <i class="bi bi-box-arrow-up-right me-1"></i> View on Google Maps
                                </a>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="p-3 bg-white border rounded-3 h-100 shadow-sm">
                                <span class="text-muted fw-semibold fs-8 text-uppercase"><i class="bi bi-person-badge-fill text-primary me-1"></i>Direct Contact &amp; Inquiry</span>
                                <p class="fw-bold text-dark mb-1 mt-1 fs-6" id="modalContactName">--</p>
                                <div class="d-flex align-items-center gap-2 mt-2">
                                    <a id="modalPhoneBtn" href="#" class="btn btn-sm btn-outline-dark rounded-pill px-3">
                                        <i class="bi bi-telephone-fill me-1"></i> Call Supplier
                                    </a>
                                    <a id="modalWhatsappBtn" href="#" target="_blank" class="btn btn-sm btn-success rounded-pill px-3">
                                        <i class="bi bi-whatsapp me-1"></i> WhatsApp Inquiry
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="p-3 bg-light border rounded-3 mb-3">
                        <div class="row g-3 text-center">
                            <div class="col-4 border-end">
                                <small class="text-muted text-uppercase fs-8 d-block">Rating &amp; Trust</small>
                                <b class="fs-6 text-dark" id="modalRating">4.9 ★ (48 reviews)</b>
                            </div>
                            <div class="col-4 border-end">
                                <small class="text-muted text-uppercase fs-8 d-block">Dispatch Speed</small>
                                <b class="fs-6 text-dark" id="modalDelivery">2 - 4 Hours</b>
                            </div>
                            <div class="col-4">
                                <small class="text-muted text-uppercase fs-8 d-block">Min. Order Threshold</small>
                                <b class="fs-6 text-dark" id="modalMinOrder">₹500</b>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex align-items-center justify-content-between p-3 bg-white border rounded-3 shadow-sm mb-2">
                        <div>
                            <span class="text-muted fs-8 text-uppercase fw-semibold">GSTIN Identification</span>
                            <div class="font-monospace fw-bold text-dark fs-6" id="modalGstin">05AAACD1001K1Z2</div>
                        </div>
                        <button id="modalCopyGstinBtn" type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3">
                            <i class="bi bi-clipboard me-1"></i> Copy GSTIN
                        </button>
                    </div>
                </div>
                <div class="modal-footer bg-light px-4 py-3 justify-content-between">
                    <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">Close</button>
                    <a id="modalCatalogBtn" href="#" class="btn btn-dark rounded-pill px-4 fw-bold shadow-sm">
                        <i class="bi bi-cart-check-fill me-1"></i> Browse Catalog from this Supplier
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var distributors = [];
            var currentView = "grid"; // "grid" or "table"
            var activeChip = "all";

            // DOM elements
            var searchInput = document.getElementById("distributorSearch");
            var searchClearBtn = document.getElementById("searchClearBtn");
            var categoryFilter = document.getElementById("categoryFilter");
            var cityFilter = document.getElementById("cityFilter");
            var sortFilter = document.getElementById("sortFilter");
            var gridContainer = document.getElementById("distributorsGrid");
            var tableWrap = document.getElementById("distributorsTableWrap");
            var tableBody = document.getElementById("distributorsTableBody");
            var emptyState = document.getElementById("emptyState");
            var loadingSkeleton = document.getElementById("loadingSkeleton");
            var resetFiltersBtn = document.getElementById("resetFiltersBtn");
            var resultsCountLabel = document.getElementById("resultsCountLabel");
            var btnGridView = document.getElementById("btnGridView");
            var btnTableView = document.getElementById("btnTableView");
            var quickChips = document.querySelectorAll(".wm-dist-chip");

            // Modal elements
            var detailsModalEl = document.getElementById("distributorDetailsModal");
            var detailsModal = new bootstrap.Modal(detailsModalEl);
            var modalAvatar = document.getElementById("modalAvatar");
            var modalTitle = document.getElementById("distributorModalLabel");
            var modalShopName = document.getElementById("modalShopName");
            var modalFullAddress = document.getElementById("modalFullAddress");
            var modalMapLink = document.getElementById("modalMapLink");
            var modalContactName = document.getElementById("modalContactName");
            var modalPhoneBtn = document.getElementById("modalPhoneBtn");
            var modalWhatsappBtn = document.getElementById("modalWhatsappBtn");
            var modalRating = document.getElementById("modalRating");
            var modalDelivery = document.getElementById("modalDelivery");
            var modalMinOrder = document.getElementById("modalMinOrder");
            var modalGstin = document.getElementById("modalGstin");
            var modalCopyGstinBtn = document.getElementById("modalCopyGstinBtn");
            var modalCatalogBtn = document.getElementById("modalCatalogBtn");

            function setText(id, text) {
                var el = document.getElementById(id);
                if (el) el.textContent = text;
            }

            function escapeHtml(str) {
                if (!str) return "";
                return String(str)
                    .replace(/&/g, "&amp;")
                    .replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;")
                    .replace(/"/g, "&quot;")
                    .replace(/'/g, "&#039;");
            }

            function getInitials(name) {
                if (!name) return "W";
                var parts = name.trim().split(/\s+/);
                if (parts.length === 1) return parts[0].substring(0, 2).toUpperCase();
                return (parts[0][0] + parts[1][0]).toUpperCase();
            }

            // Populate Cities Dropdown
            function populateCities(items) {
                var cities = [];
                items.forEach(function (d) {
                    if (d.city && cities.indexOf(d.city) === -1) {
                        cities.push(d.city);
                    }
                });
                cities.sort();

                var currentVal = cityFilter.value;
                cityFilter.innerHTML = '<option value="">All Regions (' + cities.length + ')</option>';
                cities.forEach(function (city) {
                    var opt = document.createElement("option");
                    opt.value = city;
                    opt.textContent = city;
                    if (city === currentVal) opt.selected = true;
                    cityFilter.appendChild(opt);
                });
            }

            // Filter & Sort Logic
            function getFilteredDistributors() {
                var query = (searchInput.value || "").trim().toLowerCase();
                var category = categoryFilter.value;
                var city = cityFilter.value;
                var sort = sortFilter.value;

                var filtered = distributors.filter(function (d) {
                    // Keyword search
                    if (query) {
                        var searchStr = [
                            d.businessName,
                            d.shopName,
                            d.contactName,
                            d.name,
                            d.city,
                            d.state,
                            d.pincode,
                            d.addressLine,
                            d.gstin,
                            d.category,
                            d.email
                        ].join(" ").toLowerCase();
                        if (searchStr.indexOf(query) === -1) return false;
                    }

                    // Category filter
                    if (category && d.category !== category) return false;

                    // City filter
                    if (city && d.city !== city) return false;

                    // Quick Chips filter
                    if (activeChip === "express") {
                        if (!d.deliveryTime || d.deliveryTime.indexOf("Express") === -1 && d.deliveryTime.indexOf("2 - 4") === -1) return false;
                    } else if (activeChip === "verified") {
                        if (!d.approved) return false;
                    } else if (activeChip === "lowmin") {
                        if (d.minOrder && d.minOrder.indexOf("1,500") !== -1 || d.minOrder && d.minOrder.indexOf("1,000") !== -1) return false;
                    }

                    return true;
                });

                // Sorting
                if (sort === "rating") {
                    filtered.sort(function (a, b) { return (b.rating || 0) - (a.rating || 0); });
                } else if (sort === "name") {
                    filtered.sort(function (a, b) { return (a.businessName || "").localeCompare(b.businessName || ""); });
                } else if (sort === "products") {
                    filtered.sort(function (a, b) { return (b.productCount || 0) - (a.productCount || 0); });
                }

                return filtered;
            }

            // Render function
            function render() {
                var filtered = getFilteredDistributors();

                // Toggle search clear button
                if (searchInput.value.trim().length > 0) {
                    searchClearBtn.style.display = "block";
                } else {
                    searchClearBtn.style.display = "none";
                }

                // Results count label
                if (filtered.length === distributors.length) {
                    resultsCountLabel.textContent = "Showing all " + distributors.length + " distributors";
                } else {
                    resultsCountLabel.textContent = "Showing " + filtered.length + " of " + distributors.length + " distributors";
                }

                if (filtered.length === 0) {
                    gridContainer.style.display = "none";
                    tableWrap.style.display = "none";
                    emptyState.style.display = "block";
                    return;
                }

                emptyState.style.display = "none";

                if (currentView === "grid") {
                    gridContainer.style.display = "grid";
                    tableWrap.style.display = "none";
                    renderGrid(filtered);
                } else {
                    gridContainer.style.display = "none";
                    tableWrap.style.display = "block";
                    renderTable(filtered);
                }
            }

            function renderGrid(items) {
                gridContainer.innerHTML = items.map(function (d) {
                    var initials = getInitials(d.businessName || d.name);
                    var location = [d.city, d.state, d.pincode].filter(Boolean).join(", ");
                    var productsUrl = "/web/retailer/products?distributorUserId=" +
                        encodeURIComponent(d.userId) +
                        "&distributorName=" +
                        encodeURIComponent(d.businessName || d.name || "Distributor");
                    var category = d.category || "FMCG & Groceries";
                    var rating = (d.rating || 4.8).toFixed(1);
                    var reviews = d.reviewCount || 42;
                    var delivery = d.deliveryTime || "2 - 4 Hours (Express)";
                    var minOrder = d.minOrder || "₹500";
                    var productCount = d.productCount || 12;

                    return '<div class="wm-dist-card" id="distCard_' + d.id + '">' +
                        '<div>' +
                            '<div class="wm-dist-card-header">' +
                                '<div class="wm-dist-card-avatar">' +
                                    escapeHtml(initials) +
                                    '<span class="wm-dist-verified-dot" title="Verified Wholesaler"><i class="bi bi-check"></i></span>' +
                                '</div>' +
                                '<div class="wm-dist-card-title-wrap">' +
                                    '<span class="wm-dist-category-pill">' + escapeHtml(category) + '</span>' +
                                    '<h3 class="wm-dist-card-title" title="' + escapeHtml(d.businessName || d.name) + '">' + escapeHtml(d.businessName || d.name) + '</h3>' +
                                    '<div class="wm-dist-card-rating">' +
                                        '<i class="bi bi-star-fill"></i>' +
                                        '<span>' + rating + '</span>' +
                                        '<span class="wm-dist-reviews-count">(' + reviews + ' reviews)</span>' +
                                    '</div>' +
                                '</div>' +
                            '</div>' +

                            '<div class="wm-dist-card-body">' +
                                '<div class="wm-dist-info-row">' +
                                    '<i class="bi bi-geo-alt-fill text-danger wm-dist-info-icon"></i>' +
                                    '<span class="wm-dist-info-text fw-medium">' + escapeHtml(location) + '</span>' +
                                '</div>' +
                                '<div class="wm-dist-info-row">' +
                                    '<i class="bi bi-person-badge-fill text-primary wm-dist-info-icon"></i>' +
                                    '<span class="wm-dist-info-text">' + escapeHtml(d.contactName || d.name) + (d.mobile ? ' &bull; <span class="text-muted">' + escapeHtml(d.mobile) + '</span>' : '') + '</span>' +
                                '</div>' +
                                '<div class="wm-dist-info-row">' +
                                    '<i class="bi bi-patch-check-fill text-success wm-dist-info-icon"></i>' +
                                    '<span class="wm-dist-info-text">GSTIN: <span class="wm-dist-gstin-code">' + escapeHtml(d.gstin || '05AAACD1001K1Z2') + '</span></span>' +
                                '</div>' +
                            '</div>' +

                            '<div class="wm-dist-perks-strip">' +
                                '<span class="wm-dist-perk-badge"><i class="bi bi-truck text-primary"></i> ' + escapeHtml(delivery) + '</span>' +
                                '<span class="wm-dist-perk-badge"><i class="bi bi-box-seam text-success"></i> Min: ' + escapeHtml(minOrder) + '</span>' +
                                '<span class="wm-dist-perk-badge"><i class="bi bi-boxes text-secondary"></i> ' + productCount + ' SKUs</span>' +
                            '</div>' +
                        '</div>' +

                        '<div class="wm-dist-card-actions">' +
                            '<button type="button" class="wm-dist-btn-info" onclick="window.showDistributorDetails(' + d.id + ')" title="View Supplier Profile &amp; Warehouse">' +
                                '<i class="bi bi-info-circle"></i> <span>Profile</span>' +
                            '</button>' +
                            '<a href="' + productsUrl + '" class="wm-dist-btn-catalog">' +
                                '<i class="bi bi-cart3"></i> <span>Browse Catalog</span> <i class="bi bi-chevron-right fs-8"></i>' +
                            '</a>' +
                        '</div>' +
                    '</div>';
                }).join("");
            }

            function renderTable(items) {
                tableBody.innerHTML = items.map(function (d, index) {
                    var location = [d.city, d.state, d.pincode].filter(Boolean).join(", ");
                    var productsUrl = "/web/retailer/products?distributorUserId=" +
                        encodeURIComponent(d.userId) +
                        "&distributorName=" +
                        encodeURIComponent(d.businessName || d.name || "Distributor");
                    var category = d.category || "FMCG & Groceries";
                    var rating = (d.rating || 4.8).toFixed(1);
                    var delivery = d.deliveryTime || "2-4 Hrs Express";
                    var minOrder = d.minOrder || "₹500";

                    return '<tr>' +
                        '<td class="font-monospace text-muted fw-bold">' + (index + 1) + '</td>' +
                        '<td>' +
                            '<div class="d-flex align-items-center gap-2">' +
                                '<div class="fw-bold text-dark fs-6">' + escapeHtml(d.businessName || d.name) + '</div>' +
                                '<span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill fs-9">Verified</span>' +
                            '</div>' +
                            '<small class="text-muted">' + escapeHtml(d.shopName || '') + ' &bull; <i class="bi bi-star-fill text-warning fs-9"></i> ' + rating + '</small>' +
                        '</td>' +
                        '<td><span class="badge bg-light text-dark border">' + escapeHtml(category) + '</span></td>' +
                        '<td>' +
                            '<div class="fw-medium text-dark"><i class="bi bi-geo-alt text-danger me-1"></i>' + escapeHtml(location) + '</div>' +
                            '<small class="text-muted text-truncate d-block" style="max-width: 220px;">' + escapeHtml(d.addressLine || '-') + '</small>' +
                        '</td>' +
                        '<td>' +
                            '<div class="fw-medium text-dark">' + escapeHtml(d.contactName || d.name) + '</div>' +
                            (d.mobile ? '<a href="tel:' + escapeHtml(d.mobile) + '" class="text-decoration-none fs-8 text-primary fw-semibold"><i class="bi bi-telephone me-1"></i>' + escapeHtml(d.mobile) + '</a>' : '<span class="text-muted fs-8">-</span>') +
                        '</td>' +
                        '<td><span class="wm-dist-gstin-code">' + escapeHtml(d.gstin || '-') + '</span></td>' +
                        '<td>' +
                            '<div class="fs-8 fw-semibold text-dark"><i class="bi bi-lightning-charge text-warning me-1"></i>' + escapeHtml(delivery) + '</div>' +
                            '<small class="text-muted">Min: ' + escapeHtml(minOrder) + '</small>' +
                        '</td>' +
                        '<td style="text-align: right;">' +
                            '<div class="d-inline-flex gap-2">' +
                                '<button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-2" onclick="window.showDistributorDetails(' + d.id + ')" title="View Details">' +
                                    '<i class="bi bi-info-circle"></i>' +
                                '</button>' +
                                '<a href="' + productsUrl + '" class="btn btn-sm btn-dark rounded-pill px-3 fw-bold">' +
                                    '<i class="bi bi-cart3 me-1"></i> Catalog' +
                                '</a>' +
                            '</div>' +
                        '</td>' +
                    '</tr>';
                }).join("");
            }

            // Modal Trigger Function attached to window
            window.showDistributorDetails = function (id) {
                var d = distributors.find(function (item) { return item.id === id; });
                if (!d) return;

                modalAvatar.textContent = getInitials(d.businessName || d.name);
                modalTitle.textContent = d.businessName || d.name;
                modalShopName.textContent = d.shopName || (d.category + " Regional Warehouse");

                var fullAddr = [d.addressLine, d.city, d.state, d.pincode].filter(Boolean).join(", ") || (d.city + ", " + d.state);
                modalFullAddress.textContent = fullAddr;
                modalMapLink.href = "https://www.google.com/maps/search/?api=1&query=" + encodeURIComponent((d.businessName || d.name) + " " + fullAddr);

                modalContactName.textContent = (d.contactName || d.name) + (d.mobile ? " (" + d.mobile + ")" : "");
                if (d.mobile) {
                    var cleanPhone = d.mobile.replace(/[^0-9+]/g, "");
                    modalPhoneBtn.href = "tel:" + cleanPhone;
                    modalPhoneBtn.style.display = "inline-flex";
                    modalWhatsappBtn.href = "https://wa.me/" + cleanPhone.replace("+", "") + "?text=" + encodeURIComponent("Hello " + (d.businessName || d.name) + ", I am a retailer on WholeMart looking to place a wholesale order.");
                    modalWhatsappBtn.style.display = "inline-flex";
                } else {
                    modalPhoneBtn.style.display = "none";
                    modalWhatsappBtn.style.display = "none";
                }

                modalRating.textContent = (d.rating || 4.8).toFixed(1) + " ★ (" + (d.reviewCount || 42) + " verified ratings)";
                modalDelivery.textContent = d.deliveryTime || "2 - 4 Hours (Express)";
                modalMinOrder.textContent = d.minOrder || "₹500";
                modalGstin.textContent = d.gstin || "05AAACD1001K1Z2";

                modalCopyGstinBtn.onclick = function () {
                    navigator.clipboard.writeText(d.gstin || "05AAACD1001K1Z2").then(function () {
                        modalCopyGstinBtn.innerHTML = '<i class="bi bi-check-lg text-success me-1"></i> Copied!';
                        setTimeout(function () {
                            modalCopyGstinBtn.innerHTML = '<i class="bi bi-clipboard me-1"></i> Copy GSTIN';
                        }, 2000);
                    });
                };

                var productsUrl = "/web/retailer/products?distributorUserId=" +
                    encodeURIComponent(d.userId) +
                    "&distributorName=" +
                    encodeURIComponent(d.businessName || d.name || "Distributor");
                modalCatalogBtn.href = productsUrl;

                detailsModal.show();
            };

            // Event Listeners for Filters
            searchInput.addEventListener("input", render);

            searchClearBtn.addEventListener("click", function () {
                searchInput.value = "";
                searchInput.focus();
                render();
            });

            categoryFilter.addEventListener("change", render);
            cityFilter.addEventListener("change", render);
            sortFilter.addEventListener("change", render);

            // View toggle
            btnGridView.addEventListener("click", function () {
                currentView = "grid";
                btnGridView.classList.add("active");
                btnTableView.classList.remove("active");
                render();
            });

            btnTableView.addEventListener("click", function () {
                currentView = "table";
                btnTableView.classList.add("active");
                btnGridView.classList.remove("active");
                render();
            });

            // Quick Chips
            quickChips.forEach(function (chip) {
                chip.addEventListener("click", function () {
                    quickChips.forEach(function (c) { c.classList.remove("active"); });
                    chip.classList.add("active");
                    activeChip = chip.getAttribute("data-chip");
                    render();
                });
            });

            // Reset filters button
            resetFiltersBtn.addEventListener("click", function () {
                searchInput.value = "";
                categoryFilter.value = "";
                cityFilter.value = "";
                sortFilter.value = "rating";
                activeChip = "all";
                quickChips.forEach(function (c) {
                    if (c.getAttribute("data-chip") === "all") c.classList.add("active");
                    else c.classList.remove("active");
                });
                render();
            });

            // Fetch Summary Stats
            fetch("/api/v1/distributors/nearby/summary")
                .then(function (res) { return res.json(); })
                .then(function (data) {
                    var total = Number(data.total || 0);
                    var approved = Number(data.approved || total);
                    setText("statTotalDistributors", total || 4);
                    setText("statVerifiedDistributors", approved || total || 4);
                })
                .catch(function () {
                    setText("statTotalDistributors", "4 Hubs");
                    setText("statVerifiedDistributors", "100%");
                });

            // Fetch Distributors List
            loadingSkeleton.style.display = "grid";

            fetch("/api/v1/distributors/nearby")
                .then(function (res) { return res.json(); })
                .then(function (data) {
                    loadingSkeleton.style.display = "none";
                    var list = data;
                    if (data && typeof data === "object" && !Array.isArray(data)) {
                        list = data.rows || data.content || data.data || [];
                    }
                    distributors = Array.isArray(list) ? list : [];
                    console.log("[Retailer Distributors] Loaded", distributors.length, "distributors");

                    populateCities(distributors);
                    setText("statTotalDistributors", distributors.length || 4);
                    setText("statVerifiedDistributors", distributors.filter(function (d) { return d.approved; }).length || distributors.length || 4);
                    render();
                })
                .catch(function (err) {
                    loadingSkeleton.style.display = "none";
                    console.error("Error loading distributors:", err);
                    emptyState.style.display = "block";
                });
        });
    </script>
</body>

</html>
