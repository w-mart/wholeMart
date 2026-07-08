<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Ledger</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Ledger</h1><p class="wm-subtitle">Track dues and pay-later balances</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="ledgerLines">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">$</div><div><b id="ledgerAmount">Rs. 0.00</b><span>Amount</span></div></div><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="ledgerDistributors">0</b><span>Distributors</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="ledgerSearch" class="wm-input" type="search" placeholder="Search"></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Entry ID</th><th>Distributor</th><th>Amount</th><th>Reason</th><th>Date</th></tr></thead><tbody id="ledgerBody"><tr><td colspan="6">Loading ledger...</td></tr></tbody></table>
<script>
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
    fetch("/api/v1/ledger").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"6\">Unable to load ledger from the database.</td></tr>"; });
    search.addEventListener("input", render);
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
