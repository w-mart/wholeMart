/* Page-specific scripts for distributor\delivery.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("deliveriesBody"), search = document.getElementById("deliverySearch"), status = document.getElementById("statusFilter");
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (delivery) { var row = [delivery.id, delivery.orderId, delivery.driverUserId, delivery.status].join(" ").toLowerCase(); return (!query || row.indexOf(query) !== -1) && (!status.value || delivery.status === status.value); });
        body.innerHTML = filtered.length ? filtered.map(function (delivery, index) { return "<tr><td>" + (index + 1) + "</td><td>#DEL-" + String(delivery.id).padStart(5, "0") + "</td><td>#ORD-" + String(delivery.orderId).padStart(5, "0") + "</td><td>" + delivery.status + "</td><td>#" + delivery.driverUserId + "</td><td>" + (delivery.createdAt ? new Date(delivery.createdAt).toLocaleDateString() : "-") + "</td></tr>"; }).join("") : "<tr><td colspan=\"6\">No deliveries found in the database.</td></tr>";
        text("totalDeliveries", rows.length); text("pickedDeliveries", rows.filter(function (delivery) { return delivery.status === "PICKED_UP"; }).length); text("deliveredDeliveries", rows.filter(function (delivery) { return delivery.status === "DELIVERED"; }).length);
    }
    wmFetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"6\">Unable to load deliveries from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
