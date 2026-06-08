<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Delivery Management</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Delivery Management</h1><p class="wm-subtitle">Track and manage your shipments</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalDeliveries">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="assignedDeliveries">0</b><span>Assigned</span></div></div><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="deliveredDeliveries">0</b><span>Delivered</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="deliverySearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>ASSIGNED</option><option>PICKED_UP</option><option>DELIVERED</option><option>FAILED</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Delivery ID</th><th>Order ID</th><th>Status</th><th>Driver</th><th>Date</th></tr></thead><tbody id="deliveriesBody"><tr><td colspan="6">Loading deliveries...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("deliveriesBody"), search = document.getElementById("deliverySearch"), status = document.getElementById("statusFilter");
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (delivery) { var row = [delivery.id, delivery.orderId, delivery.driverUserId, delivery.status].join(" ").toLowerCase(); return (!query || row.indexOf(query) !== -1) && (!status.value || delivery.status === status.value); });
        body.innerHTML = filtered.length ? filtered.map(function (delivery, index) { return "<tr><td>" + (index + 1) + "</td><td>#DEL-" + String(delivery.id).padStart(5, "0") + "</td><td>#ORD-" + String(delivery.orderId).padStart(5, "0") + "</td><td>" + delivery.status + "</td><td>#" + delivery.driverUserId + "</td><td>" + (delivery.createdAt ? new Date(delivery.createdAt).toLocaleDateString() : "-") + "</td></tr>"; }).join("") : "<tr><td colspan=\"6\">No deliveries found in the database.</td></tr>";
        text("totalDeliveries", rows.length); text("assignedDeliveries", rows.filter(function (delivery) { return delivery.status === "ASSIGNED"; }).length); text("deliveredDeliveries", rows.filter(function (delivery) { return delivery.status === "DELIVERED"; }).length);
    }
    fetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"6\">Unable to load deliveries from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
