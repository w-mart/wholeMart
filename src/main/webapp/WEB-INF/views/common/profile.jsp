<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile | WholeMart</title>
    <%@ include file="wholemart-shell-start.jsp" %>

    <h1 class="wm-title">Profile</h1>
    <p class="wm-subtitle">Review your account identity and workspace access.</p>

    <section class="wm-section">
        <h2 class="wm-card-title">Account Details</h2>
        <div class="wm-profile-summary-grid">
            <p><span>Name</span><strong><%= wmUserName %></strong></p>
            <p><span>Role</span><strong><%= wmRoleLabel %></strong></p>
            <p><span>Mobile</span><strong><%= session.getAttribute("mobile") == null ? "Not available" : String.valueOf(session.getAttribute("mobile")) %></strong></p>
            <p><span>Status</span><strong>Active</strong></p>
        </div>
    </section>

    <section class="wm-section">
        <h2 class="wm-card-title">Quick Access</h2>
        <div class="wm-action-list wm-profile-actions">
            <a href="/">Home</a>
            <a href="<%= wmDashboardHref %>">Dashboard</a>
            <a href="mailto:support@wholemart.com">Contact support</a>
            <a href="/web/auth/logout">Logout</a>
        </div>
    </section>

    <%@ include file="wholemart-shell-end.jsp" %>
