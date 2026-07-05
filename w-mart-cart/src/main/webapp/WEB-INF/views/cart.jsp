<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Cart</title><link href="/css/retailer/cart.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Cart</h1><p class="wm-subtitle">Review cart items before placing an order</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="cartLines">0</b><span>Lines</span></div></div><div class="wm-stat"><div class="wm-stat-icon">I</div><div><b id="cartQuantity">0</b><span>Items</span></div></div><div class="wm-stat"><div class="wm-stat-icon">$</div><div><b id="cartTotal">Rs. 0.00</b><span>Amount</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="cartSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="paymentMode" class="wm-select"><option value="FULL">Full Payment</option><option value="PARTIAL">Partial Payment</option><option value="PAY_LATER">Pay Later</option><option value="COD">Cash on Delivery</option></select></div><div class="col-auto"><button id="placeOrder" class="btn wm-gradient-btn" type="button">Place Order</button></div><div class="col-auto"><button id="clearCart" class="btn wm-btn-secondary" type="button">Clear Cart</button></div></div></div>
<div id="cartStatus" class="wm-inline-status" aria-live="polite"></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Product</th><th>Quantity</th><th>Unit Price</th><th>Amount</th><th>Actions</th></tr></thead><tbody id="cartBody"><tr><td colspan="6">Loading cart...</td></tr></tbody></table>

    <script src="/js/retailer/cart.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
