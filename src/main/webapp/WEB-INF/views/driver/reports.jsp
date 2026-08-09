<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Driver Performance Reports - WholeMart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@500;600;700&family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/css/delivery.css">
    <link rel="stylesheet" href="/css/drivers.css">

    <style>
        .wm-reports-hero {
            background: linear-gradient(135deg, #064e3b 0%, #047857 100%);
            color: #ffffff;
            border-radius: 20px;
            padding: 28px 32px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px -4px rgba(6, 78, 59, 0.2);
        }

        .wm-perf-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 20px 22px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .wm-perf-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.05);
        }

        .wm-breakdown-box {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.02);
            margin-bottom: 24px;
        }

        .wm-progress-bar-wrap {
            height: 10px;
            background: #f1f5f9;
            border-radius: 9999px;
            overflow: hidden;
            margin-top: 8px;
            margin-bottom: 12px;
        }

        .wm-progress-bar-fill {
            height: 100%;
            background: #10b981;
            border-radius: 9999px;
            transition: width 0.4s ease;
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
        <main class="wm-reports-workspace">
            <div class="container-fluid px-2 px-md-3 px-lg-4">
                <div class="wm-home-container py-3">

        <!-- Reports Hero Banner -->
        <div class="wm-reports-hero d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div>
                <div class="d-inline-flex align-items-center gap-2 bg-white bg-opacity-10 px-3 py-1 rounded-pill text-white small fw-bold font-monospace mb-2 border border-white border-opacity-10">
                    <i class="bi bi-bar-chart-line-fill text-warning"></i> Driver Analytics & Performance
                </div>
                <h1 class="h2 fw-bold text-white mb-1">Driver Performance Scorecard</h1>
                <p class="text-white-50 mb-0">Review key delivery metrics, on-time completion rates, and dispatch fulfillment statistics.</p>
            </div>
            <div class="text-md-end">
                <small class="text-white-50 font-monospace text-uppercase d-block" style="font-size: 0.72rem;">Fulfillment Rate</small>
                <div class="h2 fw-bold font-monospace text-white mb-1" id="heroFulfillmentRate">98.5%</div>
                <span class="badge bg-white bg-opacity-20 text-white border border-white border-opacity-25 px-2 py-1">
                    <i class="bi bi-shield-check me-1"></i> Top Rated Tier
                </span>
            </div>
        </div>

        <!-- 4 KPI Performance Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="wm-perf-card">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-muted text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Total Deliveries</small>
                        <div class="rounded-circle bg-primary-subtle p-2 text-primary fs-6">
                            <i class="bi bi-boxes"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace mb-1" id="totalCount">0</h3>
                    <small class="text-muted">Lifetime logged assignments</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="wm-perf-card">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-success text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Completed</small>
                        <div class="rounded-circle bg-success-subtle p-2 text-success fs-6">
                            <i class="bi bi-check-circle-fill"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace text-success mb-1" id="completedCount">0</h3>
                    <small class="text-muted">Verified & delivered orders</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="wm-perf-card">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-primary text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">Active / In Transit</small>
                        <div class="rounded-circle bg-primary-subtle p-2 text-primary fs-6">
                            <i class="bi bi-truck"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace text-primary mb-1" id="activeCount">0</h3>
                    <small class="text-muted">Ongoing route assignments</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="wm-perf-card">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <small class="text-warning text-uppercase font-monospace fw-bold" style="font-size: 0.72rem;">On-Time Rate</small>
                        <div class="rounded-circle bg-warning-subtle p-2 text-warning fs-6">
                            <i class="bi bi-stopwatch"></i>
                        </div>
                    </div>
                    <h3 class="fw-bold font-monospace text-warning mb-1" id="onTimeRate">99.2%</h3>
                    <small class="text-muted">Within SLA delivery window</small>
                </div>
            </div>
        </div>

        <!-- Performance Distribution & Summary -->
        <div class="row g-4 mb-4">
            <div class="col-lg-6">
                <div class="wm-breakdown-box h-100">
                    <h5 class="fw-bold text-dark mb-3"><i class="bi bi-pie-chart me-2 text-primary"></i> Delivery Status Distribution</h5>
                    
                    <div class="mb-3">
                        <div class="d-flex justify-content-between small fw-bold">
                            <span>Completed Deliveries</span>
                            <span id="deliveredPercent">0%</span>
                        </div>
                        <div class="wm-progress-bar-wrap">
                            <div class="wm-progress-bar-fill bg-success" id="barDelivered" style="width: 0%;"></div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between small fw-bold">
                            <span>In Transit / Picked Up</span>
                            <span id="transitPercent">0%</span>
                        </div>
                        <div class="wm-progress-bar-wrap">
                            <div class="wm-progress-bar-fill bg-primary" id="barTransit" style="width: 0%;"></div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between small fw-bold">
                            <span>Assigned Pending Acceptance</span>
                            <span id="assignedPercent">0%</span>
                        </div>
                        <div class="wm-progress-bar-wrap">
                            <div class="wm-progress-bar-fill bg-warning" id="barAssigned" style="width: 0%;"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="wm-breakdown-box h-100">
                    <h5 class="fw-bold text-dark mb-3"><i class="bi bi-award me-2 text-success"></i> Driver Badges & Milestones</h5>
                    <div class="d-flex flex-column gap-3">
                        <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3">
                            <div class="rounded-circle bg-success text-white p-2 fs-5">
                                <i class="bi bi-patch-check"></i>
                            </div>
                            <div>
                                <strong class="d-block text-dark">Verified Dispatch Partner</strong>
                                <small class="text-muted">Consistently maintaining >95% OTP customer satisfaction verification.</small>
                            </div>
                        </div>

                        <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-3">
                            <div class="rounded-circle bg-primary text-white p-2 fs-5">
                                <i class="bi bi-speedometer"></i>
                            </div>
                            <div>
                                <strong class="d-block text-dark">Quick Route Completion</strong>
                                <small class="text-muted">Average transit duration under 35 minutes per delivery run.</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Detailed Performance Ledger -->
        <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
            <div class="p-3 bg-light border-bottom d-flex justify-content-between align-items-center">
                <h6 class="fw-bold mb-0 text-dark"><i class="bi bi-table me-2 text-primary"></i> Performance Trip History</h6>
                <button type="button" onclick="window.print()" class="btn btn-sm btn-outline-secondary rounded-pill px-3">
                    <i class="bi bi-download me-1"></i> Export Report
                </button>
            </div>

            <div class="table-responsive wm-driver-table-wrap">
                <table class="table table-hover align-middle mb-0 wm-driver-table">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Delivery Identifier</th>
                            <th>Order Reference</th>
                            <th>Status</th>
                            <th>Pickup OTP</th>
                            <th>Delivery OTP</th>
                            <th>Fee</th>
                            <th>Assigned Date</th>
                        </tr>
                    </thead>
                    <tbody id="reportsBody">
                        <tr><td colspan="8" class="text-center py-5 text-muted">Loading analytics data...</td></tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        var body = document.getElementById("reportsBody");

        function text(id, val) {
            var el = document.getElementById(id);
            if (el) el.textContent = val;
        }

        function wmRows(data) {
            if (Array.isArray(data)) return data;
            if (data && Array.isArray(data.content)) return data.content;
            if (data && Array.isArray(data.deliveries)) return data.deliveries;
            return [];
        }

        fetch("/api/v1/deliveries?size=100").then(function (response) {
            return response.json();
        }).then(function (data) {
            var rows = wmRows(data);
            var total = rows.length;
            var completed = rows.filter(function (r) { return r.status === "DELIVERED"; }).length;
            var transit = rows.filter(function (r) { return r.status === "IN_TRANSIT" || r.status === "PICKED_UP"; }).length;
            var assigned = rows.filter(function (r) { return r.status === "ASSIGNED" || r.status === "ACCEPTED"; }).length;
            var active = rows.filter(function (r) { return r.status !== "DELIVERED" && r.status !== "FAILED"; }).length;

            text("totalCount", total);
            text("completedCount", completed);
            text("activeCount", active);

            var rate = total > 0 ? ((completed / total) * 100).toFixed(1) : "100";
            text("heroFulfillmentRate", rate + "%");

            var delPct = total > 0 ? Math.round((completed / total) * 100) : 0;
            var transPct = total > 0 ? Math.round((transit / total) * 100) : 0;
            var assignPct = total > 0 ? Math.round((assigned / total) * 100) : 0;

            text("deliveredPercent", delPct + "%");
            text("transitPercent", transPct + "%");
            text("assignedPercent", assignPct + "%");

            var bDel = document.getElementById("barDelivered");
            var bTrans = document.getElementById("barTransit");
            var bAss = document.getElementById("barAssigned");
            if (bDel) bDel.style.width = delPct + "%";
            if (bTrans) bTrans.style.width = transPct + "%";
            if (bAss) bAss.style.width = assignPct + "%";

            if (!rows.length) {
                body.innerHTML = "<tr><td colspan='8' class='text-center py-5 text-muted'>" +
                    "<i class='bi bi-bar-chart fs-2 text-muted mb-2 d-block'></i>" +
                    "<div class='fw-bold text-dark'>No historical performance records yet</div>" +
                    "<div class='small text-muted'>Completed delivery metrics will be automatically generated.</div>" +
                    "</td></tr>";
                return;
            }

            body.innerHTML = rows.map(function (d, i) {
                var badgeClass = 'bg-secondary';
                if (d.status === 'DELIVERED') badgeClass = 'bg-success';
                else if (d.status === 'IN_TRANSIT' || d.status === 'PICKED_UP') badgeClass = 'bg-primary';
                else if (d.status === 'ACCEPTED') badgeClass = 'bg-info text-dark';
                else if (d.status === 'ASSIGNED') badgeClass = 'bg-warning text-dark';

                return "<tr>" +
                    "<td class='font-monospace text-muted' data-label='#'>" + (i + 1) + "</td>" +
                    "<td data-label='Delivery Identifier'><strong class='font-monospace text-dark'>#DEL-" + String(d.id).padStart(5, "0") + "</strong></td>" +
                    "<td data-label='Order Reference'><span class='font-monospace text-muted'>#ORD-" + String(d.orderId).padStart(5, "0") + "</span></td>" +
                    "<td data-label='Status'><span class='badge " + badgeClass + " px-2 py-1 rounded-pill'>" + (d.status || "N/A") + "</span></td>" +
                    "<td data-label='Pickup OTP'><span class='badge bg-light text-dark border font-monospace'>" + (d.pickupOtp || "-") + "</span></td>" +
                    "<td data-label='Delivery OTP'><span class='badge bg-light text-dark border font-monospace'>" + (d.deliveryOtp || "-") + "</span></td>" +
                    "<td data-label='Fee'><span class='fw-bold font-monospace text-success'>₹" + (d.deliveryFee || "0") + "</span></td>" +
                    "<td data-label='Assigned Date' class='text-muted small'>" + (d.createdAt ? new Date(d.createdAt).toLocaleDateString() : "-") + "</td>" +
                    "</tr>";
            }).join("");
        }).catch(function () {
            body.innerHTML = "<tr><td colspan='8' class='text-center py-4 text-danger'>Unable to load performance reports.</td></tr>";
        });
    });
    </script>

                </div>
            </div>
        </main>
    </div>

    <%@ include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>
