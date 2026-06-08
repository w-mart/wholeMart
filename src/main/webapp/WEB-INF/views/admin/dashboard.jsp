<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>
    <%@ include file="../common/wholemart-shell-start.jsp" %>
        <h1 class="wm-title">Admin Dashboard</h1>
        <p class="wm-subtitle">Platform oversight from live database records.</p>
        <div class="wm-stats">
            <div class="wm-stat">
                <div class="wm-stat-icon">U</div>
                <div><b id="userCount">0</b><span>Users</span></div>
            </div>
            <div class="wm-stat">
                <div class="wm-stat-icon">A</div>
                <div><b id="approvalCount">0</b><span>Approvals</span></div>
            </div>
            <div class="wm-stat">
                <div class="wm-stat-icon">O</div>
                <div><b id="orderCount">0</b><span>Orders</span></div>
            </div>
        </div>
        <div class="wm-toolbar"><a class="btn wm-gradient-btn" href="/web/admin/users">Manage Users</a><a
                class="btn wm-gradient-btn" href="/web/admin/orders">View Orders</a></div>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                function text(id, value) { var element = document.getElementById(id); if (element) element.textContent = value; }
                fetch("/api/v1/admin/users").then(function (response) { return response.json(); }).then(function (data) { text("userCount", wmRows(data).length); }).catch(function () { text("userCount", 0); });
                fetch("/api/v1/admin/distributors").then(function (response) { return response.json(); }).then(function (data) { var rows = wmRows(data); text("approvalCount", rows.filter(function (row) { return !row.approved; }).length); }).catch(function () { text("approvalCount", 0); });
                fetch("/api/v1/admin/orders").then(function (response) { return response.json(); }).then(function (data) { text("orderCount", wmRows(data).length); }).catch(function () { text("orderCount", 0); });
            });
        </script>
        <%@ include file="../common/wholemart-shell-end.jsp" %>