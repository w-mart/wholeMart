<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
        // retailer-header.jsp is included by multiple JSPs.
        // Avoid "Duplicate local variable" compilation errors when this JSP is
        // inlined into other JSPs. Use a unique variable name.
        String wmUserNameHeader = (String) request.getAttribute("wmUserName");
        if (wmUserNameHeader == null) {
            wmUserNameHeader = (String) session.getAttribute("name");
        }
        if (wmUserNameHeader == null) {
            wmUserNameHeader = (String) session.getAttribute("username");
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
        %>

        <!--
    Requires header.css to already be linked in <head>.
    Layout mirrors common/header.jsp.
-->

        <header class="wm-header sticky-top">
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">


                    <!-- Left -->
                    <div class="d-flex align-items-center">
                        <button id="wmSidebarToggle" class="btn btn-light me-3" type="button"
                            aria-label="Toggle sidebar">
                            <i class="bi bi-list fs-4"></i>
                        </button>

                        <a class="navbar-brand wm-logo-wrap"
                            href="${pageContext.request.contextPath}/web/retailer/dashboard">
                            <div class="wm-logo-circle">W</div>
                            <div class="wm-logo-line">
                                <div class="wm-logo-title">WholeMart</div>
                                <small class="text-muted">Local B2B Marketplace</small>
                            </div>
                        </a>
                    </div>

                    <!-- Search -->
                    <form class="mx-auto wm-search d-none d-lg-block">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search"></i>
                            </span>
                            <input class="form-control border-start-0" type="text"
                                placeholder="Search products, distributors, orders...">
                        </div>
                    </form>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#wmRetailerNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>


                    <div id="wmRetailerNav">
                        <ul class="navbar-nav ms-auto align-items-lg-center">
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"></i>Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/web/retailer/orders"></i>My Orders</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/web/retailer/ask-ai"></i>Ask AI</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/uuserRegister"></i>Help</a></li>
                        </ul>
                    </div>



                    <!-- Right -->
                    <div class="d-flex align-items-center ms-auto">
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
                                        href="${pageContext.request.contextPath}/web/retailer/profile">
                                        Profile
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item wm-user-menu-item"
                                        href="${pageContext.request.contextPath}/web/retailer/settings">
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
                    </div>

                </div>
            </nav>
        </header>

        <!-- Sidebar -->
        <aside id="wmSidebar" class="wm-sidebar">
            <ul class="list-unstyled m-0">
                <li>
                    <a class="<%= wmUri.contains("/dashboard") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/retailer/dashboard">
                        <i class="bi bi-speedometer2"></i>Dashboard
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/orders") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/retailer/orders">
                        <i class="bi bi-bag-check"></i>My Orders
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/cart") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/retailer/cart">
                        <i class="bi bi-cart"></i>My Cart
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/distributors") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/retailer/distributors">
                        <i class="bi bi-shop"></i>Distributors
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/dues") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/retailer/dues">
                        <i class="bi bi-cash-coin"></i>My Dues
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/reports") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/retailer/reports">
                        <i class="bi bi-bar-chart"></i>Reports
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/alerts") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/retailer/alerts">
                        <i class="bi bi-bell"></i>Alerts
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/ask-ai") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/retailer/ask-ai">
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
