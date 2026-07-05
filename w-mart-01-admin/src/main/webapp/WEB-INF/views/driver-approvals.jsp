<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Driver Approvals</title>
    <link href="/css/admin/driver-approvals.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
        <h1 class="wm-title">Driver Approvals</h1>
        <p class="wm-subtitle">Review driver account approval state</p>
        <div class="wm-stats">
            <div class="wm-stat">
                <div class="wm-stat-icon">T</div>
                <div><b id="totalDrivers">0</b><span>Total</span></div>
            </div>
            <div class="wm-stat">
                <div class="wm-stat-icon">P</div>
                <div><b id="pendingDrivers">0</b><span>Pending</span></div>
            </div>
            <div class="wm-stat">
                <div class="wm-stat-icon">A</div>
                <div><b id="activeDrivers">0</b><span>Active</span></div>
            </div>
        </div>
        <div class="wm-toolbar">
            <div class="row g-4">
                <div class="col-md-6"><input id="driverSearch" class="wm-input" type="search" placeholder="Search">
                </div>
                <div class="col-md-3"><select id="statusFilter" class="wm-select">
                        <option value="">All Statuses</option>
                        <option>ACTIVE</option>
                        <option>PENDING_APPROVAL</option>
                        <option>SUSPENDED</option>
                    </select></div>
            </div>
        </div>
        <table class="wm-table">
            <thead>
                <tr>
                    <th>S.No</th>
                    <th>Driver</th>
                    <th>Mobile</th>
                    <th>Status</th>
                    <th>Created</th>
                </tr>
            </thead>
            <tbody id="driversBody">
                <tr>
                    <td colspan="5">Loading drivers...</td>
                </tr>
            </tbody>
        </table>
        
            <script src="/js/admin/driver-approvals.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
