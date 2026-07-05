<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Retailer Dashboard</title><link href="/css/retailer/dashboard.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Retailer Dashboard</h1><p class="wm-subtitle">Find nearby distributors, build carts, place orders, and track dues.</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="nearbyCount">0</b><span>Nearby Distributors</span></div></div><div class="wm-stat"><div class="wm-stat-icon">C</div><div><b id="cartCount">0</b><span>Cart Items</span></div></div><div class="wm-stat"><div class="wm-stat-icon">O</div><div><b id="orderCount">0</b><span>Orders</span></div></div></div>
<div class="wm-toolbar"><a class="btn wm-gradient-btn" href="/web/retailer/products">Browse Products</a><a class="btn wm-gradient-btn" href="/web/retailer/orders">View Orders</a></div><section class="border rounded p-4">Use the left navigation to manage products, cart, orders, ledger and AI assistance.</section>

    <script src="/js/retailer/dashboard.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
