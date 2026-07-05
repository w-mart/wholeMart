/* Page-specific scripts for retailer\ledger.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("ledgerBody"), search = document.getElementById("ledgerSearch");
    function money(value) { return "Rs. " + Number(value || 0).toFixed(2); }
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (entry) { return !query || [entry.id, entry.distributorUserId, entry.reason].join(" ").toLowerCase().indexOf(query) !== -1; });
        body.innerHTML = filtered.length ? filtered.map(function (entry, index) { return "<tr><td>" + (index + 1) + "</td><td>#LED-" + String(entry.id).padStart(5, "0") + "</td><td>#" + entry.distributorUserId + "</td><td>" + money(entry.amount) + "</td><td>" + entry.reason + "</td><td>" + (entry.createdAt ? new Date(entry.createdAt).toLocaleDateString() : "-") + "</td></tr>"; }).join("") : "<tr><td colspan=\"6\">No ledger entries found in the database.</td></tr>";
        text("ledgerLines", rows.length); text("ledgerAmount", money(rows.reduce(function (sum, entry) { return sum + Number(entry.amount || 0); }, 0))); text("ledgerDistributors", new Set(rows.map(function (entry) { return entry.distributorUserId; })).size);
    }
    wmFetch("/api/v1/ledger").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"6\">Unable to load ledger from the database.</td></tr>"; });
    search.addEventListener("input", render);
});
