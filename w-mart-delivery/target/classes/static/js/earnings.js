/* Page-specific scripts for driver\earnings.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var body = document.getElementById("earningsBody");
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    wmFetch("/api/v1/deliveries").then(function (response) { return response.json(); }).then(function (data) {
        var rows = wmRows(data);
        body.innerHTML = rows.length ? rows.map(function (delivery, index) { return "<tr><td>" + (index + 1) + "</td><td>#DEL-" + String(delivery.id).padStart(5, "0") + "</td><td>#ORD-" + String(delivery.orderId).padStart(5, "0") + "</td><td>" + delivery.status + "</td><td>" + (delivery.createdAt ? new Date(delivery.createdAt).toLocaleDateString() : "-") + "</td><td>Rs. 0.00</td></tr>"; }).join("") : "<tr><td colspan=\"6\">No delivery earnings records found in the database.</td></tr>";
        text("deliveredCount", rows.filter(function (delivery) { return delivery.status === "DELIVERED"; }).length);
        text("pendingCount", rows.filter(function (delivery) { return delivery.status !== "DELIVERED" && delivery.status !== "FAILED"; }).length);
    }).catch(function () { body.innerHTML = "<tr><td colspan=\"6\">Unable to load delivery records from the database.</td></tr>"; });
});
