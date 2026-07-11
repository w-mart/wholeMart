<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String message = request.getParameter("msg");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WholeMart | Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <!-- Using fonts from home.css for consistency -->
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600;700&family=IBM+Plex+Mono:wght@500;600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
</head>
<body>

<%@ include file="/WEB-INF/common/header.jsp" %>

<main class="wm-auth-page">
    <section>
        <div class="container">
            <div class="wm-auth-layout">

                <aside class="wm-auth-left">
                    <div class="badge-top">
                        <i class="bi bi-stars"></i>
                        India's Trusted Wholesale Marketplace
                    </div>

                    <h1>Grow your business with WholeMart.</h1>

                    <p>
                        Connect with verified distributors, retailers, suppliers and delivery partners
                        through one intelligent B2B commerce platform.
                    </p>

                    <div class="feature-grid">
                        <div class="feature">
                            <div class="feature-icon"><i class="bi bi-patch-check-fill"></i></div>
                            <div>
                                <h5>Verified Suppliers</h5>
                                <p>Trusted and GST verified businesses.</p>
                            </div>
                        </div>
                        <div class="feature">
                            <div class="feature-icon"><i class="bi bi-truck"></i></div>
                            <div>
                                <h5>Fast Delivery</h5>
                                <p>Reliable logistics across India.</p>
                            </div>
                        </div>
                        <div class="feature">
                            <div class="feature-icon"><i class="bi bi-graph-up-arrow"></i></div>
                            <div>
                                <h5>Business Growth</h5>
                                <p>Increase sales with AI recommendations.</p>
                            </div>
                        </div>
                        <div class="feature">
                            <div class="feature-icon"><i class="bi bi-shield-lock"></i></div>
                            <div>
                                <h5>Secure Platform</h5>
                                <p>Protected transactions and secure accounts.</p>
                            </div>
                        </div>
                    </div>
                </aside>

                <div class="auth-card">
                    <div class="auth-header">                       
                        <h3>Welcome to WholeMart</h3>
                    </div>

                    <ul class="nav nav-pills" id="authTabs">
                        <li class="nav-item">
                            <button type="button" class="nav-link active" id="tabLogin" data-target="login">Login</button>
                        </li>
                        <li class="nav-item">
                            <button type="button" class="nav-link" id="tabRegister" data-target="register">Register</button>
                        </li>
                    </ul>

                    <div class="auth-body">
                        <div class="tab-content mt-4" id="authTabContent">

                            <!-- LOGIN -->
                            <div class="tab-pane fade show active" id="login">
                                <c:if test="${message != null}">
                                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                        <c:out value="${message}"/>
                                        <button class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <form action="${pageContext.request.contextPath}/web/auth/login" method="post" class="wm-login-form">

                                    <div class="mb-4">
                                        <label class="form-label">Email Address</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <i class="bi bi-envelope"></i>
                                            </span>
                                            <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Password</label>
                                        <div class="password-group">
                                            <input type="password" id="loginPassword" class="form-control" name="password" placeholder="Enter your password" required>
                                            <i class="bi bi-eye wm-eye-icon" data-toggle-password="loginPassword" aria-hidden="true"></i>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Login As</label>
                                        <select class="form-select" name="role" required>
                                            <option value="" disabled selected>Select your role</option>
                                            <option value="Admin">Admin</option>
                                            <option value="Retailer">Retailer</option>
                                            <option value="Distributor">Distributor</option>
                                            <option value="Driver">Driver</option>
                                        </select>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="remember" name="remember">
                                            <label class="form-check-label" for="remember">Remember Me</label>
                                        </div>
                                        <a href="#" class="text-decoration-none fw-semibold">Forgot Password?</a>
                                    </div>

                                    <button class="btn btn-register w-100 py-2 mb-3" id="loginBtn" type="submit">
                                        <i class="bi bi-box-arrow-in-right me-2"></i>
                                        Login to WholeMart
                                    </button>

                                </form>

                                <div class="position-relative my-4">
                                    <hr>
                                    <span class="position-absolute top-50 start-50 translate-middle bg-white px-3 text-muted">OR</span>
                                </div>

                                <div class="row g-3">
                                    <div class="col-6">
                                        <button type="button" class="btn btn-light border w-100 py-2">
                                            <i class="bi bi-google text-danger"></i>
                                            Google
                                        </button>
                                    </div>
                                    <div class="col-6">
                                        <button type="button" class="btn btn-light border w-100 py-2">
                                            <i class="bi bi-facebook text-primary"></i>
                                            Facebook
                                        </button>
                                    </div>
                                </div>

                                <div class="text-center mt-4">
                                    <p class="text-muted mb-0">
                                        New to WholeMart?
                                        <a href="#" class="fw-bold text-decoration-none wm-show-register" role="button">Create Account</a>
                                    </p>
                                </div>
                            </div>

                            <!-- REGISTER -->
                            <div class="tab-pane fade" id="register">
                                <form id="registerForm" action="${pageContext.request.contextPath}/web/auth/register" method="post" class="wm-register-form">

                                    <div class="wizard mb-4">
                                        <div class="wizard-step active" id="indicator1">
                                            <div class="wizard-circle">1</div>
                                            <small>Personal</small>
                                        </div>
                                        <div class="wizard-line"></div>
                                        <div class="wizard-step" id="indicator2">
                                            <div class="wizard-circle">2</div>
                                            <small>Business</small>
                                        </div>
                                        <div class="wizard-line"></div>
                                        <div class="wizard-step" id="indicator3">
                                            <div class="wizard-circle">3</div>
                                            <small>Finish</small>
                                        </div>
                                    </div>

                                    <div class="register-step active-step" id="step1">
                                        <h5 class="mb-3 fw-bold">Step 1: Personal Information</h5>

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Full Name</label>
                                                <input type="text" class="form-control" name="fullName" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Mobile Number</label>
                                                <input type="tel" class="form-control" maxlength="10" name="mobile" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Email Address</label>
                                                <input type="email" class="form-control" name="email" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Register As</label>
                                                <select class="form-select" name="role" required>
                                                    <option value="Retailer">Retailer</option>
                                                    <option value="Distributor">Distributor</option>
                                                    <option value="Driver">Driver</option>
                                                </select>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Password</label>
                                                <div class="password-group">
                                                    <input type="password" id="regPassword" class="form-control" name="password" required>
                                                    <i class="bi bi-eye wm-eye-icon" data-toggle-password="regPassword" aria-hidden="true"></i>
                                                </div>
                                                <div class="password-strength mt-2">
                                                    <div id="passwordBar"></div>
                                                </div>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Confirm Password</label>
                                                <div class="password-group">
                                                    <input type="password" class="form-control" id="regConfirmPassword" name="confirmPassword" required>
                                                    <i class="bi bi-eye wm-eye-icon" data-toggle-password="regConfirmPassword" aria-hidden="true"></i>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="text-end">
                                            <button type="button" class="btn btn-register" onclick="validateAndNext(1, 2)">
                                                Continue <i class="bi bi-arrow-right ms-2"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="register-step" id="step2">
                                        <h5 class="fw-bold mb-3">Step 2: Business Information</h5>

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Business Name</label>
                                                <input class="form-control" name="businessName" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">GST Number</label>
                                                <input class="form-control" name="gstin" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Contact Person</label>
                                                <input class="form-control" name="contactName" required>
                                            </div>

                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Alternate Mobile</label>
                                                <input class="form-control" name="alternateMobile" maxlength="10" title="Enter a 10-digit mobile number">
                                            </div>
                                        </div>

                                        <div class="d-flex justify-content-between">
                                            <button type="button" class="btn btn-light border" onclick="goToStep(1)">
                                                <i class="bi bi-arrow-left"></i> Back
                                            </button>
                                            <button type="button" class="btn btn-register" onclick="validateAndNext(2, 3)">
                                                Continue <i class="bi bi-arrow-right ms-2"></i>
                                            </button>
                                        </div>
                                    </div>

                                    <div class="register-step" id="step3">
                                        <h5 class="fw-bold mb-3">Step 3: Address & Verification</h5>

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">City</label>
                                                <input class="form-control" name="city" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">State</label>
                                                <input class="form-control" name="state" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Pincode</label>
                                                <input class="form-control" name="pincode" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Landmark</label>
                                                <input class="form-control" name="landmark" required>
                                            </div>
                                            <div class="col-12 mb-4">
                                                <label class="form-label">Business Address</label>
                                                <textarea class="form-control" rows="3" name="addressLine"></textarea>
                                            </div>
                                        </div>

                                        <div class="form-check mb-4">
                                            <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                            <label class="form-check-label" for="agreeTerms">
                                                I agree to the <a href="#">Terms & Conditions</a> and <a href="#">Privacy Policy</a>
                                            </label>
                                        </div>

                                        <div class="d-flex justify-content-between">
                                            <button type="button" class="btn btn-light border" onclick="goToStep(2)">
                                                <i class="bi bi-arrow-left"></i> Back
                                            </button>
                                            <button type="submit" class="btn btn-register px-5">
                                                <i class="bi bi-check-circle me-2"></i> Create Account
                                            </button>
                                        </div>
                                    </div>

                                </form>
                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
