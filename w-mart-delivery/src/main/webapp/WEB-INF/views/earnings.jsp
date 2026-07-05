<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Earnings</title><link href="/css/driver/earnings.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Earnings</h1><p class="wm-subtitle">Delivery earnings from persisted payment records</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="deliveredCount">0</b><span>Delivered</span></div></div><div class="wm-stat"><div class="wm-stat-icon">$</div><div><b>Rs. 0.00</b><span>Recorded Earnings</span></div></div><div class="wm-stat"><div class="wm-stat-icon">P</div><div><b id="pendingCount">0</b><span>Pending</span></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Delivery ID</th><th>Order ID</th><th>Status</th><th>Date</th><th>Amount</th></tr></thead><tbody id="earningsBody"><tr><td colspan="6">Loading deliveries...</td></tr></tbody></table>

    <script src="/js/driver/earnings.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
