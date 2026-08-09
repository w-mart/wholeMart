
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

    String wmEngActive =
        (wmLang.equals("eng") || wmLang.equals("en"))
            ? "fw-bold text-success"
            : "text-muted";

    String wmHinActive =
        (wmLang.equals("hin") || wmLang.equals("hi"))
            ? "fw-bold text-success"
            : "text-muted";
%>


<script>
    function setWmLanguage(lang) {
        window.location.href =
            "<%= request.getContextPath() %>/web/lang/" +
            encodeURIComponent(lang);
    }

    window.setWmLanguage = setWmLanguage;
</script>


<!-- ========================================================= -->
<!-- Distributor Header - Uses Driver CSS                    -->
<!-- ========================================================= -->

<header class="wm-header wm-driver-header sticky-top">

    <nav class="navbar navbar-light py-2">

        <div class="container-fluid px-3 wm-header-row wm-driver-header-row">


            <!-- ================================================= -->
            <!-- LEFT: Sidebar Toggle + Logo                     -->
            <!-- ================================================= -->

            <div class="d-flex align-items-center wm-header-left wm-driver-header-left gap-2">

                <button
                    id="wmSidebarToggle"
                    class="wm-sidebar-toggle-btn wm-driver-sidebar-toggle"
                    type="button"
                    aria-label="Toggle navigation drawer"
                    title="Open distributor navigation menu">

                    <i class="bi bi-list fs-4"></i>

                </button>


                <!-- WholeMart Distributor Logo -->

                <a
                    class="navbar-brand wm-logo-wrap wm-driver-logo-wrap"
                    href="${pageContext.request.contextPath}/web/distributor/dashboard">

                    <div class="wm-logo-mark wm-driver-logo-mark">

                        <span>W</span>

                        <i class="bi bi-shop wm-driver-mark-icon"></i>

                    </div>

                    <div class="wm-logo-line">

                        <div class="wm-logo-title d-flex align-items-center gap-2">

                            WholeMart

                            <span class="wm-driver-badge d-none d-sm-inline-flex">

                                <fmt:message key="nav.distributor_workspace"/>

                            </span>

                        </div>

                        <small class="wm-logo-sub wm-driver-logo-sub">
                            Wholesale Distribution & Operations
                        </small>

                    </div>

                </a>


                <!-- Distributor Status -->

                <div
                    class="wm-driver-status-chip d-none d-md-inline-flex align-items-center"
                    title="Distributor marketplace is active">

                    <span class="wm-pulse-dot wm-pulse-dot-green"></span>

                    <span class="wm-status-text">
                        Operations Active
                    </span>

                    <span class="wm-vehicle-tag">
                        DISTRIBUTOR
                    </span>

                </div>

            </div>


            <!-- ================================================= -->
            <!-- CENTER: Search                                   -->
            <!-- ================================================= -->

            <div class="wm-header-center d-none d-md-flex flex-grow-1 justify-content-center px-3">

                <form
                    class="wm-search wm-driver-search"
                    role="search"
                    onsubmit="event.preventDefault();">

                    <i class="bi bi-search wm-search-icon"></i>

                    <input
                        class="wm-search-input"
                        type="text"
                        placeholder="<fmt:message key="nav.search_placeholder"/>"
                        aria-label="Search products, retailers, and orders">

                    <span class="wm-search-badge">
                        <i class="bi bi-box-seam me-1"></i>
                        Wholesale
                    </span>

                </form>

            </div>


            <!-- ================================================= -->
            <!-- RIGHT: Alerts + Language + Profile              -->
            <!-- ================================================= -->

            <div class="d-flex align-items-center wm-header-right wm-driver-header-right gap-2">


                <!-- Alerts -->

                <a
                    href="${pageContext.request.contextPath}/web/distributor/alerts"
                    class="wm-driver-bell-btn d-none d-sm-inline-flex"
                    title="Distributor Notifications & Alerts"
                    aria-label="View Alerts">

                    <i class="bi bi-bell"></i>

                    <span class="wm-bell-dot"></span>

                </a>


                <!-- Language Toggle -->

                <div class="wm-lang-toggle wm-driver-lang-toggle d-flex align-items-center gap-1 bg-white border rounded-pill px-2 py-1 shadow-sm fs-7">

                    <button
                        type="button"
                        onclick="setWmLanguage('eng')"
                        class="btn btn-sm p-0 border-0 <%= wmEngActive %> px-1">

                        EN

                    </button>

                    <span class="wm-lang-sep text-black-50">
                        |
                    </span>

                    <button
                        type="button"
                        onclick="setWmLanguage('hin')"
                        class="btn btn-sm p-0 border-0 <%= wmHinActive %> px-1">

                        HI

                    </button>

                </div>


                <!-- ================================================= -->
                <!-- Distributor Profile Dropdown                    -->
                <!-- ================================================= -->

                <div class="dropdown">

                    <button
                        class="btn wm-user-btn wm-driver-user-btn dropdown-toggle d-flex align-items-center gap-2"
                        data-bs-toggle="dropdown"
                        aria-expanded="false"
                        aria-label="Distributor profile menu">

                        <div class="wm-driver-avatar-wrap">

                            <span class="wm-user-avatar wm-driver-avatar">
                                <%= initials %>
                            </span>

                            <span
                                class="wm-avatar-online-pip"
                                title="Active">
                            </span>

                        </div>


                        <div class="wm-driver-user-meta d-none d-lg-flex flex-column text-start">

                            <span class="wm-driver-user-name fw-bold">
                                <%= wmUserNameHeader %>
                            </span>

                            <span class="wm-driver-user-role text-muted">
                                Distributor
                            </span>

                        </div>

                    </button>


                    <!-- Profile Dropdown -->

                    <ul class="dropdown-menu dropdown-menu-end wm-user-menu wm-driver-user-menu">


                        <!-- Distributor Profile Hero -->

                        <li class="wm-driver-menu-hero">

                            <div class="d-flex align-items-center gap-3">

                                <div class="wm-driver-menu-avatar">
                                    <%= initials %>
                                </div>

                                <div class="flex-grow-1 min-w-0">

                                    <div class="fw-bold text-dark text-truncate fs-6">
                                        <%= wmUserNameHeader %>
                                    </div>

                                    <div class="d-flex align-items-center gap-2 mt-1">

                                        <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle rounded-pill font-monospace fs-8">
                                            Distributor Account
                                        </span>

                                        <span class="text-success small fw-bold">
                                            <i class="bi bi-check-circle-fill me-1"></i>
                                            Active
                                        </span>

                                    </div>

                                </div>

                            </div>


                            <!-- Distributor Meta -->

                            <div class="wm-driver-menu-vehicle mt-2 pt-2 border-top border-light-subtle d-flex justify-content-between text-muted fs-8">

                                <span>
                                    <i class="bi bi-shop me-1"></i>
                                    Wholesale Operations
                                </span>

                                <span class="font-monospace fw-semibold text-dark">
                                    DIST-01
                                </span>

                            </div>

                        </li>


                        <li>
                            <hr class="dropdown-divider wm-user-menu-divider">
                        </li>


                        <!-- Dashboard -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/dashboard">

                                <i class="bi bi-speedometer2"></i>

                                <fmt:message key="nav.dashboard"/>

                            </a>
                        </li>


                        <!-- Orders -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/orders">

                                <i class="bi bi-cart-check"></i>

                                <fmt:message key="nav.orders"/>

                            </a>
                        </li>


                        <!-- Products -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/products">

                                <i class="bi bi-box-seam"></i>

                                <fmt:message key="nav.products"/>

                            </a>
                        </li>


                        <!-- Add Product -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/add-product">

                                <i class="bi bi-plus-circle"></i>

                                <fmt:message key="nav.add_product"/>

                            </a>
                        </li>


                        <!-- Drivers -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/drivers">

                                <i class="bi bi-truck"></i>

                                <fmt:message key="nav.drivers"/>

                            </a>
                        </li>


                        <!-- Delivery -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/delivery">

                                <i class="bi bi-geo-alt"></i>

                                <fmt:message key="nav.deliveries"/>

                            </a>
                        </li>


                        <!-- Reports -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/reports">

                                <i class="bi bi-bar-chart"></i>

                                <fmt:message key="nav.reports"/>

                            </a>
                        </li>


                        <!-- AI Chat -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/ai-chat">

                                <i class="bi bi-robot"></i>

                                <fmt:message key="nav.ai_chat"/>

                            </a>
                        </li>


                        <!-- Profile -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/profile">

                                <i class="bi bi-person-badge"></i>

                                <fmt:message key="nav.profile"/>

                            </a>
                        </li>


                        <!-- Settings -->

                        <li>
                            <a
                                class="dropdown-item wm-user-menu-item"
                                href="${pageContext.request.contextPath}/web/distributor/settings">

                                <i class="bi bi-gear"></i>

                                <fmt:message key="nav.settings"/>

                            </a>
                        </li>


                        <li>
                            <hr class="dropdown-divider wm-user-menu-divider">
                        </li>


                        <!-- Logout -->

                        <li>

                            <a
                                class="dropdown-item wm-user-menu-item wm-user-menu-logout"
                                href="${pageContext.request.contextPath}/web/auth/logout">

                                <i class="bi bi-box-arrow-right"></i>

                                <fmt:message key="nav.logout"/>

                            </a>

                        </li>

                    </ul>

                </div>

            </div>

        </div>

    </nav>

