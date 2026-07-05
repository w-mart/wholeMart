/* Page-specific scripts for distributor\reports.jsp */

document.addEventListener("DOMContentLoaded", function () {
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    wmFetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("totalOrders", rows.length); text("acceptedOrders", rows.filter(function (row) { return row.status === "ACCEPTED"; }).length); text("totalRevenue", money(rows.reduce(function (sum, row) { return sum + Number(row.totalAmount || 0); }, 0))); });
    wmFetch("/api/v1/products/mine").then(function (response) { return response.json(); }).then(function (data) { text("productCount", wmRows(data).length); });
});
