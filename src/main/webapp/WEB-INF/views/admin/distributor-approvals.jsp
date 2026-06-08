<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Distributor Approvals</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Distributor Approvals</h1><p class="wm-subtitle">Review pending distributor approvals</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalDistributors">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">P</div><div><b id="pendingDistributors">0</b><span>Pending</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="approvedDistributors">0</b><span>Approved</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="distributorSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option value="pending">Pending</option><option value="approved">Approved</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Business</th><th>User ID</th><th>Latitude</th><th>Longitude</th><th>Status</th><th>Actions</th></tr></thead><tbody id="distributorsBody"><tr><td colspan="7">Loading distributors...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("distributorsBody"), search = document.getElementById("distributorSearch"), status = document.getElementById("statusFilter");
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (distributor) {
            return (!query || distributor.businessName.toLowerCase().indexOf(query) !== -1) && (!status.value || (status.value === "approved") === distributor.approved);
        });
        body.innerHTML = filtered.length ? filtered.map(function (distributor, index) {
            var action = distributor.approved ? "<button class=\"wm-btn wm-btn-secondary\" type=\"button\">Approved</button>" : "<button class=\"wm-btn wm-btn-secondary\" data-approve-id=\"" + distributor.id + "\">Approve</button>";
            return "<tr><td>" + (index + 1) + "</td><td>" + distributor.businessName + "</td><td>#" + distributor.userId + "</td><td>" + distributor.latitude + "</td><td>" + distributor.longitude + "</td><td>" + (distributor.approved ? "Approved" : "Pending") + "</td><td>" + action + "</td></tr>";
        }).join("") : "<tr><td colspan=\"7\">No distributor profiles found in the database.</td></tr>";
        text("totalDistributors", rows.length); text("pendingDistributors", rows.filter(function (row) { return !row.approved; }).length); text("approvedDistributors", rows.filter(function (row) { return row.approved; }).length);
    }
    function load() { fetch("/api/v1/admin/distributors").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"7\">Unable to load distributors from the database.</td></tr>"; }); }
    body.addEventListener("click", function (event) { var button = event.target.closest("[data-approve-id]"); if (!button) return; fetch("/api/v1/admin/distributors/" + button.dataset.approveId + "/approve", {method: "POST"}).then(function (response) { if (!response.ok) throw new Error("approve"); load(); }).catch(function () { alert("Unable to approve distributor."); }); });
    search.addEventListener("input", render); status.addEventListener("change", render); load();
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
