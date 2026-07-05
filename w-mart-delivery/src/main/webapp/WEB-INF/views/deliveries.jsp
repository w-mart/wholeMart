<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Delivery Management</title><link href="/css/driver/deliveries.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Delivery Management</h1><p class="wm-subtitle">Track and manage your shipments</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalDeliveries">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="assignedDeliveries">0</b><span>Assigned</span></div></div><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="deliveredDeliveries">0</b><span>Delivered</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="deliverySearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>ASSIGNED</option><option>PICKED_UP</option><option>DELIVERED</option><option>FAILED</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Delivery ID</th><th>Order ID</th><th>Status</th><th>Driver</th><th>Date</th></tr></thead><tbody id="deliveriesBody"><tr><td colspan="6">Loading deliveries...</td></tr></tbody></table>

    <script src="/js/driver/deliveries.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
