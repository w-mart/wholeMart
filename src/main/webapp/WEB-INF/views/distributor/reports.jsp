<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Reports</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Reports</h1><p class="wm-subtitle">View sales, inventory, and performance reports</p><div class="wm-toolbar"><div class="row g-4"><div class="col-auto"><label>From:</label><input class="wm-input" type="date"></div><div class="col-auto"><label>To:</label><input class="wm-input" type="date"></div><div class="col-auto"><button class="btn wm-gradient-btn" type="button">Export PDF</button></div></div></div><div class="row g-4"><div class="col-lg-6"><section class="wm-section"><h2 class="h5 wm-card-title">Sales Summary</h2><table class="wm-table"><thead><tr><th>Metric</th><th>Value</th></tr></thead><tbody><tr><td>Total Orders</td><td id="totalOrders">0</td></tr><tr><td>Accepted</td><td id="acceptedOrders">0</td></tr><tr><td>Total Revenue</td><td id="totalRevenue">Rs. 0.00</td></tr></tbody></table></section></div><div class="col-lg-6"><section class="wm-section"><h2 class="h5 wm-card-title">Inventory Summary</h2><div class="wm-map">Products: <strong id="productCount">0</strong></div></section></div></div>
<script>
document.addEventListener("DOMContentLoaded", function () {
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    fetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("totalOrders", rows.length); text("acceptedOrders", rows.filter(function (row) { return row.status === "ACCEPTED"; }).length); text("totalRevenue", money(rows.reduce(function (sum, row) { return sum + Number(row.totalAmount || 0); }, 0))); });
    fetch("/api/v1/products/mine").then(function (response) { return response.json(); }).then(function (data) { text("productCount", wmRows(data).length); });
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
