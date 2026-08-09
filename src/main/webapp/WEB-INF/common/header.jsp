<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
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
                        <li class="nav-item"><a class="nav-link" href="#features"><fmt:message key="nav.impact"/></a></li>
                        <li class="nav-item"><a class="nav-link" href="#roles"><fmt:message key="nav.roles"/></a></li>
                        <li class="nav-item"><a class="nav-link" href="#operations"><fmt:message key="nav.operations"/></a></li>
                        <li class="nav-item"><a class="nav-link" href="#security"><fmt:message key="nav.security"/></a></li>
                    </ul>

                    <div class="wm-nav-actions">
                        <div class="wm-lang-toggle d-flex align-items-center gap-1 bg-white border rounded-pill px-2 py-1 me-2 shadow-sm fs-7">
<button type="button" onclick="setWmLanguage('eng')" class="btn btn-sm p-0 border-0 <%= wmEngActive %> px-1">EN</button>
                            <span class="wm-lang-sep text-black-50">|</span>
                            <button type="button" onclick="setWmLanguage('hin')" class="btn btn-sm p-0 border-0 <%= wmHinActive %> px-1">HI</button>
                        </div>
                        <a href="${pageContext.request.contextPath}/web/auth/login" class="btn wm-btn-ghost"><fmt:message key="nav.register"/></a>
                        <a href="${pageContext.request.contextPath}/web/auth/login" class="btn wm-btn-ghost"><fmt:message key="nav.login"/></a>
                    </div>
                </div>
            </div>
        </nav>
    </header>