</header>


<!-- ========================================================= -->
<!-- Distributor Off-Canvas Sidebar - Driver CSS             -->
<!-- ========================================================= -->

<aside
    id="wmSidebar"
    class="wm-sidebar wm-driver-sidebar"
    aria-label="Distributor Navigation Sidebar">


    <!-- ===================================================== -->
    <!-- Sidebar Distributor Profile                          -->
    <!-- ===================================================== -->

    <div class="wm-driver-sidebar-header">

        <div class="d-flex align-items-center justify-content-between mb-2">

            <div class="d-flex align-items-center gap-3 min-w-0">

                <div class="wm-driver-sidebar-avatar">
                    <%= initials %>
                </div>

                <div class="flex-grow-1 min-w-0">

                    <div class="fw-bold text-dark text-truncate">
                        <%= wmUserNameHeader %>
                    </div>

                    <div class="text-muted fs-8 d-flex align-items-center gap-1">

                        <span class="wm-pulse-dot wm-pulse-dot-green"></span>

                        Operations Active • DIST-01

                    </div>

                </div>

            </div>


            <!-- Close Sidebar -->

            <button
                id="wmSidebarClose"
                class="wm-sidebar-close-btn"
                type="button"
                aria-label="Close sidebar"
                title="Close navigation">

                <i class="bi bi-x-lg"></i>

            </button>

        </div>


        <!-- Distributor Meta -->

        <div class="wm-driver-sidebar-meta-row d-flex justify-content-between align-items-center">

            <span class="badge bg-warning text-dark rounded-pill px-2 py-1 font-monospace fs-8">

                <i class="bi bi-shop me-1"></i>

                DIST-01

            </span>

            <span class="text-success fw-bold fs-8">

                <i class="bi bi-box-seam me-1"></i>

                Wholesale Active

            </span>

        </div>

    </div>


    <!-- ===================================================== -->
    <!-- Sidebar Navigation                                   -->
    <!-- ===================================================== -->

    <div class="wm-driver-sidebar-scroll">


        <!-- ================================================= -->
        <!-- OPERATIONS                                        -->
        <!-- ================================================= -->

        <div class="wm-driver-sidebar-section">

            <div class="wm-driver-sidebar-kicker">
                OPERATIONS
            </div>

            <ul class="list-unstyled m-0">


                <!-- Dashboard -->

                <li>

                    <a
                        class="<%= wmUri.contains("/dashboard") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/dashboard">

                        <i class="bi bi-speedometer2"></i>

                        <span>
                            <fmt:message key="nav.dashboard"/>
                        </span>

                    </a>

                </li>


                <!-- Orders -->

                <li>

                    <a
                        class="<%= wmUri.contains("/orders") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/orders">

                        <i class="bi bi-cart-check"></i>

                        <span>
                            <fmt:message key="nav.orders"/>
                        </span>

                    </a>

                </li>


                <!-- Products -->

                <li>

                    <a
                        class="<%= wmUri.contains("/products") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/products">

                        <i class="bi bi-box-seam"></i>

                        <span>
                            <fmt:message key="nav.products"/>
                        </span>

                    </a>

                </li>


                <!-- Add Product -->

                <li>

                    <a
                        class="<%= wmUri.contains("/add-product") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/add-product">

                        <i class="bi bi-plus-circle"></i>

                        <span>
                            <fmt:message key="nav.add_product"/>
                        </span>

                    </a>

                </li>

            </ul>

        </div>


        <!-- ================================================= -->
        <!-- LOGISTICS                                         -->
        <!-- ================================================= -->

        <div class="wm-driver-sidebar-section">

            <div class="wm-driver-sidebar-kicker">
                LOGISTICS
            </div>

            <ul class="list-unstyled m-0">


                <!-- Drivers -->

                <li>

                    <a
                        class="<%= wmUri.contains("/drivers") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/drivers">

                        <i class="bi bi-truck"></i>

                        <span>
                            <fmt:message key="nav.drivers"/>
                        </span>

                    </a>

                </li>


                <!-- Deliveries -->

                <li>

                    <a
                        class="<%= wmUri.contains("/delivery") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/delivery">

                        <i class="bi bi-geo-alt"></i>

                        <span>
                            <fmt:message key="nav.deliveries"/>
                        </span>

                    </a>

                </li>

            </ul>

        </div>


        <!-- ================================================= -->
        <!-- ANALYTICS & TOOLS                                -->
        <!-- ================================================= -->

        <div class="wm-driver-sidebar-section">

            <div class="wm-driver-sidebar-kicker">
                ANALYTICS & TOOLS
            </div>

            <ul class="list-unstyled m-0">


                <!-- Reports -->

                <li>

                    <a
                        class="<%= wmUri.contains("/reports") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/reports">

                        <i class="bi bi-bar-chart"></i>

                        <span>
                            <fmt:message key="nav.reports"/>
                        </span>

                    </a>

                </li>


                <!-- Alerts -->

                <li>

                    <a
                        class="<%= wmUri.contains("/alerts") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/alerts">

                        <i class="bi bi-bell"></i>

                        <span>
                            <fmt:message key="nav.alerts"/>
                        </span>

                        <span class="badge bg-danger ms-auto rounded-pill px-2 py-0 fs-8">
                            2
                        </span>

                    </a>

                </li>


                <!-- AI Chat -->

                <li>

                    <a
                        class="<%= wmUri.contains("/ai-chat") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/ai-chat">

                        <i class="bi bi-robot text-success"></i>

                        <span>
                            <fmt:message key="nav.ai_chat"/>
                        </span>

                        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill ms-auto px-2 py-0 fs-8">
                            AI
                        </span>

                    </a>

                </li>


                <!-- Profile -->

                <li>

                    <a
                        class="<%= wmUri.contains("/profile") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/profile">

                        <i class="bi bi-person-badge"></i>

                        <span>
                            <fmt:message key="nav.profile"/>
                        </span>

                    </a>

                </li>


                <!-- Settings -->

                <li>

                    <a
                        class="<%= wmUri.contains("/settings") ? "active" : "" %>"
                        href="${pageContext.request.contextPath}/web/distributor/settings">

                        <i class="bi bi-gear"></i>

                        <span>
                            <fmt:message key="nav.settings"/>
                        </span>

                    </a>

                </li>

            </ul>

        </div>

    </div>


    <!-- ===================================================== -->
    <!-- Sidebar Footer                                      -->
    <!-- ===================================================== -->

    <div class="wm-driver-sidebar-footer">

        <div class="d-flex align-items-center justify-content-between pt-2 border-top border-light-subtle">

            <small class="text-muted fs-8">
                WholeMart Distributor v2.4
            </small>

            <a
                href="${pageContext.request.contextPath}/web/auth/logout"
                class="text-danger fw-bold fs-8 text-decoration-none d-flex align-items-center gap-1">

                <i class="bi bi-box-arrow-right"></i>

                <fmt:message key="nav.logout"/>

            </a>

        </div>

    </div>

