<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Driver Deliveries Ledger - WholeMart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@500;600;700&family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/css/delivery.css">
    <link rel="stylesheet" href="/css/drivers.css">

    <style>
        .wm-deliveries-hero {
            background: linear-gradient(135deg, #0f172a 0%, #334155 100%);
            color: #ffffff;
            border-radius: 20px;
            padding: 28px 32px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px -4px rgba(15, 23, 42, 0.15);
        }

        .wm-stat-card-clean {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 20px 22px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .wm-stat-card-clean:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05);
        }

        .wm-ledger-table-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
        }

        .wm-tab-filter-btn {
            border: 1px solid #e2e8f0;
            background: #f8fafc;
            color: #475569;
            font-size: 0.84rem;
            font-weight: 600;
            padding: 6px 14px;
            border-radius: 9999px;
            transition: all 0.15s ease;
        }

        .wm-tab-filter-btn:hover,
        .wm-tab-filter-btn.active {
            background: #0f172a;
            color: #ffffff;
            border-color: #0f172a;
        }
    </style>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/header.css">
    <link rel="stylesheet" href="/css/home.css">
    <link rel="stylesheet" href="/css/footer.css">
</head>
<body class="wm-home">
    <%@ include file="/WEB-INF/common/driver-header.jsp" %>

    <div class="wm-app">
        <main class="wm-deliveries-workspace">
            <div class="container-fluid px-2 px-md-3 px-lg-4">
                <div class="wm-home-container py-3">

        <!-- Hero Section -->
        <div class="wm-deliveries-hero d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div>
                <div class="d-inline-flex align-items-center gap-2 bg-white bg-opacity-10 px-3 py-1 rounded-pill text-white small fw-bold font-monospace mb-2 border border-white border-opacity-10">
                    <i class="bi bi-truck text-warning"></i> Driver Logistics Management
                </div>
                <h1 class="h2 fw-bold text-white mb-1">Deliveries & Shipments Ledger</h1>
                <p class="text-white-50 mb-0">Monitor all assigned dispatches, transit route stages, OTP verifications, and delivery statuses.</p>
            </div>
            <div class="d-flex gap-2">
                <a href="${pageContext.request.contextPath}/web/driver/dashboard" class="btn btn-outline-light rounded-pill px-3">
                    <i class="bi bi-speedometer2 me-1"></i> Live Hub
                </a>
                <button type="button" onclick="location.reload()" class="btn btn-warning rounded-pill px-3 fw-bold">
                    <i class="bi bi-arrow-clockwise me-1"></i> Refresh
                </button>
            </div>
        </div>

        <!-- 3 KPI Metric Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-4">
                <div class="wm-stat-card-clean">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-muted text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Total Shipments</small>
                        <div class="rounded-circle bg-primary-subtle p-2 text-primary fs-6">
                            <i class="bi bi-box-seam"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace mb-1" id="totalDeliveries">0</h3>
                    <small class="text-muted">All assigned delivery tasks</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-4">
                <div class="wm-stat-card-clean">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-warning text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Active / Assigned</small>
                        <div class="rounded-circle bg-warning-subtle p-2 text-warning fs-6">
                            <i class="bi bi-hourglass-split"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace text-warning mb-1" id="assignedDeliveries">0</h3>
                    <small class="text-muted">Awaiting pickup or transit</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-4">
                <div class="wm-stat-card-clean">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-success text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Delivered & Verified</small>
                        <div class="rounded-circle bg-success-subtle p-2 text-success fs-6">
                            <i class="bi bi-check2-circle"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace text-success mb-1" id="deliveredDeliveries">0</h3>
                    <small class="text-muted">Completed customer deliveries</small>
                </div>
            </div>
        </div>

        <!-- Filter & Search Toolbar -->
        <div class="card border-0 shadow-sm mb-4 rounded-4">
            <div class="card-body p-3">
                <div class="row g-3 align-items-center">
                    <div class="col-md-6">
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                            <input id="deliverySearch" class="form-control border-start-0" type="search" placeholder="Search by Delivery ID (#DEL-), Order ID (#ORD-), or status...">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex flex-wrap gap-2 justify-content-md-end align-items-center">
                            <button class="wm-tab-filter-btn active" data-filter="">All Deliveries</button>
                            <button class="wm-tab-filter-btn" data-filter="ASSIGNED">Assigned</button>
                            <button class="wm-tab-filter-btn" data-filter="ACCEPTED">Accepted</button>
                            <button class="wm-tab-filter-btn" data-filter="IN_TRANSIT">In Transit</button>
                            <button class="wm-tab-filter-btn" data-filter="DELIVERED">Delivered</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Deliveries Table Card -->
        <div class="wm-ledger-table-card">
            <div class="p-3 bg-light border-bottom d-flex justify-content-between align-items-center">
                <h6 class="fw-bold mb-0 text-dark"><i class="bi bi-list-columns-reverse me-2 text-primary"></i> Dispatch Records</h6>
                <span class="badge bg-white text-dark border font-monospace" id="deliveriesCounter">0 Records</span>
            </div>

            <div class="table-responsive wm-driver-table-wrap">
                <table class="table table-hover align-middle mb-0 wm-driver-table">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Delivery ID</th>
                            <th>Order Reference</th>
                            <th>Delivery Destination & Address</th>
                            <th>Status</th>
                            <th>Pickup OTP</th>
                            <th>Delivery OTP</th>
                            <th>Delivery Fee</th>
                            <th>Assigned Date</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="deliveriesBody">
                        <tr><td colspan="10" class="text-center py-5 text-muted">
                            <div class="spinner-border text-primary mb-2" role="status" style="width: 1.8rem; height: 1.8rem;"></div>
                            <div>Loading deliveries ledger...</div>
                        </td></tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <%@ include file="/WEB-INF/common/driver-order-modal.jsp" %>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        var rows = [];
        var body = document.getElementById("deliveriesBody");
        var search = document.getElementById("deliverySearch");
        var currentStatusFilter = "";

        function text(id, value) {
            var element = document.getElementById(id);
            if (element) element.textContent = value;
        }

        function render() {
            var query = (search.value || "").toLowerCase().trim();
            var filtered = rows.filter(function (delivery) {
                var searchStr = [
                    delivery.id,
                    delivery.orderId,
                    delivery.status,
                    delivery.retailerShopName,
                    delivery.retailerName,
                    delivery.deliveryAddress,
                    delivery.pickupOtp,
                    delivery.deliveryOtp,
                    delivery.deliveryFee
                ].join(" ").toLowerCase();

                var matchesQuery = !query || searchStr.indexOf(query) !== -1;
                var matchesStatus = !currentStatusFilter || delivery.status === currentStatusFilter;
                return matchesQuery && matchesStatus;
            });

            text("deliveriesCounter", filtered.length + " Records");

            if (!filtered.length) {
                body.innerHTML = "<tr><td colspan='10' class='text-center py-5 text-muted'>" +
                    "<i class='bi bi-inbox fs-2 text-muted mb-2 d-block'></i>" +
                    "<div class='fw-bold text-dark'>No deliveries found in this view</div>" +
                    "<div class='small text-muted'>Try adjusting your search query or status filter.</div>" +
                    "</td></tr>";
                return;
            }

            body.innerHTML = filtered.map(function (delivery, index) {
                var badgeClass = 'bg-secondary';
                if (delivery.status === 'DELIVERED') badgeClass = 'bg-success';
                else if (delivery.status === 'IN_TRANSIT' || delivery.status === 'PICKED_UP') badgeClass = 'bg-primary';
                else if (delivery.status === 'ACCEPTED') badgeClass = 'bg-info text-dark';
                else if (delivery.status === 'ASSIGNED') badgeClass = 'bg-warning text-dark';

                var retShop = delivery.retailerShopName || delivery.retailerName || 'Retailer Store';
                var retAddr = delivery.deliveryAddress || 'Shop No. 14, Main Market, Jaspur, UK';

                return "<tr>" +
                    "<td class='font-monospace text-muted' data-label='#'>" + (index + 1) + "</td>" +
                    "<td data-label='Delivery ID'>" +
                        "<button type='button' class='btn btn-link p-0 text-decoration-none font-monospace fw-bold text-dark wm-delivery-clickable' onclick=\"showDriverOrderDetails('" + delivery.orderId + "', '" + delivery.id + "')\" title='Click to view delivery assignment'>" +
                            "#DEL-" + String(delivery.id).padStart(5, "0") +
                        "</button>" +
                    "</td>" +
                    "<td data-label='Order Reference'>" +
                        "<button type='button' class='btn btn-link p-0 text-decoration-none fw-bold font-monospace text-primary wm-order-clickable d-inline-flex align-items-center gap-1' onclick=\"showDriverOrderDetails('" + delivery.orderId + "', '" + delivery.id + "')\" title='Click to view full order address and details'>" +
                            "#ORD-" + String(delivery.orderId).padStart(5, "0") +
                            "<i class='bi bi-box-arrow-up-right small text-primary'></i>" +
                        "</button>" +
                    "</td>" +
                    "<td data-label='Delivery Destination & Address' style='max-width: 260px;'>" +
                        "<div class='fw-bold text-dark text-truncate cursor-pointer' onclick=\"showDriverOrderDetails('" + delivery.orderId + "', '" + delivery.id + "')\">" + retShop + "</div>" +
                        "<div class='small text-muted text-truncate'><i class='bi bi-geo-alt text-danger me-1'></i>" + retAddr + "</div>" +
                    "</td>" +
                    "<td data-label='Status'><span class='badge " + badgeClass + " px-2 py-1 rounded-pill'>" + (delivery.status || "N/A") + "</span></td>" +
                    "<td data-label='Pickup OTP'><span class='badge bg-light text-dark border font-monospace cursor-pointer' onclick=\"wmDriverCopy('" + (delivery.pickupOtp || "") + "', 'Pickup OTP')\" title='Click to copy'>" + (delivery.pickupOtp || "-") + "</span></td>" +
                    "<td data-label='Delivery OTP'><span class='badge bg-light text-dark border font-monospace cursor-pointer' onclick=\"wmDriverCopy('" + (delivery.deliveryOtp || "") + "', 'Delivery OTP')\" title='Click to copy'>" + (delivery.deliveryOtp || "-") + "</span></td>" +
                    "<td data-label='Delivery Fee'><span class='fw-bold font-monospace text-success'>₹" + (delivery.deliveryFee || "0") + "</span></td>" +
                    "<td data-label='Assigned Date' class='text-muted small'>" + (delivery.createdAt ? new Date(delivery.createdAt).toLocaleDateString() : "-") + "</td>" +
                    "<td data-label='Actions' class='text-end'>" +
                        "<button type='button' class='btn btn-sm btn-outline-primary rounded-pill px-3 py-1 fw-semibold d-inline-flex align-items-center gap-1 shadow-sm' onclick=\"showDriverOrderDetails('" + delivery.orderId + "', '" + delivery.id + "')\">" +
                            "<i class='bi bi-geo-alt-fill text-primary'></i> View Details" +
                        "</button>" +
                    "</td>" +
                    "</tr>";
            }).join("");

            text("totalDeliveries", rows.length);
            text("assignedDeliveries", rows.filter(function (delivery) { return delivery.status === "ASSIGNED" || delivery.status === "ACCEPTED"; }).length);
            text("deliveredDeliveries", rows.filter(function (delivery) { return delivery.status === "DELIVERED"; }).length);
        }

        fetch("/api/v1/deliveries").then(function (response) {
            return response.json();
        }).then(function (data) {
            rows = wmRows(data);
            render();
        }).catch(function () {
            body.innerHTML = "<tr><td colspan='10' class='text-center py-4 text-danger'>Unable to load deliveries from the database.</td></tr>";
        });

        search.addEventListener("input", render);

        document.querySelectorAll(".wm-tab-filter-btn").forEach(function(btn) {
            btn.addEventListener("click", function() {
                document.querySelectorAll(".wm-tab-filter-btn").forEach(function(b) { b.classList.remove("active"); });
                this.classList.add("active");
                currentStatusFilter = this.getAttribute("data-filter") || "";
                render();
            });
        });
    });
    </script>

    <%@ include file="/WEB-INF/common/driver-order-modal.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

                </div>
            </div>
        </main>
    </div>

    <%@ include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>
