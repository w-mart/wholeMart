<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Driver Assigned Orders</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@500;600;700&family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/delivery.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/drivers.css">

    <style>
        .wm-orders-workspace {
            padding: 24px 0 60px;
            font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
            color: #0f172a;
            background: #f8fafc;
            min-height: calc(100vh - 76px);
        }

        .wm-orders-hero {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 24px 28px;
            margin-bottom: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
        }

        .wm-stat-pill-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .wm-stat-pill-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 16px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .wm-stat-pill-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05);
        }

        .wm-filter-box {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 16px 20px;
            margin-bottom: 24px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
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

        .wm-card-table {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
        }
    </style>
</head>
<body class="wm-home">
    <%@ include file="/WEB-INF/common/driver-header.jsp" %>

    <div class="wm-app">
        <main class="wm-orders-workspace">
            <div class="container-fluid px-2 px-md-3 px-lg-4">

                <!-- Hero Section -->
                <div class="wm-orders-hero d-flex flex-wrap justify-content-between align-items-center gap-3">
                    <div>
                        <div class="d-inline-flex align-items-center gap-2 bg-light px-3 py-1 rounded-pill text-dark small fw-bold font-monospace mb-2 border">
                            <i class="bi bi-box-seam text-primary"></i> Shipment Manifest
                        </div>
                        <h1 class="h3 fw-bold mb-1">Driver Assigned Orders</h1>
                        <p class="text-muted mb-0">Track all packages assigned for dispatch, transit routing, and final delivery</p>
                    </div>
                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/web/driver/dashboard" class="btn btn-outline-secondary rounded-pill px-3">
                            <i class="bi bi-speedometer2 me-1"></i> Dashboard
                        </a>
                        <button type="button" onclick="location.reload()" class="btn btn-dark rounded-pill px-3">
                            <i class="bi bi-arrow-clockwise me-1"></i> Refresh
                        </button>
                    </div>
                </div>

                <!-- KPI Stat Cards -->
                <div class="wm-stat-pill-grid">
                    <div class="wm-stat-pill-card">
                        <div>
                            <small class="text-muted text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Total Orders</small>
                            <h3 class="fw-bold font-monospace mb-0 mt-1" id="statTotalOrders">0</h3>
                        </div>
                        <div class="rounded-circle bg-light p-3 text-dark fs-5">
                            <i class="bi bi-boxes"></i>
                        </div>
                    </div>

                    <div class="wm-stat-pill-card">
                        <div>
                            <small class="text-warning text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Pending Pickup</small>
                            <h3 class="fw-bold font-monospace mb-0 mt-1 text-warning" id="statPendingPickup">0</h3>
                        </div>
                        <div class="rounded-circle bg-warning-subtle p-3 text-warning fs-5">
                            <i class="bi bi-hourglass-split"></i>
                        </div>
                    </div>

                    <div class="wm-stat-pill-card">
                        <div>
                            <small class="text-primary text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">In Transit</small>
                            <h3 class="fw-bold font-monospace mb-0 mt-1 text-primary" id="statInTransit">0</h3>
                        </div>
                        <div class="rounded-circle bg-primary-subtle p-3 text-primary fs-5">
                            <i class="bi bi-truck"></i>
                        </div>
                    </div>

                    <div class="wm-stat-pill-card">
                        <div>
                            <small class="text-success text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Delivered</small>
                            <h3 class="fw-bold font-monospace mb-0 mt-1 text-success" id="statDelivered">0</h3>
                        </div>
                        <div class="rounded-circle bg-success-subtle p-3 text-success fs-5">
                            <i class="bi bi-check2-circle"></i>
                        </div>
                    </div>
                </div>

                <!-- Filter & Search Toolbar -->
                <div class="wm-filter-box">
                    <div class="row g-3 align-items-center">
                        <div class="col-md-6">
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
                                <input id="orderSearch" class="form-control border-start-0" type="search" placeholder="Search orders by Order ID (#ORD-), Delivery ID (#DEL-), or status...">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex flex-wrap gap-2 justify-content-md-end align-items-center">
                                <button class="wm-tab-filter-btn active" data-filter="">All Orders</button>
                                <button class="wm-tab-filter-btn" data-filter="ASSIGNED">Assigned</button>
                                <button class="wm-tab-filter-btn" data-filter="ACCEPTED">Accepted</button>
                                <button class="wm-tab-filter-btn" data-filter="IN_TRANSIT">In Transit</button>
                                <button class="wm-tab-filter-btn" data-filter="DELIVERED">Delivered</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Orders Table Card -->
                <div class="wm-card-table">
                    <div class="p-3 bg-light border-bottom d-flex justify-content-between align-items-center">
                        <h6 class="fw-bold mb-0 text-dark"><i class="bi bi-list-check me-2 text-primary"></i> Assigned Shipments Ledger</h6>
                        <span class="badge bg-white text-dark border font-monospace" id="tableCounter">0 Records</span>
                    </div>

                    <div class="table-responsive wm-driver-table-wrap">
                        <table class="table table-hover align-middle mb-0 wm-driver-table">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Order Reference</th>
                                    <th>Delivery ID</th>
                                    <th>Delivery Destination & Address</th>
                                    <th>Status</th>
                                    <th>Pickup OTP</th>
                                    <th>Delivery OTP</th>
                                    <th>Delivery Fee</th>
                                    <th>Assigned Date</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="ordersBody">
                                <tr><td colspan="10" class="text-center py-5 text-muted">
                                    <div class="spinner-border text-primary mb-2" role="status" style="width: 1.8rem; height: 1.8rem;"></div>
                                    <div>Loading assigned orders...</div>
                                </td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </main>
    </div>

    <%@ include file="/WEB-INF/common/driver-order-modal.jsp" %>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        var rows = [];
        var body = document.getElementById("ordersBody");
        var search = document.getElementById("orderSearch");
        var currentStatusFilter = "";

        function wmRows(data) {
            if (Array.isArray(data)) return data;
            if (data && Array.isArray(data.content)) return data.content;
            if (data && Array.isArray(data.deliveries)) return data.deliveries;
            return [];
        }

        function text(id, val) {
            var el = document.getElementById(id);
            if (el) el.textContent = val;
        }

        function updateStats(items) {
            text("statTotalOrders", items.length);
            text("statPendingPickup", items.filter(function(d) { return d.status === 'ASSIGNED' || d.status === 'ACCEPTED'; }).length);
            text("statInTransit", items.filter(function(d) { return d.status === 'IN_TRANSIT' || d.status === 'PICKED_UP'; }).length);
            text("statDelivered", items.filter(function(d) { return d.status === 'DELIVERED'; }).length);
        }

        function render() {
            var query = (search.value || "").toLowerCase().trim();
            var filtered = rows.filter(function (delivery) {
                var searchStr = [
                    delivery.orderId,
                    delivery.id,
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

            text("tableCounter", filtered.length + " Records");

            if (!filtered.length) {
                body.innerHTML = "<tr><td colspan='10' class='text-center py-5 text-muted'>" +
                    "<i class='bi bi-inbox fs-2 text-muted mb-2 d-block'></i>" +
                    "<div class='fw-bold text-dark'>No matching orders found</div>" +
                    "<div class='small text-muted'>Try adjusting your search criteria or status filter.</div>" +
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
                    "<td data-label='Order Reference'>" +
                        "<button type='button' class='btn btn-link p-0 text-decoration-none fw-bold font-monospace text-primary wm-order-clickable d-inline-flex align-items-center gap-1' onclick=\"showDriverOrderDetails('" + delivery.orderId + "', '" + delivery.id + "')\" title='Click to view full order address and details'>" +
                            "#ORD-" + String(delivery.orderId).padStart(5, "0") +
                            "<i class='bi bi-box-arrow-up-right small text-primary'></i>" +
                        "</button>" +
                    "</td>" +
                    "<td data-label='Delivery ID'>" +
                        "<button type='button' class='btn btn-link p-0 text-decoration-none font-monospace fw-semibold text-secondary wm-delivery-clickable' onclick=\"showDriverOrderDetails('" + delivery.orderId + "', '" + delivery.id + "')\" title='Click to view delivery assignment'>" +
                            "#DEL-" + String(delivery.id).padStart(5, "0") +
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
        }

        fetch("/api/v1/deliveries").then(function (response) {
            return response.json();
        }).then(function (data) {
            rows = wmRows(data);
            updateStats(rows);
            render();
        }).catch(function () {
            body.innerHTML = "<tr><td colspan='10' class='text-center py-4 text-danger'>Unable to load assigned orders from the database.</td></tr>";
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

    <%@ include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>
