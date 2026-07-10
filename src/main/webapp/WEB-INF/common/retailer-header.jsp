<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String retailerName = session.getAttribute("name") == null ? "Retailer" : String.valueOf(session.getAttribute("name"));
    String retailerInitial = retailerName.substring(0, 1).toUpperCase();
    String wmUri = request.getRequestURI() == null ? "" : request.getRequestURI();
%>

<header class="wm-header sticky-top">
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid px-3">

            <!-- Left -->
            <div class="d-flex align-items-center">
                <button id="wmSidebarToggle" class="btn btn-light me-3" type="button" aria-label="Toggle sidebar">
                    <i class="bi bi-list fs-4"></i>
                </button>
            <!-- Logo -->
            <a class="wm-logo-wrap" href="/web/retailer/dashboard">
                <div class="wm-logo-circle">WM</div>
                <div class="wm-logo-line">
                    <span class="wm-logo-title">WHOLEMART</span>
                    <small>Retailer Workspace</small>
                </div>
            </a>

                <a class="navbar-brand wm-logo-wrap" href="${pageContext.request.contextPath}/web/retailer/dashboard">
                    <div class="wm-logo-circle">W</div>
                    <div class="wm-logo-line">
                        <div class="wm-logo-title">WholeMart</div>
                        <small class="text-muted">Retailer Workspace</small>
                    </div>
                </a>
            </div>

            <!-- Mobile Nav Toggle -->
            <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#wmRetailerNav"
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#wmRetailerNav"
                aria-controls="wmRetailerNav" aria-expanded="false" aria-label="Toggle navigation">
                <i class="bi bi-three-dots-vertical"></i>
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Nav Links (Collapsible for user menu on mobile) -->
            <!-- Nav Links (Collapsible) -->
            <div class="collapse navbar-collapse" id="wmRetailerNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="margin-left: 20px;">
                    <li class="nav-item">
                        <a class="nav-link" href="/web/retailer/dashboard"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/web/retailer/orders"><i class="bi bi-bag me-2"></i>Orders</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/web/retailer/distributors"><i class="bi bi-shop me-2"></i>Distributors</a>
                    </li>
                     <li class="nav-item">
                        <a class="nav-link" href="/web/retailer/cart"><i class="bi bi-cart me-2"></i>Cart</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/web/retailer/dues"><i class="bi bi-cash-coin me-2"></i>Dues</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/web/retailer/reports"><i class="bi bi-bar-chart me-2"></i>Reports</a>
                    </li>
                </ul>

                <!-- User Menu (Right Aligned) -->
                <div class="ms-auto d-flex align-items-center">
                <div class="d-flex align-items-center">
                    <div class="dropdown">
                        <button class="btn wm-user-btn d-flex align-items-center gap-2 dropdown-toggle" type="button"
                            id="retailerUserMenu" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="wm-user-avatar"><%= retailerInitial %></div>
                            <span class="d-none d-lg-inline fw-semibold"><%= retailerName %></span>
                            <span class="d-none d-lg-inline"><%= retailerName %></span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end wm-user-menu" aria-labelledby="retailerUserMenu">
                            <li>
                                <h6 class="dropdown-header wm-user-menu-header">
                                    Signed in as <strong><%= retailerName %></strong>
                                </h6>
                            </li>
                            <li>
                                <a class="dropdown-item wm-user-menu-item" href="${pageContext.request.contextPath}/web/retailer/profile">
                                    <i class="bi bi-person-circle me-2"></i> Profile
                                <a class="dropdown-item wm-user-menu-item" href="/web/retailer/profile">
                                    <i class="bi bi-person-circle"></i> Profile
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item wm-user-menu-item" href="${pageContext.request.contextPath}/web/retailer/settings">
                                    <i class="bi bi-gear me-2"></i> Settings
                                <a class="dropdown-item wm-user-menu-item" href="/web/retailer/settings">
                                    <i class="bi bi-gear"></i> Settings
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider wm-user-menu-divider">
                            </li>
                            <li>
                                <a class="dropdown-item wm-user-menu-item wm-user-menu-logout" href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                                <a class="dropdown-item wm-user-menu-item wm-user-menu-logout" href="/logout">
                                    <i class="bi bi-box-arrow-right"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </nav>
</header>

<!-- Sidebar -->
<aside id="wmSidebar" class="wm-sidebar">
    <ul class="list-unstyled m-0">
        <li>
            <a class="<%= wmUri.contains("/dashboard") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/dashboard">
                <i class="bi bi-speedometer2"></i>Dashboard
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/orders") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/orders">
                <i class="bi bi-bag"></i>Orders
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/distributors") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/distributors">
                <i class="bi bi-shop"></i>Distributors
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/cart") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/cart">
                <i class="bi bi-cart"></i>Cart
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/dues") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/dues">
                <i class="bi bi-cash-coin"></i>Dues
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/reports") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/reports">
                <i class="bi bi-bar-chart"></i>Reports
            </a>
        </li>
    </ul>
</aside>

<!-- Sidebar Backdrop -->
<div id="wmSidebarBackdrop" class="wm-sidebar-backdrop"></div>

<!-- Bootstrap JS for dropdowns and collapse -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const sidebar = document.getElementById("wmSidebar");
        const toggle = document.getElementById("wmSidebarToggle");
        const backdrop = document.getElementById("wmSidebarBackdrop");

        function openSidebar() {
            if (sidebar) sidebar.classList.add("show");
            if (backdrop) backdrop.classList.add("show");
        }

        function closeSidebar() {
            if (sidebar) sidebar.classList.remove("show");
            if (backdrop) backdrop.classList.remove("show");
        }

        if (toggle) {
            toggle.addEventListener("click", function () {
                if (sidebar && sidebar.classList.contains("show")) {
                    closeSidebar();
                } else {
                    openSidebar();
                }
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