/* Page-specific scripts for retailer\orders.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var ordersBody = document.getElementById("ordersBody");
    var orderSearch = document.getElementById("orderSearch");
    var statusFilter = document.getElementById("statusFilter");
    var orders = [];

    function money(value) {
        return "Rs. " + Number(value || 0).toFixed(2);
    }

    function setText(id, value) {
        var element = document.getElementById(id);
        if (element) element.textContent = value;
    }

    function render() {
        var query = (orderSearch.value || "").toLowerCase();
        var status = statusFilter.value;
        var filtered = orders.filter(function (order) {
            var text = [order.id, order.distributorUserId, order.status, order.paymentMode].join(" ").toLowerCase();
            return (!query || text.indexOf(query) !== -1) && (!status || order.status === status);
        });
        ordersBody.innerHTML = filtered.length ? filtered.map(function (order, index) {
            var date = order.createdAt ? new Date(order.createdAt).toLocaleDateString() : "-";
            return "<tr><td>" + (index + 1) + "</td><td>#ORD-" + String(order.id).padStart(5, "0") + "</td><td>#" + order.distributorUserId + "</td><td>" + money(order.totalAmount) + "</td><td>" + order.status + "</td><td>" + date + "</td><td>" + (order.paymentMode || "-") + "</td></tr>";
        }).join("") : "<tr><td colspan=\"7\">No orders found in the database.</td></tr>";
        setText("totalOrders", orders.length);
        setText("placedOrders", orders.filter(function (order) { return order.status === "PLACED"; }).length);
        setText("orderTotal", money(orders.reduce(function (total, order) { return total + Number(order.totalAmount || 0); }, 0)));
    }

    wmFetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) {
        orders = wmRows(data);
        render();
    }).catch(function () {
        ordersBody.innerHTML = "<tr><td colspan=\"7\">Unable to load orders from the database.</td></tr>";
    });
    orderSearch.addEventListener("input", render);
    statusFilter.addEventListener("change", render);
});
