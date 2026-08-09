<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 
String message = request.getParameter("msg"); 
String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><fmt:message key="auth.login_title"/></title>
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
<div class="badge-top"><i class="bi bi-stars"></i> <fmt:message key="hero.badge"/></div>
<h1><fmt:message key="hero.title"/></h1>
<p><fmt:message key="hero.subtitle"/></p>
<div class="feature-grid">
<div class="feature"><div class="feature-icon"><i class="bi bi-patch-check-fill"></i></div><div><h5><fmt:message key="sec.role_access"/></h5><p><fmt:message key="sec.role_access_desc"/></p></div>
</div>
<div class="feature"><div class="feature-icon"><i class="bi bi-truck"></i></div><div><h5><fmt:message key="feat.delivery_title"/></h5><p><fmt:message key="feat.delivery_desc"/></p></div>
</div>
<div class="feature"><div class="feature-icon"><i class="bi bi-graph-up-arrow"></i></div><div><h5><fmt:message key="feat.bi_title"/></h5><p><fmt:message key="feat.bi_desc"/></p></div>
</div>
<div class="feature"><div class="feature-icon"><i class="bi bi-shield-lock"></i></div><div><h5><fmt:message key="sec.title"/></h5><p><fmt:message key="sec.subtitle"/></p></div>
</div>
</div>
</aside>
<div class="auth-card">
<div class="auth-header mb-3"><h3><fmt:message key="auth.welcome_back"/></h3><p class="text-muted mb-0 mt-2"><fmt:message key="auth.please_sign_in"/></p></div>
<ul class="nav nav-pills wm-auth-pills mb-3" id="authTabs">
<li class="nav-item"><button type="button" class="nav-link active" id="tabLogin" data-target="login"><fmt:message key="nav.login"/></button></li>
<li class="nav-item"><button type="button" class="nav-link" id="tabRegister" data-target="register"><fmt:message key="nav.register"/></button></li>
</ul>
<div class="auth-body">
<div class="tab-content mt-4" id="authTabContent">
<!-- LOGIN TAB -->
<div class="tab-pane fade show active" id="login">
<% if (error != null && !error.isEmpty()) { %>
<div class="alert alert-danger alert-dismissible fade show d-flex align-items-center gap-2 mb-3 shadow-sm border-danger border-opacity-25" role="alert">
  <i class="bi bi-exclamation-triangle-fill fs-5 text-danger flex-shrink-0"></i>
  <div><strong><fmt:message key="auth.login_failed"/>:</strong> <%= error %></div>
  <button class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } %>
