<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
        String wmUserNameHeader = (String) request.getAttribute("wmUserName");
        if (wmUserNameHeader == null) { wmUserNameHeader = (String) session.getAttribute("username"); }
        if (wmUserNameHeader == null) { wmUserNameHeader = (String) session.getAttribute("name"); }
        if (wmUserNameHeader == null) { wmUserNameHeader = "Admin User"; }

String initials = "AD";
        String wmUri = request.getRequestURI() != null ? request.getRequestURI() : "";

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
            <div class="d-flex align-items-center wm-header-left">
                <button id="wmSidebarToggle" class="wm-sidebar-toggle-btn me-2" type="button" aria-label="Toggle sidebar"><i class="bi bi-list fs-4"></i></button>
                <a class="navbar-brand wm-logo-wrap" href="${pageContext.request.contextPath}/web/admin/dashboard">
                    <div class="wm-logo-mark">W</div>
                    <div class="wm-logo-line">
                        <div class="wm-logo-title">WholeMart</div>
                        <small class="wm-logo-sub"><fmt:message key="nav.admin_workspace"/></small>
                    </div>
                </a>
            </div>
            <div class="d-flex align-items-center wm-header-right gap-2">
                <div class="wm-lang-toggle d-flex align-items-center gap-1 bg-white border rounded-pill px-2 py-1 shadow-sm fs-7 me-1">
<button type="button" onclick="setWmLanguage('eng')" class="btn btn-sm p-0 border-0 <%= wmEngActive %> px-1">EN</button>
                    <span class="wm-lang-sep text-black-50">|</span>
                    <button type="button" onclick="setWmLanguage('hin')" class="btn btn-sm p-0 border-0 <%= wmHinActive %> px-1">HI</button>
                </div>
                <div class="dropdown">
                    <button class="btn wm-user-btn dropdown-toggle d-flex align-items-center gap-2" data-bs-toggle="dropdown">
                        <span class="wm-user-avatar"><%= initials %></span>
                        <span class="fw-semibold d-none d-lg-inline"><%= wmUserNameHeader %></span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end wm-user-menu">
                        <li><a class="dropdown-item wm-user-menu-item wm-user-menu-logout" href="${pageContext.request.contextPath}/web/auth/logout"><i class="bi bi-box-arrow-right me-2"></i><fmt:message key="nav.logout"/></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
</header>
<aside id="wmSidebar" class="wm-sidebar">
    <ul class="list-unstyled m-0">
        <li><a class="<%= wmUri.contains("/dashboard") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/admin/dashboard"><i class="bi bi-speedometer2"></i><fmt:message key="nav.dashboard"/></a></li>
        <li><a class="<%= wmUri.contains("/users") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/admin/users"><i class="bi bi-people"></i><fmt:message key="nav.users"/></a></li>
        <li><a class="<%= wmUri.contains("/distributor-approvals") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/admin/distributor-approvals"><i class="bi bi-patch-check"></i><fmt:message key="admin.distributor_approvals"/></a></li>
        <li><a class="<%= wmUri.contains("/driver-approvals") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/admin/driver-approvals"><i class="bi bi-shield-check"></i><fmt:message key="admin.driver_approvals"/></a></li>
        <li><a class="<%= wmUri.contains("/orders") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/admin/orders"><i class="bi bi-bag"></i><fmt:message key="nav.orders"/></a></li>
        <li><a class="<%= wmUri.contains("/payments") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/admin/payments"><i class="bi bi-cash-coin"></i><fmt:message key="nav.payments"/></a></li>
        <li><a class="<%= wmUri.contains("/reports") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/admin/reports"><i class="bi bi-bar-chart"></i><fmt:message key="nav.reports"/></a></li>
        <li><a class="<%= wmUri.contains("/ai-chat") ? "active" : "" %>" href="${pageContext.request.contextPath}/web/admin/ai-chat"><i class="bi bi-robot"></i><fmt:message key="nav.ai_chat"/></a></li>
    </ul>
</aside>
<div id="wmSidebarBackdrop" class="wm-sidebar-backdrop"></div>
