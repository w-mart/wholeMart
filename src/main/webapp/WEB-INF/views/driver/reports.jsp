<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Reports</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Reports</h1><p class="wm-subtitle">View delivery performance</p><div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="completedCount">0</b><span>Completed</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="activeCount">0</b><span>Active</span></div></div><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalCount">0</b><span>Total</span></div></div></div><section class="wm-section"><h2 class="h5 wm-card-title">Monthly Performance</h2><div class="wm-map">Delivery metrics loaded from database assignments.</div></section>
<script>
document.addEventListener("DOMContentLoaded", function () {
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    fetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("totalCount", rows.length); text("completedCount", rows.filter(function (row) { return row.status === "DELIVERED"; }).length); text("activeCount", rows.filter(function (row) { return row.status !== "DELIVERED" && row.status !== "FAILED"; }).length); });
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
