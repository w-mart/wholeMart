<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Order Management</title><link href="/css/admin/orders.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Order Management</h1><p class="wm-subtitle">Platform order monitoring</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalOrders">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">P</div><div><b id="placedOrders">0</b><span>Placed</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="acceptedOrders">0</b><span>Accepted</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="orderSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>PLACED</option><option>ACCEPTED</option><option>REJECTED</option><option>CANCELLED</option><option>OUT_FOR_DELIVERY</option><option>DELIVERED</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Order ID</th><th>Retailer</th><th>Distributor</th><th>Status</th><th>Amount</th><th>Date</th></tr></thead><tbody id="ordersBody"><tr><td colspan="7">Loading orders...</td></tr></tbody></table>

    <script src="/js/admin/orders.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
