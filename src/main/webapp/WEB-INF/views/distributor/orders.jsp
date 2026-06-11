<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Order Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:ital,wght@0,700;0,800;1,700&display=swap" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet">
    <link href="/css/wholemart.css" rel="stylesheet">
</head>

<body class="wm-home">
    <div class="wm-app">
        <% 
            // Initialize variables previously handled by the shell 
            String wmUri = request.getRequestURI(); 
            String wmUserName = session.getAttribute("username") == null ? "Guest" : String.valueOf(session.getAttribute("username")); 
            String wmUserInitial = wmUserName.isEmpty() ? "?" : wmUserName.substring(0, 1).toUpperCase(); 
        %>

            <%@ include file="../common/distributor-header.jsp" %>

                <main class="wm-home-main">
                    <div class="wm-home-container">

                        <h1 class="wm-home-title">Order Management</h1>
                        <p class="wm-home-subtitle">Monitor and manage orders from retailers</p>
                        <div class="wm-stats">
                            <div class="wm-stat">
                                <div class="wm-stat-icon">T</div>
                                <div><b id="totalOrders">0</b><span>Total</span></div>
                            </div>
                            <div class="wm-stat">
                                <div class="wm-stat-icon">P</div>
                                <div><b id="placedOrders">0</b><span>Placed</span></div>
                            </div>
                            <div class="wm-stat">
                                <div class="wm-stat-icon">A</div>
                                <div><b id="acceptedOrders">0</b><span>Accepted</span></div>
                            </div>
                        </div>
                        <div class="wm-toolbar">
                            <div class="row g-4">
                                <div class="col-md-6"><input id="orderSearch" class="wm-input" type="search"
                                        placeholder="Search"></div>
                                <div class="col-md-3"><select id="statusFilter" class="wm-select">
                                        <option value="">All Statuses</option>
                                        <option>PLACED</option>
                                        <option>ACCEPTED</option>
                                        <option>REJECTED</option>
                                        <option>CANCELLED</option>
                                        <option>OUT_FOR_DELIVERY</option>
                                        <option>DELIVERED</option>
                                    </select></div>
                            </div>
                        </div>
                        <table class="wm-table">
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
                                var orders = [];

                                function money(value) {
                                    return "Rs. " + Number(value || 0).toFixed(2);
                                }

                                function setText(id, value) {
                                    var element = document.getElementById(id);
                                    if (element) element.textContent = value;
                                }

                                function escapeHtml(value) {
                                    return String(value || "")
                                        .replace(/&/g, "&amp;")
                                        .replace(/</g, "&lt;")
                                        .replace(/>/g, "&gt;")
                                        .replace(/"/g, "&quot;")
                                        .replace(/'/g, "&#39;");
                                }

                                function render() {
                                    var query = (orderSearch.value || "").toLowerCase();
                                    var status = statusFilter.value;
                                    var filtered = orders.filter(function (order) {
                                        var text = [order.id, order.retailerName, order.retailerLocation, order.status, order.paymentMode].join(" ").toLowerCase();
                                        return (!query || text.indexOf(query) !== -1) && (!status || order.status === status);
                                    });
                                    ordersBody.innerHTML = filtered.length ? filtered.map(function (order, index) {
                                        var date = order.createdAt ? new Date(order.createdAt).toLocaleDateString() : "-";
                                        var retailerName = escapeHtml(order.retailerName || "#" + order.retailerUserId);
                                        var retailerLocation = escapeHtml(order.retailerLocation || "Location not available");
                                        var action = "<a class=\"wm-btn wm-btn-secondary\" href=\"/web/distributor/orders/view?id=" + encodeURIComponent(order.id) + "\">View</a>";
                                        return "<tr><td>" + (index + 1) + "</td><td>#ORD-" + String(order.id).padStart(5, "0") + "</td><td><strong>" + retailerName + "</strong><br><small>" + retailerLocation + "</small></td><td>" + money(order.totalAmount) + "</td><td>" + order.status + "</td><td>" + date + "</td><td>" + action + "</td></tr>";
                                    }).join("") : "<tr><td colspan=\"7\">No orders found in the database.</td></tr>";
                                    setText("totalOrders", orders.length);
                                    setText("placedOrders", orders.filter(function (order) { return order.status === "PLACED"; }).length);
                                    setText("acceptedOrders", orders.filter(function (order) { return order.status === "ACCEPTED"; }).length);
                                }

                                function load() {
                                    fetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) {
                                        orders = wmRows(data);
                                        render();
                                    }).catch(function () {
                                        ordersBody.innerHTML = "<tr><td colspan=\"7\">Unable to load orders from the database.</td></tr>";
                                    });
                                }
                                orderSearch.addEventListener("input", render);
                                statusFilter.addEventListener("change", render);
                                load();
                            });
                        </script>
                    </div>
                </main>
        <footer class="wm-footer-bottom">
            <p>&copy; 2024 WholeMart. All rights reserved.</p>
        </footer>
    </div>
    <script src="/js/common.js"></script>
</body>

</html>