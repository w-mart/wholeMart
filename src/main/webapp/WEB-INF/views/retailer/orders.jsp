<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Retailer Orders</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap"
        rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orders.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
</head>

<body class="wm-home">

    <%@ include file="/WEB-INF/common/retailer-header.jsp" %>

    <div class="wm-app">
        <main>
            <div class="wm-home-container">

                <section class="wm-home-hero" aria-label="Retailer Orders">
                    <h1 class="wm-title">Order Management</h1>
                    <p class="wm-subtitle">Monitor and manage your orders</p>

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
                            <div class="wm-stat-icon">$</div>
                            <div><b id="orderTotal">Rs. 0.00</b><span>Total Amount</span></div>
                        </div>
                    </div>

                    <div class="wm-toolbar">
                        <div class="row g-4">
                            <div class="col-md-6">
                                <input id="orderSearch" class="wm-input" type="search" placeholder="Search">
                            </div>
                            <div class="col-md-3">
                                <select id="statusFilter" class="wm-select">
                                    <option value="">All Statuses</option>
                                    <option>PLACED</option>
                                    <option>ACCEPTED</option>
                                    <option>REJECTED</option>
                                    <option>CANCELLED</option>
                                    <option>OUT_FOR_DELIVERY</option>
                                    <option>DELIVERED</option>
                                </select>
                            </div>
                            <div class="col-auto">
                                <a class="btn wm-gradient-btn" href="/web/retailer/products">New Order</a>
                            </div>
                        </div>
                    </div>

                    <table class="wm-table">
                        <thead>
                            <tr>
                                <th>S.No</th>
                                <th>Order ID</th>
                                <th>Distributor</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Payment</th>
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

                            function render() {
                                var query = (orderSearch.value || "").toLowerCase();
                                var status = statusFilter.value;
                                var filtered = orders.filter(function (order) {
                                    var text = [order.id, order.distributorUserId, order.status, order.paymentMode].join(" ").toLowerCase();
                                    return (!query || text.indexOf(query) !== -1) && (!status || order.status === status);
                                });

                                ordersBody.innerHTML = filtered.length ? filtered.map(function (order, index) {
                                    var date = order.createdAt ? new Date(order.createdAt).toLocaleDateString() : "-";
                                    return "<tr><td>" + (index + 1) + "</td>" +
                                        "<td>#ORD-" + String(order.id).padStart(5, "0") + "</td>" +
                                        "<td>#" + order.distributorUserId + "</td>" +
                                        "<td>" + money(order.totalAmount) + "</td>" +
                                        "<td>" + order.status + "</td>" +
                                        "<td>" + date + "</td>" +
                                        "<td>" + (order.paymentMode || "-") + "</td></tr>";
                                }).join("") : "<tr><td colspan=\"7\">No orders found in the database.</td></tr>";

                                setText("totalOrders", orders.length);
                                setText("placedOrders", orders.filter(function (order) {
                                    return order.status === "PLACED";
                                }).length);
                                setText("orderTotal", money(
                                    orders.reduce(function (total, order) {
                                        return total + Number(order.totalAmount || 0);
                                    }, 0)
                                ));
                            }

                            fetch("/api/v1/orders")
                                .then(function (response) { return response.json(); })
                                .then(function (data) {
                                    orders = wmRows(data);
                                    render();
                                })
                                .catch(function () {
                                    ordersBody.innerHTML = "<tr><td colspan=\"7\">Unable to load orders from the database.</td></tr>";
                                });

                            orderSearch.addEventListener("input", render);
                            statusFilter.addEventListener("change", render);
                        });
                    </script>
                </section>

                <%@ include file="/WEB-INF/common/footer.jsp" %>

            </div>
        </main>
    </div>
</body>

</html>

