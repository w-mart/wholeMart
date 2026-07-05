<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Products</title><link href="/css/retailer/products.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Products</h1><p class="wm-subtitle" id="productSubtitle">Browse distributor product catalog</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalProducts">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">C</div><div><b id="cartItems">0</b><span>Cart Items</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="activeProducts">0</b><span>Available</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="productSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select class="wm-select"><option>All Products</option></select></div><div class="col-auto"><a class="btn wm-gradient-btn" href="/web/retailer/cart">View Cart</a></div></div></div>
<div id="productStatus" class="wm-inline-status" aria-live="polite"></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>SKU</th><th>Product Name</th><th>Category</th><th>Distributor</th><th>Price</th><th>Actions</th></tr></thead><tbody id="productsBody"><tr><td colspan="7">Loading products...</td></tr></tbody></table>

    <script src="/js/retailer/products.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
