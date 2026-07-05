<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Ledger</title><link href="/css/retailer/ledger.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Ledger</h1><p class="wm-subtitle">Track dues and pay-later balances</p>
<div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="ledgerLines">0</b><span>Total</span></div></div><div class="wm-stat"><div class="wm-stat-icon">$</div><div><b id="ledgerAmount">Rs. 0.00</b><span>Amount</span></div></div><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="ledgerDistributors">0</b><span>Distributors</span></div></div></div>
<div class="wm-toolbar"><div class="row g-4"><div class="col-md-6"><input id="ledgerSearch" class="wm-input" type="search" placeholder="Search"></div></div></div>
<table class="wm-table"><thead><tr><th>S.No</th><th>Entry ID</th><th>Distributor</th><th>Amount</th><th>Reason</th><th>Date</th></tr></thead><tbody id="ledgerBody"><tr><td colspan="6">Loading ledger...</td></tr></tbody></table>

    <script src="/js/retailer/ledger.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
