<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
        String wmUserNameHeader = (String) session.getAttribute("username");
        if (wmUserNameHeader == null) {
            wmUserNameHeader = "Retailer User";
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
            initials = "RU";
        }

        String wmUri = request.getRequestURI();
        if (wmUri == null) {
            wmUri = "";
        }

        String wmLang = (String) session.getAttribute("lang");
        if (wmLang == null) { wmLang = "en"; }
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
    <nav class="navbar navbar-light py-2">
        <div class="container-fluid px-3 wm-header-row">
            <div class="d-flex align-items-center wm-header-left">
                <button id="wmSidebarToggle" class="wm-sidebar-toggle-btn me-2" type="button" aria-label="Toggle navigation drawer">
                    <i class="bi bi-list fs-4"></i>
                </button>

                <a class="navbar-brand wm-logo-wrap" href="${pageContext.request.contextPath}/web/retailer/dashboard">
                    <div class="wm-logo-mark">W</div>
                    <div class="wm-logo-line">
                        <div class="wm-logo-title d-flex align-items-center gap-2">WholeMart <span class="badge bg-primary-subtle text-primary-emphasis border border-primary-subtle rounded-pill d-none d-sm-inline-flex" style="font-size: .6rem; letter-spacing: .05em;">RETAILER</span></div>
                        <small class="wm-logo-sub"><fmt:message key="nav.retailer_workspace"/></small>
                    </div>
                </a>
            </div>

            <div class="wm-header-center d-none d-md-flex flex-grow-1 justify-content-center px-3">
                <form class="wm-search" role="search" onsubmit="event.preventDefault();">
                    <i class="bi bi-search wm-search-icon"></i>
                    <input class="wm-search-input" type="text" placeholder="<fmt:message key="nav.search_placeholder"/>" aria-label="Search products and distributors">
                </form>
            </div>

            <div class="d-flex align-items-center wm-header-right gap-2">
                <a href="${pageContext.request.contextPath}/web/retailer/alerts" class="wm-driver-bell-btn d-none d-sm-inline-flex" title="Notifications & Alerts" aria-label="View Alerts">
                    <i class="bi bi-bell"></i>
                    <span class="wm-bell-dot"></span>
                </a>
                <div class="wm-lang-toggle d-flex align-items-center gap-1 bg-white border rounded-pill px-2 py-1 shadow-sm fs-7 me-1">
                    <button type="button" onclick="setWmLanguage('eng')" class="btn btn-sm p-0 border-0 <%= wmEngActive %> px-1">EN</button>
                    <span class="wm-lang-sep text-black-50">|</span>
                    <button type="button" onclick="setWmLanguage('hin')" class="btn btn-sm p-0 border-0 <%= wmHinActive %> px-1">HI</button>
                </div>
                <div class="dropdown">
                    <button class="btn wm-user-btn dropdown-toggle d-flex align-items-center gap-2" data-bs-toggle="dropdown" aria-expanded="false" aria-label="Retailer profile menu">
                        <div class="wm-driver-avatar-wrap">
                            <span class="wm-user-avatar"><%= initials %></span>
                            <span class="wm-avatar-online-pip" title="Online"></span>
                        </div>
                        <div class="d-none d-lg-flex flex-column text-start lh-1">
                            <span class="fw-bold"><%= wmUserNameHeader %></span>
                            <span class="text-muted small">Retailer</span>
                        </div>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end wm-user-menu">
                        <li class="wm-driver-menu-hero">
                            <div class="d-flex align-items-center gap-3">
                                <div class="wm-driver-menu-avatar"><%= initials %></div>
                                <div class="flex-grow-1 min-w-0">
                                    <div class="fw-bold text-dark text-truncate fs-6"><%= wmUserNameHeader %></div>
                                    <div class="d-flex align-items-center gap-2 mt-1">
                                        <span class="badge bg-primary-subtle text-primary-emphasis border border-primary-subtle rounded-pill font-monospace fs-8">Retailer Account</span>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item wm-user-menu-item" href="${pageContext.request.contextPath}/web/retailer/dashboard"><i class="bi bi-speedometer2"></i><fmt:message key="nav.dashboard"/></a></li>
                        <li><a class="dropdown-item wm-user-menu-item" href="${pageContext.request.contextPath}/web/retailer/profile"><i class="bi bi-person-badge"></i><fmt:message key="nav.profile"/></a></li>
                        <li><a class="dropdown-item wm-user-menu-item" href="${pageContext.request.contextPath}/web/retailer/settings"><i class="bi bi-gear"></i><fmt:message key="nav.settings"/></a></li>
                        <li><a class="dropdown-item wm-user-menu-item" href="${pageContext.request.contextPath}/web/retailer/ai-chat"><i class="bi bi-robot"></i><fmt:message key="nav.ai_chat"/></a></li>
                        <li><hr class="dropdown-divider wm-user-menu-divider"></li>
                        <li><a class="dropdown-item wm-user-menu-item wm-user-menu-logout" href="${pageContext.request.contextPath}/web/auth/logout"><i class="bi bi-box-arrow-right me-2"></i><fmt:message key="nav.logout"/></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</header>

