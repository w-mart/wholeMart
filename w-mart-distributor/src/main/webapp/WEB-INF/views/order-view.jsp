<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>Order Details</title><link href="/css/distributor/order-view.css" rel="stylesheet">
    <%@ include file="../common/wholemart-shell-start.jsp" %>

<h1 class="wm-title">Order Details</h1><p class="wm-subtitle">Review purchased products and generate documents</p>
<div class="wm-order-actions"><a class="btn wm-btn-secondary" href="/web/distributor/orders">Back</a><button id="acceptOrder" class="btn wm-gradient-btn" type="button" hidden>Accept</button><button id="billGenerate" class="btn wm-btn-secondary" type="button">Bill Generate</button><button id="estimateGenerate" class="btn wm-btn-secondary" type="button">Cost Estimation Generate</button><button id="printEstimate" class="btn wm-btn-secondary" type="button" hidden>Print Generated</button></div>
<section class="wm-section" id="orderPanel"><p>Loading order details...</p></section>

    <script src="/js/distributor/order-view.js"></script>
    <%@ include file="../common/wholemart-shell-end.jsp" %>
