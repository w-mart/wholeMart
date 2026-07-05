<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Users</title>
    <link href="/css/admin/users.css" rel="stylesheet">
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
        
            <script src="/js/admin/users.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
