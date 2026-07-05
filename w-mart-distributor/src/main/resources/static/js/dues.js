/* Page-specific scripts for distributor\dues.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("paymentsBody"), search = document.getElementById("paymentSearch"), status = document.getElementById("statusFilter");
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (payment) { var row = [payment.id, payment.orderId, payment.status].join(" ").toLowerCase(); return (!query || row.indexOf(query) !== -1) && (!status.value || payment.status === status.value); });
        body.innerHTML = filtered.length ? filtered.map(function (payment, index) { return "<tr><td>" + (index + 1) + "</td><td>#PAY-" + String(payment.id).padStart(5, "0") + "</td><td>#ORD-" + String(payment.orderId).padStart(5, "0") + "</td><td>" + money(payment.amount) + "</td><td>" + payment.status + "</td><td>" + (payment.createdAt ? new Date(payment.createdAt).toLocaleDateString() : "-") + "</td></tr>"; }).join("") : "<tr><td colspan=\"6\">No payments found in the database.</td></tr>";
        text("totalPayments", rows.length); text("pendingPayments", rows.filter(function (payment) { return payment.status === "PENDING"; }).length); text("paidAmount", money(rows.filter(function (payment) { return payment.status === "PAID"; }).reduce(function (sum, payment) { return sum + Number(payment.amount || 0); }, 0)));
    }
    wmFetch("/api/v1/payments").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"6\">Unable to load payments from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
