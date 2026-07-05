/* Page-specific scripts for admin\distributor-approvals.jsp */

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
    function load() { wmFetch("/api/v1/admin/distributors").then(function (response) { return response.json(); }).then(function (data) { rows = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"7\">Unable to load distributors from the database.</td></tr>"; }); }
    body.addEventListener("click", function (event) { var button = event.target.closest("[data-approve-id]"); if (!button) return; wmFetch("/api/v1/admin/distributors/" + button.dataset.approveId + "/approve", {method: "POST"}).then(function (response) { if (!response.ok) throw new Error("approve"); load(); }).catch(function () { alert("Unable to approve distributor."); }); });
    search.addEventListener("input", render); status.addEventListener("change", render); load();
});
