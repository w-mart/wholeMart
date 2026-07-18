<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Retailer Products</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@500;600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/distributor.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css">

</head>

<body class="wm-home">

    <%@ include file="/WEB-INF/common/retailer-header.jsp" %>

    <div class="wm-app">
        <main>
            <div class="wm-home-container wm-products-page">

                <div class="wp-head">
                    <div>
                        <h1 class="wp-title">Products</h1>
                        <p class="wp-subtitle" id="productSubtitle">Browse distributor product catalog</p>
                    </div>

                    <div class="wp-stats">
                        <div class="wp-stat">
                            <i class="bi bi-box-seam"></i>
                            <div><b id="totalProducts">0</b><span>Total</span></div>
                        </div>
                        <div class="wp-stat is-cart">
                            <i class="bi bi-cart3"></i>
                            <div><b id="cartItems">0</b><span>Cart items</span></div>
                        </div>
                        <div class="wp-stat">
                            <i class="bi bi-check2-circle"></i>
                            <div><b id="activeProducts">0</b><span>Available</span></div>
                        </div>
                    </div>
                </div>

                <div class="wp-toolbar">
                    <div class="wp-search">
                        <i class="bi bi-search"></i>
                        <input id="productSearch" type="search" placeholder="Search by name, category or distributor...">
                    </div>
                    <div class="wp-category">
                        <select id="categoryFilter">
                            <option value="">All categories</option>
                        </select>
                    </div>
                    <a class="wp-cart-link" href="/web/retailer/cart">
                        <i class="bi bi-cart3"></i> View Cart
                    </a>
                </div>

                <div id="productStatus" class="wp-toast" aria-live="polite"></div>

                <div id="productsContainer">
                    <div class="wp-grid">
                        <div class="wp-skel-card"></div>
                        <div class="wp-skel-card"></div>
                        <div class="wp-skel-card"></div>
                        <div class="wp-skel-card"></div>
                        <div class="wp-skel-card"></div>
                    </div>
                </div>

                <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var productsContainer = document.getElementById("productsContainer");
                    var productSearch = document.getElementById("productSearch");
                    var categoryFilter = document.getElementById("categoryFilter");
                    var productSubtitle = document.getElementById("productSubtitle");

                    var params = new URLSearchParams(window.location.search);
                    var distributorUserId = params.get("distributorUserId");
                    var distributorName = params.get("distributorName");

                    var products = [];
                    var toastTimer = null;

                    // Consistent, restrained accent per category (color + text pairing)
                    var CATEGORY_PALETTE = [
                        "#2E4057", "#5F8C68", "#C67F14", "#7A4B8A", "#2E7D6F", "#C1602F"
                    ];
                    function categoryColor(category) {
                        var str = String(category || "");
                        var hash = 0;
                        for (var i = 0; i < str.length; i++) hash = (hash * 31 + str.charCodeAt(i)) >>> 0;
                        return CATEGORY_PALETTE[hash % CATEGORY_PALETTE.length];
                    }

                    if (distributorName) {
                        productSubtitle.innerHTML = "Browse products from <b>" + distributorName + "</b>";
                    }

                    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }

                    function setText(id, value) {
                        var element = document.getElementById(id);
                        if (element) element.textContent = value;
                    }

                    function setStatus(message, isError) {
                        var status = document.getElementById("productStatus");
                        if (!status) return;
                        status.textContent = message || "";
                        status.classList.toggle("is-error", Boolean(isError));
                        status.classList.toggle("is-visible", Boolean(message));
                        if (toastTimer) clearTimeout(toastTimer);
                        if (message) {
                            toastTimer = setTimeout(function () { status.classList.remove("is-visible"); }, 2200);
                        }
                    }

                    function populateCategories() {
                        var categories = Array.from(new Set(products.map(function (p) { return p.category; }).filter(Boolean))).sort();
                        categoryFilter.innerHTML = "<option value=\"\">All categories</option>" +
                            categories.map(function (c) { return "<option value=\"" + c + "\">" + c + "</option>"; }).join("");
                    }

                    function escapeHtml(value) {
                        return String(value == null ? "" : value)
                            .replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");
                    }

                    function cardTemplate(product, index) {
                        var sku = product.sku || ("PRD-" + String(product.id).padStart(5, "0"));
                        var distributorLabel = distributorName || ("#" + product.distributorUserId);
                        var imgSrc = product.imageUrl || product.image_url || "${pageContext.request.contextPath}/images/logo/wholemart-home-hero.png";
                        var accent = categoryColor(product.category);

                        return "<div class=\"wp-card\" style=\"--wp-cat-color:" + accent + "\" data-index=\"" + index + "\">" +
                            "<div class=\"wp-card-top\">" +
                                "<img class=\"wp-thumb\" src=\"" + imgSrc + "\" alt=\"" + escapeHtml(product.name || "product") + "\">" +
                                "<div class=\"wp-name-block\">" +
                                    "<p class=\"wp-name\">" + escapeHtml(product.name) + "</p>" +
                                    "<span class=\"wp-sku\">" + escapeHtml(sku) + "</span>" +
                                "</div>" +
                            "</div>" +
                            "<span class=\"wp-chip\"><i class=\"bi bi-truck\"></i> " + escapeHtml(distributorLabel) + "</span>" +
                            "<div class=\"wp-card-divider\"></div>" +
                            "<div class=\"wp-card-bottom\">" +
                                "<div class=\"wp-price\"><small>Price</small>" + money(product.unitPrice) + "</div>" +
                                "<div class=\"wp-add-group\">" +
                                    "<div class=\"wp-qty\">" +
                                        "<button type=\"button\" class=\"wp-qty-minus\" aria-label=\"Decrease quantity\">&minus;</button>" +
                                        "<input type=\"number\" class=\"wp-qty-input\" value=\"1\" min=\"1\" max=\"99\" aria-label=\"Quantity\">" +
                                        "<button type=\"button\" class=\"wp-qty-plus\" aria-label=\"Increase quantity\">&plus;</button>" +
                                    "</div>" +
                                    "<button class=\"wp-add-btn\" data-product-id=\"" + product.id + "\"><i class=\"bi bi-cart-plus\"></i> Add</button>" +
                                "</div>" +
                            "</div>" +
                        "</div>";
                    }

                    function categorySection(category, items) {
                        var accent = categoryColor(category);
                        return "<div class=\"wp-category-section\">" +
                            "<div class=\"wp-cat-head\">" +
                                "<span class=\"wp-cat-dot\" style=\"background:" + accent + "\"></span>" +
                                "<h2 class=\"wp-cat-title\">" + escapeHtml(category || "Uncategorized") + "</h2>" +
                                "<span class=\"wp-cat-count\">" + items.length + " item" + (items.length > 1 ? "s" : "") + "</span>" +
                            "</div>" +
                            "<hr class=\"wp-cat-rule\">" +
                            "<div class=\"wp-grid\">" + items.map(cardTemplate).join("") + "</div>" +
                        "</div>";
                    }

                    function render() {
                        var query = (productSearch.value || "").toLowerCase();
                        var category = categoryFilter.value;

                        var filtered = products.filter(function (product) {
                            var matchesQuery = !query || [product.name, product.category, product.distributorUserId]
                                    .join(" ").toLowerCase().indexOf(query) !== -1;
                            var matchesCategory = !category || product.category === category;
                            return matchesQuery && matchesCategory;
                        });

                        if (!filtered.length) {
                            productsContainer.innerHTML = "<div class=\"wp-empty\">" +
                                "<i class=\"bi bi-inbox\"></i>" +
                                "<strong>No products found</strong>" +
                                "Try a different search term or category." +
                                "</div>";
                        } else {
                            var groups = {};
                            var order = [];
                            filtered.forEach(function (product) {
                                var key = product.category || "Uncategorized";
                                if (!groups[key]) { groups[key] = []; order.push(key); }
                                groups[key].push(product);
                            });
                            order.sort();
                            productsContainer.innerHTML = order.map(function (key) {
                                return categorySection(key, groups[key]);
                            }).join("");
                        }

                        setText("totalProducts", products.length);
                        setText("activeProducts", products.length);
                    }

                    function loadCartCount() {
                        fetch("/api/v1/cart").then(function (response) { return response.json(); })
                            .then(function (items) {
                                setText("cartItems", items.reduce(function (total, item) {
                                    return total + Number(item.quantity || 0);
                                }, 0));
                            })
                            .catch(function () { setText("cartItems", 0); });
                    }

                    var productsUrl = "/api/v1/products" +
                        (distributorUserId ? "?distributorUserId=" + encodeURIComponent(distributorUserId) : "");

                    if (distributorUserId) {
                        productsUrl = "/api/v1/products/by-distributor?distributorUserId=" + encodeURIComponent(distributorUserId);
                    }

                    fetch(productsUrl)
                        .then(function (response) { return response.json(); })
                        .then(function (data) {
                            products = (window.wmRows ? window.wmRows(data) : data);
                            populateCategories();
                            render();
                            loadCartCount();
                        })
                        .catch(function (err) {
                            console.error("Unable to load products:", err);
                            productsContainer.innerHTML = "<div class=\"wp-empty\">" +
                                "<i class=\"bi bi-exclamation-triangle\"></i>" +
                                "<strong>Unable to load products</strong>" +
                                "Please refresh the page or try again shortly." +
                                "</div>";
                        });

                    productSearch.addEventListener("input", render);
                    categoryFilter.addEventListener("change", render);

                    productsContainer.addEventListener("click", function (event) {
                        var card = event.target.closest(".wp-card");
                        if (!card) return;
                        var qtyInput = card.querySelector(".wp-qty-input");

                        if (event.target.closest(".wp-qty-plus")) {
                            qtyInput.value = Math.min(99, Number(qtyInput.value || 1) + 1);
                            return;
                        }
                        if (event.target.closest(".wp-qty-minus")) {
                            qtyInput.value = Math.max(1, Number(qtyInput.value || 1) - 1);
                            return;
                        }

                        var button = event.target.closest("[data-product-id]");
                        if (!button) return;

                        var quantity = Math.max(1, Number(qtyInput.value || 1));
                        button.disabled = true;

                        fetch("/api/v1/cart/items", {
                            method: "POST",
                            headers: {"Content-Type": "application/json"},
                            body: JSON.stringify({
                                productId: Number(button.dataset.productId),
                                quantity: quantity
                            })
                        }).then(function (response) {
                            if (!response.ok) throw new Error("cart");

                            button.classList.add("is-added");
                            button.innerHTML = "<i class=\"bi bi-check2\"></i> Added";

                            setTimeout(function () {
                                button.disabled = false;
                                button.classList.remove("is-added");
                                button.innerHTML = "<i class=\"bi bi-cart-plus\"></i> Add";
                                qtyInput.value = 1;
                            }, 1000);

                            setStatus(quantity + " item" + (quantity > 1 ? "s" : "") + " added to cart.", false);
                            loadCartCount();
                        }).catch(function () {
                            button.disabled = false;
                            setStatus("Unable to add this product to cart.", true);
                        });
                    });
                });
                </script>

            </div>
        </main>

        <%@ include file="/WEB-INF/common/footer.jsp" %>

    </div>
</body>

</html>
