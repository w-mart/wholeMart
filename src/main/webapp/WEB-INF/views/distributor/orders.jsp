<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Order Management</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:ital,wght@0,700;0,800;1,700&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/orders.css">
</head>

<body class="wm-home">

    <% String wmUserName=session.getAttribute("name")==null ? "Guest" :
        String.valueOf(session.getAttribute("name")); String wmUserInitial=wmUserName.substring(0,1).toUpperCase();
        %>

        <%@ include file="/WEB-INF/common/distributor-header.jsp" %>

            <div class="wm-app">
                <main class="wm-home-main">
                    <div class="wm-home-container">

                        <!-- ===== Hero: Order Snapshot ===== -->
                        <div class="wm-hero-section">
                            <button class="hero-nav-btn hero-nav-prev" type="button" aria-label="Previous">
                                <i class="bi bi-chevron-left"></i>
                            </button>

                            <div class="wm-hero-grid">
                                <div class="wm-hero-left">
                                    <div class="wm-hero-eyebrow"><span class="wm-hero-dot"></span>DISTRIBUTOR WORKSPACE</div>
                                    <h1 class="wm-hero-title">Order Management, <%= wmUserName %></h1>
                                    <p class="wm-hero-sub">Monitor and manage orders from retailers, track fulfillment
                                        status, and stay on top of every delivery from one place.</p>
                                    <div class="wm-hero-actions">
                                        <a class="hero-action-btn hero-action-primary" href="#ordersListSection">
                                            <i class="bi bi-receipt"></i> All Orders
                                        </a>
                                        <a class="hero-action-btn" href="#" data-status-shortcut="PLACED">
                                            <i class="bi bi-hourglass-split"></i> Placed
                                        </a>
                                        <a class="hero-action-btn" href="#" data-status-shortcut="OUT_FOR_DELIVERY">
                                            <i class="bi bi-truck"></i> Deliveries
                                        </a>
                                    </div>
                                </div>

                                <div class="wm-hero-card">
                                    <div class="wm-hero-card-top">
                                        <span class="wm-hero-card-eyebrow">TODAY'S PERFORMANCE</span>
                                        <span class="wm-hero-ai-badge">AI</span>
                                    </div>
                                    <h2 class="wm-hero-card-title">Business Snapshot</h2>
                                    <p class="wm-hero-card-desc">
                                        Today: <b id="heroTodayOrders">0</b> orders,
                                        <b id="heroTodayRevenue">Rs. 0.00</b> revenue
                                        (<span id="heroTrend">0%</span> vs yesterday).
                                    </p>
                                    <div class="wm-hero-card-stats">
                                        <div>
                                            <b id="heroStatTotal">0</b>
                                            <span>ORDERS</span>
                                        </div>
                                        <div>
                                            <b id="heroStatPlaced">0</b>
                                            <span>PLACED</span>
                                        </div>
                                        <div>
                                            <b id="heroStatPending">0</b>
                                            <span>PENDING</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <button class="hero-nav-btn hero-nav-next" type="button" aria-label="Next">
                                <i class="bi bi-chevron-right"></i>
                            </button>
                        </div>

                        <div class="wm-hero-dots">
                            <span class="wm-hero-page-dot active"></span>
                            <span class="wm-hero-page-dot"></span>
                            <span class="wm-hero-page-dot"></span>
                        </div>
                        <hr>

                       

                        <!-- ===== Orders List ===== -->
                        <div id="ordersListSection" class="wm-orders-list-section">
                            <div class="wm-orders-headline">
                                <div>
                                    <h2 class="wm-reports-title" style="font-size:24px;margin-bottom:4px;">All Orders</h2>
                                    <p class="wm-reports-sub" style="margin-bottom:0;">Search, filter and manage every
                                        order in one list.</p>
                                </div>
                                <button class="home-btn home-btn-secondary" id="refreshOrders" type="button">
                                    <i class="bi bi-arrow-clockwise"></i> Refresh
                                </button>
                            </div>

                            <div class="wm-toolbar order-toolbar">
                                <div class="row g-3 align-items-center">
                                    <div class="col-md-5">
                                        <input id="orderSearch" class="wm-input" type="search"
                                            placeholder="Search by order ID, retailer, location...">
                                    </div>
                                    <div class="col-md-3">
                                        <select id="statusFilter" class="wm-select">
                                            <option value="">All Statuses</option>
                                            <option>PLACED</option>
                                            <option>ACCEPTED</option>
                                            <option>REJECTED</option>
                                            <option>CANCELLED</option>
                                            <option>OUT_FOR_DELIVERY</option>
                                            <option>DELIVERED</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <select id="sortOrder" class="wm-select">
                                            <option value="newest">Newest First</option>
                                            <option value="oldest">Oldest First</option>
                                            <option value="amount_high">Amount: High to Low</option>
                                            <option value="amount_low">Amount: Low to High</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2 text-md-end">
                                        <span class="order-result-count" id="resultCount">0 orders</span>
                                    </div>
                                </div>
                            </div>

                            <div id="ordersState" class="order-state-message" style="display:none;"></div>
                            <div class="order-list" id="ordersList"></div>
                        </div>

                    </div>
                </main>
            </div>

            <%@ include file="/WEB-INF/common/footer.jsp" %>

            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var ordersList = document.getElementById("ordersList");
                    var ordersState = document.getElementById("ordersState");
                    var orderSearch = document.getElementById("orderSearch");
                    var statusFilter = document.getElementById("statusFilter");
                    var sortOrder = document.getElementById("sortOrder");
                    var refreshBtn = document.getElementById("refreshOrders");
                    var orders = [];

                    var STATUS_META = {
                        PLACED: { label: "Placed", cls: "status-placed" },
                        ACCEPTED: { label: "Accepted", cls: "status-accepted" },
                        REJECTED: { label: "Rejected", cls: "status-rejected" },
                        CANCELLED: { label: "Cancelled", cls: "status-rejected" },
                        OUT_FOR_DELIVERY: { label: "Out for Delivery", cls: "status-transit" },
                        DELIVERED: { label: "Delivered", cls: "status-delivered" }
                    };

                    function money(value) {
                        return "Rs. " + Number(value || 0).toFixed(2);
                    }

                    function setText(id, value) {
                        var element = document.getElementById(id);
                        if (element) element.textContent = value;
                    }

                    function escapeHtml(value) {
                        return String(value == null ? "" : value)
                            .replace(/&/g, "&amp;")
                            .replace(/</g, "&lt;")
                            .replace(/>/g, "&gt;")
                            .replace(/"/g, "&quot;")
                            .replace(/'/g, "&#39;");
                    }

                    function normalizeOrders(payload) {
                        if (Array.isArray(payload)) return payload;
                        if (payload && Array.isArray(payload.content)) return payload.content;
                        if (payload && Array.isArray(payload.data)) return payload.data;
                        return [];
                    }

                    function isSameDay(dateA, dateB) {
                        return dateA.getFullYear() === dateB.getFullYear()
                            && dateA.getMonth() === dateB.getMonth()
                            && dateA.getDate() === dateB.getDate();
                    }

                    function setRing(ringId, pctId, percent) {
                        var pct = Math.max(0, Math.min(100, Math.round(percent || 0)));
                        var ring = document.getElementById(ringId);
                        if (!ring) return;
                        var circle = ring.querySelector(".ring-fg");
                        var circumference = 169.6;
                        circle.style.strokeDashoffset = circumference - (pct / 100) * circumference;
                        setText(pctId, pct + "%");
                    }

                    // ===== Hero: today vs yesterday snapshot =====
                    function renderHero() {
                        var today = new Date();
                        var yesterday = new Date();
                        yesterday.setDate(today.getDate() - 1);

                        var todayOrders = orders.filter(function (o) {
                            return o.createdAt && isSameDay(new Date(o.createdAt), today);
                        });
                        var yesterdayOrders = orders.filter(function (o) {
                            return o.createdAt && isSameDay(new Date(o.createdAt), yesterday);
                        });

                        var todayRevenue = todayOrders.reduce(function (sum, o) { return sum + Number(o.totalAmount || 0); }, 0);
                        var yesterdayRevenue = yesterdayOrders.reduce(function (sum, o) { return sum + Number(o.totalAmount || 0); }, 0);
                        var trend = yesterdayRevenue ? Math.round(((todayRevenue - yesterdayRevenue) / yesterdayRevenue) * 100) : 0;

                        var placed = orders.filter(function (o) { return o.status === "PLACED"; }).length;
                        var pending = orders.filter(function (o) {
                            return o.status === "PLACED" || o.status === "ACCEPTED" || o.status === "OUT_FOR_DELIVERY";
                        }).length;

                        setText("heroTodayOrders", todayOrders.length);
                        setText("heroTodayRevenue", money(todayRevenue));
                        setText("heroTrend", (trend >= 0 ? "+" : "") + trend + "%");
                        setText("heroStatTotal", orders.length);
                        setText("heroStatPlaced", placed);
                        setText("heroStatPending", pending);
                    }

                    // ===== Analytics ring cards =====
                    function renderAnalytics() {
                        var total = orders.length;
                        var delivered = orders.filter(function (o) { return o.status === "DELIVERED"; }).length;
                        var transit = orders.filter(function (o) { return o.status === "OUT_FOR_DELIVERY"; }).length;
                        var placed = orders.filter(function (o) { return o.status === "PLACED"; }).length;
                        var accepted = orders.filter(function (o) { return o.status === "ACCEPTED"; }).length;
                        var rejected = orders.filter(function (o) { return o.status === "REJECTED"; }).length;
                        var cancelled = orders.filter(function (o) { return o.status === "CANCELLED"; }).length;

                        var fulfillmentPct = total ? Math.round((delivered / total) * 100) : 0;
                        setText("repTotalOrders", total);
                        setText("repDelivered", delivered);
                        setText("repTransit", transit);
                        setText("repPending", placed);
                        setRing("ringFulfillment", "fulfillmentPct", fulfillmentPct);

                        var failed = rejected + cancelled;
                        var successRate = total ? Math.round(((total - failed) / total) * 100) : 0;
                        setText("repAccepted", accepted);
                        setText("repRejected", rejected);
                        setText("repCancelled", cancelled);
                        setText("repSuccessRate", successRate + "%");
                        setRing("ringSuccess", "successPct", successRate);

                        var totalRevenue = orders.reduce(function (sum, o) { return sum + Number(o.totalAmount || 0); }, 0);
                        var avgOrder = total ? totalRevenue / total : 0;
                        var highestOrder = orders.reduce(function (max, o) { return Math.max(max, Number(o.totalAmount || 0)); }, 0);
                        var uniqueRetailers = new Set(orders.map(function (o) { return o.retailerUserId; })).size;
                        var revenueTargetPct = Math.min(100, Math.round((totalRevenue / 100000) * 100)); // vs an indicative Rs.1,00,000 milestone

                        setText("repTotalRevenue", money(totalRevenue));
                        setText("repAvgOrder", money(avgOrder));
                        setText("repHighestOrder", money(highestOrder));
                        setText("repUniqueRetailers", uniqueRetailers);
                        setRing("ringRevenue", "revenuePct", revenueTargetPct);
                    }

                    function statusBadge(status) {
                        var meta = STATUS_META[status] || { label: status || "Unknown", cls: "status-default" };
                        return "<span class=\"order-status-badge " + meta.cls + "\">" + meta.label + "</span>";
                    }

                    function orderCard(order, index) {
                        var date = order.createdAt ? new Date(order.createdAt).toLocaleDateString("en-IN", { day: "2-digit", month: "short", year: "numeric" }) : "-";
                        var retailerName = escapeHtml(order.retailerName || ("Retailer #" + order.retailerUserId));
                        var retailerLocation = escapeHtml(order.retailerLocation || "Location not available");
                        var orderId = "ORD-" + String(order.id).padStart(5, "0");

                        return "" +
                            "<div class=\"order-card\">" +
                                "<div class=\"order-card-left\">" +
                                    "<div class=\"order-card-id\">#" + orderId + "</div>" +
                                    "<div class=\"order-card-retailer\">" +
                                        "<strong>" + retailerName + "</strong>" +
                                        "<span>" + retailerLocation + "</span>" +
                                    "</div>" +
                                "</div>" +
                                "<div class=\"order-card-mid\">" +
                                    "<div class=\"order-card-meta\"><i class=\"bi bi-calendar3\"></i> " + date + "</div>" +
                                "</div>" +
                                "<div class=\"order-card-right\">" +
                                    "<div class=\"order-card-amount\">" + money(order.totalAmount) + "</div>" +
                                    statusBadge(order.status) +
                                "</div>" +
                                "<div class=\"order-card-actions\">" +
                                    "<a class=\"wm-btn wm-btn-secondary\" href=\"/web/distributor/orders/view?id=" + encodeURIComponent(order.id) + "\">View</a>" +
                                "</div>" +
                            "</div>";
                    }

                    function sortOrders(list) {
                        var mode = sortOrder.value;
                        var sorted = list.slice();
                        sorted.sort(function (a, b) {
                            if (mode === "amount_high") return (b.totalAmount || 0) - (a.totalAmount || 0);
                            if (mode === "amount_low") return (a.totalAmount || 0) - (b.totalAmount || 0);
                            var aTime = a.createdAt ? new Date(a.createdAt).getTime() : 0;
                            var bTime = b.createdAt ? new Date(b.createdAt).getTime() : 0;
                            return mode === "oldest" ? aTime - bTime : bTime - aTime;
                        });
                        return sorted;
                    }

                    function render() {
                        var query = (orderSearch.value || "").toLowerCase();
                        var status = statusFilter.value;

                        var filtered = orders.filter(function (order) {
                            var text = [order.id, order.retailerName, order.retailerLocation, order.status, order.paymentMode]
                                .join(" ").toLowerCase();
                            return (!query || text.indexOf(query) !== -1) && (!status || order.status === status);
                        });

                        filtered = sortOrders(filtered);
                        setText("resultCount", filtered.length + (filtered.length === 1 ? " order" : " orders"));

                        if (!filtered.length) {
                            ordersList.innerHTML = "";
                            ordersState.style.display = "block";
                            ordersState.className = "order-state-message";
                            ordersState.innerHTML = orders.length
                                ? "<i class=\"bi bi-search\"></i> No orders match your search or filter."
                                : "<i class=\"bi bi-inbox\"></i> No orders found in the database.";
                            return;
                        }

                        ordersState.style.display = "none";
                        ordersList.innerHTML = filtered.map(orderCard).join("");
                    }

                    function showError(message) {
                        ordersList.innerHTML = "";
                        ordersState.style.display = "block";
                        ordersState.className = "order-state-message order-state-error";
                        ordersState.innerHTML = "<i class=\"bi bi-exclamation-triangle\"></i> " + escapeHtml(message);
                        setText("resultCount", "0 orders");
                    }

                    function load() {
                        ordersState.style.display = "block";
                        ordersState.className = "order-state-message";
                        ordersState.innerHTML = "<i class=\"bi bi-arrow-repeat spin\"></i> Loading orders...";
                        ordersList.innerHTML = "";

                        fetch("/api/v1/orders")
                            .then(function (response) {
                                return response.json().then(function (body) {
                                    return { ok: response.ok, status: response.status, body: body };
                                });
                            })
                            .then(function (result) {
                                if (!result.ok) {
                                    showError("Unable to load orders. Status: " + result.status);
                                    return;
                                }
                                orders = normalizeOrders(result.body);
                                renderHero();
                                renderAnalytics();
                                render();
                            })
                            .catch(function () {
                                showError("Unable to load orders from the database.");
                            });
                    }

                    document.querySelectorAll("[data-status-shortcut]").forEach(function (link) {
                        link.addEventListener("click", function (e) {
                            e.preventDefault();
                            statusFilter.value = link.getAttribute("data-status-shortcut");
                            render();
                            document.getElementById("ordersListSection").scrollIntoView({ behavior: "smooth" });
                        });
                    });

                    orderSearch.addEventListener("input", render);
                    statusFilter.addEventListener("change", render);
                    sortOrder.addEventListener("change", render);
                    refreshBtn.addEventListener("click", load);

                    load();
                });
            </script>
</body>

</html>
