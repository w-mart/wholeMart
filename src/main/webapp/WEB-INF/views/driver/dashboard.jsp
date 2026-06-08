<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Driver Dashboard</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Driver Dashboard</h1><p class="wm-subtitle">Track assigned deliveries, earnings and AI assistance.</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="totalDeliveries">0</b><span>Deliveries</span></div></div><div class="wm-stat"><div class="wm-stat-icon">C</div><div><b id="completedDeliveries">0</b><span>Completed</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="activeDeliveries">0</b><span>Active</span></div></div></div>
<div class="wm-toolbar"><a class="btn wm-gradient-btn" href="/web/driver/deliveries">View Deliveries</a><a class="btn wm-gradient-btn" href="/web/driver/earnings">Earnings</a></div>
<script>
document.addEventListener("DOMContentLoaded", function () {
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    fetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) {
        var rows = wmRows(data);
        text("totalDeliveries", rows.length);
        text("completedDeliveries", rows.filter(function (delivery) { return delivery.status === "DELIVERED"; }).length);
        text("activeDeliveries", rows.filter(function (delivery) { return delivery.status !== "DELIVERED" && delivery.status !== "FAILED"; }).length);
    }).catch(function () {
        text("totalDeliveries", 0); text("completedDeliveries", 0); text("activeDeliveries", 0);
    });
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
