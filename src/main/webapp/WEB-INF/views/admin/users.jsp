<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Users</title>
    <%@ include file="../common/wholemart-shell-start.jsp" %>
        <h1 class="wm-title">Users</h1>
        <p class="wm-subtitle">User administration and account monitoring</p>
        <div class="wm-stats">
            <div class="wm-stat">
                <div class="wm-stat-icon">T</div>
                <div><b id="totalUsers">0</b><span>Total</span></div>
            </div>
            <div class="wm-stat">
                <div class="wm-stat-icon">A</div>
                <div><b id="activeUsers">0</b><span>Active</span></div>
            </div>
            <div class="wm-stat">
                <div class="wm-stat-icon">P</div>
                <div><b id="pendingUsers">0</b><span>Pending</span></div>
            </div>
        </div>
        <div class="wm-toolbar">
            <div class="row g-4">
                <div class="col-md-6"><input id="userSearch" class="wm-input" type="search" placeholder="Search"></div>
                <div class="col-md-3"><select id="roleFilter" class="wm-select">
                        <option value="">All Roles</option>
                        <option>ROLE_ADMIN</option>
                        <option>ROLE_DISTRIBUTOR</option>
                        <option>ROLE_RETAILER</option>
                        <option>ROLE_DRIVER</option>
                    </select></div>
            </div>
        </div>
        <table class="wm-table">
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>Name</th>
                    <th>Role</th>
                    <th>Mobile</th>
                    <th>Status</th>
                    <th>Created</th>
                </tr>
            </thead>
            <tbody id="usersBody">
                <tr>
                    <td colspan="6">Loading users...</td>
                </tr>
            </tbody>
        </table>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                var users = [], body = document.getElementById("usersBody"), search = document.getElementById("userSearch"), role = document.getElementById("roleFilter");
                function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
                function date(value) { return value ? new Date(value).toLocaleDateString() : "-"; }
                function render() {
                    var query = (search.value || "").toLowerCase();
                    var filtered = users.filter(function (user) {
                        var row = [user.name, user.mobile, user.role, user.status].join(" ").toLowerCase();
                        return (!query || row.indexOf(query) !== -1) && (!role.value || user.role === role.value);
                    });
                    body.innerHTML = filtered.length ? filtered.map(function (user, index) {
                        return "<tr><td>" + (index + 1) + "</td><td>" + user.name + "</td><td>" + user.role + "</td><td>" + user.mobile + "</td><td>" + user.status + "</td><td>" + date(user.createdAt) + "</td></tr>";
                    }).join("") : "<tr><td colspan=\"6\">No users found in the database.</td></tr>";
                    text("totalUsers", users.length);
                    text("activeUsers", users.filter(function (user) { return user.status === "ACTIVE"; }).length);
                    text("pendingUsers", users.filter(function (user) { return user.status !== "ACTIVE"; }).length);
                }
                fetch("/api/v1/admin/users").then(function (response) { return response.json(); }).then(function (data) { users = wmRows(data); render(); }).catch(function () { body.innerHTML = "<tr><td colspan=\"6\">Unable to load users from the database.</td></tr>"; });
                search.addEventListener("input", render); role.addEventListener("change", render);
            });
        </script>
        <%@ include file="../common/wholemart-shell-end.jsp" %>