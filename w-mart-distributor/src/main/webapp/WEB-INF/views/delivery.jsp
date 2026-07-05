<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Delivery Management</title><link href="/css/distributor/delivery.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Delivery Management</h1><p class="wm-subtitle">Track and manage your shipments</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalDeliveries">0</b><span>Total Deliveries</span></div></div><div class="wm-stat"><div class="wm-stat-icon">P</div><div><b id="pickedDeliveries">0</b><span>Picked Up</span></div></div><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="deliveredDeliveries">0</b><span>Delivered</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="deliverySearch" class="wm-input" type="search" placeholder="Search by delivery ID, order ID, or driver"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>ASSIGNED</option><option>PICKED_UP</option><option>DELIVERED</option><option>FAILED</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Delivery ID</th><th>Order ID</th><th>Status</th><th>Driver</th><th>Date</th></tr></thead><tbody id="deliveriesBody"><tr><td colspan="6">Loading deliveries...</td></tr></tbody></table>
<div class="wm-map-card"><h2 class="h5 wm-card-title">Delivery Tracking Map</h2><div class="wm-map">Delivery map uses live delivery rows above.</div><div class="wm-map-legend"><span>ASSIGNED</span><span>PICKED_UP</span><span>DELIVERED</span></div></div>

    <script src="/js/distributor/delivery.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