</aside>


<!-- ========================================================= -->
<!-- Sidebar Backdrop                                         -->
<!-- ========================================================= -->

<div
    id="wmSidebarBackdrop"
    class="wm-sidebar-backdrop">
</div>


<!-- ========================================================= -->
<!-- Sidebar JavaScript                                       -->
<!-- ========================================================= -->

<script>

    document.addEventListener("DOMContentLoaded", function () {

        const sidebar =
            document.getElementById("wmSidebar");

        const toggle =
            document.getElementById("wmSidebarToggle");

        const closeBtn =
            document.getElementById("wmSidebarClose");

        const backdrop =
            document.getElementById("wmSidebarBackdrop");


        function openSidebar() {

            if (sidebar) {
                sidebar.classList.add("show");
            }

            if (backdrop) {
                backdrop.classList.add("show");
            }

            document.body.classList.add("wm-sidebar-open");

        }


        function closeSidebar() {

            if (sidebar) {
                sidebar.classList.remove("show");
            }

            if (backdrop) {
                backdrop.classList.remove("show");
            }

            document.body.classList.remove("wm-sidebar-open");

        }


        /* Toggle sidebar */

        if (toggle) {

            toggle.addEventListener("click", function (e) {

                e.preventDefault();
                e.stopPropagation();

                if (
                    sidebar &&
                    sidebar.classList.contains("show")
                ) {

                    closeSidebar();

                } else {

                    openSidebar();

                }

            });

        }


        /* Close button */

        if (closeBtn) {

            closeBtn.addEventListener("click", function (e) {

                e.preventDefault();
                e.stopPropagation();

                closeSidebar();

            });

        }


        /* Backdrop */

        if (backdrop) {

            backdrop.addEventListener(
                "click",
                closeSidebar
            );

        }


        /* Escape key */

        document.addEventListener("keydown", function (e) {

            if (e.key === "Escape") {
                closeSidebar();
            }

        });


        /* Close drawer after navigation */

        if (sidebar) {

            const sidebarLinks =
                sidebar.querySelectorAll("a");

            sidebarLinks.forEach(function (link) {

                link.addEventListener("click", function () {

                    closeSidebar();

                });

            });

        }

    });

</script>