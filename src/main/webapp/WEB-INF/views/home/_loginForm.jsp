<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="wm-auth-container">

    <div class="wm-auth-card">
        <button type="button" class="wm-close-btn">&times;</button>
        <div class="wm-brand">
            <div class="wm-logo">W</div>
            <h2>WholeMart</h2>
            <p>Local B2B AI Marketplace</p>
        </div>
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger mb-3">
                ${error}
            </div>
        </c:if>
        <form method="post"
              action="${pageContext.request.contextPath}/web/main/auth/login"
              id="loginForm">
            <!-- CSRF -->
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}" />
            <div class="wm-form-group">
                <label>Username or Mobile</label>
                <input
                        type="text"
                        class="wm-input"
                        id="loginMobile"
                        name="username"
                        placeholder="Enter Username or Mobile (10 digits)"
                        required>
                <div id="mobileError" class="text-danger" style="display:none; font-size: .9rem; margin-top: 6px;">
                    Please enter a valid 10-digit mobile number.
                </div>
            </div>

            <div class="wm-form-group">
                <label>Password</label>
                <input
                        type="password"
                        class="wm-input"
                        name="password"
                        placeholder="Password"
                        required>
            </div>
            <div class="wm-form-group">
                <label>Select Role</label>
                <select class="wm-input" name="role" id="role" required>
                    <option value="">Choose Role</option>
                    <c:choose>
                        <c:when test="${not empty roles}">
                            <c:forEach items="${roles}" var="role">
                                <option value="${role}">
                                    ${role}
                                </option>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <option value="ROLE_ADMIN">Admin</option>
                            <option value="ROLE_RETAILER">Retailer</option>
                            <option value="ROLE_DISTRIBUTOR">Distributor</option>
                            <option value="ROLE_DRIVER">Driver</option>
                        </c:otherwise>
                    </c:choose>
                </select>
            </div>
            <button class="wm-login-btn" type="submit">
                Login
            </button>
        </form>
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