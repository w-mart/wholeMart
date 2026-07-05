/* Page-specific scripts for admin\orders.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var orders = [], body = document.getElementById("ordersBody"), search = document.getElementById("orderSearch"), status = document.getElementById("statusFilter");
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = orders.filter(function (order) {
            var row = [order.id, order.retailerUserId, order.distributorUserId, order.status].join(" ").toLowerCase();
            return (!query || row.indexOf(query) !== -1) && (!status.value || order.status === status.value);
        });
        body.innerHTML = filtered.length ? filtered.map(function (order, index) {
            return "<tr><td>" + (index + 1) + "</td><td>#ORD-" + String(order.id).padStart(5, "0") + "</td><td>#" + order.retailerUserId + "</td><td>#" + order.distributorUserId + "</td><td>" + order.status + "</td><td>" + money(order.totalAmount) + "</td><td>" + (order.createdAt ? new Date(order.createdAt).toLocaleDateString() : "-") + "</td></tr>";
        }).join("") : "<tr><td colspan=\"7\">No orders found in the database.</td></tr>";
        text("totalOrders", orders.length); text("placedOrders", orders.filter(function (order) { return order.status === "PLACED"; }).length); text("acceptedOrders", orders.filter(function (order) { return order.status === "ACCEPTED"; }).length);
    }
    fetch("/api/v1/admin/orders").then(function (response) { return response.json(); }).then(function (data) { orders = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"7\">Unable to load orders from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
