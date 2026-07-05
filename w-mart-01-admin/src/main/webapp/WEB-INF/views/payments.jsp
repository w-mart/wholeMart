<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Payments</title><link href="/css/admin/payments.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Payments</h1><p class="wm-subtitle">Payment reconciliation and monitoring</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalPayments">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">P</div><div><b id="pendingPayments">0</b><span>Pending</span></div></div><div class="wm-stat"><div class="wm-stat-icon">$</div><div><b id="paymentAmount">Rs. 0.00</b><span>Amount</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="paymentSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>PENDING</option><option>PAID</option><option>PARTIAL</option><option>REFUNDED</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Payment ID</th><th>Order</th><th>Amount</th><th>Status</th><th>Date</th></tr></thead><tbody id="paymentsBody"><tr><td colspan="6">Loading payments...</td></tr></tbody></table>

    <script src="/js/admin/payments.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
