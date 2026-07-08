<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Orders</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Orders</h1><p class="wm-subtitle">Assigned orders for delivery</p><div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="orderSearch" class="wm-input" type="search" placeholder="Search orders"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>ASSIGNED</option><option>PICKED_UP</option><option>DELIVERED</option><option>FAILED</option></select></div></div></div><table class="wm-table"><thead><tr><th>S.No</th><th>Order ID</th><th>Delivery ID</th><th>Status</th><th>Assigned</th></tr></thead><tbody id="ordersBody"><tr><td colspan="5">Loading assigned orders...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("ordersBody"), search = document.getElementById("orderSearch"), status = document.getElementById("statusFilter");
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (delivery) { var row = [delivery.orderId, delivery.id, delivery.status].join(" ").toLowerCase(); return (!query || row.indexOf(query) !== -1) && (!status.value || delivery.status === status.value); });
        body.innerHTML = filtered.length ? filtered.map(function (delivery, index) { return "<tr><td>" + (index + 1) + "</td><td>#ORD-" + String(delivery.orderId).padStart(5, "0") + "</td><td>#DEL-" + String(delivery.id).padStart(5, "0") + "</td><td>" + delivery.status + "</td><td>" + (delivery.createdAt ? new Date(delivery.createdAt).toLocaleDateString() : "-") + "</td></tr>"; }).join("") : "<tr><td colspan=\"5\">No assigned delivery orders found in the database.</td></tr>";
    }
    fetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"5\">Unable to load assigned orders from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
