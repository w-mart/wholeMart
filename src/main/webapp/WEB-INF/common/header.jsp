<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <header class="wm-header sticky-top">
        <nav class="navbar navbar-expand-lg">
            <div class="container">
                <a class="navbar-brand wm-logo-wrap" href="${pageContext.request.contextPath}/">
                    <div class="wm-logo-mark">W</div>
                    <div class="wm-logo-line">
                        <div class="wm-logo-title">WholeMart</div>
                        <small class="wm-logo-sub">Local B2B Marketplace</small>
                    </div>
                </a>

                <form class="wm-search d-none d-lg-flex" role="search">
                    <i class="bi bi-search wm-search-icon"></i>
                    <input class="wm-search-input" type="text"
                        placeholder="Search products, distributors, retailers...">
                </form>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar"
                    aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="mainNavbar">
                    <form class="wm-search d-lg-none" role="search">
                        <i class="bi bi-search wm-search-icon"></i>
                        <input class="wm-search-input" type="text"
                            placeholder="Search products, distributors, retailers...">
                    </form>

                    <ul class="navbar-nav wm-nav-links">
                        <li class="nav-item"><a class="nav-link" href="#features">Impact</a></li>
                        <li class="nav-item"><a class="nav-link" href="#roles">Roles</a></li>
                        <li class="nav-item"><a class="nav-link" href="#operations">Operations</a></li>
                        <li class="nav-item"><a class="nav-link" href="#security">Security</a></li>
                    </ul>

                    <div class="wm-nav-actions">
                        <div class="wm-lang-toggle">
                            <a href="?lang=en" class="wm-lang-option active">EN</a>
                            <span class="wm-lang-sep">|</span>
                            <a href="?lang=hi" class="wm-lang-option">HI</a>
                        </div>
                        <a href="${pageContext.request.contextPath}/web/auth/login" class="btn wm-btn-ghost">Sign up</a>
                        <a href="${pageContext.request.contextPath}/web/auth/login" class="btn wm-btn-primary">Login</a>
                    </div>
                </div>
            </div>
        </nav>
    </header>