<% if (message != null && !message.isEmpty()) { %>
<div class="alert alert-info alert-dismissible fade show d-flex align-items-center gap-2 mb-3 shadow-sm border-info border-opacity-25" role="alert">
  <i class="bi bi-info-circle-fill fs-5 text-info flex-shrink-0"></i>
  <div><%= message %></div>
  <button class="btn-close ms-auto" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
<% } %>
<form action="${pageContext.request.contextPath}/web/auth/login" method="post" class="wm-login-form">
<div class="mb-3">
<label class="form-label"><fmt:message key="auth.username"/></label>
<div class="input-group"><span class="input-group-text"><i class="bi bi-envelope"></i></span>
<input type="text" class="form-control" name="email" placeholder="<fmt:message key="auth.username"/>" required>
</div>
</div>
<div class="mb-3">
<label class="form-label"><fmt:message key="auth.password"/></label>
<div class="password-group">
<input type="password" id="loginPassword" class="form-control" name="password" placeholder="<fmt:message key="auth.password"/>" required>
<i class="bi bi-eye wm-eye-icon" data-toggle-password="loginPassword"></i>
</div>
</div>
<div class="mb-3">
<label class="form-label"><fmt:message key="auth.select_role"/></label>
<select class="form-select" name="role" required>
<option value="" disabled selected><fmt:message key="auth.select_role"/></option>
<option value="ROLE_ADMIN"><fmt:message key="auth.admin"/></option>
<option value="ROLE_RETAILER"><fmt:message key="auth.retailer"/></option>
<option value="ROLE_DISTRIBUTOR"><fmt:message key="auth.distributor"/></option>
<option value="ROLE_DRIVER"><fmt:message key="auth.driver"/></option>
</select>
</div>
<div class="d-flex justify-content-between align-items-center mb-4">
<div class="form-check"><input class="form-check-input" type="checkbox" id="remember" name="remember"><label class="form-check-label" for="remember"><fmt:message key="auth.remember_me"/></label></div>
<a href="#" class="text-decoration-none fw-semibold"><fmt:message key="auth.forgot_password"/></a>
</div>
<button class="btn btn-register w-100 py-2 mb-3" id="loginBtn" type="submit"><i class="bi bi-box-arrow-in-right me-2"></i><fmt:message key="nav.login"/></button>
</form>
<div class="position-relative my-4"><hr><span class="position-absolute top-50 start-50 translate-middle bg-white px-3 text-muted"><fmt:message key="auth.or"/></span></div>
<div class="row g-2">
<div class="col-12"><a href="${pageContext.request.contextPath}/web/auth/google?action=login" class="btn btn-outline-dark w-100 py-2 d-flex align-items-center justify-content-center gap-2 fw-semibold"><i class="bi bi-google text-danger fs-5"></i> <fmt:message key="auth.google_login"/></a></div>
</div>
<div class="wm-auth-card-footer"><div class="text-center mt-4"><p class="text-muted mb-0"><fmt:message key="auth.new_user"/> <a href="#" class="fw-bold text-decoration-none wm-show-register"><fmt:message key="auth.create_account"/></a></p></div>
</div>
</div>
<!-- REGISTER TAB -->
<div class="tab-pane fade" id="register">
<div class="mb-3">
<a href="${pageContext.request.contextPath}/web/auth/google?action=register" class="btn btn-outline-dark w-100 py-2 d-flex align-items-center justify-content-center gap-2 fw-semibold"><i class="bi bi-google text-danger fs-5"></i> <fmt:message key="auth.google_register"/></a>
<div class="position-relative my-3"><hr><span class="position-absolute top-50 start-50 translate-middle bg-white px-3 text-muted" style="font-size:0.8rem;"><fmt:message key="auth.or"/></span></div>
</div>
<form id="registerForm" action="${pageContext.request.contextPath}/web/auth/register" method="post" class="wm-register-form">
<div class="wizard mb-4">
<div class="wizard-step active" id="indicator1"><div class="wizard-circle">1</div><small><fmt:message key="auth.personal_info"/></small></div>
<div class="wizard-line"></div>
<div class="wizard-step" id="indicator2"><div class="wizard-circle">2</div><small><fmt:message key="auth.business_info"/></small></div>
<div class="wizard-line"></div>
<div class="wizard-step" id="indicator3"><div class="wizard-circle">3</div><small><fmt:message key="table.address"/></small></div>
</div>
<!-- Step 1 -->
<div class="register-step active-step" id="step1">
<h5 class="mb-3 fw-bold">Step 1: <fmt:message key="auth.personal_info"/></h5>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label"><fmt:message key="table.name"/></label><input type="text" class="form-control" name="fullName" required></div>
<div class="col-md-6 mb-3"><label class="form-label"><fmt:message key="table.phone"/></label><input type="tel" class="form-control" maxlength="10" name="mobile" required></div>
</div>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label"><fmt:message key="auth.email"/></label><input type="email" class="form-control" name="email" required></div>
<div class="col-md-6 mb-3">
<label class="form-label"><fmt:message key="auth.select_role"/></label>
<select class="form-select" name="role" id="regRoleSelect" required>
<option value="Retailer"><fmt:message key="auth.retailer"/></option>
<option value="Distributor"><fmt:message key="auth.distributor"/></option>
<option value="Driver"><fmt:message key="auth.driver"/></option>
</select>
</div>
</div>
<div class="row">
<div class="col-md-6 mb-3">
<label class="form-label"><fmt:message key="auth.password"/></label>
<div class="password-group">
<input type="password" id="regPassword" class="form-control" name="password" required>
<i class="bi bi-eye wm-eye-icon" data-toggle-password="regPassword"></i>
</div>
<div class="password-strength mt-2"><div id="passwordBar"></div></div>
</div>
<div class="col-md-6 mb-3">
<label class="form-label"><fmt:message key="auth.password"/></label>
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
<h5 class="fw-bold mb-3" id="step2Title">Step 2: <fmt:message key="auth.business_info"/></h5>
<div id="businessFields">
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">Shop/Business Name</label><input class="form-control" name="businessName"></div>
<div class="col-md-6 mb-3"><label class="form-label">GSTIN / Trade License</label><input class="form-control" name="gstin"></div>
</div>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label"><fmt:message key="table.name"/></label><input class="form-control" name="contactName"></div>
<div class="col-md-6 mb-3"><label class="form-label"><fmt:message key="table.phone"/></label><input class="form-control" name="alternateMobile" maxlength="10"></div>
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
<div class="col-md-6 mb-3"><label class="form-label"><fmt:message key="table.vehicle"/></label><input class="form-control" name="vehicleNumber" placeholder="e.g. MH-01-AB-1234"></div>
</div>
</div>
<div class="d-flex justify-content-between mt-4">
<button type="button" class="btn btn-light border" onclick="goToStep(1)"><i class="bi bi-arrow-left"></i> <fmt:message key="btn.back"/></button>
<button type="button" class="btn btn-register" onclick="validateAndNext(2,3)">Continue <i class="bi bi-arrow-right ms-2"></i></button>
</div>
</div>
<!-- Step 3 -->
<div class="register-step" id="step3">
<h5 class="fw-bold mb-3">Step 3: <fmt:message key="table.address"/></h5>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">City</label><input class="form-control" name="city" required></div>
<div class="col-md-6 mb-3"><label class="form-label">State</label><input class="form-control" name="state" required></div>
</div>
<div class="row">
<div class="col-md-6 mb-3"><label class="form-label">Pincode</label><input class="form-control" name="pincode" required></div>
<div class="col-md-6 mb-3"><label class="form-label">Landmark</label><input class="form-control" name="landmark"></div>
</div>
<div class="row">
<div class="col-12 mb-4"><label class="form-label"><fmt:message key="table.address"/></label><textarea class="form-control" rows="3" name="addressLine"></textarea></div>
</div>
<div class="row">
<div class="col-12 mb-4">
<div class="form-check">
<input class="form-check-input" type="checkbox" id="agreeTerms" required>
<label class="form-check-label" for="agreeTerms">I agree to Terms & Conditions</label>
</div>
</div>
</div>
<div class="d-flex justify-content-between">
<button type="button" class="btn btn-light border" onclick="goToStep(2)"><i class="bi bi-arrow-left"></i> <fmt:message key="btn.back"/></button>
<button type="submit" class="btn btn-register" id="finalSubmitBtn"><i class="bi bi-check2-circle me-2"></i><fmt:message key="auth.create_account"/></button>
</div>
</div>
</form>
<div class="wm-auth-card-footer"><div class="text-center mt-4"><p class="text-muted mb-0"><fmt:message key="auth.already_user"/> <a href="#" class="fw-bold text-decoration-none wm-show-login"><fmt:message key="auth.login_here"/></a></p></div>
</div>
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
<script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>
