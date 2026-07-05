<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="wholemart-header">
    <div class="header-container">
        <!-- Logo and Brand -->
        <div class="brand-section">
            <a href="<c:url value='/' />" class="brand-link">
                <div class="logo-icon">WM</div>
                <span class="brand-name">WholeMart</span>
            </a>
        </div>

        <!-- Search Bar -->
        <div class="search-section">
            <form class="search-form" action="<c:url value='/search' />" method="get">
                <input type="text" name="q" class="search-input" placeholder="Search marketplace, orders, or support..." required>
                <button type="submit" class="search-button">
                    <span class="search-icon">&#128269;</span>
                </button>
            </form>
        </div>

        <!-- Navigation Menu -->
        <nav class="nav-menu">
            <ul class="nav-list">
                <li class="nav-item"><a href="<c:url value='/impact' />" class="nav-link">Impact</a></li>
                <li class="nav-item"><a href="<c:url value='/roles' />" class="nav-link">Roles</a></li>
                <li class="nav-item"><a href="<c:url value='/operations' />" class="nav-link">Operations</a></li>
                <li class="nav-item"><a href="<c:url value='/faq' />" class="nav-link">FAQ</a></li>
                <li class="nav-item"><a href="<c:url value='/ai-agent' />" class="nav-link">AI Agent</a></li>
            </ul>
        </nav>

        <!-- Sign In Button -->
        <div class="auth-section">
            <a href="<c:url value='/login' />" class="signin-button">Sign in</a>
        </div>
    </div>
</header>
