<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String retailerName = session.getAttribute("name") == null ? "Retailer" : String.valueOf(session.getAttribute("name"));
    String retailerInitial = retailerName.substring(0, 1).toUpperCase();
%>

<header class="wm-header sticky-top">
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid px-3">

            <!-- Logo -->
            <a class="wm-logo-wrap" href="/web/retailer/dashboard">
                <div class="wm-logo-circle">M</div>
                <div class="wm-logo-line">
                    <span class="wm-logo-title">WholeMart</span>
                    <small>Retailer Workspace</small>
                </div>
            </a>

            <!-- Mobile Nav Toggle -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#wmRetailerNav"
                aria-controls="wmRetailerNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

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
                <div class="d-flex align-items-center">
                    <div class="dropdown">
                        <button class="btn wm-user-btn d-flex align-items-center gap-2 dropdown-toggle" type="button"
                            id="retailerUserMenu" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="wm-user-avatar"><%= retailerInitial %></div>
                            <span class="d-none d-lg-inline"><%= retailerName %></span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end wm-user-menu" aria-labelledby="retailerUserMenu">
                            <li>
                                <h6 class="dropdown-header wm-user-menu-header">
                                    Signed in as <strong><%= retailerName %></strong>
                                </h6>
                            </li>
                            <li>
                                <a class="dropdown-item wm-user-menu-item" href="/web/retailer/profile">
                                    <i class="bi bi-person-circle"></i> Profile
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item wm-user-menu-item" href="/web/retailer/settings">
                                    <i class="bi bi-gear"></i> Settings
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider wm-user-menu-divider">
                            </li>
                            <li>
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

<!-- Bootstrap JS for dropdowns and collapse -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>