<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Cart</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Cart</h1><p class="wm-subtitle">Review cart items before placing an order</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="cartLines">0</b><span>Lines</span></div></div><div class="wm-stat"><div class="wm-stat-icon">I</div><div><b id="cartQuantity">0</b><span>Items</span></div></div><div class="wm-stat"><div class="wm-stat-icon">$</div><div><b id="cartTotal">Rs. 0.00</b><span>Amount</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="cartSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="paymentMode" class="wm-select"><option value="FULL">Full Payment</option><option value="PARTIAL">Partial Payment</option><option value="PAY_LATER">Pay Later</option><option value="COD">Cash on Delivery</option></select></div><div class="col-auto"><button id="placeOrder" class="btn wm-gradient-btn" type="button">Place Order</button></div><div class="col-auto"><button id="clearCart" class="btn wm-btn-secondary" type="button">Clear Cart</button></div></div></div>
<div id="cartStatus" class="wm-inline-status" aria-live="polite"></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Product</th><th>Quantity</th><th>Unit Price</th><th>Amount</th><th>Actions</th></tr></thead><tbody id="cartBody"><tr><td colspan="6">Loading cart...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var cartBody = document.getElementById("cartBody");
    var cartSearch = document.getElementById("cartSearch");
    var placeOrder = document.getElementById("placeOrder");
    var clearCart = document.getElementById("clearCart");
    var items = [];
    var productsById = {};

    function money(value) {
        return "Rs. " + Number(value || 0).toFixed(2);
    }

    function setText(id, value) {
        var element = document.getElementById(id);
        if (element) element.textContent = value;
    }

    function setStatus(message, isError) {
        var status = document.getElementById("cartStatus");
        if (!status) return;
        status.textContent = message || "";
        status.classList.toggle("is-error", Boolean(isError));
    }

    function productFor(item) {
        return productsById[item.productId] || {id: item.productId, name: "Product #" + item.productId, unitPrice: 0, distributorUserId: null};
    }

    function cartDistributorId() {
        var distributorId = null;
        for (var i = 0; i < items.length; i++) {
            var product = productFor(items[i]);
            if (!product.distributorUserId) return null;
            if (distributorId === null) {
                distributorId = product.distributorUserId;
            } else if (String(distributorId) !== String(product.distributorUserId)) {
                return "mixed";
            }
        }
        return distributorId;
    }

    function render() {
        var query = (cartSearch.value || "").toLowerCase();
        var filtered = items.filter(function (item) {
            var product = productFor(item);
            return !query || [product.name, product.sku, product.category, product.distributorUserId].join(" ").toLowerCase().indexOf(query) !== -1;
        });
        var totalQuantity = items.reduce(function (total, item) { return total + Number(item.quantity || 0); }, 0);
        var totalAmount = items.reduce(function (total, item) {
            return total + Number(item.quantity || 0) * Number(productFor(item).unitPrice || 0);
        }, 0);
        cartBody.innerHTML = filtered.length ? filtered.map(function (item, index) {
            var product = productFor(item);
            var amount = Number(item.quantity || 0) * Number(product.unitPrice || 0);
            var sku = product.sku || ("PRD-" + String(product.id || item.productId).padStart(5, "0"));
            var productLabel = "<strong>" + product.name + "</strong><span class=\"wm-muted-line\">" + sku + " | Distributor #" + (product.distributorUserId || "-") + "</span>";
            var quantity = Number(item.quantity || 1);
            var quantityControl = "<div class=\"wm-qty-control\"><button type=\"button\" data-cart-action=\"decrease\" data-cart-id=\"" + item.id + "\">-</button><input class=\"wm-qty-input\" data-cart-action=\"quantity\" data-cart-id=\"" + item.id + "\" type=\"number\" min=\"1\" step=\"1\" value=\"" + quantity + "\"><button type=\"button\" data-cart-action=\"increase\" data-cart-id=\"" + item.id + "\">+</button></div>";
            return "<tr><td>" + (index + 1) + "</td><td>" + productLabel + "</td><td>" + quantityControl + "</td><td>" + money(product.unitPrice) + "</td><td>" + money(amount) + "</td><td><button class=\"wm-btn wm-btn-danger\" data-cart-action=\"remove\" data-cart-id=\"" + item.id + "\">Remove</button></td></tr>";
        }).join("") : "<tr><td colspan=\"6\">Your cart is empty.</td></tr>";
        setText("cartLines", items.length);
        setText("cartQuantity", totalQuantity);
        setText("cartTotal", money(totalAmount));
        placeOrder.disabled = !items.length;
        clearCart.disabled = !items.length;
    }

    function load() {
        Promise.all([
            fetch("/api/v1/cart").then(function (response) { return response.json(); }),
            fetch("/api/v1/products").then(function (response) { return response.json(); })
        ]).then(function (responses) {
            items = wmRows(responses[0]);
            productsById = {};
            wmRows(responses[1]).forEach(function (product) {
                productsById[product.id] = product;
            });
            render();
        }).catch(function () {
            cartBody.innerHTML = "<tr><td colspan=\"6\">Unable to load cart from the database.</td></tr>";
            placeOrder.disabled = true;
            clearCart.disabled = true;
        });
    }

    function updateQuantity(cartItemId, quantity) {
        if (quantity < 1) return;
        fetch("/api/v1/cart/items/" + cartItemId, {
            method: "PUT",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({quantity: quantity})
        }).then(function (response) {
            if (!response.ok) throw new Error("quantity");
            setStatus("Cart quantity updated.", false);
            load();
        }).catch(function () {
            setStatus("Unable to update quantity.", true);
        });
    }

    cartSearch.addEventListener("input", render);
    cartBody.addEventListener("click", function (event) {
        var button = event.target.closest("[data-cart-action]");
        if (!button) return;
        var cartItemId = Number(button.dataset.cartId);
        var item = items.find(function (cartItem) { return Number(cartItem.id) === cartItemId; });
        if (!item) return;
        if (button.dataset.cartAction === "increase") {
            updateQuantity(cartItemId, Number(item.quantity || 1) + 1);
            return;
        }
        if (button.dataset.cartAction === "decrease") {
            updateQuantity(cartItemId, Math.max(1, Number(item.quantity || 1) - 1));
            return;
        }
        if (button.dataset.cartAction !== "remove") return;
        fetch("/api/v1/cart/items/" + cartItemId, {method: "DELETE"}).then(function (response) {
            if (!response.ok) throw new Error("remove");
            setStatus("Item removed from cart.", false);
            load();
        }).catch(function () {
            setStatus("Unable to remove this item.", true);
        });
    });
    cartBody.addEventListener("change", function (event) {
        var input = event.target.closest("[data-cart-action=\"quantity\"]");
        if (!input) return;
        updateQuantity(Number(input.dataset.cartId), Math.max(1, Number(input.value || 1)));
    });
    clearCart.addEventListener("click", function () {
        if (!items.length) return;
        fetch("/api/v1/cart", {method: "DELETE"}).then(function (response) {
            if (!response.ok) throw new Error("clear");
            setStatus("Cart cleared.", false);
            load();
        }).catch(function () {
            setStatus("Unable to clear cart.", true);
        });
    });
    placeOrder.addEventListener("click", function () {
        if (!items.length) return;
        var distributorId = cartDistributorId();
        if (!distributorId) {
            setStatus("Cart products are missing distributor data.", true);
            return;
        }
        if (distributorId === "mixed") {
            setStatus("Please keep products from one distributor in a single order.", true);
            return;
        }
        fetch("/api/v1/orders", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify({distributorUserId: distributorId, paymentMode: document.getElementById("paymentMode").value})
        }).then(function (response) {
            if (!response.ok) throw new Error("order");
            location.href = "/web/retailer/orders";
        }).catch(function () {
            setStatus("Unable to place order.", true);
        });
    });
    load();
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
