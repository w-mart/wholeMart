/* Page-specific scripts for driver\dashboard.jsp */

document.addEventListener("DOMContentLoaded", function () {
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    wmFetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) {
        var rows = wmRows(data);
        text("totalDeliveries", rows.length);
        text("completedDeliveries", rows.filter(function (delivery) { return delivery.status === "DELIVERED"; }).length);
        text("activeDeliveries", rows.filter(function (delivery) { return delivery.status !== "DELIVERED" && delivery.status !== "FAILED"; }).length);
    }).catch(function () {
        text("totalDeliveries", 0); text("completedDeliveries", 0); text("activeDeliveries", 0);
    });
});
