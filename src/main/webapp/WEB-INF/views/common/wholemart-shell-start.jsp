<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/css/common.css" rel="stylesheet">
<link href="/css/wholemart.css?v=project-theme-refresh-52" rel="stylesheet">
<%-- Shared shell start: opens body, app wrapper, sidebar, main, and panel. Closed by wholemart-shell-end.jsp. --%>
<%
    String wmUri = request.getRequestURI();
    String wmRole = session.getAttribute("role") == null ? "ROLE_DISTRIBUTOR" : String.valueOf(session.getAttribute("role"));
    String wmRoleLabel = wmRole.replace("ROLE_", "");
    String wmUserName = session.getAttribute("username") == null ? "Guest" : String.valueOf(session.getAttribute("username"));
    String wmUserInitial = wmUserName.isEmpty() ? "?" : wmUserName.substring(0, 1).toUpperCase();
    String wmBodyClass = request.getAttribute("wmBodyClass") == null ? "" : String.valueOf(request.getAttribute("wmBodyClass"));
    if (wmUri.contains("/dashboard")) {
        wmBodyClass = (wmBodyClass + " wm-dashboard-page").trim();
    }
%>
</head>
<body class="<%= wmBodyClass %>" data-role="<%= wmRoleLabel %>" >
<div class="wm-app">
    <header class="wm-topbar" role="banner">
        <div class="wm-topbar-left">
            <button class="wm-menu" type="button" aria-label="Toggle menu" aria-expanded="true">
                <span class="wm-menu-line"></span>
                <span class="wm-menu-line"></span>
                <span class="wm-menu-line"></span>
            </button>
            <a class="wm-brand-link" href="/" aria-label="WholeMart home">
                <span class="wm-logo">W</span>
                <span class="wm-brand-name">WholeMart</span>
            </a>
        </div>
        <div class="wm-topbar-center">
            <input id="wm-search" class="wm-search" placeholder="Search products, orders, or support..." aria-label="Search">
        </div>
        <div class="wm-topbar-right wm-top-actions">
            <button class="wm-bell" type="button" aria-label="Open notifications">
                <svg viewBox="0 0 24 24" aria-hidden="true" focusable="false">
                    <path d="M18 16v-5a6 6 0 0 0-12 0v5l-2 2h16l-2-2Z"></path>
                    <path d="M10 20a2 2 0 0 0 4 0"></path>
                </svg>
                <span></span>
            </button>
            <div class="wm-user-menu" data-profile-menu>
                <button class="wm-user-trigger" type="button" aria-haspopup="true" aria-expanded="false" aria-label="Open profile settings">
                    <span class="wm-user-avatar"><%= wmUserInitial %></span>
                    <span class="wm-welcome">
                        <span>Welcome</span>
                        <strong><%= wmUserName %></strong>
                        <span class="wm-role-label"><%= wmRoleLabel %></span>
                    </span>
                </button>
                <div class="wm-profile-popover" role="menu" hidden>
                    <div class="wm-profile-head">
                        <span class="wm-user-avatar"><%= wmUserInitial %></span>
                        <div>
                            <strong><%= wmUserName %></strong>
                            <span><%= wmRoleLabel %></span>
                        </div>
                    </div>
                    <a href="/web/auth/login" role="menuitem">Switch account</a>
                    <a href="/" role="menuitem">Back to home</a>
                </div>
            </div>
        </div>
    </header>
    <aside class="wm-sidebar">
        <nav class="wm-nav">
            <%
                java.util.List<String[]> navItems = new java.util.ArrayList<>();

                if ("ROLE_ADMIN".equals(wmRole)) {
                    navItems.add(new String[]{"/web/admin/dashboard", "Dashboard", "/admin/dashboard"});
                    navItems.add(new String[]{"/web/admin/users", "Users", "/admin/users"});
                    navItems.add(new String[]{"/web/admin/orders", "Orders<span class=\"wm-dot\"></span>", "/admin/orders"});
                    navItems.add(new String[]{"/web/admin/payments", "Payments", "/admin/payments"});
                    navItems.add(new String[]{"/web/admin/reports", "Reports<span class=\"wm-dot\"></span>", "/admin/reports"});
                    navItems.add(new String[]{"/web/admin/distributor-approvals", "Distributors", "/admin/distributor-approvals"});
                    navItems.add(new String[]{"/web/admin/driver-approvals", "Drivers", "/admin/driver-approvals"});
                    navItems.add(new String[]{"/web/admin/ai-chat", "AI", "/admin/ai-chat"});
                } else if ("ROLE_RETAILER".equals(wmRole)) {
                    navItems.add(new String[]{"/web/retailer/dashboard", "Dashboard", "/retailer/dashboard"});
                    navItems.add(new String[]{"/web/retailer/distributors", "Distributors", "/retailer/distributors"});
                    navItems.add(new String[]{"/web/retailer/products", "Products<span class=\"wm-dot\"></span>", "/retailer/products"});
                    navItems.add(new String[]{"/web/retailer/cart", "Cart", "/retailer/cart"});
                    navItems.add(new String[]{"/web/retailer/orders", "Orders<span class=\"wm-dot\"></span>", "/retailer/orders"});
                    navItems.add(new String[]{"/web/retailer/payments", "Payments", "/retailer/payments"});
                    navItems.add(new String[]{"/web/retailer/ledger", "Ledger", "/retailer/ledger"});
                    navItems.add(new String[]{"/web/retailer/reports", "Reports", "/retailer/reports"});
                    navItems.add(new String[]{"/web/retailer/alerts", "Alerts<span class=\"wm-dot\"></span>", "/retailer/alerts"});
                    navItems.add(new String[]{"/web/retailer/ai-chat", "AI", "/retailer/ai-chat"});
                } else if ("ROLE_DRIVER".equals(wmRole)) {
                    navItems.add(new String[]{"/web/driver/dashboard", "Dashboard", "/driver/dashboard"});
                    navItems.add(new String[]{"/web/driver/orders", "Orders", "/driver/orders"});
                    navItems.add(new String[]{"/web/driver/deliveries", "Deliveries<span class=\"wm-dot\"></span>", "/driver/deliveries"});
                    navItems.add(new String[]{"/web/driver/earnings", "Earnings", "/driver/earnings"});
                    navItems.add(new String[]{"/web/driver/reports", "Reports", "/driver/reports"});
                    navItems.add(new String[]{"/web/driver/alerts", "Alerts<span class=\"wm-dot\"></span>", "/driver/alerts"});
                    navItems.add(new String[]{"/web/driver/ai-chat", "AI", "/driver/ai-chat"});
                } else {
                    navItems.add(new String[]{"/web/distributor/dashboard", "Dashboard", "/distributor/dashboard"});
                    navItems.add(new String[]{"/web/distributor/orders", "Orders<span class=\"wm-dot\"></span>", "/distributor/orders"});
                    navItems.add(new String[]{"/web/distributor/products", "Inventory<span class=\"wm-dot\"></span>", "/distributor/products"});
                    navItems.add(new String[]{"/web/distributor/add-product", "Add Product", "/distributor/add-product"});
                    navItems.add(new String[]{"/web/distributor/delivery", "Delivery", "/distributor/delivery"});
                    navItems.add(new String[]{"/web/distributor/drivers", "Drivers", "/distributor/drivers"});
                    navItems.add(new String[]{"/web/distributor/reports", "Reports<span class=\"wm-dot\"></span>", "/distributor/reports"});
                    navItems.add(new String[]{"/web/distributor/dues", "Payments", "/distributor/dues"});
                    navItems.add(new String[]{"/web/distributor/alerts", "Alerts<span class=\"wm-dot\"></span>", "/distributor/alerts"});
                    navItems.add(new String[]{"/web/distributor/ai-chat", "AI", "/distributor/ai-chat"});
                }

                for (String[] item : navItems) {
                    String active = wmUri.contains(item[2]) ? "active" : "";
            %>
                    <a class="<%= active %>" href="<%= item[0] %>"><%= item[1] %></a>
            <%
                }
            %>
        </nav>
        <div class="wm-user">
            <div class="wm-user-avatar"><%= wmUserInitial %></div>
            <div><strong><%= wmUserName %></strong><span><%= wmRoleLabel %></span></div>
        </div>
    </aside>
    <main class="wm-main">
        <section class="wm-panel">
            <%-- Page-specific JSP content is inserted here after this include. --%>
