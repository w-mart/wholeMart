<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Drivers</title><%@ include file="../common/wholemart-shell-start.jsp" %>
<link href="/css/drivers.css" rel="stylesheet">
<h1 class="wm-title">Drivers</h1>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalDrivers">0</b><span>Total Drivers</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="activeDrivers">0</b><span>Active Drivers</span></div></div><div class="wm-stat"><div class="wm-stat-icon">I</div><div><b id="inactiveDrivers">0</b><span>Inactive Drivers</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="driverSearch" class="wm-input" type="search" placeholder="Search drivers"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option>ACTIVE</option><option>PENDING_APPROVAL</option><option>SUSPENDED</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Driver Name</th><th>Mobile</th><th>Status</th><th>Created</th></tr></thead><tbody id="driversBody"><tr><td colspan="5">Loading drivers...</td></tr></tbody></table>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("driversBody"), search = document.getElementById("driverSearch"), status = document.getElementById("statusFilter");
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (driver) { var row = [driver.name, driver.mobile, driver.status].join(" ").toLowerCase(); return (!query || row.indexOf(query) !== -1) && (!status.value || driver.status === status.value); });
        body.innerHTML = filtered.length ? filtered.map(function (driver, index) { return "<tr><td>" + (index + 1) + "</td><td>" + driver.name + "</td><td>" + driver.mobile + "</td><td>" + driver.status + "</td><td>" + (driver.createdAt ? new Date(driver.createdAt).toLocaleDateString() : "-") + "</td></tr>"; }).join("") : "<tr><td colspan=\"5\">No driver accounts found in the database.</td></tr>";
        text("totalDrivers", rows.length); text("activeDrivers", rows.filter(function (driver) { return driver.status === "ACTIVE"; }).length); text("inactiveDrivers", rows.filter(function (driver) { return driver.status !== "ACTIVE"; }).length);
    }
    fetch("/api/v1/users/drivers").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"5\">Unable to load drivers from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
</script>
<%@ include file="../common/wholemart-shell-end.jsp" %>
