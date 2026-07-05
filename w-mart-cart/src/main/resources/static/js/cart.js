/* Page-specific scripts for retailer\cart.jsp */

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
            wmFetch("/api/v1/cart").then(function (response) { return response.json(); }),
            wmFetch("/api/v1/products").then(function (response) { return response.json(); })
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
        wmFetch("/api/v1/cart/items/" + cartItemId, {
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
        wmFetch("/api/v1/cart/items/" + cartItemId, {method: "DELETE"}).then(function (response) {
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
        wmFetch("/api/v1/cart", {method: "DELETE"}).then(function (response) {
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
        wmFetch("/api/v1/orders", {
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
