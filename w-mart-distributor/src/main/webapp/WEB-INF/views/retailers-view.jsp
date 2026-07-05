<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Nearby Distributors</title><link href="/css/retailer/distributors.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Nearby Distributors</h1><p class="wm-subtitle">Find distributors serving your location</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalDistributors">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="approvedDistributors">0</b><span>Approved</span></div></div><div class="wm-stat"><div class="wm-stat-icon">O</div><div><b id="onlineDistributors">0</b><span>Available</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="distributorSearch" class="wm-input" type="search" placeholder="Search"></div><div class="col-md-3"><select class="wm-select"><option>All Statuses</option></select></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Business Name</th><th>Shop / Contact</th><th>Location</th><th>GSTIN</th><th>Actions</th></tr></thead><tbody id="distributorsBody"><tr><td colspan="6">Loading distributors...</td></tr></tbody></table>

    <script src="/js/retailer/distributors.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
