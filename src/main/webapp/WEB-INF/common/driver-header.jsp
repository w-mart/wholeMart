<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            wmUserNameHeader = "Driver User";
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
            initials = "DR";
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

<script>
  function setWmLanguage(lang) {
    try {
      document.cookie = "wm_lang=" + encodeURIComponent(lang) + "; path=/; max-age=31536000";
      var url = new URL(window.location.href);
      url.searchParams.set('lang', lang);
      window.location.href = url.toString();
    } catch (e) {
      window.location.search = '?lang=' + encodeURIComponent(lang);
    }
  }
  window.setWmLanguage = setWmLanguage;
  if (typeof globalThis !== 'undefined') { globalThis.setWmLanguage = setWmLanguage; }
</script>

<header class="wm-header wm-driver-header sticky-top">
    <nav class="navbar navbar-light py-2">
        <div class="container-fluid px-3 wm-header-row wm-driver-header-row">

            <!-- Left: sidebar toggle (menu button) + logo + duty pill -->
            <div class="d-flex align-items-center wm-header-left wm-driver-header-left gap-2">
                <button id="wmSidebarToggle" class="wm-sidebar-toggle-btn wm-driver-sidebar-toggle" type="button"
                    aria-label="Toggle navigation drawer" title="Open driver navigation menu">
                    <i class="bi bi-list fs-4"></i>
                </button>

                <a class="navbar-brand wm-logo-wrap wm-driver-logo-wrap"
                    href="${pageContext.request.contextPath}/web/driver/dashboard">
                    <div class="wm-logo-mark wm-driver-logo-mark">
                        <span>W</span>
                        <i class="bi bi-truck wm-driver-mark-icon"></i>
                    </div>
                    <div class="wm-logo-line">
                        <div class="wm-logo-title d-flex align-items-center gap-2">
                            WholeMart
                            <span class="wm-driver-badge d-none d-sm-inline-flex"><fmt:message key="nav.driver_workspace"/></span>
                        </div>
                        <small class="wm-logo-sub wm-driver-logo-sub">Fleet Dispatch & Logistics</small>
                    </div>
                </a>

                <!-- Live Duty Status Chip (Desktop & Tablet) -->
                <div class="wm-driver-status-chip d-none d-md-inline-flex align-items-center" title="GPS tracking active and dispatches enabled">
                    <span class="wm-pulse-dot wm-pulse-dot-green"></span>
                    <span class="wm-status-text">On Duty</span>
                    <span class="wm-vehicle-tag">UP20 CX 3626</span>
                </div>
            </div>

            <!-- Center: Search Manifest / Drop-offs / Orders -->
            <div class="wm-header-center d-none d-md-flex flex-grow-1 justify-content-center px-3">
                <form class="wm-search wm-driver-search" role="search" onsubmit="event.preventDefault();">
                    <i class="bi bi-search wm-search-icon"></i>
                    <input class="wm-search-input" type="text"
                        placeholder="Search manifests, drop-offs, stores, OTP..." aria-label="Search deliveries">
                    <span class="wm-search-badge"><i class="bi bi-geo-alt me-1"></i>GPS</span>
                </form>
            </div>

            <!-- Right: Alerts + Language toggle + Driver Profile dropdown -->
            <div class="d-flex align-items-center wm-header-right wm-driver-header-right gap-2">
                <!-- Quick Alerts Bell -->
                <a href="${pageContext.request.contextPath}/web/driver/alerts" class="wm-driver-bell-btn d-none d-sm-inline-flex" title="Driver Notifications & Route Alerts" aria-label="Route Alerts">
                    <i class="bi bi-bell"></i>
                    <span class="wm-bell-dot"></span>
                </a>

                <!-- Language Toggle -->
                <div class="wm-lang-toggle wm-driver-lang-toggle d-flex align-items-center gap-1 bg-white border rounded-pill px-2 py-1 shadow-sm fs-7">
                    <button type="button" onclick="setWmLanguage('eng')" class="btn btn-sm p-0 border-0 <%= (wmLang != null && ("eng".equals(wmLang) || "en".equals(wmLang))) ? "fw-bold text-success" : "text-muted" %> px-1">EN</button>
                    <span class="wm-lang-sep text-black-50">|</span>
                    <button type="button" onclick="setWmLanguage('hin')" class="btn btn-sm p-0 border-0 <%= (wmLang != null && ("hin".equals(wmLang) || "hi".equals(wmLang))) ? "fw-bold text-success" : "text-muted" %> px-1">HI</button>
                </div>

                <!-- Driver User Profile Dropdown -->
                <div class="dropdown">
                    <button class="btn wm-user-btn wm-driver-user-btn dropdown-toggle d-flex align-items-center gap-2"
                        data-bs-toggle="dropdown" aria-expanded="false" aria-label="Driver profile menu">
                        <div class="wm-driver-avatar-wrap">
                            <span class="wm-user-avatar wm-driver-avatar">
                                <%= initials %>
                            </span>
                            <span class="wm-avatar-online-pip" title="Active"></span>
                        </div>
                        <div class="wm-driver-user-meta d-none d-lg-flex flex-column text-start">
                            <span class="wm-driver-user-name fw-bold">
                                <%= wmUserNameHeader %>
                            </span>
                            <span class="wm-driver-user-role text-muted">Vehicle UP20 CX 3626</span>
                        </div>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end wm-user-menu wm-driver-user-menu">
                        <!-- Driver Profile Card in Dropdown -->
                        <li class="wm-driver-menu-hero">
                            <div class="d-flex align-items-center gap-3">
                                <div class="wm-driver-menu-avatar"><%= initials %></div>
                                <div class="flex-grow-1 min-w-0">
                                    <div class="fw-bold text-dark text-truncate fs-6"><%= wmUserNameHeader %></div>
                                    <div class="d-flex align-items-center gap-2 mt-1">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill font-monospace fs-8">Active Driver</span>
                                        <span class="text-warning small fw-bold"><i class="bi bi-star-fill me-1"></i>4.9</span>
                                    </div>
                                </div>
                            </div>
                            <div class="wm-driver-menu-vehicle mt-2 pt-2 border-top border-light-subtle d-flex justify-content-between text-muted fs-8">
                                <span><i class="bi bi-truck me-1"></i>Auto Loader</span>
                                <span class="font-monospace fw-semibold text-dark">UP20 CX 3626</span>
                            </div>
                        </li>

                        <li><hr class="dropdown-divider wm-user-menu-divider"></li>

                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/driver/dashboard">
                                <i class="bi bi-speedometer2"></i><fmt:message key="nav.dashboard"/>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/driver/deliveries">
                                <i class="bi bi-truck"></i><fmt:message key="nav.deliveries"/>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/driver/orders">
                                <i class="bi bi-box-seam"></i><fmt:message key="nav.orders"/>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/driver/earnings">
                                <i class="bi bi-wallet2"></i><fmt:message key="driver.earnings"/>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/driver/ai-chat">
                                <i class="bi bi-robot"></i><fmt:message key="nav.ai_chat"/>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/driver/profile">
                                <i class="bi bi-person-badge"></i><fmt:message key="nav.profile"/>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/driver/settings">
                                <i class="bi bi-gear"></i><fmt:message key="nav.settings"/>
                            </a>
                        </li>

                        <li><hr class="dropdown-divider wm-user-menu-divider"></li>

                        <li>
                            <a class="dropdown-item wm-user-menu-item wm-user-menu-logout"
                                href="${pageContext.request.contextPath}/web/auth/logout">
                                <i class="bi bi-box-arrow-right"></i><fmt:message key="nav.logout"/>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

        </div>
    </nav>
