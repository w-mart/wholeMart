<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Earnings - WholeMart</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Earnings</h1><p class="wm-subtitle">Delivery earnings and trip history</p>
<div class="wm-stats">
    <div class="wm-stat"><div class="wm-stat-icon">$</div><div><b id="totalEarnings">₹0</b><span>Total Earnings</span></div>
    <div class="wm-stat"><div class="wm-stat-icon" style="background:#DCEEE1;color:#3F7D53;">$</div><div><b id="todayEarnings">₹0</b><span>Today's Earnings</span></div>
    <div class="wm-stat"><div class="wm-stat-icon" style="background:#E4EEE1;color:#4F8F6B;">T</div><div><b id="totalTrips">0</b><span>Total Trips</span></div>
    <div class="wm-stat"><div class="wm-stat-icon" style="background:#DCEEE1;color:#3F7D53;">D</div><div><b id="completedCount">0</b><span>Completed</span></div>
    <div class="wm-stat"><div class="wm-stat-icon" style="background:#F5E6CC;color:#B8842E;">$</div><div><b id="feeEarnings">₹0</b><span>Delivery Fee Earnings</span></div>
</div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Delivery ID</th><th>Order ID</th><th>Status</th><th>Delivery Fee</th><th>Date</th></tr></thead><tbody id="earningsBody"><tr><td colspan="6">Loading earnings...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var body = document.getElementById("earningsBody");
    function text(id, value) { var el = document.getElementById(id); if (el) el.textContent = value; }
    
    fetch("/api/v1/driver/earnings").then(function(r) { return r.json(); }).then(function(data) {
        text("totalEarnings", "₹" + (data.totalEarnings || "0.00"));
        text("todayEarnings", "₹" + (data.todayEarnings || "0.00"));
        text("totalTrips", data.totalTrips || 0);
        text("completedCount", data.completedDeliveries || 0);
        text("feeEarnings", "₹" + (data.deliveryFeeEarnings || "0.00"));
    }).catch(function() {
        text("totalEarnings", "₹0"); text("todayEarnings", "₹0"); text("totalTrips", 0); text("completedCount", 0); text("feeEarnings", "₹0");
    });
    
    fetch("/api/v1/deliveries?size=50").then(function(r) { return r.json(); }).then(function(data) {
        var rows = wmRows(data);
        body.innerHTML = rows.length ? rows.map(function(d, i) {
            var fee = d.deliveryFee ? "₹" + d.deliveryFee : "₹0";
            return "<tr><td>" + (i + 1) + "</td><td>#DEL-" + String(d.id).padStart(5, "0") + "</td><td>#ORD-" + String(d.orderId).padStart(5, "0") + "</td><td>" + (d.status || "N/A") + "</td><td>" + fee + "</td><td>" + (d.createdAt ? new Date(d.createdAt).toLocaleDateString() : "-") + "</td></tr>";
        }).join("") : "<tr><td colspan=\"6\">No earnings records found.</td></tr>";
    }).catch(function() { body.innerHTML = "<tr><td colspan=\"6\">Unable to load records.</td></tr>"; });
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
