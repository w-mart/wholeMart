<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Order Details</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<style>
    .wm-order-actions { display: flex; flex-wrap: wrap; gap: 12px; margin-bottom: 18px; }
    .wm-order-detail-layout { display: grid; gap: 10px; }
    .wm-order-hero { display: grid; grid-template-columns: 1fr auto; gap: 14px; align-items: center; padding: 14px 18px; border: 1px solid #cfe3da; border-radius: 8px; background: #fff; }
    .wm-order-hero h2 { margin: 0 0 3px; font-size: 1.28rem; color: #073f31; }
    .wm-order-hero p { margin: 2px 0; color: #52645d; }
    .wm-order-hero p:last-child { display: none; }
    .wm-order-badge { display: inline-flex; align-items: center; justify-content: center; min-width: 96px; min-height: 34px; padding: 6px 12px; border: 1px solid #0b6b52; border-radius: 999px; color: #064735; font-weight: 800; background: #f1fbf6; }
    .wm-order-card-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 16px; }
    .wm-order-info-card { border: 1px solid #d7e8df; border-radius: 8px; padding: 12px 16px; background: #fff; }
    .wm-order-info-card h3 { margin: 0 0 8px; font-size: .9rem; color: #66756e; text-transform: uppercase; }
    .wm-order-info-card p { margin: 4px 0; color: #30463d; }
    .wm-order-metrics { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 10px; }
    .wm-order-metric { border: 1px solid #d7e8df; border-radius: 8px; padding: 10px 14px; background: #fff; }
    .wm-order-metric span { display: block; color: #66756e; font-size: .84rem; margin-bottom: 4px; }
    .wm-order-metric strong { color: #142c24; font-size: 1.05rem; }
    .wm-order-table { width: 100%; border-collapse: collapse; background: #fff; border: 1px solid #d7e8df; border-radius: 8px; overflow: hidden; }
    .wm-order-table th, .wm-order-table td { border-bottom: 1px solid #e1eee8; padding: 10px 14px; vertical-align: top; }
    .wm-order-table th { background: #f7faf5; color: #1b2f27; }
    .wm-order-table th:nth-child(1), .wm-order-table td:nth-child(1), .wm-order-table th:nth-child(4), .wm-order-table td:nth-child(4) { text-align: center; }
    .wm-order-table th:nth-child(3), .wm-order-table td:nth-child(3), .wm-order-table th:nth-child(5), .wm-order-table td:nth-child(5) { text-align: right; }
    .wm-estimate-bill { max-width: 980px; margin: 0 auto 28px; background: #fff; border: 1px solid #1d5c49; color: #15251f; }
    .wm-bill-top { display: grid; grid-template-columns: 1fr auto; gap: 24px; padding: 24px 28px; border-bottom: 2px solid #1d5c49; }
    .wm-bill-title { text-align: right; }
    .wm-bill-title h2 { font-size: 1.75rem; letter-spacing: 0; margin: 0 0 8px; text-transform: uppercase; color: #073f31; }
    .wm-bill-title p, .wm-shop-block p, .wm-bill-to p { margin: 4px 0; color: #34453e; }
    .wm-shop-block h3 { font-size: 1.35rem; margin: 0 0 8px; color: #073f31; }
    .wm-bill-meta { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .wm-bill-meta td { border: 1px solid #cfe3da; padding: 8px 10px; white-space: nowrap; }
    .wm-bill-meta td:first-child { color: #5f7069; font-weight: 700; }
    .wm-bill-parties { display: grid; grid-template-columns: 1fr 1fr; border-bottom: 1px solid #1d5c49; }
    .wm-bill-to { padding: 18px 28px; min-height: 120px; }
    .wm-bill-to + .wm-bill-to { border-left: 1px solid #1d5c49; }
    .wm-bill-to h3 { font-size: .9rem; margin: 0 0 10px; text-transform: uppercase; color: #5f7069; }
    .wm-bill-to strong { color: #142c24; font-size: 1.05rem; }
    .wm-bill-table { width: 100%; border-collapse: collapse; }
    .wm-bill-table th, .wm-bill-table td { border-bottom: 1px solid #d8e8e0; padding: 13px 14px; vertical-align: top; }
    .wm-bill-table th { background: #f7faf5; color: #15251f; font-size: .92rem; text-transform: uppercase; }
    .wm-bill-table th:nth-child(1), .wm-bill-table td:nth-child(1), .wm-bill-table th:nth-child(4), .wm-bill-table td:nth-child(4) { text-align: center; }
    .wm-bill-table th:nth-child(3), .wm-bill-table td:nth-child(3), .wm-bill-table th:nth-child(5), .wm-bill-table td:nth-child(5) { text-align: right; }
    .wm-bill-table small { color: #66756e; }
    .wm-bill-footer { display: flex; justify-content: flex-end; padding: 18px 28px 26px; }
    .wm-bill-total-box { min-width: 310px; border: 1px solid #1d5c49; }
    .wm-bill-total-row { display: grid; grid-template-columns: 1fr auto; gap: 18px; padding: 13px 16px; }
    .wm-bill-total-row + .wm-bill-total-row { border-top: 1px solid #cfe3da; }
    .wm-bill-total-row strong { font-size: 1.15rem; color: #073f31; }
    .wm-order-empty { text-align: center; color: #66756e; }
    .wm-order-total { text-align: right; font-weight: 700; }
    @media (max-width: 760px) {
        .wm-order-hero, .wm-order-card-grid, .wm-order-metrics { grid-template-columns: 1fr; }
        .wm-bill-top, .wm-bill-parties { grid-template-columns: 1fr; }
        .wm-bill-title { text-align: left; }
        .wm-bill-to + .wm-bill-to { border-left: 0; border-top: 1px solid #1d5c49; }
        .wm-bill-footer { justify-content: stretch; }
        .wm-bill-total-box { min-width: 0; width: 100%; }
    }
    @media print {
        .wm-topbar, .wm-sidebar, .wm-order-actions, .wm-footer, .wm-title, .wm-subtitle { display: none !important; }
        .wm-main, .wm-content { margin: 0 !important; padding: 0 !important; }
        .wm-section { border: 0 !important; box-shadow: none !important; padding: 0 !important; background: #fff !important; }
        .wm-estimate-bill { max-width: none; margin: 0; border-color: #000; }
    }
</style>
<h1 class="wm-title">Order Details</h1><p class="wm-subtitle">Review purchased products and generate documents</p>
<div class="wm-order-actions"><a class="btn wm-btn-secondary" href="/web/distributor/orders">Back</a><button id="acceptOrder" class="btn wm-gradient-btn" type="button" hidden>Accept</button><button id="billGenerate" class="btn wm-btn-secondary" type="button">Bill Generate</button><button id="estimateGenerate" class="btn wm-btn-secondary" type="button">Cost Estimation Generate</button><button id="printEstimate" class="btn wm-btn-secondary" type="button" hidden>Print Generated</button></div>
<section class="wm-section" id="orderPanel"><p>Loading order details...</p></section>
<script>
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
        fetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) {
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
        fetch("/api/v1/orders/" + encodeURIComponent(currentOrder.id) + "/accept", {method: "POST"}).then(function (response) {
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
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
