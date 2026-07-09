<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Reports</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<link href="/css/reports.css" rel="stylesheet">
<h1 class="wm-title">Reports</h1>
<script>
document.addEventListener("DOMContentLoaded", function () {
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    fetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("totalOrders", rows.length); text("acceptedOrders", rows.filter(function (row) { return row.status === "ACCEPTED"; }).length); text("totalRevenue", money(rows.reduce(function (sum, row) { return sum + Number(row.totalAmount || 0); }, 0))); });
    fetch("/api/v1/products/mine").then(function (response) { return response.json(); }).then(function (data) { text("productCount", wmRows(data).length); });
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
