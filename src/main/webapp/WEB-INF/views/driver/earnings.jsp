<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Driver Earnings & Payouts - WholeMart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@500;600;700&family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/css/delivery.css">
    <link rel="stylesheet" href="/css/drivers.css">

    <style>
        .wm-earnings-hero {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #ffffff;
            border-radius: 20px;
            padding: 28px 32px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px -4px rgba(15, 23, 42, 0.15);
        }

        .wm-stat-card-elevated {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 20px 22px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .wm-stat-card-elevated:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05);
        }

        .wm-breakdown-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
            margin-bottom: 24px;
        }

        .wm-earnings-table-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
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
        <main class="wm-earnings-workspace">
            <div class="container-fluid px-2 px-md-3 px-lg-4">
                <div class="wm-home-container py-3">

        <!-- Top Hero Banner -->
        <div class="wm-earnings-hero d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div>
                <div class="d-inline-flex align-items-center gap-2 bg-white bg-opacity-10 px-3 py-1 rounded-pill text-white small fw-bold font-monospace mb-2 border border-white border-opacity-10">
                    <i class="bi bi-wallet2 text-warning"></i> Driver Financial Portal
                </div>
                <h1 class="h2 fw-bold text-white mb-1">Driver Earnings & Payouts</h1>
                <p class="text-white-50 mb-0">Track completed trip compensations, delivery fees, and automated weekly settlements.</p>
            </div>
            <div class="text-md-end">
                <small class="text-white-50 font-monospace text-uppercase d-block" style="font-size: 0.72rem;">Available Balance</small>
                <div class="h2 fw-bold font-monospace text-warning mb-1" id="heroTotalEarnings">₹0.00</div>
                <span class="badge bg-success bg-opacity-25 text-success-light border border-success border-opacity-25 px-2 py-1">
                    <i class="bi bi-check-circle me-1"></i> Direct Payout Ready
                </span>
            </div>
        </div>

        <!-- 4 Key Metric Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="wm-stat-card-elevated">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-muted text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Total Earnings</small>
                        <div class="rounded-circle bg-primary-subtle p-2 text-primary fs-6">
                            <i class="bi bi-cash-stack"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace mb-1" id="totalEarnings">₹0.00</h3>
                    <small class="text-muted">Lifetime trip compensation</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="wm-stat-card-elevated">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-success text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Today's Payout</small>
                        <div class="rounded-circle bg-success-subtle p-2 text-success fs-6">
                            <i class="bi bi-graph-up-arrow"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace text-success mb-1" id="todayEarnings">₹0.00</h3>
                    <small class="text-muted">Calculated for current shift</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="wm-stat-card-elevated">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-muted text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Completed Trips</small>
                        <div class="rounded-circle bg-info-subtle p-2 text-info fs-6">
                            <i class="bi bi-check2-all"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace mb-1" id="completedCount">0</h3>
                    <small class="text-muted">Successfully delivered packages</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="wm-stat-card-elevated">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-warning text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Delivery Fee Pool</small>
                        <div class="rounded-circle bg-warning-subtle p-2 text-warning fs-6">
                            <i class="bi bi-tag"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace text-warning mb-1" id="feeEarnings">₹0.00</h3>
                    <small class="text-muted">Standard rate charges</small>
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
                            <input id="earningsSearch" class="form-control border-start-0" type="search" placeholder="Search by Delivery ID (#DEL-), Order ID (#ORD-), or fee...">
                        </div>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <div class="d-flex gap-2 justify-content-md-end align-items-center">
                            <button type="button" onclick="window.print()" class="btn btn-outline-secondary rounded-pill px-3">
                                <i class="bi bi-printer me-1"></i> Print Statement
                            </button>
                            <button type="button" onclick="location.reload()" class="btn btn-dark rounded-pill px-3">
                                <i class="bi bi-arrow-clockwise me-1"></i> Refresh
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Earnings Ledger Table -->
        <div class="wm-earnings-table-card">
            <div class="p-3 bg-light border-bottom d-flex justify-content-between align-items-center">
                <h6 class="fw-bold mb-0 text-dark"><i class="bi bi-journal-text me-2 text-primary"></i> Trip Compensation History</h6>
                <span class="badge bg-white text-dark border font-monospace" id="earningsCounter">0 Trips Logged</span>
            </div>

            <div class="table-responsive wm-driver-table-wrap">
                <table class="table table-hover align-middle mb-0 wm-driver-table">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Delivery Reference</th>
                            <th>Order ID</th>
                            <th>Status</th>
                            <th>Delivery Compensation</th>
                            <th>Logged Date</th>
                        </tr>
                    </thead>
                    <tbody id="earningsBody">
                        <tr><td colspan="6" class="text-center py-5 text-muted">
                            <div class="spinner-border text-primary mb-2" role="status" style="width: 1.8rem; height: 1.8rem;"></div>
                            <div>Calculating earnings ledger...</div>
                        </td></tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        var rows = [];
        var body = document.getElementById("earningsBody");
        var search = document.getElementById("earningsSearch");

        function text(id, value) {
            var el = document.getElementById(id);
            if (el) el.textContent = value;
        }

        function wmRows(data) {
            if (Array.isArray(data)) return data;
            if (data && Array.isArray(data.content)) return data.content;
            if (data && Array.isArray(data.deliveries)) return data.deliveries;
            return [];
        }

        function render() {
            var query = (search ? search.value : "").toLowerCase().trim();
            var filtered = rows.filter(function(d) {
                var str = [d.id, d.orderId, d.status, d.deliveryFee].join(" ").toLowerCase();
                return !query || str.indexOf(query) !== -1;
            });

            text("earningsCounter", filtered.length + " Trips Logged");

            if (!filtered.length) {
                body.innerHTML = "<tr><td colspan='6' class='text-center py-5 text-muted'>" +
                    "<i class='bi bi-coin fs-2 text-muted mb-2 d-block'></i>" +
                    "<div class='fw-bold text-dark'>No earnings records found</div>" +
                    "<div class='small text-muted'>Completed delivery trips will be automatically credited and logged here.</div>" +
                    "</td></tr>";
                return;
            }

            body.innerHTML = filtered.map(function(d, i) {
                var fee = d.deliveryFee ? "₹" + d.deliveryFee : "₹0";
                var badgeClass = 'bg-secondary';
                if (d.status === 'DELIVERED') badgeClass = 'bg-success';
                else if (d.status === 'IN_TRANSIT' || d.status === 'ACCEPTED') badgeClass = 'bg-primary';

                return "<tr>" +
                    "<td class='font-monospace text-muted' data-label='#'>" + (i + 1) + "</td>" +
                    "<td data-label='Delivery Reference'>" +
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
                    "<td data-label='Status'><span class='badge " + badgeClass + " px-2 py-1 rounded-pill'>" + (d.status || "N/A") + "</span></td>" +
                    "<td data-label='Delivery Compensation'><span class='fw-bold font-monospace text-success fs-6'>" + fee + "</span></td>" +
                    "<td data-label='Logged Date' class='text-muted small'>" + (d.createdAt ? new Date(d.createdAt).toLocaleDateString() : "-") + "</td>" +
                    "</tr>";
            }).join("");
        }

        fetch("/api/v1/driver/earnings").then(function(r) {
            return r.json();
        }).then(function(data) {
            var formattedTotal = "₹" + (data.totalEarnings || "0.00");
            text("totalEarnings", formattedTotal);
            text("heroTotalEarnings", formattedTotal);
            text("todayEarnings", "₹" + (data.todayEarnings || "0.00"));
            text("completedCount", data.completedDeliveries || 0);
            text("feeEarnings", "₹" + (data.deliveryFeeEarnings || "0.00"));
        }).catch(function() {
            text("totalEarnings", "₹0.00");
            text("heroTotalEarnings", "₹0.00");
            text("todayEarnings", "₹0.00");
            text("completedCount", 0);
            text("feeEarnings", "₹0.00");
        });

        fetch("/api/v1/deliveries?size=50").then(function(r) {
            return r.json();
        }).then(function(data) {
            rows = wmRows(data);
            render();
        }).catch(function() {
            body.innerHTML = "<tr><td colspan='6' class='text-center py-4 text-danger'>Unable to load delivery earnings records.</td></tr>";
        });

        if (search) {
            search.addEventListener("input", render);
        }
    });
    </script>

    <%@ include file="/WEB-INF/common/driver-order-modal.jsp" %>

                </div>
            </div>
        </main>
    </div>

    <%@ include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>
