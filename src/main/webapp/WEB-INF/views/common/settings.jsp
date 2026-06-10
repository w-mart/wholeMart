<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Business Settings | WholeMart</title>
    <%@ include file="wholemart-shell-start.jsp" %>

    <h1 class="wm-title">Business Settings</h1>
    <p class="wm-subtitle">Manage workspace preferences and support access for your WholeMart account.</p>

    <section class="wm-section">
        <h2 class="wm-card-title">Workspace</h2>
        <div class="wm-profile-summary-grid">
            <p><span>Workspace</span><strong><%= wmRoleLabel %></strong></p>
            <p><span>Primary user</span><strong><%= wmUserName %></strong></p>
            <p><span>Notifications</span><strong>Enabled</strong></p>
            <p><span>Support channel</span><strong>support@wholemart.com</strong></p>
        </div>
    </section>

    <section class="wm-section">
        <h2 class="wm-card-title">Common Actions</h2>
        <div class="wm-action-list wm-profile-actions">
            <a href="<%= wmDashboardHref %>">Back to dashboard</a>
            <a href="mailto:support@wholemart.com">Request account changes</a>
            <a href="/web/auth/login">Switch account</a>
            <a href="/web/auth/logout">Logout</a>
        </div>
    </section>

    <%@ include file="wholemart-shell-end.jsp" %>