</main>

<%@ include file="/WEB-INF/common/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
(function () {
    const tabLogin = document.getElementById('tabLogin');
    const tabRegister = document.getElementById('tabRegister');
    const loginPane = document.getElementById('login');
    const registerPane = document.getElementById('register');
    const showRegisterLinks = document.querySelectorAll('.wm-show-register');

    function showTab(target) {
        const isLogin = target === 'login';
        tabLogin && tabLogin.classList.toggle('active', isLogin);
        tabRegister && tabRegister.classList.toggle('active', !isLogin);

        loginPane && loginPane.classList.toggle('show', isLogin);
        loginPane && loginPane.classList.toggle('active', isLogin);

        registerPane && registerPane.classList.toggle('show', !isLogin);
        registerPane && registerPane.classList.toggle('active', !isLogin);
    }

    tabLogin && tabLogin.addEventListener('click', () => showTab('login'));
    tabRegister && tabRegister.addEventListener('click', () => showTab('register'));
    showRegisterLinks.forEach(a => a.addEventListener('click', (e) => { e.preventDefault(); showTab('register'); }));

    // Password toggle
    document.querySelectorAll('[data-toggle-password]').forEach(function (icon) {
        icon.addEventListener('click', function () {
            const inputId = icon.getAttribute('data-toggle-password');
            const input = document.getElementById(inputId);
            if (!input) return;

            const isCurrentlyPassword = input.type === 'password';
            input.type = isCurrentlyPassword ? 'text' : 'password';

            icon.classList.toggle('bi-eye-slash', isCurrentlyPassword);
            icon.classList.toggle('bi-eye', !isCurrentlyPassword);
        });
    });

    // Login submit spinner
    const loginForm = document.querySelector('.wm-login-form');
    const btn = document.getElementById('loginBtn');
    if (loginForm && btn) {
        loginForm.addEventListener('submit', function () {
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Signing In...';
        });
    }

    // Password strength (registration)
    const password = document.getElementById('regPassword');
    const bar = document.getElementById('passwordBar');
    if (password && bar) {
        password.addEventListener('keyup', function () {
            let score = 0;
            const value = password.value || '';

            if (value.length >= 8) score++;
            if (/[A-Z]/.test(value)) score++;
            if (/[0-9]/.test(value)) score++;
            if (/[!@#$%^&*]/.test(value)) score++;

            const widths = ['0%', '25%', '50%', '75%', '100%'];
            const colors = ['#e9ecef', '#dc3545', '#ffc107', '#17a2b8', '#28a745'];
            bar.style.width = widths[score];
            bar.style.backgroundColor = colors[score];
        });
    }

    // Pre-select role on login form from URL param
    const loginRoleSelect = document.querySelector('#login select[name="role"]');
    const urlParamsForLogin = new URLSearchParams(window.location.search);
    const roleForLogin = urlParamsForLogin.get('role');
    if (roleForLogin && loginRoleSelect) {
        loginRoleSelect.value = roleForLogin.charAt(0).toUpperCase() + roleForLogin.slice(1);
    }

    // Multi-step register
    window.goToStep = function (step) {
        document.querySelectorAll('.register-step').forEach(function (e) {
            e.classList.remove('active-step');
        });
        const el = document.getElementById('step' + step);
        if (el) el.classList.add('active-step');
        updateIndicator(step);
    }

    window.validateAndNext = function(currentStep, nextStep) {
        const stepContainer = document.getElementById('step' + currentStep);
        if (!stepContainer) return;

        const inputs = stepContainer.querySelectorAll('input[required], select[required]');
        let allValid = true;

        inputs.forEach(input => {
            if (!input.value.trim()) {
                allValid = false;
                input.classList.add('is-invalid');
            } else {
                input.classList.remove('is-invalid');
            }
        });

        const password = document.getElementById('regPassword');
        const confirmPassword = document.getElementById('regConfirmPassword');
        if (password && confirmPassword && password.value !== confirmPassword.value) {
            allValid = false;
            confirmPassword.classList.add('is-invalid');
        } else if (confirmPassword) {
            confirmPassword.classList.remove('is-invalid');
        }

        if (allValid) {
            goToStep(nextStep);
        }
    }

    function updateIndicator(step) {
        document.querySelectorAll('.wizard-step').forEach(function (e) {
            e.classList.remove('active');
        });
        for (let i = 1; i <= step; i++) {
            const ind = document.getElementById('indicator' + i);
            if (ind) ind.classList.add('active');
        }
    }

    // Handle query param for role
    const urlParams = new URLSearchParams(window.location.search);
    const role = urlParams.get('role');
    if (role) {
        const roleSelect = document.querySelector('select[name="role"]');
        if (roleSelect) {
            roleSelect.value = role.charAt(0).toUpperCase() + role.slice(1);
        }
    }
})();
</script>

</body>
</html>
