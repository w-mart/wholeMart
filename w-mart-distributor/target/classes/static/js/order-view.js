/* Page-specific scripts for distributor\order-view.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var orderPanel = document.getElementById("orderPanel");
    var acceptOrder = document.getElementById("acceptOrder");
    var billGenerate = document.getElementById("billGenerate");
    var estimateGenerate = document.getElementById("estimateGenerate");
    var printEstimate = document.getElementById("printEstimate");
    var orderId = new URLSearchParams(window.location.search).get("id");
    var currentOrder = null;
    var generatedMode = "details";

    function money(value) {
        return "Rs. " + Number(value || 0).toFixed(2);
    }

    function escapeHtml(value) {
        return String(value || "")
            .replace(/&/g, "&amp;")
            .replace(/</g, "&lt;")
            .replace(/>/g, "&gt;")
            .replace(/"/g, "&quot;")
            .replace(/'/g, "&#39;");
    }

    function orderCode(order) {
        return "#ORD-" + String(order.id).padStart(5, "0");
    }

    function viewModel(order) {
        var date = order.createdAt ? new Date(order.createdAt).toLocaleDateString() : "-";
        var retailerName = escapeHtml(order.retailerName || "#" + order.retailerUserId);
        var retailerLocation = escapeHtml(order.retailerLocation || "Location not available");
        var items = Array.isArray(order.items) ? order.items : [];
        var itemRows = items.length ? items.map(function (item, index) {
            return "<tr><td>" + (index + 1) + "</td><td><strong>" + escapeHtml(item.productName || "Product #" + item.productId) + "</strong><br><small>SKU: " + escapeHtml(item.sku || "-") + "</small></td><td>" + money(item.unitPrice) + "</td><td>" + Number(item.quantity || 0) + "</td><td>" + money(item.lineTotal) + "</td></tr>";
        }).join("") : "<tr><td colspan=\"5\" class=\"wm-order-empty\">Product details are not available for this earlier order. New orders will show full product details here.</td></tr>";
        var distributorShopName = escapeHtml(order.distributorShopName || order.distributorBusinessName || "Distributor Shop");
        var distributorBusinessName = escapeHtml(order.distributorBusinessName || "-");
        var distributorAddress = escapeHtml(order.distributorAddress || "Address not available");
        return {
            date: date,
            retailerName: retailerName,
            retailerLocation: retailerLocation,
            itemRows: itemRows,
            distributorShopName: distributorShopName,
            distributorBusinessName: distributorBusinessName,
            distributorAddress: distributorAddress,
            total: money(order.totalAmount),
            itemCount: items.length
        };
    }

    function renderDetails(order) {
        var data = viewModel(order);
        orderPanel.innerHTML =
            "<div class=\"wm-order-detail-layout\">" +
            "<div class=\"wm-order-hero\"><div><h2>" + orderCode(order) + "</h2><p>Order from <strong>" + data.retailerName + "</strong></p><p>Review the order first, then generate a bill or cost estimation document.</p></div><div class=\"wm-order-badge\">" + escapeHtml(order.status) + "</div></div>" +
            "<div class=\"wm-order-metrics\"><div class=\"wm-order-metric\"><span>Total Amount</span><strong>" + data.total + "</strong></div><div class=\"wm-order-metric\"><span>Products</span><strong>" + data.itemCount + "</strong></div><div class=\"wm-order-metric\"><span>Payment Mode</span><strong>" + escapeHtml(order.paymentMode || "-") + "</strong></div><div class=\"wm-order-metric\"><span>Order Date</span><strong>" + data.date + "</strong></div></div>" +
            "<div class=\"wm-order-card-grid\"><div class=\"wm-order-info-card\"><h3>Distributor Shop</h3><p><strong>" + data.distributorShopName + "</strong></p><p>" + data.distributorBusinessName + "</p><p>" + data.distributorAddress + "</p></div><div class=\"wm-order-info-card\"><h3>Retailer</h3><p><strong>" + data.retailerName + "</strong></p><p>" + data.retailerLocation + "</p></div></div>" +
            "<table class=\"wm-order-table\"><thead><tr><th>S.No</th><th>Purchase Product Details</th><th>Price</th><th>Qty</th><th>Amount</th></tr></thead><tbody>" + data.itemRows + "<tr><td colspan=\"4\" class=\"wm-order-total\">Order Total</td><td><strong>" + data.total + "</strong></td></tr></tbody></table>" +
            "</div>";
        printEstimate.hidden = true;
    }

    function renderDocument(order, type) {
        var data = viewModel(order);
        var isBill = type === "bill";
        var title = isBill ? "Bill" : "Cost Estimation";
        var numberLabel = isBill ? "Bill No." : "Estimate No.";
        var totalLabel = isBill ? "Total Bill Amount" : "Total Estimation Cost";
        var metaRows = "<tr><td>" + numberLabel + "</td><td>" + orderCode(order) + "</td></tr><tr><td>Date</td><td>" + data.date + "</td></tr>";
        if (isBill) {
            metaRows += "<tr><td>Status</td><td>" + escapeHtml(order.status) + "</td></tr><tr><td>Payment</td><td>" + escapeHtml(order.paymentMode || "-") + "</td></tr>";
        }
        orderPanel.innerHTML =
            "<div class=\"wm-estimate-bill\">" +
            "<div class=\"wm-bill-top\">" +
            "<div class=\"wm-shop-block\"><h3>" + data.distributorShopName + "</h3><p><strong>Distributor Shop Details</strong></p><p>" + data.distributorBusinessName + "</p><p>" + data.distributorAddress + "</p></div>" +
            "<div class=\"wm-bill-title\"><h2>" + title + "</h2><table class=\"wm-bill-meta\"><tbody>" + metaRows + "</tbody></table></div>" +
            "</div>" +
            "<div class=\"wm-bill-parties\"><div class=\"wm-bill-to\"><h3>Bill From</h3><p><strong>" + data.distributorShopName + "</strong></p><p>" + data.distributorAddress + "</p></div><div class=\"wm-bill-to\"><h3>Bill To / Retailer</h3><p><strong>" + data.retailerName + "</strong></p><p>" + data.retailerLocation + "</p></div></div>" +
            "<table class=\"wm-bill-table\"><thead><tr><th>S.No</th><th>Purchase Product Details</th><th>Price</th><th>Qty</th><th>Amount</th></tr></thead><tbody>" + data.itemRows + "</tbody></table>" +
            "<div class=\"wm-bill-footer\"><div class=\"wm-bill-total-box\"><div class=\"wm-bill-total-row\"><span>Subtotal</span><span>" + data.total + "</span></div><div class=\"wm-bill-total-row\"><strong>" + totalLabel + "</strong><strong>" + data.total + "</strong></div></div></div>" +
            "</div>";
        printEstimate.hidden = false;
    }

    function render(order) {
        if (generatedMode === "bill") {
            renderDocument(order, "bill");
        } else if (generatedMode === "estimate") {
            renderDocument(order, "estimate");
        } else {
            renderDetails(order);
        }
        acceptOrder.hidden = order.status !== "PLACED";
    }

    function load() {
        if (!orderId) {
            orderPanel.innerHTML = "<p>Order ID is missing.</p>";
            return;
        }
        wmFetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) {
            var orders = wmRows(data);
            currentOrder = orders.find(function (order) { return String(order.id) === String(orderId); });
            if (!currentOrder) {
                orderPanel.innerHTML = "<p>Unable to find this order.</p>";
                return;
            }
            render(currentOrder);
        }).catch(function () {
            orderPanel.innerHTML = "<p>Unable to load order details from the database.</p>";
        });
    }

    acceptOrder.addEventListener("click", function () {
        if (!currentOrder) return;
        acceptOrder.disabled = true;
        wmFetch("/api/v1/orders/" + encodeURIComponent(currentOrder.id) + "/accept", {method: "POST"}).then(function (response) {
            if (!response.ok) throw new Error("accept");
            return response.json();
        }).then(function (order) {
            currentOrder.status = order.status || "ACCEPTED";
            render(currentOrder);
        }).catch(function () {
            alert("Unable to accept this order.");
        }).finally(function () {
            acceptOrder.disabled = false;
        });
    });

    billGenerate.addEventListener("click", function () {
        if (!currentOrder) return;
        generatedMode = "bill";
        render(currentOrder);
    });

    estimateGenerate.addEventListener("click", function () {
        if (!currentOrder) return;
        generatedMode = "estimate";
        render(currentOrder);
    });

    printEstimate.addEventListener("click", function () {
        window.print();
    });

    load();
});
