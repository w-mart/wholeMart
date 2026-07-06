<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="wm-auth-container">

    <div class="wm-auth-card">

        <button type="button" class="wm-close-btn">&times;</button>

        <div class="wm-brand">

            <div class="wm-logo">
                W
            </div>

            <h2>WholeMart</h2>

            <p>Local B2B AI Marketplace</p>

        </div>

        <form method="post"
              action="${pageContext.request.contextPath}/web/main/auth/login">

            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}" />

            <div class="wm-form-group">

                <label>Username / Email</label>

                <input
                        type="text"
                        class="wm-input"
                        name="username"
                        placeholder="Username, Email or Mobile"
                        required>

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

                <select class="wm-input" name="role" required>

                    <option value="">Choose Role</option>

                    <option value="admin">Admin</option>

                    <option value="retailer">Retailer</option>

                    <option value="distributor">Distributor</option>

                    <option value="driver">Driver</option>

                </select>

            </div>

            <button class="wm-login-btn" type="submit">
                Login
            </button>

        </form>

    </div>

</div>