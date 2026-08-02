<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String message = request.getParameter("msg"); %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WholeMart | Login</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
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
<div class="badge-top"><i class="bi bi-stars"></i> India's Trusted Wholesale Marketplace</div>
<h1>Grow your business with WholeMart.</h1>
<p>Connect with verified distributors, retailers, suppliers and delivery partners through one intelligent B2B commerce platform.</p>
<div class="feature-grid">
<div class="feature"><div class="feature-icon"><i class="bi bi-patch-check-fill"></i></div><div><h5>Verified Suppliers</h5><p>Trusted and GST verified businesses.</p></div>
</div>
<div class="feature"><div class="feature-icon"><i class="bi bi-truck"></i></div><div><h5>Fast Delivery</h5><p>Reliable logistics across India.</p></div>
</div>
<div class="feature"><div class="feature-icon"><i class="bi bi-graph-up-arrow"></i></div><div><h5>Business Growth</h5><p>Increase sales with AI recommendations.</p></div>
</div>
<div class="feature"><div class="feature-icon"><i class="bi bi-shield-lock"></i></div><div><h5>Secure Platform</h5><p>Protected transactions and secure accounts.</p></div>
</div>
</div>
</aside>
<div class="auth-card">
<div class="auth-header"><h3>Welcome to WholeMart</h3></div>
<ul class="nav nav-pills" id="authTabs">
<li class="nav-item"><button type="button" class="nav-link active" id="tabLogin" data-target="login">Login</button></li>
<li class="nav-item"><button type="button" class="nav-link" id="tabRegister" data-target="register">Register</button></li>
</ul>
<div class="auth-body">
<div class="tab-content mt-4" id="authTabContent">
<!-- LOGIN TAB -->
<div class="tab-pane fade show active" id="login">
<c:if test="${message != null}">
<div class="alert alert-warning alert-dismissible fade show" role="alert"><c:out value="${message}"/><button class="btn-close" data-bs-dismiss="alert"></button></div>
</c:if>
<form action="${pageContext.request.contextPath}/web/auth/login" method="post" class="wm-login-form">
<div class="mb-3">
<label class="form-label">Email or Mobile</label>
<div class="input-group"><span class="input-group-text"><i class="bi bi-envelope"></i></span>
<input type="text" class="form-control" name="email" placeholder="Enter email or mobile number" required>
</div>
</div>
<div class="mb-3">
<label class="form-label">Password</label>
<div class="password-group">
<input type="password" id="loginPassword" class="form-control" name="password" placeholder="Enter your password" required>
<i class="bi bi-eye wm-eye-icon" data-toggle-password="loginPassword"></i>
</div>
</div>
<div class="mb-3">
<label class="form-label">Login As</label>
<select class="form-select" name="role" required>
<option value="" disabled selected>Select your role</option>
<option value="ROLE_ADMIN">Admin</option>
<option value="ROLE_RETAILER">Retailer</option>
<option value="ROLE_DISTRIBUTOR">Distributor</option>
<option value="ROLE_DRIVER">Driver</option>
</select>
</div>
<div class="d-flex justify-content-between align-items-center mb-4">
<div class="form-check"><input class="form-check-input" type="checkbox" id="remember" name="remember"><label class="form-check-label" for="remember">Remember Me</label></div>
<a href="#" class="text-decoration-none fw-semibold">Forgot Password?</a>
</div>
<button class="btn btn-register w-100 py-2 mb-3" id="loginBtn" type="submit"><i class="bi bi-box-arrow-in-right me-2"></i>Login to WholeMart</button>
</form>
<div class="position-relative my-4"><hr><span class="position-absolute top-50 start-50 translate-middle bg-white px-3 text-muted">OR</span></div>
<div class="row g-3">
<div class="col-6"><button type="button" class="btn btn-light border w-100 py-2"><i class="bi bi-google text-danger"></i> Google</button></div>
<div class="col-6"><button type="button" class="btn btn-light border w-100 py-2"><i class="bi bi-facebook text-primary"></i> Facebook</button></div>
</div>
<div class="wm-auth-card-footer"><div class="text-center mt-4"><p class="text-muted mb-0">New to WholeMart? <a href="#" class="fw-bold text-decoration-none wm-show-register">Create Account</a></p></div>
</div>
</div>
<!-- REGISTER TAB -->
<div class="tab-pane fade" id="register">
<form id="registerForm" action="${pageContext.request.contextPath}/web/auth/register" method="post" class="wm-register-form">
<div class="wizard mb-4">
<div class="wizard-step active" id="indicator1"><div class="wizard-circle">1</div><small>Personal</small></div>
<div class="wizard-line"></div>
<div class="wizard-step" id="indicator2"><div class="wizard-circle">2</div><small>Business/Vehicle</small></div>
<div class="wizard-line"></div>
<div class="wizard-step" id="indicator3"><div class="wizard-circle">3</div><small>Address</small></div>
</div>
<!-- Step 1 -->
<div class="register-step active-step" id="step1">
<h5 class="mb-3 fw-bold">Step 1: Personal Information</h5>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">Full Name</label><input type="text" class="form-control" name="fullName" required></div>
<div class="col-md-6 mb-3"><label class="form-label">Mobile Number</label><input type="tel" class="form-control" maxlength="10" name="mobile" required></div>
</div>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">Email Address</label><input type="email" class="form-control" name="email" required></div>
<div class="col-md-6 mb-3">
<label class="form-label">Register As</label>
<select class="form-select" name="role" id="regRoleSelect" required>
<option value="Retailer">Retailer</option>
<option value="Distributor">Distributor</option>
<option value="Driver">Driver</option>
</select>
</div>
</div>
<div class="row">
<div class="col-md-6 mb-3">
<label class="form-label">Password</label>
<div class="password-group">
<input type="password" id="regPassword" class="form-control" name="password" required>
<i class="bi bi-eye wm-eye-icon" data-toggle-password="regPassword"></i>
</div>
<div class="password-strength mt-2"><div id="passwordBar"></div></div>
</div>
<div class="col-md-6 mb-3">
<label class="form-label">Confirm Password</label>
<div class="password-group">
<input type="password" class="form-control" id="regConfirmPassword" name="confirmPassword" required>
<i class="bi bi-eye wm-eye-icon" data-toggle-password="regConfirmPassword"></i>
</div>
</div>
</div>
<div class="text-end mt-3"><button type="button" class="btn btn-register" onclick="validateAndNext(1,2)">Continue <i class="bi bi-arrow-right ms-2"></i></button></div>
</div>
<!-- Step 2 -->
<div class="register-step" id="step2">
<h5 class="fw-bold mb-3" id="step2Title">Step 2: Business / Vehicle Information</h5>
<div id="businessFields">
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">Business/Shop Name</label><input class="form-control" name="businessName"></div>
<div class="col-md-6 mb-3"><label class="form-label">GST Number</label><input class="form-control" name="gstin"></div>
</div>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">Contact Person</label><input class="form-control" name="contactName"></div>
<div class="col-md-6 mb-3"><label class="form-label">Alternate Mobile</label><input class="form-control" name="alternateMobile" maxlength="10"></div>
</div>
</div>
<div id="driverFields" style="display:none;">
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">Driving License Number</label><input class="form-control" name="licenseNumber" placeholder="Enter DL number"></div>
<div class="col-md-6 mb-3"><label class="form-label">Aadhaar Number</label><input class="form-control" name="aadhaarNumber" placeholder="XXXX XXXX XXXX" maxlength="12"></div>
</div>
<div class="row">
<div class="col-md-6 mb-3">
<label class="form-label">Vehicle Type</label>
<select class="form-select" name="vehicleType">
<option value="">Select vehicle type</option>
<option value="Bike">Bike</option><option value="Scooter">Scooter</option>
<option value="Auto">Auto Rickshaw</option><option value="MiniTruck">Mini Truck</option>
<option value="Truck">Truck</option><option value="Van">Van</option>
</select>
</div>
<div class="col-md-6 mb-3"><label class="form-label">Vehicle Number</label><input class="form-control" name="vehicleNumber" placeholder="e.g. MH-01-AB-1234"></div>
</div>
</div>
<div class="d-flex justify-content-between mt-4">
<button type="button" class="btn btn-light border" onclick="goToStep(1)"><i class="bi bi-arrow-left"></i> Back</button>
<button type="button" class="btn btn-register" onclick="validateAndNext(2,3)">Continue <i class="bi bi-arrow-right ms-2"></i></button>
</div>
</div>
<!-- Step 3 -->
<div class="register-step" id="step3">
<h5 class="fw-bold mb-3">Step 3: Address & Verification</h5>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">City</label><input class="form-control" name="city" required></div>
<div class="col-md-6 mb-3"><label class="form-label">State</label><input class="form-control" name="state" required></div>
</div>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">Pincode</label><input class="form-control" name="pincode" required></div>
<div class="col-md-6 mb-3"><label class="form-label">Landmark</label><input class="form-control" name="landmark"></div>
</div>
<div class="row">
<div class="col-12 mb-4"><label class="form-label">Address</label><textarea class="form-control" rows="3" name="addressLine"></textarea></div>
</div>
<div class="row">
<div class="col-12 mb-4">
<div class="form-check">
<input class="form-check-input" type="checkbox" id="agreeTerms" required>
<label class="form-check-label" for="agreeTerms">I agree to the <a href="#">Terms & Conditions</a> and <a href="#">Privacy Policy</a></label>
</div>
</div>
</div>
<div class="d-flex justify-content-between">
<button type="button" class="btn btn-light border" onclick="goToStep(2)"><i class="bi bi-arrow-left"></i> Back</button>
<button type="submit" class="btn btn-register px-5"><i class="bi bi-check-circle me-2"></i> Create Account</button>
</div>
</div>
</form>
</div>
</div>
</div>
</section>
</main>
<%@ include file="/WEB-INF/common/footer.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
(function() {
    var tabLogin = document.getElementById('tabLogin');
    var tabRegister = document.getElementById('tabRegister');
    var loginPane = document.getElementById('login');
    var registerPane = document.getElementById('register');
    var showRegisterLinks = document.querySelectorAll('.wm-show-register');
    function showTab(target) {
        var isLogin = target === 'login';
        if (tabLogin) tabLogin.classList.toggle('active', isLogin);
        if (tabRegister) tabRegister.classList.toggle('active', !isLogin);
        if (loginPane) { loginPane.classList.toggle('show', isLogin); loginPane.classList.toggle('active', isLogin); }
        if (registerPane) { registerPane.classList.toggle('show', !isLogin); registerPane.classList.toggle('active', !isLogin); }
    }
    if (tabLogin) tabLogin.addEventListener('click', function() { showTab('login'); });
    if (tabRegister) tabRegister.addEventListener('click', function() { showTab('register'); });
    for (var i = 0; i < showRegisterLinks.length; i++) {
        showRegisterLinks[i].addEventListener('click', function(e) { e.preventDefault(); showTab('register'); });
    }
    document.querySelectorAll('[data-toggle-password]').forEach(function(icon) {
        icon.addEventListener('click', function() {
            var inputId = icon.getAttribute('data-toggle-password');
            var input = document.getElementById(inputId);
            if (!input) return;
            var isPassword = input.type === 'password';
            input.type = isPassword ? 'text' : 'password';
            icon.classList.toggle('bi-eye-slash', isPassword);
            icon.classList.toggle('bi-eye', !isPassword);
        });
    });
    var loginForm = document.querySelector('.wm-login-form');
    var btn = document.getElementById('loginBtn');
    if (loginForm && btn) {
        loginForm.addEventListener('submit', function() {
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Signing In...';
        });
    }
    var password = document.getElementById('regPassword');
    var bar = document.getElementById('passwordBar');
    if (password && bar) {
        password.addEventListener('keyup', function() {
            var score = 0;
            var v = password.value || '';
            if (v.length >= 8) score++;
            if (/[A-Z]/.test(v)) score++;
            if (/[0-9]/.test(v)) score++;
            if (/[!@#$%^&*]/.test(v)) score++;
            var widths = ['0%','25%','50%','75%','100%'];
            var colors = ['#e9ecef','#dc3545','#ffc107','#17a2b8','#28a745'];
            bar.style.width = widths[score];
            bar.style.backgroundColor = colors[score];
        });
    }
    var regRoleSelect = document.getElementById('regRoleSelect');
    if (regRoleSelect) {
        function toggleDriverFields() {
            var isDriver = regRoleSelect.value === 'Driver';
            document.getElementById('businessFields').style.display = isDriver ? 'none' : '';
            document.getElementById('driverFields').style.display = isDriver ? '' : 'none';
            document.getElementById('step2Title').textContent = isDriver ? 'Step 2: Vehicle & KYC Information' : 'Step 2: Business Information';
        }
        regRoleSelect.addEventListener('change', toggleDriverFields);
        toggleDriverFields();
    }
    window.goToStep = function(step) {
        document.querySelectorAll('.register-step').forEach(function(e) { e.classList.remove('active-step'); });
        var el = document.getElementById('step' + step);
        if (el) el.classList.add('active-step');
        for (var i = 1; i <= 3; i++) {
            var ind = document.getElementById('indicator' + i);
            if (ind) ind.classList.toggle('active', i <= step);
        }
    };
    window.validateAndNext = function(currentStep, nextStep) {
        var container = document.getElementById('step' + currentStep);
        if (!container) return;
        var inputs = container.querySelectorAll('input[required], select[required]');
        var allValid = true;
        inputs.forEach(function(input) {
            if (!input.value.trim()) { allValid = false; input.classList.add('is-invalid'); }
            else { input.classList.remove('is-invalid'); }
        });
        var pwd = document.getElementById('regPassword');
        var cpwd = document.getElementById('regConfirmPassword');
        if (pwd && cpwd && pwd.value !== cpwd.value) { allValid = false; cpwd.classList.add('is-invalid'); }
        else if (cpwd) { cpwd.classList.remove('is-invalid'); }
        if (allValid) { window.goToStep(nextStep); }
    };
})();
</script>
</body>
</html>
