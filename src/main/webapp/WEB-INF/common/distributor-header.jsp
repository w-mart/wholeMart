<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
        String wmUserNameHeader = (String) request.getAttribute("wmUserName");
        if (wmUserNameHeader == null) {
            wmUserNameHeader = (String) session.getAttribute("username");
        }
        if (wmUserNameHeader == null) {
            wmUserNameHeader = (String) session.getAttribute("name");
        }
        if (wmUserNameHeader == null) {
            wmUserNameHeader = "Distributor User";
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
            initials = "DU";
        }

        String wmUri = request.getRequestURI();
        if (wmUri == null) {
            wmUri = "";
        }

String wmLang = (String) session.getAttribute("lang");
        if (wmLang == null) {
            wmLang = "en";
        }
        String wmEngActive = (wmLang.equals("eng") || wmLang.equals("en")) ? "fw-bold text-success" : "text-muted";
        String wmHinActive = (wmLang.equals("hin") || wmLang.equals("hi")) ? "fw-bold text-success" : "text-muted";
%>

<script>
  function setWmLanguage(lang) {
    window.location.href = "<%= request.getContextPath() %>/web/lang/" + encodeURIComponent(lang);
  }
  window.setWmLanguage = setWmLanguage;
</script>

<header class="wm-header sticky-top">
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid px-3 wm-header-row">

            <!-- Left: sidebar toggle + logo -->
            <div class="d-flex align-items-center wm-header-left">
                <button id="wmSidebarToggle" class="wm-sidebar-toggle-btn me-2" type="button"
                    aria-label="Toggle sidebar">
                    <i class="bi bi-list fs-4"></i>
                </button>

                <a class="navbar-brand wm-logo-wrap"
                    href="${pageContext.request.contextPath}/web/distributor/dashboard">
                    <div class="wm-logo-mark">W</div>
                    <div class="wm-logo-line">
                        <div class="wm-logo-title">WholeMart</div>
                        <small class="wm-logo-sub"><fmt:message key="nav.distributor_workspace"/></small>
                    </div>
                </a>
            </div>

            <!-- Search (desktop only) -->
            <form class="wm-search d-none d-lg-flex">
                <i class="bi bi-search wm-search-icon"></i>
                <input class="wm-search-input" type="text"
                    placeholder="<fmt:message key="nav.search_placeholder"/>">
            </form>

            <div class="collapse navbar-collapse wm-header-collapse" id="wmDistributorNav">
                <form class="wm-search d-lg-none">
                    <i class="bi bi-search wm-search-icon"></i>
                    <input class="wm-search-input" type="text"
                        placeholder="<fmt:message key="nav.search_placeholder"/>">
                </form>

                <ul class="navbar-nav wm-nav-links d-none d-lg-flex">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/"><fmt:message key="nav.home"/></a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/web/distributor/products"><fmt:message key="nav.products"/></a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/web/distributor/ai-chat"><fmt:message key="nav.ai_chat"/></a></li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/web/auth/logout"><fmt:message key="nav.logout"/></a>
                    </li>
                </ul>
            </div>

            <!-- Right: lang toggle + user dropdown -->
            <div class="d-flex align-items-center wm-header-right gap-2">
                <div class="wm-lang-toggle d-flex align-items-center gap-1 bg-white border rounded-pill px-2 py-1 shadow-sm fs-7 me-1">
<button type="button" onclick="setWmLanguage('eng')" class="btn btn-sm p-0 border-0 <%= wmEngActive %> px-1">EN</button>
                    <span class="wm-lang-sep text-black-50">|</span>
                    <button type="button" onclick="setWmLanguage('hin')" class="btn btn-sm p-0 border-0 <%= wmHinActive %> px-1">HI</button>
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
                                <fmt:message key="nav.profile"/>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/settings">
                                <i class="bi bi-gear me-2"></i><fmt:message key="nav.settings"/>
                            </a>
                        </li>
                        <li>
                            <hr class="dropdown-divider wm-user-menu-divider">
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item wm-user-menu-logout"
                                href="${pageContext.request.contextPath}/web/auth/logout">
                                <i class="bi bi-box-arrow-right me-2"></i><fmt:message key="nav.logout"/>
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
                href="${pageContext.request.contextPath}/web/distributor/dashboard">
                <i class="bi bi-speedometer2"></i><fmt:message key="nav.dashboard"/>
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/orders") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/orders">
                <i class="bi bi-cart-check"></i><fmt:message key="nav.orders"/>
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/products") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/products">
                <i class="bi bi-box-seam"></i><fmt:message key="nav.products"/>
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/add-product") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/add-product">
                <i class="bi bi-plus-circle"></i><fmt:message key="nav.add_product"/>
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/drivers") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/drivers">
                <i class="bi bi-truck"></i><fmt:message key="nav.drivers"/>
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/delivery") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/delivery">
                <i class="bi bi-geo-alt"></i><fmt:message key="nav.deliveries"/>
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/reports") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/reports">
                <i class="bi bi-bar-chart"></i><fmt:message key="nav.reports"/>
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/alerts") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/alerts">
                <i class="bi bi-bell"></i><fmt:message key="nav.alerts"/>
            </a>
        </li>
        <li>
            <a class="<%= wmUri.contains("/ai-chat") ? "active" : "" %>"
                href="${pageContext.request.contextPath}/web/distributor/ai-chat">
                <i class="bi bi-robot"></i><fmt:message key="nav.ai_chat"/>
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
            if (sidebar) sidebar.classList.add("show");
            if (backdrop) backdrop.classList.add("show");
        }

        function closeSidebar() {
            if (sidebar) sidebar.classList.remove("show");
            if (backdrop) backdrop.classList.remove("show");
        }

        if (toggle) {
            toggle.addEventListener("click", function () {
                sidebar && sidebar.classList.contains("show") ? closeSidebar() : openSidebar();
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
