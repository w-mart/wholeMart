<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Earnings</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Earnings</h1><p class="wm-subtitle">Delivery earnings from persisted payment records</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="deliveredCount">0</b><span>Delivered</span></div></div><div class="wm-stat"><div class="wm-stat-icon">$</div><div><b>Rs. 0.00</b><span>Recorded Earnings</span></div></div><div class="wm-stat"><div class="wm-stat-icon">P</div><div><b id="pendingCount">0</b><span>Pending</span></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Delivery ID</th><th>Order ID</th><th>Status</th><th>Date</th><th>Amount</th></tr></thead><tbody id="earningsBody"><tr><td colspan="6">Loading deliveries...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var body = document.getElementById("earningsBody");
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    fetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) {
        var rows = wmRows(data);
        body.innerHTML = rows.length ? rows.map(function (delivery, index) { return "<tr><td>" + (index + 1) + "</td><td>#DEL-" + String(delivery.id).padStart(5, "0") + "</td><td>#ORD-" + String(delivery.orderId).padStart(5, "0") + "</td><td>" + delivery.status + "</td><td>" + (delivery.createdAt ? new Date(delivery.createdAt).toLocaleDateString() : "-") + "</td><td>Rs. 0.00</td></tr>"; }).join("") : "<tr><td colspan=\"6\">No delivery earnings records found in the database.</td></tr>";
        text("deliveredCount", rows.filter(function (delivery) { return delivery.status === "DELIVERED"; }).length);
        text("pendingCount", rows.filter(function (delivery) { return delivery.status !== "DELIVERED" && delivery.status !== "FAILED"; }).length);
    }).catch(function () { body.innerHTML = "<tr><td colspan=\"6\">Unable to load delivery records from the database.</td></tr>"; });
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
