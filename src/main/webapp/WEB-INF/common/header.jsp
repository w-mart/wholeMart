<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <header class="wm-header sticky-top">
        <nav class="navbar navbar-expand-lg navbar-light bg-white">
            <div class="container">
                <a class="navbar-brand wm-logo-wrap" href="${pageContext.request.contextPath}/">
                    <div class="wm-logo-circle">W</div>
                    <div class="wm-logo-line">
                    <div class="wm-logo-title">WholeMart</div>
                    <small class="text-muted">
                        Local B2B Marketplace
                    </small>
                    </div>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="mainNavbar">
                    <form class="mx-auto wm-search">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0">
                                <i class="bi bi-search"></i>
                            </span>
                            <input class="form-control border-start-0" type="text"
                                placeholder="Search products, distributors, retailers...">
                        </div>
                    </form>
                    <ul class="navbar-nav ms-auto align-items-lg-center">
                        <li class="nav-item"><a class="nav-link" href="#features">Impact</a></li>
                        <li class="nav-item"><a class="nav-link" href="#roles">Roles</a></li>
                        <li class="nav-item"><a class="nav-link" href="#operations">Operations</a></li>
                        <li class="nav-item"><a class="nav-link" href="#security">Security</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/uuserRegister">Sign up</a></li>
                        <li class="nav-item"><a href="${pageContext.request.contextPath}/web/auth/login" class="btn wm-btn-primary js-auth-open" style="height: 42px; padding: 0 18px;">Sign In</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>