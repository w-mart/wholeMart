<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Orders</title><link href="/css/driver/orders.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Orders</h1><p class="wm-subtitle">Assigned orders for delivery</p><div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="orderSearch" class="wm-input" type="search" placeholder="Search orders"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>ASSIGNED</option><option>PICKED_UP</option><option>DELIVERED</option><option>FAILED</option></select></div></div></div><table class="wm-table"><thead><tr><th>S.No</th><th>Order ID</th><th>Delivery ID</th><th>Status</th><th>Assigned</th></tr></thead><tbody id="ordersBody"><tr><td colspan="5">Loading assigned orders...</td></tr></tbody></table>

    <script src="/js/driver/orders.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
