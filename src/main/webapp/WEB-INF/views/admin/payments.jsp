<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Payments</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Payments</h1><p class="wm-subtitle">Payment reconciliation and monitoring</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalPayments">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">P</div><div><b id="pendingPayments">0</b><span>Pending</span></div></div><div class="wm-stat"><div class="wm-stat-icon">$</div><div><b id="paymentAmount">Rs. 0.00</b><span>Amount</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="paymentSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>PENDING</option><option>PAID</option><option>PARTIAL</option><option>REFUNDED</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Payment ID</th><th>Order</th><th>Amount</th><th>Status</th><th>Date</th></tr></thead><tbody id="paymentsBody"><tr><td colspan="6">Loading payments...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("paymentsBody"), search = document.getElementById("paymentSearch"), status = document.getElementById("statusFilter");
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (payment) { var row = [payment.id, payment.orderId, payment.status].join(" ").toLowerCase(); return (!query || row.indexOf(query) !== -1) && (!status.value || payment.status === status.value); });
        body.innerHTML = filtered.length ? filtered.map(function (payment, index) { return "<tr><td>" + (index + 1) + "</td><td>#PAY-" + String(payment.id).padStart(5, "0") + "</td><td>#ORD-" + String(payment.orderId).padStart(5, "0") + "</td><td>" + money(payment.amount) + "</td><td>" + payment.status + "</td><td>" + (payment.createdAt ? new Date(payment.createdAt).toLocaleDateString() : "-") + "</td></tr>"; }).join("") : "<tr><td colspan=\"6\">No payments found in the database.</td></tr>";
        text("totalPayments", rows.length); text("pendingPayments", rows.filter(function (payment) { return payment.status === "PENDING"; }).length); text("paymentAmount", money(rows.reduce(function (sum, payment) { return sum + Number(payment.amount || 0); }, 0)));
    }
    fetch("/api/v1/admin/payments").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"6\">Unable to load payments from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
