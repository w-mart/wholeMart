/* Page-specific scripts for driver\orders.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("ordersBody"), search = document.getElementById("orderSearch"), status = document.getElementById("statusFilter");
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (delivery) { var row = [delivery.orderId, delivery.id, delivery.status].join(" ").toLowerCase(); return (!query || row.indexOf(query) !== -1) && (!status.value || delivery.status === status.value); });
        body.innerHTML = filtered.length ? filtered.map(function (delivery, index) { return "<tr><td>" + (index + 1) + "</td><td>#ORD-" + String(delivery.orderId).padStart(5, "0") + "</td><td>#DEL-" + String(delivery.id).padStart(5, "0") + "</td><td>" + delivery.status + "</td><td>" + (delivery.createdAt ? new Date(delivery.createdAt).toLocaleDateString() : "-") + "</td></tr>"; }).join("") : "<tr><td colspan=\"5\">No assigned delivery orders found in the database.</td></tr>";
    }
    wmFetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"5\">Unable to load assigned orders from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
