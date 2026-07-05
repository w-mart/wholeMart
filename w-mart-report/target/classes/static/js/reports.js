/* Page-specific scripts for retailer\reports.jsp */

document.addEventListener("DOMContentLoaded", function () {
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    wmFetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("totalOrders", rows.length); text("placedOrders", rows.filter(function (row) { return row.status === "PLACED"; }).length); text("deliveredOrders", rows.filter(function (row) { return row.status === "DELIVERED"; }).length); });
    wmFetch("/api/v1/payments").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("totalPaid", money(rows.filter(function (row) { return row.status === "PAID"; }).reduce(function (sum, row) { return sum + Number(row.amount || 0); }, 0))); });
    wmFetch("/api/v1/ledger").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("ledgerDue", money(rows.reduce(function (sum, row) { return sum + Number(row.amount || 0); }, 0))); });
});
