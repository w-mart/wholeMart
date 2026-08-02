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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">

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
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="activeDeliveriesBody">
                            <tr><td colspan="8">Loading active deliveries...</td></tr>
                        </tbody>
                    </table>
                </section>

                <!-- Delivery Details Modal -->
               <!-- ========================================================= -->
<!-- Delivery Details Modal -->
<!-- ========================================================= -->

<div class="modal fade"
     id="driverDeliveryModal"
     tabindex="-1"
     aria-labelledby="driverDeliveryModalLabel"
     aria-hidden="true">

    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">

        <div class="modal-content shadow-lg border-0">

            <!-- Header -->

            <div class="modal-header bg-primary text-white">

                <div>

                    <h4 class="modal-title mb-1">

                        <i class="bi bi-truck"></i>

                        Delivery Assignment

                        <span id="modalAssignmentId"></span>

                    </h4>

                    <small class="opacity-75">

                        Review delivery before accepting

                    </small>

                </div>

                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal">
                </button>

            </div>

            <!-- BODY -->

            <div class="modal-body bg-light">

                <!-- ADDRESS -->

                <div class="row g-4 mb-4">

                    <div class="col-lg-6">

                        <div class="card border-0 shadow-sm h-100">

                            <div class="card-body">

                                <div class="d-flex">

                                    <div class="me-3">

                                        <div class="rounded-circle bg-primary text-white d-flex justify-content-center align-items-center"
                                             style="width:52px;height:52px;">

                                            <i class="bi bi-shop fs-4"></i>

                                        </div>

                                    </div>

                                    <div>

                                        <div class="fw-bold">

                                            Pickup Location

                                        </div>

                                        <div class="text-muted mt-2"
                                             id="modalFromAddress">

                                            Loading...

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                    <div class="col-lg-6">

                        <div class="card border-0 shadow-sm h-100">

                            <div class="card-body">

                                <div class="d-flex">

                                    <div class="me-3">

                                        <div class="rounded-circle bg-success text-white d-flex justify-content-center align-items-center"
                                             style="width:52px;height:52px;">

                                            <i class="bi bi-geo-alt-fill fs-4"></i>

                                        </div>

                                    </div>

                                    <div>

                                        <div class="fw-bold">

                                            Delivery Location

                                        </div>

                                        <div class="text-muted mt-2"
                                             id="modalToAddress">

                                            Loading...

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- ORDER HEADER -->

                <div class="card border-0 shadow-sm mb-4">

                    <div class="card-body">

                        <div class="d-flex justify-content-between align-items-center flex-wrap">

                            <div>

                                <h4 class="fw-bold mb-2"
                                    id="modalOrderId">
                                </h4>

                                <span class="badge bg-warning text-dark fs-6 px-3 py-2"
                                      id="modalOrderStatus">
                                </span>

                            </div>

                            <div class="text-end">

                                <div class="text-muted">

                                    Payment Mode

                                </div>

                                <div class="fw-bold fs-5"
                                     id="modalPaymentMode">
                                </div>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- SUMMARY -->

                <div class="row g-3 mb-4">

                    <div class="col-md-3">

                        <div class="card shadow-sm border-0">

                            <div class="card-body text-center">

                                <div class="text-muted small">

                                    Order Total

                                </div>

                                <h3 class="text-primary fw-bold"
                                    id="modalOrderTotal">
                                </h3>

                            </div>

                        </div>

                    </div>

                    <div class="col-md-3">

                        <div class="card shadow-sm border-0">

                            <div class="card-body text-center">

                                <div class="text-muted small">

                                    Delivery Fee

                                </div>

                                <h3 class="text-success fw-bold"
                                    id="modalDeliveryFee">
                                </h3>

                            </div>

                        </div>

                    </div>

                    <div class="col-md-3">

                        <div class="card shadow-sm border-0">

                            <div class="card-body text-center">

                                <div class="text-muted small">

                                    Pickup OTP

                                </div>

                                <h3 class="fw-bold"
                                    id="modalPickupOtp">
                                </h3>

                            </div>

                        </div>

                    </div>

                    <div class="col-md-3">

                        <div class="card shadow-sm border-0">

                            <div class="card-body text-center">

                                <div class="text-muted small">

                                    Delivery OTP

                                </div>

                                <h3 class="fw-bold"
                                    id="modalDeliveryOtp">
                                </h3>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- ITEMS -->

                <div class="card shadow-sm border-0">

                    <div class="card-header bg-white">

                        <div class="d-flex justify-content-between align-items-center">

                            <h5 class="fw-bold mb-0">

                                <i class="bi bi-box-seam"></i>

                                Order Items

                            </h5>

                            <span class="badge bg-primary"
                                  id="modalItemsCount">
                                0
                            </span>

                        </div>

                    </div>

                    <div class="table-responsive">

                        <table class="table table-hover align-middle mb-0">

                            <thead class="table-light">

                            <tr>

                                <th>Product</th>
                                <th class="text-center">Qty</th>
                                <th class="text-end">Price</th>
                                <th class="text-end">Total</th>

                            </tr>

                            </thead>

                            <tbody id="modalOrderItemsBody">

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

            <!-- FOOTER -->

            <div class="modal-footer bg-white">

                <button type="button"
                        class="btn btn-outline-danger btn-lg px-4"
                        id="modalRejectBtn">

                    <i class="bi bi-x-circle"></i>

                    Reject

                </button>

                <button type="button"
                        class="btn btn-success btn-lg px-5"
                        id="modalAcceptBtn">

                    <i class="bi bi-check-circle"></i>

                    Accept Delivery

                </button>

            </div>

        </div>

    </div>