<aside id="wmSidebar" class="wm-sidebar wm-driver-sidebar" aria-label="Retailer Navigation Sidebar">
    <div class="wm-driver-sidebar-header">
        <div class="d-flex align-items-center justify-content-between mb-2">
            <div class="d-flex align-items-center gap-3 min-w-0">
                <div class="wm-driver-sidebar-avatar"><%= initials %></div>
                <div class="flex-grow-1 min-w-0">
                    <div class="fw-bold text-dark text-truncate"><%= wmUserNameHeader %></div>
                    <div class="text-muted fs-8 d-flex align-items-center gap-1">
                        <span class="wm-pulse-dot" style="background-color: var(--bs-primary);"></span> Retailer Account
                    </div>
                </div>
            </div>
            <button id="wmSidebarClose" class="wm-sidebar-close-btn" type="button" aria-label="Close sidebar" title="Close navigation">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
    </div>

    <div class="wm-driver-sidebar-scroll">
        <div class="wm-driver-sidebar-section">
            <div class="wm-driver-sidebar-kicker">WORKSPACE</div>
            <ul class="list-unstyled m-0">
                <li><a class="<%= wmUri.contains("/dashboard") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/dashboard"><i class="bi bi-speedometer2"></i><span><fmt:message key="nav.dashboard"/></span></a></li>
                <li><a class="<%= wmUri.contains("/distributors") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/distributors"><i class="bi bi-shop"></i><span><fmt:message key="nav.distributors"/></span></a></li>
                <li><a class="<%= wmUri.contains("/products") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/products"><i class="bi bi-box-seam"></i><span><fmt:message key="nav.products"/></span></a></li>
                <li><a class="<%= wmUri.contains("/cart") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/cart"><i class="bi bi-cart"></i><span><fmt:message key="nav.cart"/></span></a></li>
                <li><a class="<%= wmUri.contains("/orders") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/orders"><i class="bi bi-bag"></i><span><fmt:message key="nav.orders"/></span></a></li>
            </ul>
        </div>

        <div class="wm-driver-sidebar-section">
            <div class="wm-driver-sidebar-kicker">FINANCE</div>
            <ul class="list-unstyled m-0">
                <li><a class="<%= wmUri.contains("/ledger") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/ledger"><i class="bi bi-book"></i><span><fmt:message key="nav.ledger"/></span></a></li>
                <li><a class="<%= wmUri.contains("/payments") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/payments"><i class="bi bi-cash-coin"></i><span><fmt:message key="nav.payments"/></span></a></li>
            </ul>
        </div>

        <div class="wm-driver-sidebar-section">
            <div class="wm-driver-sidebar-kicker">TOOLS & SUPPORT</div>
            <ul class="list-unstyled m-0">
                <li><a class="<%= wmUri.contains("/reports") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/reports"><i class="bi bi-bar-chart"></i><span><fmt:message key="nav.reports"/></span></a></li>
                <li><a class="<%= wmUri.contains("/alerts") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/alerts"><i class="bi bi-bell"></i><span><fmt:message key="nav.alerts"/></span></a></li>
                <li><a class="<%= wmUri.contains("/ai-chat") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/retailer/ai-chat"><i class="bi bi-robot text-success"></i><span><fmt:message key="nav.ai_chat"/></span><span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill ms-auto px-2 py-0 fs-8">AI</span></a></li>
            </ul>
        </div>
    </div>

    <div class="wm-driver-sidebar-footer">
        <div class="d-flex align-items-center justify-content-between pt-2 border-top border-light-subtle">
            <small class="text-muted fs-8">WholeMart Retailer v2.4</small>
            <a href="${pageContext.request.contextPath}/web/auth/logout" class="text-danger fw-bold fs-8 text-decoration-none d-flex align-items-center gap-1">
                <i class="bi bi-box-arrow-right"></i> <fmt:message key="nav.logout"/>
            </a>
        </div>
    </div>
</aside>
<div id="wmSidebarBackdrop" class="wm-sidebar-backdrop"></div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const sidebar = document.getElementById("wmSidebar");
        const toggle = document.getElementById("wmSidebarToggle");
        const closeBtn = document.getElementById("wmSidebarClose");
        const backdrop = document.getElementById("wmSidebarBackdrop");

        function openSidebar() {
            if (sidebar) sidebar.classList.add("show");
            if (backdrop) backdrop.classList.add("show");
            document.body.classList.add("wm-sidebar-open");
        }

        function closeSidebar() {
            if (sidebar) sidebar.classList.remove("show");
            if (backdrop) backdrop.classList.remove("show");
            document.body.classList.remove("wm-sidebar-open");
        }

        if (toggle) {
            toggle.addEventListener("click", function (e) {
                e.preventDefault();
                e.stopPropagation();
                if (sidebar && sidebar.classList.contains("show")) {
                    closeSidebar();
                } else {
                    openSidebar();
                }
            });
        }

        if (closeBtn) {
            closeBtn.addEventListener("click", function (e) {
                e.preventDefault();
                e.stopPropagation();
                closeSidebar();
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
