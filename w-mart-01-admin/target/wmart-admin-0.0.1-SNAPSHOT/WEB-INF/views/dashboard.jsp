<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>
    <link href="/css/admin/dashboard.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>

    <section class="wm-dashboard-shell">
        <h1 class="wm-title">Admin Dashboard</h1>
        <p class="wm-subtitle">Platform oversight from live database records.</p>

        <div class="wm-stats" aria-label="Platform statistics">
            <div class="wm-stat">
                <div class="wm-stat-icon">U</div>
                <div class="wm-stat-details">
                    <b id="userCount">0</b>
                    <span>Users</span>
                </div>
            </div>
            <div class="wm-stat">
                <div class="wm-stat-icon">A</div>
                <div class="wm-stat-details">
                    <b id="approvalCount">0</b>
                    <span>Approvals</span>
                </div>
            </div>
            <div class="wm-stat">
                <div class="wm-stat-icon">O</div>
                <div class="wm-stat-details">
                    <b id="orderCount">0</b>
                    <span>Orders</span>
                </div>
            </div>
        </div>

        <div class="wm-toolbar">
            <a class="btn wm-gradient-btn" href="/web/admin/users">Manage Users</a>
            <a class="btn wm-gradient-btn" href="/web/admin/orders">View Orders</a>
        </div>
    </section>

    <%@ include file="../common/wholemart-shell-end.jsp" %>
    <script src="/js/admin/dashboard.js"></script>
</body>
</html>
