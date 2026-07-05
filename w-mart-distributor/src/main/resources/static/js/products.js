/* Page-specific scripts for distributor\products.jsp */

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

    wmFetch("/api/v1/products/mine").then(function (response) { return response.json(); }).then(function (data) {
        products = wmRows(data);
        render();
    }).catch(function () {
        productsBody.innerHTML = "<tr><td colspan=\"7\">Unable to load inventory from the database.</td></tr>";
    });
    productSearch.addEventListener("input", render);
});
