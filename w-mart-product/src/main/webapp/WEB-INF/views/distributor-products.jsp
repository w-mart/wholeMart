<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Inventory Management</title><link href="/css/distributor/products.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Inventory Management</h1><p class="wm-subtitle">Monitor and manage your stock with intelligence</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalProducts">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">C</div><div><b id="categoryCount">0</b><span>Categories</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="activeProducts">0</b><span>Active</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="productSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select class="wm-select"><option>All Products</option></select></div><div class="col-auto"><a class="btn wm-gradient-btn" href="/web/distributor/add-product">Add Product</a></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>SKU</th><th>Product Name</th><th>Category</th><th>Qty</th><th>Price</th><th>Actions</th></tr></thead><tbody id="productsBody"><tr><td colspan="7">Loading inventory...</td></tr></tbody></table>

    <script src="/js/distributor/products.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
