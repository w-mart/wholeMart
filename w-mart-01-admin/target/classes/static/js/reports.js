/* Page-specific scripts for admin\reports.jsp */

document.addEventListener("DOMContentLoaded", function () {
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    fetch("/api/v1/admin/orders").then(function (response) { return response.json(); }).then(function (data) { text("totalOrders", wmRows(data).length); });
    fetch("/api/v1/admin/payments").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("totalPayments", rows.length); text("paymentAmount", money(rows.reduce(function (sum, row) { return sum + Number(row.amount || 0); }, 0))); });
    fetch("/api/v1/admin/users").then(function (response) { return response.json(); }).then(function (data) { text("userCount", wmRows(data).length); });
});
