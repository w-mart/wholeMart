<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Order Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
        rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600;display=swap"
        rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hero-carousel.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orders.css">
</head>

<body class="wm-home">

    <%
        String wmUserName = session.getAttribute("name") == null ? "Guest" : String.valueOf(session.getAttribute("name"));
        String wmUserInitial = wmUserName.substring(0, 1).toUpperCase();
    %>

    <%@ include file="/WEB-INF/common/distributor-header.jsp" %>

    <div class="wm-app">
        <main class="wm-home-main">
            <div class="wm-home-container">

                <h1 class="wm-home-title">Order Management</h1>
                <p class="wm-home-subtitle">Monitor and manage orders from retailers</p>

                <div class="wm-stats" aria-label="Order summary">
                    <div class="wm-stat">
                        <div class="wm-stat-icon">T</div>
                        <div class="wm-stat-icon">P</div>
                        <div><b id="placedOrders">0</b><span>Placed</span></div>
                    </div>
                    <div class="wm-stat">
                        <div class="wm-stat-icon">A</div>
                        <div><b id="acceptedOrders">0</b><span>Accepted</span></div>
                    </div>
                </div>

                <div class="wm-toolbar" aria-label="Order filters">
                    <div class="row g-4 align-items-end">
                        <div class="col-md-6">
                            <input id="orderSearch" class="wm-input" type="search" placeholder="Search" autocomplete="off">
                        </div>
                        <div class="col-md-3">
                            <select id="statusFilter" class="wm-select">
                                <option value="">All Statuses</option>
                                <option value="PLACED">PLACED</option>
                                <option value="ACCEPTED">ACCEPTED</option>
                                <option value="REJECTED">REJECTED</option>
                                <option value="CANCELLED">CANCELLED</option>
                                <option value="OUT_FOR_DELIVERY">OUT_FOR_DELIVERY</option>
                                <option value="DELIVERED">DELIVERED</option>
                            </select>
                        </div>
                        <div class="col-md-3 d-grid">
                            <button type="button" id="refreshBtn" class="home-btn home-btn-secondary">
                                <i class="bi bi-arrow-clockwise"></i> Refresh
                            </button>
                        </div>
                    </div>
                </div>

                <table class="wm-table" aria-label="Orders table">
                    <thead>
                        <tr>
                            <th>S.No</th>
                            <th>Order ID</th>
                            <th>Retailer</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="ordersBody">
                        <tr>
                            <td colspan="7">Loading orders...</td>
                        </tr>
                    </tbody>
                </table>

                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        var ordersBody = document.getElementById("ordersBody");
                        var orderSearch = document.getElementById("orderSearch");
                        var statusFilter = document.getElementById("statusFilter");
                        var refreshBtn = document.getElementById("refreshBtn");
                        var orders = [];

                        function money(value) {
                            return "Rs. " + Number(value || 0).toFixed(2);
                        }

                        function setText(id, value) {
                            var el = document.getElementById(id);
                            if (el) el.textContent = value;
                        }

                        function escapeHtml(value) {
                            return String(value || "")
                                .replace(/&/g, "&amp;")
                                .replace(/</g, "<")
                                .replace(/>/g, ">")
                                .replace(/\"/g, """)
                                .replace(/'/g, "&#39;");
                        }

                        function statusBadge(text) {
                            // Keep CSS simple; orders.css doesn't define status colors yet.
                            return "" + escapeHtml(text || "-");
                        }

                        function render() {
                            var query = ((orderSearch && orderSearch.value) ? orderSearch.value : "").toLowerCase();
                            var status = (statusFilter ? statusFilter.value : "");

                            var filtered = orders.filter(function (order) {
                                var text = [order.id, order.retailerName, order.retailerLocation, order.status, order.paymentMode]
                                    .filter(Boolean)
                                    .join(" ")
                                    .toLowerCase();

                                var queryOk = (!query || text.indexOf(query) !== -1);
                                var statusOk = (!status || order.status === status);
                                return queryOk && statusOk;
                            });

                            if (!filtered.length) {
                                ordersBody.innerHTML = "<tr><td colspan=\"7\">No orders found in the database.</td></tr>";
                                return;
                            }

                            ordersBody.innerHTML = filtered.map(function (order, index) {
                                var date = order.createdAt ? new Date(order.createdAt).toLocaleDateString() : "-";
                                var retailerName = escapeHtml(order.retailerName || ("#" + order.retailerUserId));
                                var retailerLocation = escapeHtml(order.retailerLocation || "Location not available");

                                var action = "<a class=\"wm-btn wm-btn-secondary\" href=\"/web/distributor/orders/view?id=" +
                                    encodeURIComponent(order.id) +
                                    "\">View</a>";

                                return "<tr>" +
                                    "<td>" + (index + 1) + "</td>" +
                                    "<td>#ORD-" + String(order.id).padStart(5, "0") + "</td>" +
                                    "<td><strong>" + retailerName + "</strong><br><small>" + retailerLocation + "</small></td>" +
                                    "<td>" + money(order.totalAmount) + "</td>" +
                                    "<td>" + statusBadge(order.status) + "</td>" +
                                    "<td>" + escapeHtml(date) + "</td>" +
                                    "<td>" + action + "</td>" +
                                    "</tr>";
                            }).join("");

                            setText("totalOrders", orders.length);
                            setText("placedOrders", orders.filter(function (o) { return o.status === "PLACED"; }).length);
                            setText("acceptedOrders", orders.filter(function (o) { return o.status === "ACCEPTED"; }).length);
                        }

                        async function load() {
                            ordersBody.innerHTML = "<tr><td colspan=\"7\">Loading orders...</td></tr>";
                            try {
                                var resp = await fetch("/api/v1/orders");
                                if (!resp.ok) throw new Error("Unable to load orders");
                                var data = await resp.json();

                                orders = (window.wmRows ? window.wmRows(data) : (Array.isArray(data) ? data : []));
                                render();
                            } catch (e) {
                                ordersBody.innerHTML = "<tr><td colspan=\"7\">Unable to load orders from the database.</td></tr>";
                            }
                        }

                        if (orderSearch) orderSearch.addEventListener("input", render);
                        if (statusFilter) statusFilter.addEventListener("change", render);
                        if (refreshBtn) refreshBtn.addEventListener("click", load);

                        load();
                    });
                </script>
            </div>
        </main>

        <%@ include file="/WEB-INF/common/footer.jsp" %>
    </div>
</body>

</html>

