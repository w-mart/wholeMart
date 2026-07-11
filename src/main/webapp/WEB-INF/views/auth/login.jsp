<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

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

<style>

:root{

--primary:#8C5E3C;
--primary-dark:#6D472B;

--secondary:#F8F5F1;

--card:#ffffff;

--border:#e8e8e8;

--text:#212529;

--muted:#6c757d;

--shadow:0 20px 60px rgba(0,0,0,.08);

--radius:22px;

}

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Inter',sans-serif;
}

body{

background:

radial-gradient(circle at top left,#FFF7EF 0%,transparent 35%),

radial-gradient(circle at bottom right,#F7F1E7 0%,transparent 30%),

#FAFAFA;

min-height:100vh;

display:flex;

flex-direction:column;

}

/*==========================
HEADER
===========================*/

.wm-header{

height:72px;

background:#fff;

border-bottom:1px solid #ececec;

position:sticky;

top:0;

z-index:1000;

}

.wm-navbar{

max-width:1400px;

margin:auto;

height:72px;

display:flex;

align-items:center;

justify-content:space-between;

padding:0 25px;

}

.logo{

display:flex;

align-items:center;

gap:12px;

font-weight:800;

font-size:24px;

color:var(--primary);

}

.logo-icon{

width:48px;

height:48px;

border-radius:14px;

background:linear-gradient(135deg,#A66A43,#8C5E3C);

display:flex;

align-items:center;

justify-content:center;

color:#fff;

font-size:22px;

}

.search-box{

width:420px;

position:relative;

}

.search-box input{

width:100%;

padding:13px 18px 13px 48px;

border-radius:50px;

border:1px solid var(--border);

background:#fafafa;

transition:.3s;

}

.search-box input:focus{

outline:none;

border-color:var(--primary);

box-shadow:0 0 0 4px rgba(140,94,60,.1);

}

.search-box i{

position:absolute;

left:18px;

top:14px;

color:#999;

}

.header-btns{

display:flex;

gap:12px;

}

.btn-login{

border-radius:50px;

padding:10px 22px;

font-weight:600;

}

.btn-register{

border-radius:50px;

padding:10px 24px;

background:var(--primary);

color:white;

font-weight:600;

}

.btn-register:hover{

background:var(--primary-dark);

color:white;

}

/*==========================
HERO
===========================*/

.hero{

flex:1;

padding:60px 20px;

}

.hero-container{

max-width:1380px;

margin:auto;

display:grid;

grid-template-columns:1fr 620px;

gap:45px;

align-items:center;

}

.left-panel{

padding-right:40px;

}

.badge-top{

display:inline-flex;

gap:8px;

align-items:center;

padding:10px 18px;

background:#fff;

border-radius:50px;

border:1px solid #eee;

font-weight:600;

margin-bottom:25px;

box-shadow:0 8px 25px rgba(0,0,0,.05);

}

.left-panel h1{

font-size:56px;

font-weight:800;

line-height:1.1;

margin-bottom:20px;

}

.left-panel p{

font-size:18px;

color:#666;

line-height:1.8;

margin-bottom:35px;

}

.feature-grid{

display:grid;

grid-template-columns:repeat(2,1fr);

gap:18px;

}

.feature{

background:#fff;

padding:22px;

border-radius:18px;

box-shadow:0 12px 35px rgba(0,0,0,.05);

display:flex;

gap:18px;

align-items:flex-start;

transition:.3s;

}

.feature:hover{

transform:translateY(-5px);

}

.feature-icon{

width:54px;

height:54px;

border-radius:14px;

background:#F5EEE6;

display:flex;

align-items:center;

justify-content:center;

color:var(--primary);

font-size:24px;

}

.feature h5{

font-weight:700;

margin-bottom:5px;

}

.feature p{

margin:0;

font-size:14px;

color:#777;

line-height:1.5;

}

/*==========================
AUTH CARD
===========================*/

.auth-card{

background:white;

border-radius:26px;

box-shadow:var(--shadow);

overflow:hidden;

}

.auth-header{

padding:35px;

border-bottom:1px solid #eee;

}

.auth-header h3{

font-weight:800;

margin-bottom:8px;

}

.auth-header p{

margin:0;

color:#777;

}

.nav-pills{

padding:20px 30px 0;

gap:10px;

}

.nav-pills .nav-link{

border-radius:50px;

padding:12px 25px;

font-weight:600;

color:#666;

}

.nav-pills .nav-link.active{

background:var(--primary);

}

.auth-body{

padding:35px;

}

.form-control,

.form-select{

height:54px;

border-radius:14px;

border:1px solid #ddd;

background:#fafafa;

}

.form-control:focus,

.form-select:focus{

box-shadow:0 0 0 4px rgba(140,94,60,.12);

border-color:var(--primary);

background:white;

}

.form-label{

font-weight:600;

margin-bottom:8px;

}

.password-group{

position:relative;

}

.password-group i{

position:absolute;

right:18px;

top:17px;

cursor:pointer;

color:#777;

}

/* Responsive */

@media(max-width:1200px){

.hero-container{

grid-template-columns:1fr;

}

.left-panel{

padding-right:0;

}

.search-box{

display:none;

}

}

@media(max-width:768px){

.left-panel h1{

font-size:38px;

}

.feature-grid{

grid-template-columns:1fr;

}

.wm-navbar{

padding:0 15px;

}

}

</style>

</head>

<body>

<header class="wm-header">

<div class="wm-navbar">

<div class="logo">

<div class="logo-icon">

<i class="bi bi-shop"></i>

</div>

WholeMart

</div>

<div class="search-box">

<i class="bi bi-search"></i>

<input type="text" placeholder="Search products, suppliers...">

</div>

<div class="header-btns">

<button class="btn btn-light btn-login">
Login
</button>

<button class="btn btn-register">
Register
</button>

</div>

</div>

</header>

<section class="hero">

<div class="hero-container">

<!-- LEFT -->

<div class="left-panel">

<div class="badge-top">

<i class="bi bi-stars"></i>

India's Trusted Wholesale Marketplace

</div>

<h1>

Grow your business with WholeMart.

</h1>

<p>

Connect with verified distributors, retailers, suppliers and delivery partners
through one intelligent B2B commerce platform.

</p>

<div class="feature-grid">

<div class="feature">

<div class="feature-icon">

<i class="bi bi-patch-check-fill"></i>

</div>

<div>

<h5>Verified Suppliers</h5>

<p>Trusted and GST verified businesses.</p>

</div>

</div>

<div class="feature">

<div class="feature-icon">

<i class="bi bi-truck"></i>

</div>

<div>

<h5>Fast Delivery</h5>

<p>Reliable logistics across India.</p>

</div>

</div>

<div class="feature">

<div class="feature-icon">

<i class="bi bi-graph-up-arrow"></i>

</div>

<div>

<h5>Business Growth</h5>

<p>Increase sales with AI recommendations.</p>

</div>

</div>

<div class="feature">

<div class="feature-icon">

<i class="bi bi-shield-lock"></i>

</div>

<div>

<h5>Secure Platform</h5>

<p>Protected transactions and secure accounts.</p>

</div>

</div>

</div>

</div>

<!-- RIGHT -->

<div class="auth-card">

<div class="auth-header">

<h3>Welcome Back 👋</h3>

<p>Login or create your WholeMart account.</p>

</div>

<ul class="nav nav-pills" id="authTabs">

<li class="nav-item">

<button class="nav-link active">

Login

</button>

</li>

<li class="nav-item">

<button class="nav-link">

Register

</button>

</li>

</ul>

<div class="auth-body">

<!-- PART 2 STARTS HERE -->
<!-- ==========================
     LOGIN TAB
========================== -->

<div class="tab-content mt-4" id="authTabContent">

    <!-- LOGIN -->
    <div class="tab-pane fade show active" id="login">

        <% if(message!=null){ %>
        <div class="alert alert-warning alert-dismissible fade show">
            <%=message%>
            <button class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <% } %>

        <form action="login" method="post">

            <!-- Email -->

            <div class="mb-4">

                <label class="form-label">
                    Email Address
                </label>

                <div class="input-group">

                    <span class="input-group-text bg-white">
                        <i class="bi bi-envelope"></i>
                    </span>

                    <input
                            type="email"
                            class="form-control"
                            name="email"
                            placeholder="Enter your email"
                            required>

                </div>

            </div>

            <!-- Password -->

            <div class="mb-3">

                <label class="form-label">
                    Password
                </label>

                <div class="password-group">

                    <input
                            type="password"
                            id="loginPassword"
                            class="form-control"
                            name="password"
                            placeholder="Enter your password"
                            required>

                    <i class="bi bi-eye"
                       onclick="togglePassword('loginPassword',this)">
                    </i>

                </div>

            </div>

            <!-- Remember -->

            <div class="d-flex justify-content-between align-items-center mb-4">

                <div class="form-check">

                    <input class="form-check-input"
                           type="checkbox"
                           id="remember">

                    <label class="form-check-label"
                           for="remember">

                        Remember Me

                    </label>

                </div>

                <a href="forgot-password.jsp"
                   class="text-decoration-none fw-semibold">

                    Forgot Password?

                </a>

            </div>

            <!-- Login Button -->

            <button
                    class="btn btn-register w-100 py-3 mb-3"
                    id="loginBtn">

                <i class="bi bi-box-arrow-in-right me-2"></i>

                Login to WholeMart

            </button>

        </form>

        <!-- Divider -->

        <div class="position-relative my-4">

            <hr>

            <span
                    class="position-absolute top-50 start-50 translate-middle bg-white px-3 text-muted">

                OR

            </span>

        </div>

        <!-- Social Buttons -->

        <div class="row g-3">

            <div class="col-6">

                <button
                        class="btn btn-light border w-100 py-3">

                    <i class="bi bi-google text-danger"></i>

                    Google

                </button>

            </div>

            <div class="col-6">

                <button
                        class="btn btn-light border w-100 py-3">

                    <i class="bi bi-facebook text-primary"></i>

                    Facebook

                </button>

            </div>

        </div>

        <!-- Bottom Text -->

        <div class="text-center mt-4">

            <p class="text-muted mb-0">

                New to WholeMart?

                <a href="#"
                   class="fw-bold text-decoration-none"
                   onclick="showRegister()">

                    Create Account

                </a>

            </p>

        </div>

    </div>

    <!-- ==========================
         REGISTER TAB STARTS HERE
         (Part 3)
    ========================== -->

    <div class="tab-pane fade"
         id="register">
<form id="registerForm" action="register" method="post">

    <!-- ==========================
         STEP INDICATOR
    ========================== -->

    <div class="wizard mb-5">

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


    <!-- ======================================================
                    STEP 1
    ======================================================= -->

    <div class="register-step active-step" id="step1">

        <h5 class="mb-4 fw-bold">
            Personal Information
        </h5>

        <div class="row">

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    Full Name
                </label>

                <input
                        type="text"
                        class="form-control"
                        name="fullName"
                        required>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    Mobile Number
                </label>

                <input
                        type="tel"
                        class="form-control"
                        maxlength="10"
                        name="mobile"
                        required>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    Email Address
                </label>

                <input
                        type="email"
                        class="form-control"
                        name="email"
                        required>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    Register As
                </label>

                <select
                        class="form-select"
                        name="role">

                    <option value="Retailer">Retailer</option>
                    <option value="Distributor">Distributor</option>
                    <option value="Driver">Driver</option>

                </select>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    Password
                </label>

                <div class="password-group">

                    <input
                            type="password"
                            id="regPassword"
                            class="form-control"
                            required>

                    <i class="bi bi-eye"
                       onclick="togglePassword('regPassword',this)">
                    </i>

                </div>

                <div class="password-strength mt-2">

                    <div id="passwordBar"></div>

                </div>

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    Confirm Password
                </label>

                <div class="password-group">

                    <input
                            type="password"
                            class="form-control"
                            name="password"
                            required>

                    <i class="bi bi-eye"></i>

                </div>

            </div>

        </div>

        <div class="text-end">

            <button
                    type="button"
                    class="btn btn-register"
                    onclick="nextStep(2)">

                Continue
                <i class="bi bi-arrow-right ms-2"></i>

            </button>

        </div>

    </div>



    <!-- ======================================================
                    STEP 2
    ======================================================= -->

    <div class="register-step" id="step2">

        <h5 class="fw-bold mb-4">
            Business Information
        </h5>

        <div class="row">

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    Business Name
                </label>

                <input
                        class="form-control"
                        name="businessName">

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    GST Number
                </label>

                <input
                        class="form-control"
                        name="gstNumber">

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    Contact Person
                </label>

                <input
                        class="form-control"
                        name="contactPerson">

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">
                    Alternate Mobile
                </label>

                <input
                        class="form-control"
                        name="alternateMobile">

            </div>

        </div>

        <div class="d-flex justify-content-between">

            <button
                    type="button"
                    class="btn btn-light border"
                    onclick="previousStep(1)">

                <i class="bi bi-arrow-left"></i>

                Back

            </button>

            <button
                    type="button"
                    class="btn btn-register"
                    onclick="nextStep(3)">

                Continue

                <i class="bi bi-arrow-right ms-2"></i>

            </button>

        </div>

    </div>




    <!-- ======================================================
                    STEP 3
    ======================================================= -->

    <div class="register-step" id="step3">

        <h5 class="fw-bold mb-4">

            Address & Verification

        </h5>

        <div class="row">

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    City

                </label>

                <input
                        class="form-control"
                        name="city">

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    State

                </label>

                <input
                        class="form-control"
                        name="state">

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Pincode

                </label>

                <input
                        class="form-control"
                        name="pincode">

            </div>

            <div class="col-md-6 mb-3">

                <label class="form-label">

                    Landmark

                </label>

                <input
                        class="form-control"
                        name="landmark">

            </div>

            <div class="col-12 mb-4">

                <label class="form-label">

                    Business Address

                </label>

                <textarea
                        class="form-control"
                        rows="4"
                        name="address"></textarea>

            </div>

        </div>

        <div class="form-check mb-4">

            <input
                    class="form-check-input"
                    type="checkbox"
                    required>

            <label class="form-check-label">

                I agree to the
                <a href="#">Terms & Conditions</a>
                and
                <a href="#">Privacy Policy</a>

            </label>

        </div>

        <div class="d-flex justify-content-between">

            <button
                    type="button"
                    class="btn btn-light border"
                    onclick="previousStep(2)">

                <i class="bi bi-arrow-left"></i>

                Back

            </button>

            <button
                    class="btn btn-register px-5">

                <i class="bi bi-check-circle me-2"></i>

                Create Account

            </button>

        </div>

    </div>

</form>

</div>
        <!-- REGISTER TAB END -->
    </div>
</div>
<!-- auth-body -->
</div>
<!-- auth-card -->

</div>
<!-- hero-container -->
</section>

<!-- ===========================
FOOTER
=========================== -->

<footer class="bg-white border-top mt-5">

    <div class="container py-5">

        <div class="row">

            <div class="col-lg-4">

                <h4 class="fw-bold text-primary mb-3">
                    WholeMart
                </h4>

                <p class="text-muted">

                    India's trusted B2B wholesale marketplace connecting
                    retailers, distributors and suppliers.

                </p>

            </div>

            <div class="col-lg-2">

                <h6 class="fw-bold">
                    Platform
                </h6>

                <ul class="list-unstyled">

                    <li><a href="#" class="text-decoration-none text-muted">Home</a></li>

                    <li><a href="#" class="text-decoration-none text-muted">Products</a></li>

                    <li><a href="#" class="text-decoration-none text-muted">Categories</a></li>

                </ul>

            </div>

            <div class="col-lg-2">

                <h6 class="fw-bold">
                    Resources
                </h6>

                <ul class="list-unstyled">

                    <li><a href="#" class="text-decoration-none text-muted">Help</a></li>

                    <li><a href="#" class="text-decoration-none text-muted">Support</a></li>

                    <li><a href="#" class="text-decoration-none text-muted">FAQs</a></li>

                </ul>

            </div>

            <div class="col-lg-4">

                <h6 class="fw-bold">
                    Contact
                </h6>

                <p class="text-muted mb-1">

                    support@wholemart.in

                </p>

                <p class="text-muted">

                    © 2026 WholeMart. All Rights Reserved.

                </p>

            </div>

        </div>

    </div>

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>

/*==============================
LOGIN / REGISTER TAB
==============================*/

const loginBtn=document.querySelectorAll(".nav-link")[0];

const registerBtn=document.querySelectorAll(".nav-link")[1];

const loginTab=document.getElementById("login");

const registerTab=document.getElementById("register");

loginBtn.onclick=function(){

loginBtn.classList.add("active");
registerBtn.classList.remove("active");

loginTab.classList.add("show","active");
registerTab.classList.remove("show","active");

}

registerBtn.onclick=function(){

registerBtn.classList.add("active");
loginBtn.classList.remove("active");

registerTab.classList.add("show","active");
loginTab.classList.remove("show","active");

}

function showRegister(){

registerBtn.click();

}

/*==============================
PASSWORD SHOW/HIDE
==============================*/

function togglePassword(id,icon){

const input=document.getElementById(id);

if(input.type==="password"){

input.type="text";

icon.classList.remove("bi-eye");

icon.classList.add("bi-eye-slash");

}else{

input.type="password";

icon.classList.remove("bi-eye-slash");

icon.classList.add("bi-eye");

}

}

/*==============================
PASSWORD STRENGTH
==============================*/

const password=document.getElementById("regPassword");

if(password){

password.addEventListener("keyup",function(){

let score=0;

const value=password.value;

if(value.length>=8)score++;

if(/[A-Z]/.test(value))score++;

if(/[0-9]/.test(value))score++;

if(/[!@#$%^&*]/.test(value))score++;

const bar=document.getElementById("passwordBar");

const widths=["0%","25%","50%","75%","100%"];

const colors=["#ddd","#dc3545","#ffc107","#17a2b8","#28a745"];

bar.style.width=widths[score];

bar.style.background=colors[score];

});

}

/*==============================
MULTI STEP REGISTER
==============================*/

function nextStep(step){

document.querySelectorAll(".register-step").forEach(function(e){

e.classList.remove("active-step");

});

document.getElementById("step"+step).classList.add("active-step");

updateIndicator(step);

}

function previousStep(step){

document.querySelectorAll(".register-step").forEach(function(e){

e.classList.remove("active-step");

});

document.getElementById("step"+step).classList.add("active-step");

updateIndicator(step);

}

function updateIndicator(step){

document.querySelectorAll(".wizard-step").forEach(function(e){

e.classList.remove("active");

});

for(let i=1;i<=step;i++){

document.getElementById("indicator"+i).classList.add("active");

}

}

/*==============================
BUTTON LOADING
==============================*/

const loginForm=document.querySelector("form[action='login']");

if(loginForm){

loginForm.addEventListener("submit",function(){

const btn=document.getElementById("loginBtn");

btn.disabled=true;

btn.innerHTML='<span class="spinner-border spinner-border-sm me-2"></span>Signing In...';

});

}

</script>

</body>
</html>