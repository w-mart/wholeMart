/* Page-specific scripts for distributor\drivers.jsp */

document.addEventListener("DOMContentLoaded", function () {
    var rows = [], body = document.getElementById("driversBody"), search = document.getElementById("driverSearch"), status = document.getElementById("statusFilter");
    function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
    function render() {
        var query = (search.value || "").toLowerCase();
        var filtered = rows.filter(function (driver) { var row = [driver.name, driver.mobile, driver.status].join(" ").toLowerCase(); return (!query || row.indexOf(query) !== -1) && (!status.value || driver.status === status.value); });
        body.innerHTML = filtered.length ? filtered.map(function (driver, index) { return "<tr><td>" + (index + 1) + "</td><td>" + driver.name + "</td><td>" + driver.mobile + "</td><td>" + driver.status + "</td><td>" + (driver.createdAt ? new Date(driver.createdAt).toLocaleDateString() : "-") + "</td></tr>"; }).join("") : "<tr><td colspan=\"5\">No driver accounts found in the database.</td></tr>";
        text("totalDrivers", rows.length); text("activeDrivers", rows.filter(function (driver) { return driver.status === "ACTIVE"; }).length); text("inactiveDrivers", rows.filter(function (driver) { return driver.status !== "ACTIVE"; }).length);
    }
    wmFetch("/api/v1/users/drivers").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"5\">Unable to load drivers from the database.</td></tr>"; });
    search.addEventListener("input", render); status.addEventListener("change", render);
});
