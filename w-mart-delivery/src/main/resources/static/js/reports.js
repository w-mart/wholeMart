/* Page-specific scripts for driver\reports.jsp */

document.addEventListener("DOMContentLoaded", function () {
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    wmFetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("totalCount", rows.length); text("completedCount", rows.filter(function (row) { return row.status === "DELIVERED"; }).length); text("activeCount", rows.filter(function (row) { return row.status !== "DELIVERED" && row.status !== "FAILED"; }).length); });
});
