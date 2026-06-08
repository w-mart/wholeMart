<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Order Management</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Order Management</h1><p class="wm-subtitle">Platform order monitoring</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalOrders">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">P</div><div><b id="placedOrders">0</b><span>Placed</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="acceptedOrders">0</b><span>Accepted</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="orderSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>PLACED</option><option>ACCEPTED</option><option>REJECTED</option><option>CANCELLED</option><option>OUT_FOR_DELIVERY</option><option>DELIVERED</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Order ID</th><th>Retailer</th><th>Distributor</th><th>Status</th><th>Amount</th><th>Date</th></tr></thead><tbody id="ordersBody"><tr><td colspan="7">Loading orders...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var orders = [], body = document.getElementById("ordersBody"), search = document.getElementById("orderSearch"), status = document.getElementById("statusFilter");
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = orders.filter(function (order) {
            var row = [order.id, order.retailerUserId, order.distributorUserId, order.status].join(" ").toLowerCase();
            return (!query || row.indexOf(query) !== -1) && (!status.value || order.status === status.value);
        });
        body.innerHTML = filtered.length ? filtered.map(function (order, index) {
            return "<tr><td>" + (index + 1) + "</td><td>#ORD-" + String(order.id).padStart(5, "0") + "</td><td>#" + order.retailerUserId + "</td><td>#" + order.distributorUserId + "</td><td>" + order.status + "</td><td>" + money(order.totalAmount) + "</td><td>" + (order.createdAt ? new Date(order.createdAt).toLocaleDateString() : "-") + "</td></tr>";
        }).join("") : "<tr><td colspan=\"7\">No orders found in the database.</td></tr>";
        text("totalOrders", orders.length); text("placedOrders", orders.filter(function (order) { return order.status === "PLACED"; }).length); text("acceptedOrders", orders.filter(function (order) { return order.status === "ACCEPTED"; }).length);
    }
    fetch("/api/v1/admin/orders").then(function (response) { return response.json(); }).then(function (data) { orders = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"7\">Unable to load orders from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