</div>

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
    var activeDeliveries = [];
    var currentDeliveryAssignmentId = null;
    var deliveryModal = null;
    var autoOpenedAssignmentId = null;

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

    function normalizeAddress(value, fallback) {
        if (!value) {
            return fallback || "Not available";
        }
        var cleaned = value.split(',').map(function(part) {
            return part.trim();
        }).filter(function(part) {
            return part.length > 0;
        }).join(', ');
        return cleaned || (fallback || "Not available");
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

    window.openDeliveryModal = function(assignmentId) {
        currentDeliveryAssignmentId = assignmentId;
        var assignment = activeDeliveries.find(function(d) { return d.id === assignmentId; });
        if (!assignment) {
            alert("Delivery assignment not found.");
            return;
        }
        fetch("/api/v1/orders/" + assignment.orderId)
            .then(function(response) {
                if (!response.ok) {
                    throw new Error("Unable to load order details");
                }
                return response.json();
            })
            .then(function(order) {
                document.getElementById("modalAssignmentId").textContent = "#" + String(assignmentId).padStart(5, "0");
                document.getElementById("modalOrderId").textContent = "#ORD-" + String(order.id).padStart(5, "0");
                document.getElementById("modalOrderStatus").textContent = order.status || "N/A";
                document.getElementById("modalPaymentMode").textContent = order.paymentMode || "N/A";
                document.getElementById("modalOrderTotal").textContent = order.totalAmount != null ? "₹" + order.totalAmount : "-";
                document.getElementById("modalDeliveryFee").textContent = assignment.deliveryFee != null ? "₹" + assignment.deliveryFee : "₹0";
                document.getElementById("modalPickupOtp").textContent = assignment.pickupOtp || "-";
                document.getElementById("modalDeliveryOtp").textContent = assignment.deliveryOtp || "-";
                document.getElementById("modalFromAddress").textContent = normalizeAddress(order.distributorAddress || order.distributorShopName, "Not available");
                document.getElementById("modalToAddress").textContent = normalizeAddress(order.deliveryAddress || order.retailerLocation, "Not available");
                var itemsBody = document.getElementById("modalOrderItemsBody");
                itemsBody.innerHTML = order.items && order.items.length
                    ? order.items.map(function(item) {
                        return "<tr>" +
                            "<td>" + (item.productName || "-") + "</td>" +
                            "<td>" + (item.sku || "-") + "</td>" +
                            "<td>" + item.quantity + "</td>" +
                            "<td>₹" + (item.unitPrice || "0") + "</td>" +
                            "<td>₹" + (item.lineTotal || "0") + "</td>" +
                            "<td>" + (item.packSize || "-") + "</td>" +
                            "<td>" + (item.weightKg != null ? item.weightKg : "-") + "</td>" +
                            "</tr>";
                    }).join("")
                    : "<tr><td colspan='7'>No item details available.</td></tr>";
                document.getElementById("modalItemsCount").textContent = order.items ? order.items.length : 0;
                if (!deliveryModal) {
                    deliveryModal = new bootstrap.Modal(document.getElementById('driverDeliveryModal'));
                }
                document.getElementById('modalAcceptBtn').onclick = function() { window.acceptDelivery(assignmentId); };
                document.getElementById('modalRejectBtn').onclick = function() { window.rejectDelivery(assignmentId); };
                deliveryModal.show();
            })
            .catch(function() {
                alert("Unable to load delivery details. Please try again.");
            });
    };

    window.acceptDelivery = function(assignmentId) {
        var confirmAccept = confirm("Accept this delivery assignment?");
        if (!confirmAccept) {
            return;
        }
        fetch("/api/v1/deliveries/" + assignmentId + "/accept", { method: "POST" })
            .then(function(response) {
                if (!response.ok) {
                    throw new Error("Failed to accept delivery");
                }
                return response.json();
            })
            .then(function() {
                if (deliveryModal) {
                    deliveryModal.hide();
                }
                loadStats();
                loadActiveDeliveries();
            })
            .catch(function() {
                alert("Unable to accept delivery. Please try again.");
            });
    };

    window.rejectDelivery = function(assignmentId) {
        var reason = prompt("Enter rejection reason (optional):", "Not available right now");
        if (reason === null) {
            return;
        }
        fetch("/api/v1/deliveries/" + assignmentId + "/reject?reason=" + encodeURIComponent(reason), { method: "POST" })
            .then(function(response) {
                if (!response.ok) {
                    throw new Error("Failed to reject delivery");
                }
                return response.text();
            })
            .then(function() {
                if (deliveryModal) {
                    deliveryModal.hide();
                }
                loadStats();
                loadActiveDeliveries();
            })
            .catch(function() {
                alert("Unable to reject delivery. Please try again.");
            });
    };

    // Load active deliveries
    function loadActiveDeliveries() {
        fetch("/api/v1/driver/active-deliveries")
            .then(function(r) { return r.json(); })
            .then(function(data) {
                var rows = Array.isArray(data) ? data : (data.content || []);
                activeDeliveries = rows;
                var body = document.getElementById("activeDeliveriesBody");
                if (rows.length === 0) {
                    body.innerHTML = "<tr><td colspan=\"8\">No active deliveries.</td></tr>";
                    return;
                }
                body.innerHTML = rows.map(function(d, i) {
                    var canRespond = d.status === 'ASSIGNED';
                    var actions = canRespond
                        ? "<button class='btn btn-sm btn-primary' onclick='openDeliveryModal(" + d.id + ")'>Review</button>"
                        : "<span class='wm-muted'>No actions</span>";
                    return "<tr>" +
                        "<td>" + (i + 1) + "</td>" +
                        "<td>#ORD-" + String(d.orderId).padStart(5, "0") + "</td>" +
                        "<td><span class='wm-status-badge'>" + (d.status || "N/A") + "</span></td>" +
                        "<td><code>" + (d.pickupOtp || "-") + "</code></td>" +
                        "<td><code>" + (d.deliveryOtp || "-") + "</code></td>" +
                        "<td>₹" + (d.deliveryFee || "0") + "</td>" +
                        "<td>" + (d.createdAt ? new Date(d.createdAt).toLocaleDateString() : "-") + "</td>" +
                        "<td>" + actions + "</td>" +
                        "</tr>";
                }).join("");
                var firstAssigned = rows.find(function(d) { return d.status === 'ASSIGNED'; });
                if (firstAssigned) {
                    openDeliveryModal(firstAssigned.id);
                }
            })
            .catch(function() {
                document.getElementById("activeDeliveriesBody").innerHTML = "<tr><td colspan=\"8\">Unable to load active deliveries.</td></tr>";
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