</header>

<!-- Driver Off-Canvas Sidebar / Navigation Drawer -->
<aside id="wmSidebar" class="wm-sidebar wm-driver-sidebar" aria-label="Driver Navigation Sidebar">
    <!-- Sidebar Driver Profile Header -->
    <div class="wm-driver-sidebar-header">
        <div class="d-flex align-items-center justify-content-between mb-2">
            <div class="d-flex align-items-center gap-3 min-w-0">
                <div class="wm-driver-sidebar-avatar"><%= initials %></div>
                <div class="flex-grow-1 min-w-0">
                    <div class="fw-bold text-dark text-truncate"><%= wmUserNameHeader %></div>
                    <div class="text-muted fs-8 d-flex align-items-center gap-1">
                        <span class="wm-pulse-dot wm-pulse-dot-green"></span> GPS Active • DRV-01
                    </div>
                </div>
            </div>
            <button id="wmSidebarClose" class="wm-sidebar-close-btn" type="button" aria-label="Close sidebar" title="Close navigation">
                <i class="bi bi-x-lg"></i>
            </button>
        </div>
        <div class="wm-driver-sidebar-meta-row d-flex justify-content-between align-items-center">
            <span class="badge bg-dark text-white rounded-pill px-2 py-1 font-monospace fs-8">
                <i class="bi bi-truck me-1"></i>UP20 CX 3626
            </span>
            <span class="text-success fw-bold fs-8">
                <i class="bi bi-geo-alt-fill me-1"></i>Jaspur Hub
            </span>
        </div>
    </div>

    <!-- Grouped Nav Items -->
    <div class="wm-driver-sidebar-scroll">
        <div class="wm-driver-sidebar-section">
            <div class="wm-driver-sidebar-kicker">DISPATCH & DELIVERIES</div>
            <ul class="list-unstyled m-0">
                <li>
                    <a class="<%= wmUri.contains("/dashboard") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/driver/dashboard">
                        <i class="bi bi-speedometer2"></i>
                        <span><fmt:message key="nav.dashboard"/></span>
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/deliveries") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/driver/deliveries">
                        <i class="bi bi-truck"></i>
                        <span><fmt:message key="nav.deliveries"/></span>
                        <span class="wm-sidebar-pill-badge ms-auto">Live</span>
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/orders") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/driver/orders">
                        <i class="bi bi-box-seam"></i>
                        <span><fmt:message key="nav.orders"/></span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="wm-driver-sidebar-section">
            <div class="wm-driver-sidebar-kicker">PERFORMANCE & REVENUES</div>
            <ul class="list-unstyled m-0">
                <li>
                    <a class="<%= wmUri.contains("/earnings") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/driver/earnings">
                        <i class="bi bi-wallet2"></i>
                        <span><fmt:message key="driver.earnings"/></span>
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/reports") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/driver/reports">
                        <i class="bi bi-bar-chart"></i>
                        <span><fmt:message key="nav.reports"/></span>
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/alerts") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/driver/alerts">
                        <i class="bi bi-bell"></i>
                        <span><fmt:message key="nav.alerts"/></span>
                        <span class="badge bg-danger ms-auto rounded-pill px-2 py-0 fs-8">2</span>
                    </a>
                </li>
            </ul>
        </div>

        <div class="wm-driver-sidebar-section">
            <div class="wm-driver-sidebar-kicker">ASSISTANT & TOOLS</div>
            <ul class="list-unstyled m-0">
                <li>
                    <a class="<%= wmUri.contains("/ai-chat") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/driver/ai-chat">
                        <i class="bi bi-robot text-success"></i>
                        <span><fmt:message key="nav.ai_chat"/></span>
                        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill ms-auto px-2 py-0 fs-8">AI</span>
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/profile") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/driver/profile">
                        <i class="bi bi-person-badge"></i>
                        <span><fmt:message key="nav.profile"/></span>
                    </a>
                </li>
                <li>
                    <a class="<%= wmUri.contains("/settings") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/driver/settings">
                        <i class="bi bi-gear"></i>
                        <span><fmt:message key="nav.settings"/></span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- Sidebar Footer with Emergency Hotline and Logout -->
    <div class="wm-driver-sidebar-footer">
        <div class="wm-driver-sos-box d-flex align-items-center justify-content-between mb-2">
            <div class="d-flex align-items-center gap-2">
                <i class="bi bi-shield-fill-check text-success fs-5"></i>
                <div class="lh-1">
                    <div class="fw-bold text-dark fs-8">Driver SOS Helpline</div>
                    <small class="text-muted fs-8">1800-WHOLE-MART</small>
                </div>
            </div>
            <a href="tel:180094653" class="btn btn-sm btn-outline-dark rounded-pill py-1 px-2 fs-8 font-monospace">Call</a>
        </div>
        <div class="d-flex align-items-center justify-content-between pt-2 border-top border-light-subtle">
            <small class="text-muted fs-8">WholeMart Fleet v2.4</small>
            <a href="${pageContext.request.contextPath}/web/auth/logout" class="text-danger fw-bold fs-8 text-decoration-none d-flex align-items-center gap-1">
                <i class="bi bi-box-arrow-right"></i> <fmt:message key="nav.logout"/>
            </a>
        </div>
    </div>
</aside>

<!-- Sidebar Backdrop -->
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

