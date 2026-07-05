/* Page-specific scripts for admin\users.jsp */

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
