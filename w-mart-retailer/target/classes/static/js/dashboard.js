/* Page-specific scripts for retailer\dashboard.jsp */

document.addEventListener("DOMContentLoaded", function () {
    function setText(id, value) {
        var element = document.getElementById(id);
        if (element) element.textContent = value;
    }

    wmFetch("/api/v1/distributors/nearby/summary").then(function (response) { return response.json(); }).then(function (data) {
        setText("nearbyCount", Number(data.total));
    }).catch(function () { setText("nearbyCount", 0); });

    wmFetch("/api/v1/cart").then(function (response) { return response.json(); }).then(function (data) {
        var total = wmRows(data).reduce(function (sum, item) { return sum + Number(item.quantity || 0); }, 0);
        setText("cartCount", total);
    }).catch(function () { setText("cartCount", 0); });

    wmFetch("/api/v1/orders").then(function (response) { return response.json(); }).then(function (data) {
        setText("orderCount", wmRows(data).length);
    }).catch(function () { setText("orderCount", 0); });
});
