<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="wm-auth-container">

    <div class="wm-auth-card">
        <button type="button" class="wm-close-btn">&times;</button>
        <div class="wm-brand">
            <div class="wm-logo">W</div>
            <h2>WholeMart</h2>
            <p>Local B2B AI Marketplace</p>
            <p class="mt-2 mb-0 text-muted"><fmt:message key="auth.please_sign_in"/></p>
        </div>
        <!-- Error & Message Banner -->
        <% 
        Object errObj = request.getAttribute("error");
        String errParam = request.getParameter("error");
        String errMsg = errObj != null ? String.valueOf(errObj) : errParam;
        
        Object msgObj = request.getAttribute("msg");
        String msgParam = request.getParameter("msg");
        String infoMsg = msgObj != null ? String.valueOf(msgObj) : msgParam;
        %>
        <% if (errMsg != null && !errMsg.isEmpty()) { %>
            <div class="alert alert-danger mb-3 d-flex align-items-center gap-2" style="font-size: 0.9rem;">
                <i class="bi bi-exclamation-triangle-fill flex-shrink-0"></i>
                <div><%= errMsg %></div>
            </div>
        <% } %>
        <% if (infoMsg != null && !infoMsg.isEmpty()) { %>
            <div class="alert alert-info mb-3 d-flex align-items-center gap-2" style="font-size: 0.9rem;">
                <i class="bi bi-info-circle-fill flex-shrink-0"></i>
                <div><%= infoMsg %></div>
            </div>
        <% } %>
        <form method="post"
              action="${pageContext.request.contextPath}/web/auth/login"
              id="loginForm">
            <!-- CSRF -->
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}" />
            <div class="wm-form-group">
                <label><fmt:message key="auth.username_or_mobile"/></label>
                <input
                        type="text"
                        class="wm-input"
                        id="loginMobile"
                        name="username"
                        placeholder="<fmt:message key='auth.enter_username_or_mobile'/>"
                        required>
                <div id="mobileError" class="text-danger" style="display:none; font-size: .9rem; margin-top: 6px;">
                    <fmt:message key="auth.mobile_error"/>
                </div>
            </div>

            <div class="wm-form-group">
                <label><fmt:message key="auth.password"/></label>
                <input
                        type="password"
                        class="wm-input"
                        name="password"
                        placeholder="<fmt:message key='auth.password'/>"
                        required>
            </div>
            <div class="wm-form-group">
                <label><fmt:message key="auth.select_role"/></label>
                <select class="wm-input" name="role" id="role" required>
                    <option value=""><fmt:message key="auth.choose_role"/></option>
                    <option value="ROLE_ADMIN"><fmt:message key="auth.admin"/></option>
                    <option value="ROLE_RETAILER"><fmt:message key="auth.retailer"/></option>
                    <option value="ROLE_DISTRIBUTOR"><fmt:message key="auth.distributor"/></option>
                    <option value="ROLE_DRIVER"><fmt:message key="auth.driver"/></option>
                </select>
            </div>
            <button class="wm-login-btn" type="submit">
                <fmt:message key="nav.login"/>
            </button>
        </form>
        <div class="wm-form-group text-center mt-3">
            <div class="position-relative my-3"><hr style="border-color: var(--line);"><span class="position-absolute top-50 start-50 translate-middle bg-white px-2 text-muted" style="font-size:0.8rem;"><fmt:message key="auth.or"/></span></div>
            <a href="${pageContext.request.contextPath}/web/auth/google" class="wm-btn-outline w-100 py-2 d-flex align-items-center justify-content-center gap-2" style="border-radius: var(--radius-sm); border: 1px solid var(--line-strong); width: 100%; text-decoration: none;">
                <i class="bi bi-google text-danger"></i> <fmt:message key="auth.google_login"/>
            </a>
        </div>
    </div>
</div>

<script>

document.addEventListener("DOMContentLoaded", function () {

    const form = document.getElementById("loginForm");

    const mobileInput = document.getElementById("loginMobile");

    const mobileError = document.getElementById("mobileError");

    function normalizeMobile(value) {
        return (value || "").replace(/\D+/g, "").trim();
    }

    function validateMobile() {

        if (!mobileInput) {
            return true;
        }

        const normalized = normalizeMobile(mobileInput.value);

        const valid = /^[0-9]{10}$/.test(normalized);

        if (!valid) {

            if (mobileError) {
                mobileError.style.display = "block";
            }

            mobileInput.classList.add("is-invalid");

        } else {

            if (mobileError) {
                mobileError.style.display = "none";
            }

            mobileInput.classList.remove("is-invalid");

            mobileInput.value = normalized;

        }

        return valid;

    }

    if (mobileInput) {

        mobileInput.addEventListener("input", function () {

            if (mobileError && mobileError.style.display === "block") {
                validateMobile();
            }

        });

    }

    form.addEventListener("submit", function (event) {

        if (!validateMobile()) {

            event.preventDefault();

            event.stopPropagation();

            mobileInput.focus();

        }

    });

});

</script>