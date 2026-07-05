/* Page-specific scripts for retailer\products.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var productsBody = document.getElementById("productsBody");
    var productSearch = document.getElementById("productSearch");
    var productSubtitle = document.getElementById("productSubtitle");
    var params = new URLSearchParams(window.location.search);
    var distributorUserId = params.get("distributorUserId");
    var distributorName = params.get("distributorName");
    var products = [];

    if (distributorName) {
        productSubtitle.textContent = "Browse products from " + distributorName;
    }

    function money(value) {
        return "Rs. " + Number(value || 0).toFixed(2);
    }

    function setText(id, value) {
        var element = document.getElementById(id);
        if (element) element.textContent = value;
    }

    function setStatus(message, isError) {
        var status = document.getElementById("productStatus");
        if (!status) return;
        status.textContent = message || "";
        status.classList.toggle("is-error", Boolean(isError));
    }

    function render() {
        var query = (productSearch.value || "").toLowerCase();
        var filtered = products.filter(function (product) {
            return !query || [product.name, product.category, product.distributorUserId].join(" ").toLowerCase().indexOf(query) !== -1;
        });
        productsBody.innerHTML = filtered.length ? filtered.map(function (product, index) {
            var sku = product.sku || ("PRD-" + String(product.id).padStart(5, "0"));
            var distributorLabel = distributorName || ("#" + product.distributorUserId);
            return "<tr><td>" + (index + 1) + "</td><td>" + sku + "</td><td>" + product.name + "</td><td>" + product.category + "</td><td>" + distributorLabel + "</td><td>" + money(product.unitPrice) + "</td><td><button class=\"wm-btn wm-btn-secondary\" data-product-id=\"" + product.id + "\">Add</button></td></tr>";
        }).join("") : "<tr><td colspan=\"7\">No products found for this distributor.</td></tr>";
        setText("totalProducts", products.length);
        setText("activeProducts", products.length);
    }

    function loadCartCount() {
        wmFetch("/api/v1/cart").then(function (response) { return response.json(); }).then(function (items) {
            setText("cartItems", items.reduce(function (total, item) { return total + Number(item.quantity || 0); }, 0));
        }).catch(function () { setText("cartItems", 0); });
    }

    var productsUrl = "/api/v1/products" + (distributorUserId ? "?distributorUserId=" + encodeURIComponent(distributorUserId) : "");
    wmFetch(productsUrl).then(function (response) { return response.json(); }).then(function (data) {
        products = wmRows(data);
        render();
        loadCartCount();
    }).catch(function () {
        productsBody.innerHTML = "<tr><td colspan=\"7\">Unable to load products from the database.</td></tr>";
    });

    productSearch.addEventListener("input", render);
    productsBody.addEventListener("click", function (event) {
        var button = event.target.closest("[data-product-id]");
        if (!button) return;
        wmFetch("/api/v1/cart/items", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({productId: Number(button.dataset.productId), quantity: 1})
        }).then(function (response) {
            if (!response.ok) throw new Error("cart");
            button.disabled = true;
            button.textContent = "Added";
            setTimeout(function () {
                button.disabled = false;
                button.textContent = "Add";
            }, 900);
            setStatus("Product added to cart.", false);
            loadCartCount();
        }).catch(function () {
            setStatus("Unable to add this product to cart.", true);
        });
    });
});
