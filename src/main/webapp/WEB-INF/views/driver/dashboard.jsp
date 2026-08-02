<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>WholeMart | Driver Dashboard</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
            rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero-carousel.css">

    </head>

<body class="wm-home">

    <% String wmUserName = session.getAttribute("username") == null ? "Driver" : String.valueOf(session.getAttribute("username")); %>

    <%@ include file="/WEB-INF/common/distributor-header.jsp" %>

    <div class="wm-app">

        <main>
            <div class="wm-home-container">

                <!-- ========================================= -->
                <!-- DRIVER DASHBOARD HEADER -->
                <!-- ========================================= -->
                <section class="wm-home-hero" aria-label="Driver hero">
                    <div class="wm-home-hero-grid">
                        <div class="wm-home-hero-copy">
                            <span class="wm-kicker"><span class="wm-live-dot"></span> DRIVER WORKSPACE</span>
                            <h1 class="wm-home-title">Welcome back, <strong><%= wmUserName %></strong></h1>
                            <p class="wm-home-subtitle">Manage your deliveries, track earnings, and stay online to receive delivery requests.</p>
                        </div>
                    </div>
                </section>

                <!-- Online/Offline Status Bar -->
                <section class="wm-section">
                    <div class="wm-online-bar" id="onlineBar">
                        <span id="onlineDot" class="wm-online-dot"></span>
                        <span id="onlineText" class="wm-online-text">Checking status...</span>
                        <button id="toggleOnlineBtn" class="btn btn-sm btn-online">Go Online</button>
                    </div>
                </section>

                <!-- KPI Stats -->
                <section class="wm-section">
                    <div class="wm-stats">
                        <div class="wm-stat">
                            <div class="wm-stat-icon">D</div>
                            <div><b id="statTotalDeliveries">0</b><span>Total Deliveries</span></div>
                        </div>
                        <div class="wm-stat">
                            <div class="wm-stat-icon wm-stat-icon-completed">C</div>
                            <div><b id="statCompleted">0</b><span>Completed</span></div>
                        </div>
                        <div class="wm-stat">
                            <div class="wm-stat-icon wm-stat-icon-active">A</div>
                            <div><b id="statActive">0</b><span>Active</span></div>
                        </div>
                        <div class="wm-stat">
                            <div class="wm-stat-icon wm-stat-icon-today">T</div>
                            <div><b id="statToday">0</b><span>Today</span></div>
                        </div>
                        <div class="wm-stat">
                            <div class="wm-stat-icon wm-stat-icon-earnings">$</div>
                            <div><b id="statEarnings">₹0</b><span>Today's Earnings</span></div>
                        </div>
                        <div class="wm-stat">
                            <div class="wm-stat-icon wm-stat-icon-total">$</div>
                            <div><b id="statTotalEarnings">₹0</b><span>Total Earnings</span></div>
                        </div>
                    </div>
                </section>

                <!-- Quick Actions -->
                <section class="wm-section">
                    <div class="wm-toolbar">
                        <a class="btn wm-gradient-btn" href="${pageContext.request.contextPath}/web/driver/deliveries"><i class="bi bi-truck"></i> View All Deliveries</a>
                        <a class="btn wm-gradient-btn" href="${pageContext.request.contextPath}/web/driver/earnings"><i class="bi bi-currency-rupee"></i> Earnings Report</a>
                        <a class="btn wm-gradient-btn" href="${pageContext.request.contextPath}/web/driver/orders"><i class="bi bi-box-seam"></i> Assigned Orders</a>
                        <a class="btn wm-gradient-btn" href="${pageContext.request.contextPath}/web/driver/ai-chat"><i class="bi bi-chat-dots"></i> AI Assistant</a>
                    </div>
                </section>

                <!-- Active Deliveries Section -->
                <section class="wm-section">
                    <h2 class="wm-section-title">Active Deliveries</h2>
                    <table class="wm-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Order ID</th>
                                <th>Status</th>
                                <th>Pickup OTP</th>
                                <th>Delivery OTP</th>
                                <th>Delivery Fee</th>
                                <th>Assigned At</th>
                            </tr>
                        </thead>
                        <tbody id="activeDeliveriesBody">
                            <tr><td colspan="7">Loading active deliveries...</td></tr>
                        </tbody>
                    </table>
                </section>

                <!-- Recent Deliveries -->
                <section class="wm-section">
                    <h2 class="wm-section-title">Recent Deliveries</h2>
                    <table class="wm-table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Delivery ID</th>
                                <th>Order ID</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Fee</th>
                            </tr>
                        </thead>
                        <tbody id="recentDeliveriesBody">
                            <tr><td colspan="6">Loading recent deliveries...</td></tr>
                        </tbody>
                    </table>
                </section>

            </div>
        </main>

        <%@ include file="/WEB-INF/common/footer.jsp" %>

    </div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var isOnline = false;
    var latitude = null;
    var longitude = null;

    function text(id, val) {
        var el = document.getElementById(id);
        if (el) el.textContent = val;
    }

    function updateOnlineUI(online) {
        isOnline = online;
        var dot = document.getElementById("onlineDot");
        var txt = document.getElementById("onlineText");
        var btn = document.getElementById("toggleOnlineBtn");
        if (online) {
            dot.classList.add("online");
            txt.textContent = "You are ONLINE - Ready to receive delivery requests";
            btn.textContent = "Go Offline";
            btn.classList.remove("btn-online");
            btn.classList.add("btn-offline");
        } else {
            dot.classList.remove("online");
            txt.textContent = "You are OFFLINE - Not receiving delivery requests";
            btn.textContent = "Go Online";
            btn.classList.remove("btn-offline");
            btn.classList.add("btn-online");
        }
    }

    function getLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(pos) {
                latitude = pos.coords.latitude;
                longitude = pos.coords.longitude;
            }, function() {
                latitude = 0;
                longitude = 0;
            });
        }
    }

    // Load stats
    function loadStats() {
        fetch("/api/v1/driver/stats")
            .then(function(r) { return r.json(); })
            .then(function(stats) {
                text("statTotalDeliveries", stats.totalDeliveries || 0);
                text("statCompleted", stats.completedDeliveries || 0);
                text("statActive", stats.activeDeliveries || 0);
                text("statToday", stats.todayDeliveries || 0);
                text("statEarnings", "₹" + (stats.todayEarnings || "0.00"));
                text("statTotalEarnings", "₹" + (stats.totalEarnings || "0.00"));
                updateOnlineUI(stats.isOnline || false);
            })
            .catch(function() {
                text("statTotalDeliveries", 0);
                text("statCompleted", 0);
                text("statActive", 0);
                text("statToday", 0);
                text("statEarnings", "₹0");
                text("statTotalEarnings", "₹0");
            });
    }

    // Load active deliveries
    function loadActiveDeliveries() {
        fetch("/api/v1/driver/active-deliveries")
            .then(function(r) { return r.json(); })
            .then(function(data) {
                var rows = Array.isArray(data) ? data : (data.content || []);
                var body = document.getElementById("activeDeliveriesBody");
                if (rows.length === 0) {
                    body.innerHTML = "<tr><td colspan=\"7\">No active deliveries.</td></tr>";
                    return;
                }
                body.innerHTML = rows.map(function(d, i) {
                    return "<tr>" +
                        "<td>" + (i + 1) + "</td>" +
                        "<td>#ORD-" + String(d.orderId).padStart(5, "0") + "</td>" +
                        "<td><span class='wm-status-badge'>" + (d.status || "N/A") + "</span></td>" +
                        "<td><code>" + (d.pickupOtp || "-") + "</code></td>" +
                        "<td><code>" + (d.deliveryOtp || "-") + "</code></td>" +
                        "<td>₹" + (d.deliveryFee || "0") + "</td>" +
                        "<td>" + (d.createdAt ? new Date(d.createdAt).toLocaleString() : "-") + "</td>" +
                        "</tr>";
                }).join("");
            })
            .catch(function() {
                document.getElementById("activeDeliveriesBody").innerHTML = "<tr><td colspan=\"7\">Unable to load active deliveries.</td></tr>";
            });
    }

    // Load recent deliveries
    function loadRecentDeliveries() {
        fetch("/api/v1/deliveries?page=0&size=10")
            .then(function(r) { return r.json(); })
            .then(function(data) {
                var rows = Array.isArray(data) ? data : (data.content || []);
                var body = document.getElementById("recentDeliveriesBody");
                if (rows.length === 0) {
                    body.innerHTML = "<tr><td colspan=\"6\">No deliveries yet.</td></tr>";
                    return;
                }
                body.innerHTML = rows.map(function(d, i) {
                    return "<tr>" +
                        "<td>" + (i + 1) + "</td>" +
                        "<td>#DEL-" + String(d.id).padStart(5, "0") + "</td>" +
                        "<td>#ORD-" + String(d.orderId).padStart(5, "0") + "</td>" +
                        "<td>" + (d.status || "N/A") + "</td>" +
                        "<td>" + (d.createdAt ? new Date(d.createdAt).toLocaleDateString() : "-") + "</td>" +
                        "<td>₹" + (d.deliveryFee || "0") + "</td>" +
                        "</tr>";
                }).join("");
            })
            .catch(function() {
                document.getElementById("recentDeliveriesBody").innerHTML = "<tr><td colspan=\"6\">Unable to load deliveries.</td></tr>";
            });
    }

    // Toggle online/offline
    document.getElementById("toggleOnlineBtn").addEventListener("click", function() {
        getLocation();
        var btn = this;
        btn.disabled = true;
        if (isOnline) {
            fetch("/api/v1/driver/go-offline", { method: "POST" })
                .then(function() {
                    isOnline = false;
                    updateOnlineUI(false);
                    btn.disabled = false;
                })
                .catch(function() { btn.disabled = false; });
        } else {
            var lat = latitude || 0;
            var lng = longitude || 0;
            fetch("/api/v1/driver/go-online?latitude=" + lat + "&longitude=" + lng + "&vehicleType=", { method: "POST" })
                .then(function() {
                    isOnline = true;
                    updateOnlineUI(true);
                    btn.disabled = false;
                })
                .catch(function() { btn.disabled = false; });
        }
    });

    loadStats();
    loadActiveDeliveries();
    loadRecentDeliveries();
    getLocation();

    // Auto-refresh every 15 seconds
    setInterval(function() {
        loadStats();
        loadActiveDeliveries();
    }, 15000);
});
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
