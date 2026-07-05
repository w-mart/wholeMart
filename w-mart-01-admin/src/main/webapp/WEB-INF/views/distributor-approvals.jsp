<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Distributor Approvals</title><link href="/css/admin/distributor-approvals.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Distributor Approvals</h1><p class="wm-subtitle">Review pending distributor approvals</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalDistributors">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">P</div><div><b id="pendingDistributors">0</b><span>Pending</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="approvedDistributors">0</b><span>Approved</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="distributorSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select id="statusFilter" class="wm-select"><option value="">All Statuses</option><option value="pending">Pending</option><option value="approved">Approved</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Business</th><th>User ID</th><th>Latitude</th><th>Longitude</th><th>Status</th><th>Actions</th></tr></thead><tbody id="distributorsBody"><tr><td colspan="7">Loading distributors...</td></tr></tbody></table>

    <script src="/js/admin/distributor-approvals.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
