<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Retailer Commodity Catalog</title>
    <meta name="description" content="WholeMart B2B Retailer Commodity Catalog - Browse wholesale supplies, bulk tier pricing, and instant regional dispatch.">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700;800&family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&family=IBM+Plex+Mono:wght@500;600;700&family=JetBrains+Mono:wght@500;600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css">
</head>

<body class="wm-home wm-retailer-products-page">

    <%@ include file="/WEB-INF/common/retailer-header.jsp" %>

    <div class="wm-app">
        <main>
            <!-- Hero & Telemetry Header (Inspired by home.jsp Dispatch Ledger) -->
            <section class="wm-products-hero-texture">
                <div class="container-fluid px-lg-4 px-3">
                    <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
                        <div>
                            <span class="badge wm-section-badge mb-2">
                                <span class="wm-live-pulse-dot"></span> <fmt:message key="nav.products"/> &bull; <fmt:message key="ops.live_inventory"/>
                            </span>
                            <h1 class="wm-products-hero-title">Retailer Commodity Catalog</h1>
                            <p class="wm-products-hero-subtitle" id="productHeroSubtitle">
                                Sourcing direct from verified wholesale distributors with transparent volume tiers &amp; doorstep freight dispatch.
                            </p>
                        </div>
                        <div class="d-flex align-items-center gap-2">
                            <a href="${pageContext.request.contextPath}/web/retailer/cart" class="btn wm-btn-cart-direct">
                                <i class="bi bi-bag-check-fill"></i>
                                <span>Wholesale Cart</span>
                                <span class="wm-cart-count-badge" id="heroCartCount">0</span>
                            </a>
                        </div>
                    </div>

                    <!-- Telemetry Metrics Strip (Direct reference from home.jsp operations hub) -->
                    <div class="wm-operations-telemetry-grid">
                        <div class="wm-telemetry-card" style="--card-accent: var(--wm-prod-green);">
                            <div class="wm-telemetry-icon inventory">
                                <i class="bi bi-boxes"></i>
                            </div>
                            <div class="wm-telemetry-content">
                                <h5 id="statTotalSkus">--</h5>
                                <small><fmt:message key="ops.live_inventory"/> &bull; <fmt:message key="ops.in_stock"/></small>
                            </div>
                        </div>

                        <div class="wm-telemetry-card" style="--card-accent: var(--wm-prod-blue);">
                            <div class="wm-telemetry-icon suppliers">
                                <i class="bi bi-building"></i>
                            </div>
                            <div class="wm-telemetry-content">
                                <h5 id="statDistributorsCount">--</h5>
                                <small>Regional Wholesale Hubs</small>
                            </div>
                        </div>

                        <div class="wm-telemetry-card" style="--card-accent: var(--wm-prod-amber);">
                            <div class="wm-telemetry-icon margins">
                                <i class="bi bi-percent"></i>
                            </div>
                            <div class="wm-telemetry-content">
                                <h5 id="statAvgMargin">18.5% - 35%</h5>
                                <small>Wholesale Margin vs MRP</small>
                            </div>
                        </div>

                        <div class="wm-telemetry-card" style="--card-accent: var(--wm-prod-ink);">
                            <div class="wm-telemetry-icon cart">
                                <i class="bi bi-cart-check"></i>
                            </div>
                            <div class="wm-telemetry-content">
                                <h5 id="statCartValue">Rs. 0.00</h5>
                                <small id="statCartItemsSub">0 items in manifest</small>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Main Interactive Catalog Container -->
            <div class="container-fluid px-lg-4 px-3">

                <!-- Control Center & Filter Toolbar -->
                <div class="wm-products-toolbar-wrap">
                    <div class="wm-toolbar-primary-row">
                        <!-- Search Box -->
                        <div class="wm-search-box">
                            <i class="bi bi-search"></i>
                            <input id="productSearchInput" type="search" placeholder="Search commodities by name, category, SKU, brand..." autocomplete="off">
                            <span class="wm-search-shortcut">/</span>
                            <button id="searchClearBtn" class="wm-search-clear-btn" type="button" aria-label="Clear search">
                                <i class="bi bi-x"></i>
                            </button>
                        </div>

                        <!-- Distributor Filter -->
                        <div class="wm-select-control">
                            <select id="distributorFilterSelect" aria-label="Filter by distributor">
                                <option value="">All Wholesale Hubs</option>
                            </select>
                        </div>

                        <!-- Sort Option -->
                        <div class="wm-select-control">
                            <select id="sortFilterSelect" aria-label="Sort products">
                                <option value="featured">Recommended Sourcing</option>
                                <option value="price-asc">Price: Low to High</option>
                                <option value="price-desc">Price: High to Low</option>
                                <option value="stock-desc">Stock: High to Low</option>
                                <option value="name-asc">Name: A to Z</option>
                            </select>
                        </div>

                        <!-- View Switcher (Grid vs Table) -->
                        <div class="wm-view-toggle">
                            <button id="viewGridBtn" class="wm-view-btn active" type="button" title="Commodity Card Grid">
                                <i class="bi bi-grid-fill"></i>
                                <span class="d-none d-md-inline">Grid</span>
                            </button>
                            <button id="viewTableBtn" class="wm-view-btn" type="button" title="Manifest Ledger Table">
                                <i class="bi bi-table"></i>
                                <span class="d-none d-md-inline">Ledger</span>
                            </button>
                        </div>
                    </div>

                    <!-- Category Filter Chips Bar -->
                    <div class="wm-category-filter-bar" id="categoryFilterBar">
                        <button class="wm-cat-chip active" data-category="">
                            <span class="chip-dot" style="background: var(--wm-prod-ink);"></span>
                            <span>All Commodities</span>
                            <span class="chip-count" id="countAllCats">0</span>
                        </button>
                        <!-- Dynamic category chips will be injected here -->
                    </div>
                </div>

                <!-- Active Filter Summary & Result Count -->
                <div class="wm-filter-summary-row" id="filterSummaryRow">
                    <div>
                        Showing <strong id="resultCountText" class="text-dark">0</strong> commodities matching criteria
                    </div>
                    <div class="wm-active-filter-tags" id="activeFilterTags"></div>
                </div>

                <!-- Products Display Area -->
                <div id="productsViewContainer">
                    <!-- Grid View (Default) -->
                    <div id="productsGridView" class="wm-commodity-grid">
                        <div class="wm-skel-card">
                            <div class="wm-skel-accent-bar wm-shimmer"></div>
                            <div class="wm-skel-media wm-shimmer">
                                <div class="wm-skel-media-badge-left"></div>
                                <div class="wm-skel-media-badge-right"></div>
                            </div>
                            <div class="wm-skel-body">
                                <div class="wm-skel-meta">
                                    <div class="wm-skel-sku wm-shimmer"></div>
                                    <div class="wm-skel-stock wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-title-line1 wm-shimmer"></div>
                                <div class="wm-skel-title-line2 wm-shimmer"></div>
                                <div class="wm-skel-distributor wm-shimmer"></div>
                                <div class="wm-skel-chips">
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-tier wm-shimmer"></div>
                                <div class="wm-skel-pricing">
                                    <div class="wm-skel-price-val wm-shimmer"></div>
                                    <div class="wm-skel-mrp-val wm-shimmer"></div>
                                </div>
                            </div>
                            <div class="wm-skel-actions">
                                <div class="wm-skel-presets">
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-stepper-row">
                                    <div class="wm-skel-stepper wm-shimmer"></div>
                                    <div class="wm-skel-add-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-calc-link wm-shimmer"></div>
                            </div>
                        </div>
                        <div class="wm-skel-card">
                            <div class="wm-skel-accent-bar wm-shimmer"></div>
                            <div class="wm-skel-media wm-shimmer">
                                <div class="wm-skel-media-badge-left"></div>
                                <div class="wm-skel-media-badge-right"></div>
                            </div>
                            <div class="wm-skel-body">
                                <div class="wm-skel-meta">
                                    <div class="wm-skel-sku wm-shimmer"></div>
                                    <div class="wm-skel-stock wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-title-line1 wm-shimmer"></div>
                                <div class="wm-skel-title-line2 wm-shimmer"></div>
                                <div class="wm-skel-distributor wm-shimmer"></div>
                                <div class="wm-skel-chips">
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-tier wm-shimmer"></div>
                                <div class="wm-skel-pricing">
                                    <div class="wm-skel-price-val wm-shimmer"></div>
                                    <div class="wm-skel-mrp-val wm-shimmer"></div>
                                </div>
                            </div>
                            <div class="wm-skel-actions">
                                <div class="wm-skel-presets">
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-stepper-row">
                                    <div class="wm-skel-stepper wm-shimmer"></div>
                                    <div class="wm-skel-add-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-calc-link wm-shimmer"></div>
                            </div>
                        </div>
                        <div class="wm-skel-card">
                            <div class="wm-skel-accent-bar wm-shimmer"></div>
                            <div class="wm-skel-media wm-shimmer">
                                <div class="wm-skel-media-badge-left"></div>
                                <div class="wm-skel-media-badge-right"></div>
                            </div>
                            <div class="wm-skel-body">
                                <div class="wm-skel-meta">
                                    <div class="wm-skel-sku wm-shimmer"></div>
                                    <div class="wm-skel-stock wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-title-line1 wm-shimmer"></div>
                                <div class="wm-skel-title-line2 wm-shimmer"></div>
                                <div class="wm-skel-distributor wm-shimmer"></div>
                                <div class="wm-skel-chips">
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-tier wm-shimmer"></div>
                                <div class="wm-skel-pricing">
                                    <div class="wm-skel-price-val wm-shimmer"></div>
                                    <div class="wm-skel-mrp-val wm-shimmer"></div>
                                </div>
                            </div>
                            <div class="wm-skel-actions">
                                <div class="wm-skel-presets">
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-stepper-row">
                                    <div class="wm-skel-stepper wm-shimmer"></div>
                                    <div class="wm-skel-add-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-calc-link wm-shimmer"></div>
                            </div>
                        </div>
                        <div class="wm-skel-card">
                            <div class="wm-skel-accent-bar wm-shimmer"></div>
                            <div class="wm-skel-media wm-shimmer">
                                <div class="wm-skel-media-badge-left"></div>
                                <div class="wm-skel-media-badge-right"></div>
                            </div>
                            <div class="wm-skel-body">
                                <div class="wm-skel-meta">
                                    <div class="wm-skel-sku wm-shimmer"></div>
                                    <div class="wm-skel-stock wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-title-line1 wm-shimmer"></div>
                                <div class="wm-skel-title-line2 wm-shimmer"></div>
                                <div class="wm-skel-distributor wm-shimmer"></div>
                                <div class="wm-skel-chips">
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-tier wm-shimmer"></div>
                                <div class="wm-skel-pricing">
                                    <div class="wm-skel-price-val wm-shimmer"></div>
                                    <div class="wm-skel-mrp-val wm-shimmer"></div>
                                </div>
                            </div>
                            <div class="wm-skel-actions">
                                <div class="wm-skel-presets">
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-stepper-row">
                                    <div class="wm-skel-stepper wm-shimmer"></div>
                                    <div class="wm-skel-add-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-calc-link wm-shimmer"></div>
                            </div>
                        </div>
                        <div class="wm-skel-card">
                            <div class="wm-skel-accent-bar wm-shimmer"></div>
                            <div class="wm-skel-media wm-shimmer">
                                <div class="wm-skel-media-badge-left"></div>
                                <div class="wm-skel-media-badge-right"></div>
                            </div>
                            <div class="wm-skel-body">
                                <div class="wm-skel-meta">
                                    <div class="wm-skel-sku wm-shimmer"></div>
                                    <div class="wm-skel-stock wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-title-line1 wm-shimmer"></div>
                                <div class="wm-skel-title-line2 wm-shimmer"></div>
                                <div class="wm-skel-distributor wm-shimmer"></div>
                                <div class="wm-skel-chips">
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-tier wm-shimmer"></div>
                                <div class="wm-skel-pricing">
                                    <div class="wm-skel-price-val wm-shimmer"></div>
                                    <div class="wm-skel-mrp-val wm-shimmer"></div>
                                </div>
                            </div>
                            <div class="wm-skel-actions">
                                <div class="wm-skel-presets">
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-stepper-row">
                                    <div class="wm-skel-stepper wm-shimmer"></div>
                                    <div class="wm-skel-add-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-calc-link wm-shimmer"></div>
                            </div>
                        </div>
                        <div class="wm-skel-card">
                            <div class="wm-skel-accent-bar wm-shimmer"></div>
                            <div class="wm-skel-media wm-shimmer">
                                <div class="wm-skel-media-badge-left"></div>
                                <div class="wm-skel-media-badge-right"></div>
                            </div>
                            <div class="wm-skel-body">
                                <div class="wm-skel-meta">
                                    <div class="wm-skel-sku wm-shimmer"></div>
                                    <div class="wm-skel-stock wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-title-line1 wm-shimmer"></div>
                                <div class="wm-skel-title-line2 wm-shimmer"></div>
                                <div class="wm-skel-distributor wm-shimmer"></div>
                                <div class="wm-skel-chips">
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                    <div class="wm-skel-chip wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-tier wm-shimmer"></div>
                                <div class="wm-skel-pricing">
                                    <div class="wm-skel-price-val wm-shimmer"></div>
                                    <div class="wm-skel-mrp-val wm-shimmer"></div>
                                </div>
                            </div>
                            <div class="wm-skel-actions">
                                <div class="wm-skel-presets">
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                    <div class="wm-skel-preset-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-stepper-row">
                                    <div class="wm-skel-stepper wm-shimmer"></div>
                                    <div class="wm-skel-add-btn wm-shimmer"></div>
                                </div>
                                <div class="wm-skel-calc-link wm-shimmer"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Ledger Table View (Hidden by default) -->
                    <div id="productsTableView" class="wm-manifest-table-card d-none">
                        <div class="table-responsive">
                            <table class="wm-manifest-table">
                                <thead>
                                    <tr>
                                        <th>Commodity &amp; Code</th>
                                        <th>Category</th>
                                        <th>Wholesale Hub</th>
                                        <th>Pack Specs</th>
                                        <th>Available Stock</th>
                                        <th>Wholesale Rate</th>
                                        <th>MRP / Margin</th>
                                        <th>Bulk Order Qty</th>
                                        <th class="text-end">Action</th>
                                    </tr>
                                </thead>
                                <tbody id="manifestTableBody">
                                    <!-- Table rows or skeleton rows injected via JS -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Empty State (Hidden unless no products match) -->
                <div id="productsEmptyState" class="wm-products-empty-state d-none">
                    <i class="bi bi-inbox-fill"></i>
                    <h3>No Commodities Found</h3>
                    <p>No products match your active search filters or selected distributor.</p>
                    <button class="btn wm-btn-primary" id="resetFiltersBtn" type="button">
                        <i class="bi bi-arrow-counterclockwise"></i> Reset All Filters
                    </button>
                </div>

            </div>
        </main>

        <%@ include file="/WEB-INF/common/footer.jsp" %>
    </div>

    <!-- Floating Quick Cart Manifest Bar -->
    <div id="floatingCartBar" class="wm-floating-cart-bar" aria-live="polite">
        <div class="wm-floating-cart-info">
            <i class="bi bi-cart3 fs-5 text-warning"></i>
            <div>
                <span id="floatingCartItemsCount">0 commodities</span> in manifest &bull;
                <span class="wm-floating-cart-total" id="floatingCartTotalAmount">Rs. 0.00</span>
            </div>
        </div>
        <a href="${pageContext.request.contextPath}/web/retailer/cart" class="wm-btn-floating-checkout">
            <span>Review &amp; Place Order</span>
            <i class="bi bi-arrow-right"></i>
        </a>
    </div>

    <!-- Toast Notification Banner -->
    <div id="cartToastNotification" class="wm-cart-toast" role="alert" aria-live="assertive">
        <i class="bi bi-check-circle-fill text-success fs-5" id="toastIcon"></i>
        <div class="flex-grow-1" id="toastMessage">Item added to cart</div>
        <a href="${pageContext.request.contextPath}/web/retailer/cart" class="btn btn-sm btn-outline-light text-nowrap ms-2">View Cart</a>
    </div>

    <!-- Freight Delivery Estimator Modal (Referencing home.jsp modal styling) -->
    <div id="freightModalBackdrop" class="wm-modal-backdrop" role="dialog" aria-modal="true" aria-labelledby="freightModalTitle">
        <div class="wm-modal-dialog">
            <div class="wm-modal-header">
                <h4 id="freightModalTitle"><i class="bi bi-truck text-success me-2"></i>Freight &amp; Route Estimator</h4>
                <button type="button" class="btn-close" id="closeFreightModalBtn" aria-label="Close"></button>
            </div>
            <div class="wm-modal-body">
                <p class="text-muted small mb-3">
                    Calculate estimated delivery freight rates for this commodity based on vehicle size, distance, and wholesale weight slabs.
                </p>
                <div class="card bg-light border-0 p-3 mb-3">
                    <div class="d-flex justify-content-between align-items-center mb-1">
                        <strong id="modalProdName" class="text-dark">Commodity Item</strong>
                        <span id="modalProdSku" class="badge bg-secondary">#SKU-0000</span>
                    </div>
                    <div class="small text-muted" id="modalProdSpecs">Pack: 50kg Bag &bull; Origin: Apex Suppliers, Jaspur</div>
                </div>

                <form id="freightCalcForm" class="row g-3">
                    <div class="col-6">
                        <label class="form-label small fw-bold">Order Quantity (Units)</label>
                        <input type="number" id="calcModalQty" class="form-control" value="5" min="1" max="500">
                    </div>
                    <div class="col-6">
                        <label class="form-label small fw-bold">Delivery Vehicle</label>
                        <select id="calcModalVehicle" class="form-select">
                            <option value="AUTO_3W">3-Wheeler Auto / E-Loader (1.00x)</option>
                            <option value="TATA_ACE">Tata Ace / Chhota Hathi (1.30x)</option>
                            <option value="PICKUP_1TON">1.5-Ton Pickup Truck (1.50x)</option>
                            <option value="TRUCK_HEAVY">14ft Commercial Truck (2.00x)</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <label class="form-label small fw-bold">Commercial Route Corridor</label>
                        <select id="calcModalRoute" class="form-select">
                            <option value="14.8" data-pickup="Kashipur" data-dropoff="Jaspur">Kashipur Depot &rarr; Jaspur Retail Hub (14.8 km)</option>
                            <option value="26.4" data-pickup="Kashipur" data-dropoff="Ramnagar">Kashipur Depot &rarr; Ramnagar Hub (26.4 km)</option>
                            <option value="54.0" data-pickup="Kashipur" data-dropoff="Rudrapur">Kashipur Depot &rarr; Rudrapur Hub (54.0 km)</option>
                            <option value="4.5" data-pickup="Local" data-dropoff="Local">Intra-City Local Depot Dispatch (4.5 km)</option>
                        </select>
                    </div>
                </form>

                <div id="freightCalcResult" class="mt-3 p-3 border rounded bg-white">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <small class="text-muted text-uppercase fw-bold">Estimated Delivery Fee</small>
                            <h3 class="mb-0 text-success fw-bold" id="calcEstimatedFee">Rs. --</h3>
                        </div>
                        <div class="text-end small text-muted" id="calcWeightDetails">
                            Weight: ~25.0 kg<br>Distance: 14.8 km
                        </div>
                    </div>
                </div>
            </div>
            <div class="wm-modal-footer">
                <button type="button" class="btn btn-secondary btn-sm" id="dismissFreightModalBtn">Close</button>
                <button type="button" class="btn wm-btn-primary btn-sm" id="modalAddToCartBtn">
                    <i class="bi bi-cart-plus"></i> Add Quantity to Cart
                </button>
            </div>
        </div>
    </div>

    <!-- Client-side Interactive Engine -->
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // State
        var allProducts = [];
        var allDistributors = [];
        var activeCart = [];
        var activeCategory = "";
        var activeDistributor = "";
        var activeSort = "featured";
        var currentViewMode = "grid"; // "grid" | "table"
        var activeModalProduct = null;
        var toastTimeout = null;

        // Category Palette Mapping for visual distinction
        var CATEGORY_CONFIG = {
            "Grocery": { color: "#1B5E3C", icon: "bi-basket2-fill", fallbackImg: "${pageContext.request.contextPath}/images/wholemart_operations.jpg" },
            "Dairy": { color: "#1E5BB8", icon: "bi-cup-hot-fill", fallbackImg: "${pageContext.request.contextPath}/images/wholemart_operations.jpg" },
            "Home": { color: "#C67F14", icon: "bi-house-door-fill", fallbackImg: "${pageContext.request.contextPath}/images/wholemart_operations.jpg" },
            "Fashion": { color: "#7A4B8A", icon: "bi-tag-fill", fallbackImg: "${pageContext.request.contextPath}/images/wholemart_operations.jpg" },
            "Electronics": { color: "#2E4057", icon: "bi-plug-fill", fallbackImg: "${pageContext.request.contextPath}/images/wholemart_operations.jpg" }
        };

        function getCategoryStyle(cat) {
            return CATEGORY_CONFIG[cat] || {
                color: "#2E4057",
                icon: "bi-box-seam-fill",
                fallbackImg: "${pageContext.request.contextPath}/images/wholemart_operations.jpg"
            };
        }

        // Format Currency Helper
        function formatMoney(amount) {
            var num = Number(amount || 0);
            return "Rs. " + num.toLocaleString("en-IN", { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }

        function escapeHtml(str) {
            return String(str == null ? "" : str)
                .replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
        }

        // Elements
        var searchInput = document.getElementById("productSearchInput");
        var searchClearBtn = document.getElementById("searchClearBtn");
        var distributorSelect = document.getElementById("distributorFilterSelect");
        var sortSelect = document.getElementById("sortFilterSelect");
        var viewGridBtn = document.getElementById("viewGridBtn");
        var viewTableBtn = document.getElementById("viewTableBtn");
        var categoryFilterBar = document.getElementById("categoryFilterBar");
        var productsGridView = document.getElementById("productsGridView");
        var productsTableView = document.getElementById("productsTableView");
        var manifestTableBody = document.getElementById("manifestTableBody");
        var productsEmptyState = document.getElementById("productsEmptyState");
        var resultCountText = document.getElementById("resultCountText");
        var resetFiltersBtn = document.getElementById("resetFiltersBtn");
        var activeFilterTags = document.getElementById("activeFilterTags");
        var productHeroSubtitle = document.getElementById("productHeroSubtitle");

        // Telemetry & Stats Elements
        var statTotalSkus = document.getElementById("statTotalSkus");
        var statDistributorsCount = document.getElementById("statDistributorsCount");
        var statCartValue = document.getElementById("statCartValue");
        var statCartItemsSub = document.getElementById("statCartItemsSub");
        var heroCartCount = document.getElementById("heroCartCount");
        var floatingCartBar = document.getElementById("floatingCartBar");
        var floatingCartItemsCount = document.getElementById("floatingCartItemsCount");
        var floatingCartTotalAmount = document.getElementById("floatingCartTotalAmount");

        // Parse URL Params
        var urlParams = new URLSearchParams(window.location.search);
        var paramDistributorId = urlParams.get("distributorUserId") || urlParams.get("distributorId");
        var paramDistributorName = urlParams.get("distributorName");

        if (paramDistributorName) {
            productHeroSubtitle.innerHTML = "Browsing wholesale inventory from <b>" + escapeHtml(paramDistributorName) + "</b>";
        }

        // Keyboard Shortcut: '/' to focus search
        document.addEventListener("keydown", function (e) {
            if (e.key === "/" && document.activeElement !== searchInput) {
                e.preventDefault();
                searchInput.focus();
                searchInput.select();
            }
        });

        // Search Clear
        searchInput.addEventListener("input", function () {
            searchClearBtn.style.display = searchInput.value ? "block" : "none";
            renderProducts();
        });

        searchClearBtn.addEventListener("click", function () {
            searchInput.value = "";
            searchClearBtn.style.display = "none";
            renderProducts();
            searchInput.focus();
        });

        // View Mode Switcher
        viewGridBtn.addEventListener("click", function () {
            currentViewMode = "grid";
            viewGridBtn.classList.add("active");
            viewTableBtn.classList.remove("active");
            productsGridView.classList.remove("d-none");
            productsTableView.classList.add("d-none");
        });

        viewTableBtn.addEventListener("click", function () {
            currentViewMode = "table";
            viewTableBtn.classList.add("active");
            viewGridBtn.classList.remove("active");
            productsGridView.classList.add("d-none");
            productsTableView.classList.remove("d-none");
        });

        distributorSelect.addEventListener("change", function () {
            activeDistributor = distributorSelect.value;
            renderProducts();
        });

        sortSelect.addEventListener("change", function () {
            activeSort = sortSelect.value;
            renderProducts();
        });

        resetFiltersBtn.addEventListener("click", function () {
            searchInput.value = "";
            searchClearBtn.style.display = "none";
            activeCategory = "";
            activeDistributor = "";
            activeSort = "featured";
            distributorSelect.value = "";
            sortSelect.value = "featured";
            updateCategoryChipsUI();
            renderProducts();
        });

        // Toast Feedback
        function showToast(message, isError) {
            var toast = document.getElementById("cartToastNotification");
            var icon = document.getElementById("toastIcon");
            var msg = document.getElementById("toastMessage");
            if (!toast) return;

            msg.textContent = message;
            toast.classList.toggle("is-error", Boolean(isError));
            if (isError) {
                icon.className = "bi bi-exclamation-triangle-fill text-danger fs-5";
            } else {
                icon.className = "bi bi-check-circle-fill text-success fs-5";
            }

            toast.classList.add("is-visible");
            if (toastTimeout) clearTimeout(toastTimeout);
            toastTimeout = setTimeout(function () {
                toast.classList.remove("is-visible");
            }, 3200);
        }

        // Populate Category Filter Chips
        function renderCategoryChips() {
            var catCounts = {};
            allProducts.forEach(function (p) {
                var c = p.category || "General";
                catCounts[c] = (catCounts[c] || 0) + 1;
            });

            document.getElementById("countAllCats").textContent = allProducts.length;

            var existingChips = categoryFilterBar.querySelectorAll(".wm-cat-chip:not([data-category=''])");
            existingChips.forEach(function (el) { el.remove(); });

            Object.keys(catCounts).sort().forEach(function (cat) {
                var btn = document.createElement("button");
                btn.type = "button";
                btn.className = "wm-cat-chip" + (activeCategory === cat ? " active" : "");
                btn.dataset.category = cat;

                var style = getCategoryStyle(cat);
                btn.innerHTML = '<span class="chip-dot" style="background:' + style.color + '"></span>' +
                                '<span>' + escapeHtml(cat) + '</span>' +
                                '<span class="chip-count">' + catCounts[cat] + '</span>';

                btn.addEventListener("click", function () {
                    activeCategory = (activeCategory === cat) ? "" : cat;
                    updateCategoryChipsUI();
                    renderProducts();
                });

                categoryFilterBar.appendChild(btn);
            });

            categoryFilterBar.querySelector("[data-category='']").addEventListener("click", function () {
                activeCategory = "";
                updateCategoryChipsUI();
                renderProducts();
            });
        }

        function updateCategoryChipsUI() {
            var chips = categoryFilterBar.querySelectorAll(".wm-cat-chip");
            chips.forEach(function (chip) {
                var cat = chip.dataset.category || "";
                chip.classList.toggle("active", cat === activeCategory);
            });
        }

        // Populate Distributor Dropdown
        function renderDistributorSelect() {
            distributorSelect.innerHTML = '<option value="">All Wholesale Hubs (' + (allDistributors.length || "Active") + ')</option>';
            allDistributors.forEach(function (d) {
                var opt = document.createElement("option");
                opt.value = d.userId || d.id;
                opt.textContent = (d.shopName || d.name) + " (" + (d.city || "Jaspur Hub") + ")";
                distributorSelect.appendChild(opt);
            });

            if (paramDistributorId) {
                distributorSelect.value = paramDistributorId;
                activeDistributor = paramDistributorId;
            }
        }

        // Fetch Cart
        function syncCart() {
            fetch("/api/v1/cart")
                .then(function (res) { return res.json(); })
                .then(function (cartItems) {
                    activeCart = Array.isArray(cartItems) ? cartItems : [];
                    var totalQty = activeCart.reduce(function (sum, item) { return sum + Number(item.quantity || 1); }, 0);
                    var totalAmount = activeCart.reduce(function (sum, item) {
                        return sum + (Number(item.quantity || 1) * Number(item.unitPrice || item.price || 0));
                    }, 0);

                    heroCartCount.textContent = totalQty;
                    statCartValue.textContent = formatMoney(totalAmount);
                    statCartItemsSub.textContent = totalQty + " item" + (totalQty === 1 ? "" : "s") + " in manifest";

                    // Floating Cart Bar
                    if (totalQty > 0) {
                        floatingCartItemsCount.textContent = totalQty + " item" + (totalQty === 1 ? "" : "s");
                        floatingCartTotalAmount.textContent = formatMoney(totalAmount);
                        floatingCartBar.classList.add("is-visible");
                    } else {
                        floatingCartBar.classList.remove("is-visible");
                    }
                })
                .catch(function (e) {
                    console.error("Cart sync error:", e);
                });
        }

        // Add to Cart API Call
        function addToCart(productId, quantity, btnElement) {
            var pId = Number(productId);
            var qty = Number(quantity || 1);

            if (btnElement) {
                btnElement.disabled = true;
                btnElement.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span>';
            }

            fetch("/api/v1/cart/items", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ productId: pId, quantity: qty })
            })
            .then(function (res) {
                if (!res.ok) throw new Error("Cart request failed");
                return res.json();
            })
            .then(function (data) {
                var prod = allProducts.find(function (p) { return p.id === pId; });
                var pName = prod ? prod.name : "Commodity";

                showToast(qty + "x " + pName + " added to Wholesale Cart", false);
                syncCart();

                if (btnElement) {
                    btnElement.classList.add("is-added");
                    btnElement.innerHTML = '<i class="bi bi-check2"></i> Added';
                    setTimeout(function () {
                        btnElement.disabled = false;
                        btnElement.classList.remove("is-added");
                        btnElement.innerHTML = '<i class="bi bi-cart-plus"></i> Add';
                    }, 1400);
                }
            })
            .catch(function (err) {
                console.error("Add to cart error:", err);
                showToast("Failed to add commodity to cart. Please retry.", true);
                if (btnElement) {
                    btnElement.disabled = false;
                    btnElement.innerHTML = '<i class="bi bi-cart-plus"></i> Add';
                }
            });
        }

        // Template for Grid Card
        function renderCardHTML(p) {
            var sku = p.sku || ("#SKU-" + String(p.id).padStart(5, "0"));
            var category = p.category || "General";
            var catStyle = getCategoryStyle(category);
            var distName = "Apex Wholesale Suppliers";
            var distObj = allDistributors.find(function (d) { return (d.userId == p.distributorUserId || d.id == p.distributorId); });
            if (distObj) distName = distObj.shopName || distObj.name;

            var unitPrice = Number(p.unitPrice || p.price || 0);
            var mrp = Number(p.mrp || 0);
            if (mrp <= unitPrice) mrp = Math.round(unitPrice * 1.22);
            var savingsPct = Math.max(8, Math.round(((mrp - unitPrice) / mrp) * 100));

            var stockQty = Number(p.stock != null ? p.stock : 5000);
            var packSize = p.packSize || p.unit || "50kg Bulk Sack";
            var brandName = p.brand || "WholeMart Verified";

            var imgSrc = p.imageUrl || p.image_url || "${pageContext.request.contextPath}/images/wholemart_operations.jpg";

            var bulkTierSavings = Math.round(unitPrice * 0.05);

            return '<div class="wm-commodity-card wm-card-enter" style="--cat-color:' + catStyle.color + '" data-id="' + p.id + '">' +
                '<div class="wm-card-accent-bar"></div>' +
                '<div class="wm-card-media-wrap">' +
                    '<img class="wm-card-img" src="' + imgSrc + '" alt="' + escapeHtml(p.name) + '" onerror="this.onerror=null;this.src=\'/images/wholemart_operations.jpg\';">' +
                    '<div class="wm-media-top-badges">' +
                        '<span class="wm-badge-category">' + escapeHtml(category) + '</span>' +
                        '<span class="wm-badge-savings">Save ' + savingsPct + '%</span>' +
                    '</div>' +
                '</div>' +
                '<div class="wm-card-body">' +
                    '<div class="wm-card-meta-line">' +
                        '<span class="wm-card-sku">' + escapeHtml(sku) + '</span>' +
                        '<span class="wm-stock-indicator in-stock"><i class="bi bi-check-circle-fill"></i> In Stock</span>' +
                    '</div>' +
                    '<h3 class="wm-card-title" title="' + escapeHtml(p.name) + '">' + escapeHtml(p.name) + '</h3>' +
                    '<div class="wm-card-distributor-info">' +
                        '<i class="bi bi-building"></i> <span>' + escapeHtml(distName) + '</span>' +
                    '</div>' +
                    '<div class="wm-card-spec-tags">' +
                        '<span class="wm-spec-tag"><i class="bi bi-box-seam"></i> ' + escapeHtml(packSize) + '</span>' +
                        '<span class="wm-spec-tag"><i class="bi bi-shield-check"></i> ' + escapeHtml(brandName) + '</span>' +
                    '</div>' +
                    '<div class="wm-bulk-tier-hint">' +
                        '<i class="bi bi-tag-fill"></i> Bulk 10+ Save ' + formatMoney(bulkTierSavings) + '/unit' +
                    '</div>' +
                    '<div class="wm-card-pricing-block">' +
                        '<div class="wm-price-main">' +
                            '<small>Wholesale Rate</small>' +
                            formatMoney(unitPrice) +
                        '</div>' +
                        '<div class="wm-price-mrp-group">' +
                            '<span>MRP: </span><span class="wm-mrp-strike">' + formatMoney(mrp) + '</span>' +
                        '</div>' +
                    '</div>' +
                '</div>' +
                '<div class="wm-card-actions">' +
                    '<div class="wm-bulk-preset-row">' +
                        '<span class="text-muted small" style="font-size:0.68rem; font-weight:700;">QUICK BULK:</span>' +
                        '<button type="button" class="wm-preset-btn" data-preset="5">+5</button>' +
                        '<button type="button" class="wm-preset-btn" data-preset="10">+10</button>' +
                        '<button type="button" class="wm-preset-btn" data-preset="25">+25</button>' +
                    '</div>' +
                    '<div class="wm-stepper-add-row">' +
                        '<div class="wm-qty-stepper">' +
                            '<button type="button" class="wm-qty-btn qty-minus" aria-label="Decrease quantity">&minus;</button>' +
                            '<input type="number" class="wm-qty-input" value="1" min="1" max="500" aria-label="Quantity">' +
                            '<button type="button" class="wm-qty-btn qty-plus" aria-label="Increase quantity">&plus;</button>' +
                        '</div>' +
                        '<button type="button" class="wm-btn-add-commodity" data-product-id="' + p.id + '">' +
                            '<i class="bi bi-cart-plus"></i> Add' +
                        '</button>' +
                    '</div>' +
                    '<a href="javascript:void(0)" class="wm-freight-calc-link" data-calc-id="' + p.id + '">' +
                        '<i class="bi bi-calculator"></i> Estimate Freight &amp; Delivery' +
                    '</a>' +
                '</div>' +
            '</div>';
        }

        // Template for Table Row
        function renderTableRowHTML(p) {
            var sku = p.sku || ("#SKU-" + String(p.id).padStart(5, "0"));
            var category = p.category || "General";
            var catStyle = getCategoryStyle(category);
            var distName = "Apex Wholesale Hub";
            var distObj = allDistributors.find(function (d) { return (d.userId == p.distributorUserId || d.id == p.distributorId); });
            if (distObj) distName = distObj.shopName || distObj.name;

            var unitPrice = Number(p.unitPrice || p.price || 0);
            var mrp = Number(p.mrp || 0);
            if (mrp <= unitPrice) mrp = Math.round(unitPrice * 1.22);
            var savingsPct = Math.max(8, Math.round(((mrp - unitPrice) / mrp) * 100));

            var packSize = p.packSize || p.unit || "50kg Sack";
            var imgSrc = p.imageUrl || p.image_url || "${pageContext.request.contextPath}/images/wholemart_operations.jpg";

            return '<tr data-id="' + p.id + '">' +
                '<td>' +
                    '<div class="wm-table-prod-cell">' +
                        '<img class="wm-table-thumb" src="' + imgSrc + '" alt="' + escapeHtml(p.name) + '" onerror="this.onerror=null;this.src=\'/images/wholemart_operations.jpg\';">' +
                        '<div>' +
                            '<p class="wm-table-prod-name">' + escapeHtml(p.name) + '</p>' +
                            '<span class="wm-card-sku">' + escapeHtml(sku) + '</span>' +
                        '</div>' +
                    '</div>' +
                '</td>' +
                '<td><span class="badge" style="background:' + catStyle.color + '; color:#fff;">' + escapeHtml(category) + '</span></td>' +
                '<td><small class="fw-semibold text-muted"><i class="bi bi-building"></i> ' + escapeHtml(distName) + '</small></td>' +
                '<td><span class="wm-spec-tag">' + escapeHtml(packSize) + '</span></td>' +
                '<td><span class="text-success fw-bold small"><i class="bi bi-check-circle-fill"></i> Available</span></td>' +
                '<td><strong class="text-dark fs-6">' + formatMoney(unitPrice) + '</strong></td>' +
                '<td>' +
                    '<div class="small">' +
                        '<span class="text-decoration-line-through text-muted">' + formatMoney(mrp) + '</span> ' +
                        '<span class="badge bg-success-subtle text-success">Save ' + savingsPct + '%</span>' +
                    '</div>' +
                '</td>' +
                '<td>' +
                    '<div class="wm-qty-stepper" style="flex:0 0 95px; height:34px;">' +
                        '<button type="button" class="wm-qty-btn qty-minus" style="height:34px;">&minus;</button>' +
                        '<input type="number" class="wm-qty-input" value="1" min="1" max="500" style="height:34px;">' +
                        '<button type="button" class="wm-qty-btn qty-plus" style="height:34px;">&plus;</button>' +
                    '</div>' +
                '</td>' +
                '<td class="text-end">' +
                    '<button type="button" class="btn wm-btn-primary btn-sm wm-table-add-btn" data-product-id="' + p.id + '">' +
                        '<i class="bi bi-cart-plus"></i> Add' +
                    '</button>' +
                '</td>' +
            '</tr>';
        }

        // Render Filtered Products
        function renderProducts() {
            var query = (searchInput.value || "").trim().toLowerCase();

            var filtered = allProducts.filter(function (p) {
                var matchesQuery = true;
                if (query) {
                    var searchTarget = [
                        p.name,
                        p.category,
                        p.brand,
                        p.packSize,
                        p.sku,
                        p.distributorUserId
                    ].join(" ").toLowerCase();
                    matchesQuery = searchTarget.indexOf(query) !== -1;
                }

                var matchesCat = !activeCategory || p.category === activeCategory;
                var matchesDist = !activeDistributor || String(p.distributorUserId || p.distributorId) === String(activeDistributor);

                return matchesQuery && matchesCat && matchesDist;
            });

            // Sorting
            filtered.sort(function (a, b) {
                var priceA = Number(a.unitPrice || a.price || 0);
                var priceB = Number(b.unitPrice || b.price || 0);
                var stockA = Number(a.stock || 0);
                var stockB = Number(b.stock || 0);

                if (activeSort === "price-asc") return priceA - priceB;
                if (activeSort === "price-desc") return priceB - priceA;
                if (activeSort === "stock-desc") return stockB - stockA;
                if (activeSort === "name-asc") return (a.name || "").localeCompare(b.name || "");
                return b.id - a.id;
            });

            resultCountText.textContent = filtered.length;

            // Render Active Filter Tags
            var tagsHTML = "";
            if (activeCategory) {
                tagsHTML += '<span class="wm-filter-tag">Category: ' + escapeHtml(activeCategory) + ' <i class="bi bi-x-circle-fill tag-remove-cat"></i></span>';
            }
            if (activeDistributor) {
                var dObj = allDistributors.find(function (d) { return String(d.userId || d.id) === String(activeDistributor); });
                var dLabel = dObj ? (dObj.shopName || dObj.name) : ("Distributor #" + activeDistributor);
                tagsHTML += '<span class="wm-filter-tag">Hub: ' + escapeHtml(dLabel) + ' <i class="bi bi-x-circle-fill tag-remove-dist"></i></span>';
            }
            if (query) {
                tagsHTML += '<span class="wm-filter-tag">Query: "' + escapeHtml(query) + '" <i class="bi bi-x-circle-fill tag-remove-query"></i></span>';
            }
            activeFilterTags.innerHTML = tagsHTML;

            // Bind tag removals
            var remCat = activeFilterTags.querySelector(".tag-remove-cat");
            if (remCat) remCat.addEventListener("click", function () { activeCategory = ""; updateCategoryChipsUI(); renderProducts(); });
            var remDist = activeFilterTags.querySelector(".tag-remove-dist");
            if (remDist) remDist.addEventListener("click", function () { activeDistributor = ""; distributorSelect.value = ""; renderProducts(); });
            var remQuery = activeFilterTags.querySelector(".tag-remove-query");
            if (remQuery) remQuery.addEventListener("click", function () { searchInput.value = ""; searchClearBtn.style.display = "none"; renderProducts(); });

            // Empty state handling
            if (filtered.length === 0) {
                productsGridView.innerHTML = "";
                manifestTableBody.innerHTML = "";
                productsEmptyState.classList.remove("d-none");
            } else {
                productsEmptyState.classList.add("d-none");
                productsGridView.innerHTML = filtered.map(renderCardHTML).join("");
                manifestTableBody.innerHTML = filtered.map(renderTableRowHTML).join("");
            }
        }

        // Delegate Click Actions (Steppers, Quick presets, Add to Cart, Freight Calc)
        document.getElementById("productsViewContainer").addEventListener("click", function (event) {
            var target = event.target;

            // Plus quantity
            var plusBtn = target.closest(".qty-plus");
            if (plusBtn) {
                var stepper = plusBtn.closest(".wm-qty-stepper");
                var input = stepper.querySelector(".wm-qty-input");
                input.value = Math.min(500, Number(input.value || 1) + 1);
                return;
            }

            // Minus quantity
            var minusBtn = target.closest(".qty-minus");
            if (minusBtn) {
                var stepper = minusBtn.closest(".wm-qty-stepper");
                var input = stepper.querySelector(".wm-qty-input");
                input.value = Math.max(1, Number(input.value || 1) - 1);
                return;
            }

            // Quick Preset Buttons (+5, +10, +25)
            var presetBtn = target.closest(".wm-preset-btn");
            if (presetBtn) {
                var card = presetBtn.closest(".wm-commodity-card");
                var input = card.querySelector(".wm-qty-input");
                var addVal = Number(presetBtn.dataset.preset || 5);
                input.value = Math.min(500, Number(input.value || 1) + addVal);
                return;
            }

            // Add to Cart Button (Card Grid or Table Row)
            var addBtn = target.closest(".wm-btn-add-commodity") || target.closest(".wm-table-add-btn");
            if (addBtn) {
                var pId = Number(addBtn.dataset.productId);
                var parentContainer = addBtn.closest(".wm-commodity-card") || addBtn.closest("tr");
                var qtyInput = parentContainer.querySelector(".wm-qty-input");
                var quantity = Math.max(1, Number(qtyInput ? qtyInput.value : 1));
                addToCart(pId, quantity, addBtn);
                return;
            }

            // Freight Calculator Modal Trigger
            var calcLink = target.closest(".wm-freight-calc-link");
            if (calcLink) {
                var pId = Number(calcLink.dataset.calcId);
                var prod = allProducts.find(function (p) { return p.id === pId; });
                if (prod) openFreightModal(prod);
                return;
            }
        });

        // ============================================================
        // FREIGHT CALCULATOR MODAL ENGINE
        // ============================================================
        var freightModal = document.getElementById("freightModalBackdrop");
        var closeFreightModalBtn = document.getElementById("closeFreightModalBtn");
        var dismissFreightModalBtn = document.getElementById("dismissFreightModalBtn");
        var calcModalQty = document.getElementById("calcModalQty");
        var calcModalVehicle = document.getElementById("calcModalVehicle");
        var calcModalRoute = document.getElementById("calcModalRoute");
        var calcEstimatedFee = document.getElementById("calcEstimatedFee");
        var calcWeightDetails = document.getElementById("calcWeightDetails");
        var modalAddToCartBtn = document.getElementById("modalAddToCartBtn");

        function openFreightModal(prod) {
            activeModalProduct = prod;
            document.getElementById("modalProdName").textContent = prod.name;
            document.getElementById("modalProdSku").textContent = prod.sku || ("#SKU-" + String(prod.id).padStart(5, "0"));
            document.getElementById("modalProdSpecs").textContent = "Pack: " + (prod.packSize || "50kg Sack") + " &bull; Rate: " + formatMoney(prod.unitPrice || prod.price);

            calcModalQty.value = 5;
            calculateModalFreight();
            freightModal.classList.add("is-active");
        }

        function closeFreightModal() {
            freightModal.classList.remove("is-active");
            activeModalProduct = null;
        }

        closeFreightModalBtn.addEventListener("click", closeFreightModal);
        dismissFreightModalBtn.addEventListener("click", closeFreightModal);
        freightModal.addEventListener("click", function (e) {
            if (e.target === freightModal) closeFreightModal();
        });

        function calculateModalFreight() {
            if (!activeModalProduct) return;
            var qty = Math.max(1, Number(calcModalQty.value || 1));
            var distKm = parseFloat(calcModalRoute.value || 14.8);
            var vehicle = calcModalVehicle.value;

            var weightPerUnit = 5.0;
            var pack = (activeModalProduct.packSize || "").toLowerCase();
            if (pack.includes("50kg")) weightPerUnit = 50.0;
            else if (pack.includes("25kg")) weightPerUnit = 25.0;
            else if (pack.includes("10kg")) weightPerUnit = 10.0;

            var totalWeight = (qty * weightPerUnit);

            fetch("/api/v1/deliveries/calculate-fee", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    weightKg: totalWeight,
                    distanceKm: distKm,
                    vehicleType: vehicle,
                    items: [{
                        productName: activeModalProduct.name,
                        quantity: qty,
                        weightKg: totalWeight,
                        weightKgIsTotal: true,
                        packSize: activeModalProduct.packSize
                    }]
                })
            })
            .then(function (res) { return res.json(); })
            .then(function (data) {
                calcEstimatedFee.textContent = "Rs. " + Number(data.totalDeliveryFee || 0).toFixed(2);
                calcWeightDetails.innerHTML = "Cargo: " + totalWeight.toFixed(1) + " kg (" + qty + " units)<br>" +
                                              "Corridor: " + distKm + " km (" + data.vehicleType + ")";
            })
            .catch(function (err) {
                console.error("Freight calc error:", err);
            });
        }

        calcModalQty.addEventListener("input", calculateModalFreight);
        calcModalVehicle.addEventListener("change", calculateModalFreight);
        calcModalRoute.addEventListener("change", calculateModalFreight);

        modalAddToCartBtn.addEventListener("click", function () {
            if (!activeModalProduct) return;
            var qty = Math.max(1, Number(calcModalQty.value || 1));
            addToCart(activeModalProduct.id, qty, null);
            closeFreightModal();
        });

        // ============================================================
        // SKELETON LOADING GENERATOR
        // ============================================================
        function renderSkeletonGrid(count) {
            count = count || 8;
            var skelCardHTML =
                '<div class="wm-skel-card">' +
                    '<div class="wm-skel-accent-bar wm-shimmer"></div>' +
                    '<div class="wm-skel-media wm-shimmer">' +
                        '<div class="wm-skel-media-badge-left"></div>' +
                        '<div class="wm-skel-media-badge-right"></div>' +
                    '</div>' +
                    '<div class="wm-skel-body">' +
                        '<div class="wm-skel-meta">' +
                            '<div class="wm-skel-sku wm-shimmer"></div>' +
                            '<div class="wm-skel-stock wm-shimmer"></div>' +
                        '</div>' +
                        '<div class="wm-skel-title-line1 wm-shimmer"></div>' +
                        '<div class="wm-skel-title-line2 wm-shimmer"></div>' +
                        '<div class="wm-skel-distributor wm-shimmer"></div>' +
                        '<div class="wm-skel-chips">' +
                            '<div class="wm-skel-chip wm-shimmer"></div>' +
                            '<div class="wm-skel-chip wm-shimmer"></div>' +
                        '</div>' +
                        '<div class="wm-skel-tier wm-shimmer"></div>' +
                        '<div class="wm-skel-pricing">' +
                            '<div class="wm-skel-price-val wm-shimmer"></div>' +
                            '<div class="wm-skel-mrp-val wm-shimmer"></div>' +
                        '</div>' +
                    '</div>' +
                    '<div class="wm-skel-actions">' +
                        '<div class="wm-skel-presets">' +
                            '<div class="wm-skel-preset-btn wm-shimmer"></div>' +
                            '<div class="wm-skel-preset-btn wm-shimmer"></div>' +
                            '<div class="wm-skel-preset-btn wm-shimmer"></div>' +
                        '</div>' +
                        '<div class="wm-skel-stepper-row">' +
                            '<div class="wm-skel-stepper wm-shimmer"></div>' +
                            '<div class="wm-skel-add-btn wm-shimmer"></div>' +
                        '</div>' +
                        '<div class="wm-skel-calc-link wm-shimmer"></div>' +
                    '</div>' +
                '</div>';

            var skelRowHTML =
                '<tr class="wm-skel-tr">' +
                    '<td><div class="d-flex align-items-center gap-3"><div class="wm-skel-table-thumb wm-shimmer"></div><div><div class="wm-skel-text-md wm-shimmer" style="width:140px; margin-bottom:6px;"></div><div class="wm-skel-text-sm wm-shimmer" style="width:70px;"></div></div></div></td>' +
                    '<td><div class="wm-skel-text-sm wm-shimmer" style="width:80px; height:22px; border-radius:6px;"></div></td>' +
                    '<td><div class="wm-skel-text-sm wm-shimmer" style="width:110px;"></div></td>' +
                    '<td><div class="wm-skel-text-sm wm-shimmer" style="width:75px;"></div></td>' +
                    '<td><div class="wm-skel-text-sm wm-shimmer" style="width:65px;"></div></td>' +
                    '<td><div class="wm-skel-text-md wm-shimmer" style="width:75px;"></div></td>' +
                    '<td><div class="wm-skel-text-sm wm-shimmer" style="width:85px;"></div></td>' +
                    '<td><div class="wm-skel-text-sm wm-shimmer" style="width:80px; height:34px; border-radius:6px;"></div></td>' +
                    '<td class="text-end"><div class="wm-skel-text-sm wm-shimmer ms-auto" style="width:60px; height:32px; border-radius:6px;"></div></td>' +
                '</tr>';

            var gridArr = [];
            var rowArr = [];
            for (var i = 0; i < count; i++) {
                gridArr.push(skelCardHTML);
                rowArr.push(skelRowHTML);
            }
            productsGridView.innerHTML = gridArr.join("");
            manifestTableBody.innerHTML = rowArr.join("");
            productsEmptyState.classList.add("d-none");
            resultCountText.innerHTML = '<span class="d-inline-flex align-items-center gap-1 text-muted"><span class="spinner-border spinner-border-sm text-success" style="width:0.75rem; height:0.75rem; border-width:1.5px;" role="status"></span> Loading catalog...</span>';
        }

        // ============================================================
        // INITIAL DATA LOAD
        // ============================================================
        function loadInitialData() {
            // Render realistic skeleton cards immediately for perceived performance
            renderSkeletonGrid(8);

            // 1. Fetch Distributors
            fetch("/api/v1/distributors")
                .then(function (res) { return res.json(); })
                .then(function (dists) {
                    allDistributors = Array.isArray(dists) ? dists : [];
                    statDistributorsCount.textContent = (allDistributors.length || 4) + " Hubs";
                    renderDistributorSelect();
                })
                .catch(function () {
                    allDistributors = [
                        { id: 1, userId: 1, name: "Apex Wholesale Suppliers", shopName: "Apex Wholesale Suppliers", city: "Jaspur" },
                        { id: 2, userId: 2, name: "Kashipur Mega Hub", shopName: "Kashipur Mega Grain Hub", city: "Kashipur" }
                    ];
                    statDistributorsCount.textContent = "4 Hubs";
                    renderDistributorSelect();
                });

            // 2. Fetch Products
            var fetchUrl = "/api/v1/products";
            if (paramDistributorId) {
                fetchUrl += "?distributorUserId=" + encodeURIComponent(paramDistributorId);
            }

            fetch(fetchUrl)
                .then(function (res) { return res.json(); })
                .then(function (data) {
                    allProducts = (window.wmRows ? window.wmRows(data) : data);
                    if (!Array.isArray(allProducts)) allProducts = [];

                    statTotalSkus.textContent = allProducts.length + " SKUs";
                    renderCategoryChips();
                    renderProducts();
                    syncCart();
                })
                .catch(function (err) {
                    console.error("Error loading products:", err);
                    productsGridView.innerHTML = '<div class="col-12">' +
                        '<div class="wm-products-empty-state">' +
                            '<i class="bi bi-exclamation-triangle text-danger"></i>' +
                            '<h3>Unable to Load Products</h3>' +
                            '<p>Could not connect to the wholesale database catalog. Please refresh or retry.</p>' +
                            '<button class="btn wm-btn-primary" id="retryLoadBtn"><i class="bi bi-arrow-repeat"></i> Retry</button>' +
                        '</div>' +
                    '</div>';
                    var retryBtn = document.getElementById("retryLoadBtn");
                    if (retryBtn) retryBtn.addEventListener("click", loadInitialData);
                });
        }

        loadInitialData();
    });
    </script>
</body>

</html>
