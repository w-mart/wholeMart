<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Reports</title><link href="/css/driver/reports.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>
<h1 class="wm-title">Reports</h1><p class="wm-subtitle">View delivery performance</p><div class="wm-stats"><div class="wm-stat"><div class="wm-stat-icon">D</div><div><b id="completedCount">0</b><span>Completed</span></div></div><div class="wm-stat"><div class="wm-stat-icon">A</div><div><b id="activeCount">0</b><span>Active</span></div></div><div class="wm-stat"><div class="wm-stat-icon">T</div><div><b id="totalCount">0</b><span>Total</span></div></div></div><section class="wm-section"><h2 class="h5 wm-card-title">Monthly Performance</h2><div class="wm-map">Delivery metrics loaded from database assignments.</div></section>

    <script src="/js/driver/reports.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
