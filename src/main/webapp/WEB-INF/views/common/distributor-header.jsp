<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String initials = "";
    if (wmUserName != null && !wmUserName.isEmpty()) {
        String[] parts = wmUserName.trim().split("\\s+");
        for (String part : parts) {
            if (!part.isEmpty()) initials += part.substring(0, 1).toUpperCase();
        }
        if (initials.length() > 2) initials = initials.substring(0, 2);
    }
    if (initials.isEmpty()) initials = "?";
%>

<style>
    /* ── Hamburger button ── */
    .wm-topbar .wm-menu {
        display: flex !important;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 5px;
        width: 40px;
        height: 40px;
        background: var(--wm-surface, #fff);
        border: 1.5px solid var(--wm-border, #e5e7eb);
        border-radius: 10px;
        padding: 8px;
        cursor: pointer;
        box-shadow: 0 1px 4px rgba(0,0,0,0.08);
        transition: box-shadow 0.15s, background 0.15s;
    }
    .wm-topbar .wm-menu:hover, .wm-topbar .wm-menu.is-active {
        background: var(--wm-hover, #f3f4f6);
        box-shadow: 0 2px 8px rgba(0,0,0,0.13);
    }
    .wm-topbar .wm-menu .wm-menu-line {
        display: block;
        width: 18px;
        height: 2px;
        background: var(--wm-brand-ink, #1a2e1a);
        border-radius: 2px;
        transition: transform 0.2s, opacity 0.2s;
    }

    .wm-topbar .wm-menu.is-active .wm-menu-line:nth-child(1) {
        transform: translateY(7px) rotate(45deg);
    }
    .wm-topbar .wm-menu.is-active .wm-menu-line:nth-child(2) {
        opacity: 0;
    }
    .wm-topbar .wm-menu.is-active .wm-menu-line:nth-child(3) {
        transform: translateY(-7px) rotate(-45deg);
    }

    /* ── Mobile drawer ── */
    .wm-mobile-nav {
        position: fixed;
        top: 0;
        left: 0;
        width: 300px;
        height: 100dvh;
        background: #ffffff;
        z-index: 1100;
        display: flex;
        flex-direction: column;
        padding-top: 70px;
        transform: translateX(-100%);
        transition: transform 0.26s cubic-bezier(.4,0,.2,1);
        box-shadow: none;
        scrollbar-width: none; /* Remove scrollbar for Firefox */
    }
    .wm-mobile-nav::-webkit-scrollbar {
        display: none; /* Remove scrollbar for Chrome/Safari */
    }
    .wm-mobile-nav.wm-nav--mobile-open {
        transform: translateX(0);
        box-shadow: 4px 0 32px rgba(0,0,0,0.12);
    }

    /* ── Nav links ── */
    .wm-mobile-nav-links {
        flex: 1;
        overflow-y: auto;
        display: flex;
        flex-direction: column;
        padding: 12px;
        gap: 2px;
    }
    .wm-mobile-nav-link {
        display: block;
        padding: 13px 20px;
        font-size: 15px;
        font-weight: 600;
        color: #166534;
        text-decoration: none;
        border-radius: 10px;
        background: transparent;
        transition: background 0.15s, color 0.15s;
        letter-spacing: 0.01em;
    }
    .wm-mobile-nav-link:hover {
        background: #f0fdf4;
        color: #166534;
    }
    .wm-mobile-nav-link.active {
        background: linear-gradient(135deg, #0d9488, #134e4a);
        color: #ffffff !important;
        font-weight: 700;
        border-radius: 10px;
    }

    /* ── Footer ── */
    .wm-mobile-nav-footer {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 20px;
        border-top: 1px solid #e5e7eb;
    }
    .wm-mobile-nav-footer .wm-nav-avatar {
        width: 42px;
        height: 42px;
        font-size: 15px;
        line-height: 42px;
        border-radius: 50%;
        background: #0d9488;
        color: #fff;
        text-align: center;
        font-weight: 700;
        flex-shrink: 0;
    }
    .wm-mobile-nav-footer-info {
        display: flex;
        flex-direction: column;
    }
    .wm-mobile-nav-footer-name {
        font-size: 14px;
        font-weight: 700;
        color: #111827;
    }
    .wm-mobile-nav-footer-role {
        font-size: 11px;
        font-weight: 500;
        color: #6b7280;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    /* ── Topbar Layering ── */
    .wm-topbar {
        z-index: 1200 !important;
        position: fixed !important;
    }

    /* ── Backdrop ── */
    .wm-mobile-nav-backdrop {
        display: none;
        position: fixed;
        inset: 0;
        background: rgba(0,0,0,0.32);
        z-index: 1099;
    }
    .wm-mobile-nav-backdrop.active {
        display: block;
    }

    /* ── Responsive ── */
    @media (max-width: 900px) {
        .wm-header-links { display: none !important; }
    }
    @media (min-width: 901px) {
        .wm-header-links { display: none !important; }

        .wm-app {
            transition: padding-left 0.26s cubic-bezier(.4,0,.2,1);
        }
        .wm-topbar {
            transition: left 0.26s cubic-bezier(.4,0,.2,1);
        }

        /* Push content and topbar when sidebar is open */
        body.wm-sidebar-open.wm-home .wm-app {
            padding-left: 300px !important;
        }
        body.wm-sidebar-open .wm-topbar {
            left: 300px !important;
        }
        body.wm-sidebar-open .wm-mobile-nav-backdrop {
            display: none !important;
        }
    }
</style>

<header class="wm-topbar" role="banner">
    <div class="wm-topbar-left" style="flex: 1 1 0%;">
        <button class="wm-menu" type="button" aria-label="Toggle menu" aria-expanded="false">
            <span class="wm-menu-line"></span>
            <span class="wm-menu-line"></span>
            <span class="wm-menu-line"></span>
        </button>
        <a class="wm-brand-link" href="/" aria-label="WholeMart home">
            <span class="wm-logo">WM</span>
            <span class="wm-brand-name">WholeMart</span>
        </a>
    </div>
    <div class="wm-topbar-center" style="flex: 0 0 auto; width: 400px;">
        <input id="wm-search" class="wm-search" placeholder="Search marketplace, orders, or support..." aria-label="Search">
    </div>
    <div class="wm-topbar-right" style="flex: 1 1 0%; display: flex; justify-content: flex-end; align-items: center; gap: 16px;">
        <nav class="wm-header-links" aria-label="Header quick links">
            <a class="wm-header-link <%= wmUri.contains("/dashboard") ? "active" : "" %>" href="/web/distributor/dashboard">Dashboard</a>
            <a class="wm-header-link <%= wmUri.contains("/orders")    ? "active" : "" %>" href="/web/distributor/orders">Orders</a>
            <a class="wm-header-link <%= wmUri.contains("/products")  ? "active" : "" %>" href="/web/distributor/products">Inventory</a>
            <a class="wm-header-link <%= wmUri.contains("/ai-chat")   ? "active" : "" %>" href="/web/distributor/ai-chat">AI Assistant</a>
            <a class="wm-header-link <%= wmUri.contains("/delivery")  ? "active" : "" %>" href="/web/distributor/delivery">Delivery</a>
            <a class="wm-header-link" href="/#faq">FAQ</a>
        </nav>
        <div class="d-flex align-items-center gap-2">
            <span class="wm-user-avatar" style="width:32px; height:32px; font-size:12px; line-height:32px;"><%= initials %></span>
            <span class="d-none d-lg-inline" style="font-weight:700; color:var(--wm-brand-ink); font-size:13px; white-space:nowrap;"><%= wmUserName %></span>
            <a href="/web/auth/logout" class="btn btn-sm btn-outline-danger" style="font-size:11px; font-weight:800; min-height:32px;">Logout</a>
        </div>
    </div>
</header>

<!-- Mobile drawer -->
<div class="wm-mobile-nav" id="wm-mobile-nav" aria-hidden="true">
    <nav class="wm-mobile-nav-links">
        <a class="wm-mobile-nav-link <%= wmUri.contains("/dashboard")   ? "active" : "" %>" href="/web/distributor/dashboard">Dashboard</a>
        <a class="wm-mobile-nav-link <%= wmUri.contains("/orders")      ? "active" : "" %>" href="/web/distributor/orders">Orders</a>
        <a class="wm-mobile-nav-link <%= wmUri.contains("/products")    ? "active" : "" %>" href="/web/distributor/products">Inventory</a>
        <a class="wm-mobile-nav-link <%= wmUri.contains("/add-product") ? "active" : "" %>" href="/web/distributor/add-product">Add Product</a>
        <a class="wm-mobile-nav-link <%= wmUri.contains("/delivery")    ? "active" : "" %>" href="/web/distributor/delivery">Delivery</a>
        <a class="wm-mobile-nav-link <%= wmUri.contains("/drivers")     ? "active" : "" %>" href="/web/distributor/drivers">Drivers</a>
        <a class="wm-mobile-nav-link <%= wmUri.contains("/reports")     ? "active" : "" %>" href="/web/distributor/reports">Reports</a>
        <a class="wm-mobile-nav-link <%= wmUri.contains("/dues")        ? "active" : "" %>" href="/web/distributor/dues">Payments</a>
        <a class="wm-mobile-nav-link <%= wmUri.contains("/alerts")      ? "active" : "" %>" href="/web/distributor/alerts">Alerts</a>
        <a class="wm-mobile-nav-link <%= wmUri.contains("/ai-chat")     ? "active" : "" %>" href="/web/distributor/ai-chat">AI Assistant</a>
    </nav>
    <div class="wm-mobile-nav-footer">
        <div class="wm-nav-avatar"><%= initials %></div>
        <div class="wm-mobile-nav-footer-info">
            <span class="wm-mobile-nav-footer-name"><%= wmUserName %></span>
            <span class="wm-mobile-nav-footer-role">Distributor</span>
        </div>
    </div>
</div>

<!-- Backdrop -->
<div class="wm-mobile-nav-backdrop" id="wm-mobile-nav-backdrop"></div>

<script>
    (function () {
        const btn      = document.querySelector('.wm-menu');
        const drawer   = document.getElementById('wm-mobile-nav');
        const backdrop = document.getElementById('wm-mobile-nav-backdrop');

        function openNav() {
            drawer.classList.add('wm-nav--mobile-open');
            backdrop.classList.add('active');
            btn.classList.add('is-active');
            drawer.setAttribute('aria-hidden', 'false');
            btn.setAttribute('aria-expanded', 'true');
            document.body.classList.add('wm-sidebar-open');
            
            if (window.innerWidth <= 900) {
                document.body.style.overflow = 'hidden';
            }
        }

        function closeNav() {
            drawer.classList.remove('wm-nav--mobile-open');
            backdrop.classList.remove('active');
            btn.classList.remove('is-active');
            drawer.setAttribute('aria-hidden', 'true');
            btn.setAttribute('aria-expanded', 'false');
            document.body.classList.remove('wm-sidebar-open');
            document.body.style.overflow = '';
        }

        btn?.addEventListener('click', function (e) {
            e.stopPropagation();
            drawer.classList.contains('wm-nav--mobile-open') ? closeNav() : openNav();
        });

        // Force closed on load to override global common.js desktop defaults
        closeNav();

        backdrop?.addEventListener('click', closeNav);
        drawer?.querySelectorAll('a').forEach(link => link.addEventListener('click', closeNav));

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeNav();
        });
    })();
</script>