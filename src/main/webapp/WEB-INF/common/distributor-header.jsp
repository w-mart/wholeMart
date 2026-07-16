<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
        // distributor-header.jsp is included by multiple JSPs.
        // Avoid "Duplicate local variable" compilation errors when this JSP is
        // inlined into other JSPs. Use a unique variable name.
        String wmUserNameHeader = (String) request.getAttribute("wmUserName");
        if (wmUserNameHeader == null) {
            wmUserNameHeader = (String) session.getAttribute("username");
        }
        if (wmUserNameHeader == null) {
            wmUserNameHeader = (String) session.getAttribute("name");
        }
        if (wmUserNameHeader == null) {
            wmUserNameHeader = "Guest";
        }

        String initials = "";
        if (wmUserNameHeader != null && !wmUserNameHeader.trim().isEmpty()) {
            String[] names = wmUserNameHeader.trim().split("\\s+");
            for (String n : names) {
                if (n != null && !n.isEmpty()) {
                    initials += n.substring(0, 1).toUpperCase();
                }
            }
            if (initials.length() > 2) {
                initials = initials.substring(0, 2);
            }
        }
        if (initials.isEmpty()) {
            initials = "WM";
        }

        String wmUri = request.getRequestURI();
        if (wmUri == null) {
            wmUri = "";
        }

        String wmLang = (String) session.getAttribute("lang");
        if (wmLang == null) {
            wmLang = "en";
        }
%>

<!--
    Requires header.css to already be linked in <head>.
    Layout: on desktop the order is [sidebar toggle + logo] [search] [nav links] [lang + user dropdown],
    with the custom sidebar toggle on the far left.
    On mobile the order is [logo] [lang + user dropdown + hamburger] on row 1,
    with the collapsible nav links + search wrapping to a full-width row 2 when opened.
    Mirrors retailer-header.jsp.
-->

<header class="wm-header sticky-top">
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid px-3 wm-header-row">

            <!-- Left: sidebar toggle + logo -->
            <div class="d-flex align-items-center wm-header-left">
                <button id="wmSidebarToggle" class="wm-sidebar-toggle-btn me-3" type="button"
                    aria-label="Toggle sidebar">
                    <i class="bi bi-list fs-4"></i>
                </button>

                <a class="navbar-brand wm-logo-wrap"
                    href="${pageContext.request.contextPath}/web/distributor/dashboard">
                    <div class="wm-logo-mark">W</div>
                    <div class="wm-logo-line">
                        <div class="wm-logo-title">WholeMart</div>
                        <small class="wm-logo-sub">Local B2B Marketplace</small>
                    </div>
                </a>
            </div>

            <!-- Search (desktop only) -->
            <form class="wm-search d-none d-lg-flex">
                <i class="bi bi-search wm-search-icon"></i>
                <input class="wm-search-input" type="text"
                    placeholder="Search products, retailers, orders...">
            </form>

            <!-- Nav links + mobile search: inline on desktop, wraps to full-width row on mobile when opened -->
            <div class="collapse navbar-collapse wm-header-collapse" id="wmDistributorNav">
                <form class="wm-search d-lg-none">
                    <i class="bi bi-search wm-search-icon"></i>
                    <input class="wm-search-input" type="text"
                        placeholder="Search products, retailers, orders...">
                </form>

                <ul class="navbar-nav wm-nav-links">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/web/distributor/pruducts">Inventory</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/web/distributor/ask-ai">Ask AI</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/uuserRegister">Help</a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/web/auth/logout">Logout</a>
                    </li>
                </ul>
            </div>

            <!-- Right: lang toggle + user dropdown + mobile hamburger, grouped so they stay on one line -->
            <div class="d-flex align-items-center wm-header-right">
                <div class="wm-lang-toggle">
                    <a href="?lang=en" class="wm-lang-option <%= "en".equals(wmLang) ? "active" : "" %>">EN</a>
                    <span class="wm-lang-sep">|</span>
                    <a href="?lang=hi" class="wm-lang-option <%= "hi".equals(wmLang) ? "active" : "" %>">HI</a>
                </div>

                <div class="dropdown">
                    <button class="btn wm-user-btn dropdown-toggle d-flex align-items-center gap-2"
                        data-bs-toggle="dropdown">
                        <span class="wm-user-avatar">
                            <%= initials %>
                        </span>
                        <span class="fw-semibold d-none d-lg-inline">
                            <%= wmUserNameHeader %>
                        </span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end wm-user-menu">
                        <li>
                            <h6 class="dropdown-header wm-user-menu-header">
                                <%= wmUserNameHeader %>
                            </h6>
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/profile">
                                Profile
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/settings">
                                <i class="bi bi-gear me-2"></i>Settings
                            </a>
                        </li>
                        <li>
                            <hr class="dropdown-divider wm-user-menu-divider">
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item wm-user-menu-logout"
                                href="${pageContext.request.contextPath}/web/auth/logout">
                                <i class="bi bi-box-arrow-right me-2"></i>Logout
                            </a>
                        </li>
                    </ul>
                </div>

                <button class="navbar-toggler" type="button"
                        data-bs-toggle="collapse" data-bs-target="#wmDistributorNav"
                        aria-controls="wmDistributorNav" aria-expanded="false">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>

        </div>
    </nav>
</header>

<!-- Sidebar -->
<aside id="wmSidebar" class="wm-sidebar">
    <ul class="list-unstyled m-0">
        <li>
            <a class="<%= wmUri.contains("/dashboard") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/dashboard">
                <i class="bi bi-speedometer2"></i>Dashboard
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/orders") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/orders">
                <i class="bi bi-cart-check"></i>Orders
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/products") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/products">
                <i class="bi bi-box-seam"></i>Products
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/add-product") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/add-product">
                <i class="bi bi-plus-circle"></i>Add Product
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/drivers") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/drivers">
                <i class="bi bi-truck"></i>Drivers
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/delivery") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/delivery">
                <i class="bi bi-geo-alt"></i>Delivery
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/reports") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/reports">
                <i class="bi bi-bar-chart"></i>Reports
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/alerts") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/alerts">
                <i class="bi bi-bell"></i>Alerts
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/ai-chat") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/ai-chat">
                <i class="bi bi-robot"></i>AI Assistant
            </a>
        </li>
    </ul>
</aside>

<!-- Sidebar Backdrop -->
<div id="wmSidebarBackdrop" class="wm-sidebar-backdrop"></div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const sidebar = document.getElementById("wmSidebar");
        const toggle = document.getElementById("wmSidebarToggle");
        const backdrop = document.getElementById("wmSidebarBackdrop");

        function openSidebar() {
            sidebar.classList.add("show");
            backdrop.classList.add("show");
        }

        function closeSidebar() {
            sidebar.classList.remove("show");
            backdrop.classList.remove("show");
        }

        if (toggle) {
            toggle.addEventListener("click", function () {
                sidebar.classList.contains("show") ? closeSidebar() : openSidebar();
            });
        }

        if (backdrop) {
            backdrop.addEventListener("click", closeSidebar);
        }

        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") {
                closeSidebar();
            }
        });
    });
</script>