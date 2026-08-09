<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Driver Dispatch Alerts & Notifications - WholeMart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@500;600;700&family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="/css/delivery.css">
    <link rel="stylesheet" href="/css/drivers.css">

    <style>
        .wm-alerts-hero {
            background: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%);
            color: #ffffff;
            border-radius: 20px;
            padding: 28px 32px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px -4px rgba(30, 27, 75, 0.2);
        }

        .wm-alert-item {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 18px 22px;
            margin-bottom: 14px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
            transition: all 0.15s ease;
            display: flex;
            align-items: flex-start;
            gap: 16px;
        }

        .wm-alert-item:hover {
            transform: translateX(3px);
            border-color: #cbd5e1;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
        }

        .wm-alert-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 1.25rem;
        }

        .wm-alert-tag-btn {
            border: 1px solid #e2e8f0;
            background: #f8fafc;
            color: #475569;
            font-size: 0.84rem;
            font-weight: 600;
            padding: 6px 16px;
            border-radius: 9999px;
            transition: all 0.15s ease;
        }

        .wm-alert-tag-btn:hover,
        .wm-alert-tag-btn.active {
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
        <main class="wm-alerts-workspace">
            <div class="container-fluid px-2 px-md-3 px-lg-4">
                <div class="wm-home-container py-3">

        <!-- Hero Section -->
        <div class="wm-alerts-hero d-flex flex-wrap justify-content-between align-items-center gap-3">
            <div>
                <div class="d-inline-flex align-items-center gap-2 bg-white bg-opacity-10 px-3 py-1 rounded-pill text-white small fw-bold font-monospace mb-2 border border-white border-opacity-10">
                    <i class="bi bi-bell-fill text-warning"></i> Dispatch Communication Center
                </div>
                <h1 class="h2 fw-bold text-white mb-1">Driver Alerts & Notifications</h1>
                <p class="text-white-50 mb-0">Stay informed about live dispatch assignments, urgent route advisories, and payout confirmations.</p>
            </div>
            <div class="d-flex gap-2">
                <button type="button" onclick="markAllRead()" class="btn btn-outline-light rounded-pill px-3">
                    <i class="bi bi-check2-all me-1"></i> Mark All as Read
                </button>
                <a href="${pageContext.request.contextPath}/web/driver/dashboard" class="btn btn-warning rounded-pill px-3 fw-bold">
                    <i class="bi bi-speedometer2 me-1"></i> Live Hub
                </a>
            </div>
        </div>

        <!-- Filter Tags Bar -->
        <div class="card border-0 shadow-sm rounded-4 mb-4">
            <div class="card-body p-3 d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div class="d-flex flex-wrap gap-2" id="alertFilterTabs">
                    <button class="wm-alert-tag-btn active" data-category="ALL">All Alerts (<span id="countAll">0</span>)</button>
                    <button class="wm-alert-tag-btn" data-category="DISPATCH">Dispatch Orders</button>
                    <button class="wm-alert-tag-btn" data-category="ROUTE">Route Advisories</button>
                    <button class="wm-alert-tag-btn" data-category="PAYOUT">Payouts</button>
                    <button class="wm-alert-tag-btn" data-category="SYSTEM">System</button>
                </div>
                <small class="text-muted font-monospace"><i class="bi bi-broadcast text-primary"></i> Real-time notification feed</small>
            </div>
        </div>

        <!-- Alerts Feed List Container -->
        <div id="alertsContainer">
            <!-- Dynamic alerts rendered here -->
        </div>

    </div>

    <script>
    document.addEventListener("DOMContentLoaded", function () {
        var sampleAlerts = [
            {
                id: 1,
                category: "DISPATCH",
                title: "New Dispatch Order Assigned",
                message: "A new shipment batch #ORD-00042 has been routed to your queue. Please review and accept in your dashboard.",
                time: "5 minutes ago",
                icon: "bi-box-seam",
                iconBg: "bg-primary-subtle text-primary",
                read: false,
                link: "${pageContext.request.contextPath}/web/driver/dashboard"
            },
            {
                id: 2,
                category: "ROUTE",
                title: "Traffic Advisory & Route Update",
                message: "Heavy traffic reported on Main Arterial Bypass. AI Navigation recommends taking the Eastern Ring Road for next delivery.",
                time: "24 minutes ago",
                icon: "bi-geo-alt-fill",
                iconBg: "bg-warning-subtle text-warning",
                read: false,
                link: "${pageContext.request.contextPath}/web/driver/ai-chat"
            },
            {
                id: 3,
                category: "PAYOUT",
                title: "Daily Shift Compensation Credited",
                message: "₹450.00 delivery fee has been verified and settled to your driver balance for 3 completed runs.",
                time: "2 hours ago",
                icon: "bi-wallet2",
                iconBg: "bg-success-subtle text-success",
                read: true,
                link: "${pageContext.request.contextPath}/web/driver/earnings"
            },
            {
                id: 4,
                category: "SYSTEM",
                title: "GPS Shift Tracking Enabled",
                message: "Your live dispatch beacon is synchronized with distributor dispatch systems for automatic route assignments.",
                time: "Today, 08:30 AM",
                icon: "bi-broadcast",
                iconBg: "bg-info-subtle text-info",
                read: true
            }
        ];

        var currentCategory = "ALL";

        function renderAlerts() {
            var container = document.getElementById("alertsContainer");
            var filtered = sampleAlerts.filter(function (a) {
                return currentCategory === "ALL" || a.category === currentCategory;
            });

            var countAll = document.getElementById("countAll");
            if (countAll) countAll.textContent = sampleAlerts.length;

            if (!filtered.length) {
                container.innerHTML = "<div class='card border-0 shadow-sm rounded-4 p-5 text-center text-muted'>" +
                    "<i class='bi bi-bell-slash fs-2 text-muted mb-2 d-block'></i>" +
                    "<div class='fw-bold text-dark'>No alerts in this category</div>" +
                    "<div class='small text-muted'>You are completely up to date with your dispatch notifications.</div>" +
                    "</div>";
                return;
            }

            container.innerHTML = filtered.map(function (a) {
                var actionBtn = a.link
                    ? "<a href='" + a.link + "' class='btn btn-sm btn-outline-primary rounded-pill px-3'><i class='bi bi-arrow-right me-1'></i> View Details</a>"
                    : "";

                var opacityClass = a.read ? "opacity-75" : "";

                return "<div class='wm-alert-item " + opacityClass + "' id='alert-" + a.id + "'>" +
                    "<div class='wm-alert-icon " + a.iconBg + "'><i class='bi " + a.icon + "'></i></div>" +
                    "<div class='flex-grow-1'>" +
                    "  <div class='d-flex justify-content-between align-items-center mb-1'>" +
                    "    <h6 class='fw-bold text-dark mb-0'>" + a.title + "</h6>" +
                    "    <small class='text-muted font-monospace'>" + a.time + "</small>" +
                    "  </div>" +
                    "  <p class='text-muted small mb-2'>" + a.message + "</p>" +
                    "  <div class='d-flex gap-2 align-items-center'>" +
                    actionBtn +
                    "    <button type='button' onclick='dismissAlert(" + a.id + ")' class='btn btn-sm btn-link text-muted p-0 ms-2 text-decoration-none'>Dismiss</button>" +
                    "  </div>" +
                    "</div>" +
                    "</div>";
            }).join("");
        }

        window.dismissAlert = function (id) {
            sampleAlerts = sampleAlerts.filter(function (a) { return a.id !== id; });
            renderAlerts();
        };

        window.markAllRead = function () {
            sampleAlerts.forEach(function (a) { a.read = true; });
            renderAlerts();
        };

        document.querySelectorAll(".wm-alert-tag-btn").forEach(function (btn) {
            btn.addEventListener("click", function () {
                document.querySelectorAll(".wm-alert-tag-btn").forEach(function (b) { b.classList.remove("active"); });
                this.classList.add("active");
                currentCategory = this.getAttribute("data-category") || "ALL";
                renderAlerts();
            });
        });

        renderAlerts();
    });
    </script>

                </div>
            </div>
        </main>
    </div>

    <%@ include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>
