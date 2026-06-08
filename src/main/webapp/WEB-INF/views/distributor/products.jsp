<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Inventory Management</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Inventory Management</h1><p class="wm-subtitle">Monitor and manage your stock with intelligence</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalProducts">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">C</div><div><b id="categoryCount">0</b><span>Categories</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="activeProducts">0</b><span>Active</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="productSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select class="wm-select"><option>All Products</option></select></div><div class="col-auto"><a class="btn wm-gradient-btn" href="/web/distributor/add-product">Add Product</a></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>SKU</th><th>Product Name</th><th>Category</th><th>Qty</th><th>Price</th><th>Actions</th></tr></thead><tbody id="productsBody"><tr><td colspan="7">Loading inventory...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var productsBody = document.getElementById("productsBody");
    var productSearch = document.getElementById("productSearch");
    var products = [];

    function money(value) {
        return "Rs. " + Number(value || 0).toFixed(2);
    }

    function setText(id, value) {
        var element = document.getElementById(id);
        if (element) element.textContent = value;
    }

    function render() {
        var query = (productSearch.value || "").toLowerCase();
        var filtered = products.filter(function (product) {
            return !query || [product.name, product.category].join(" ").toLowerCase().indexOf(query) !== -1;
        });
        productsBody.innerHTML = filtered.length ? filtered.map(function (product, index) {
            var qty = product.stockQuantity == null ? "-" : product.stockQuantity;
            var sku = product.sku || ("PRD-" + String(product.id).padStart(5, "0"));
            return "<tr><td>" + (index + 1) + "</td><td>" + sku + "</td><td>" + product.name + "</td><td>" + product.category + "</td><td>" + qty + "</td><td>" + money(product.unitPrice) + "</td><td><button class=\"wm-btn wm-btn-secondary\" type=\"button\">View</button></td></tr>";
        }).join("") : "<tr><td colspan=\"7\">No inventory found for your distributor account.</td></tr>";
        setText("totalProducts", products.length);
        setText("activeProducts", products.length);
        setText("categoryCount", new Set(products.map(function (product) { return product.category; })).size);
    }

    fetch("/api/v1/products/mine").then(function (response) { return response.json(); }).then(function (data) {
        products = wmRows(data);
        render();
    }).catch(function () {
        productsBody.innerHTML = "<tr><td colspan=\"7\">Unable to load inventory from the database.</td></tr>";
    });
    productSearch.addEventListener("input", render);
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
