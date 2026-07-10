<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login & Register | WholeMart</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body class="wm-home">
<div class="wm-app">
    <%@ include file="/WEB-INF/common/header.jsp" %>

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow-lg border-0 rounded-4">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <span class="wm-kicker">Join WholeMart</span>
                            <h2 class="fw-bold mt-2">Create Your Business Account</h2>
                            <p class="text-muted">Register as Retailer, Distributor, Driver or Admin</p>
                        </div>

                        <ul class="nav nav-tabs" id="authTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="login-tab" data-bs-toggle="tab" data-bs-target="#login" type="button" role="tab" aria-controls="login" aria-selected="true">
                                    Login
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="register-tab" data-bs-toggle="tab" data-bs-target="#register" type="button" role="tab" aria-controls="register" aria-selected="false">
                                    Register
                                </button>
                            </li>
                        </ul>

                        <div class="tab-content" id="authTabsContent">

                            <!-- LOGIN TAB -->
                            <div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="login-tab">
                                <div class="pt-4">
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger" role="alert">${error}</div>
                                    </c:if>

                                    <form action="${pageContext.request.contextPath}/web/auth/login" method="post">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Email Address</label>
                                                <input type="email" class="form-control" name="email" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Role</label>
                                                <select class="form-select" name="role" required id="loginRole">
                                                    <option value="">Select Role</option>
                                                    <c:forEach items="${roles}" var="r">
                                                        <option value="${r.name()}">${r.name()}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-12 mb-3">
                                                <label class="form-label">Password</label>
                                                <input type="password" class="form-control" name="password" required>
                                            </div>
                                        </div>

                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-primary btn-lg">Login</button>
                                        </div>

                                        <div class="text-center mt-4">
                                            <span class="text-muted">New here?</span>
                                            <button class="btn btn-link p-0 fw-semibold" type="button"
                                                    onclick="bootstrap.Tab.getOrCreateInstance(document.getElementById('register-tab')).show()">
                                                Create Account
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- REGISTER TAB -->
                            <div class="tab-pane fade" id="register" role="tabpanel" aria-labelledby="register-tab">
                                <div class="pt-4">
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger" role="alert">${error}</div>
                                    </c:if>

                                    <form action="${pageContext.request.contextPath}/web/auth/register" method="post">

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Full Name</label>
                                                <input type="text" class="form-control" name="fullName" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Mobile Number</label>
                                                <input type="text" class="form-control" name="mobile" maxlength="10" required>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Email</label>
                                                <input type="text" class="form-control" name="email">
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Role</label>
                                                <select class="form-select" id="registerRole" name="role" required>
                                                    <option value="">Select Role</option>
                                                    <option value="ROLE_RETAILER">Retailer</option>
                                                    <option value="ROLE_DISTRIBUTOR">Distributor</option>
                                                    <option value="ROLE_DRIVER">Driver</option>
                                                    <option value="ROLE_ADMIN">Admin</option>
                                                </select>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Password</label>
                                                <input type="password" class="form-control" name="password" required>
                                            </div>
                                            <div class="col-md-6 mb-4">
                                                <label class="form-label">Confirm Password</label>
                                                <input type="password" class="form-control" name="confirmPassword" required>
                                            </div>
                                        </div>

                                        <!-- Retailer section -->
                                        <div id="retailerSection" style="display:none;">
                                            <hr>
                                            <h4 class="mb-4">Retailer Information</h4>
                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Shop Name</label>
                                                    <input class="form-control" name="shopName">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Owner Name</label>
                                                    <input class="form-control" name="ownerName">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">City</label>
                                                    <input class="form-control" name="city">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">State</label>
                                                    <input class="form-control" name="state">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Pincode</label>
                                                    <input class="form-control" name="pincode">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Address</label>
                                                    <textarea class="form-control" rows="2" name="address"></textarea>
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Latitude</label>
                                                    <input class="form-control" name="latitude">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Longitude</label>
                                                    <input class="form-control" name="longitude">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Distributor section -->
                                        <div id="distributorSection" style="display:none;">
                                            <hr>
                                            <h4 class="mb-4">Distributor Information</h4>
                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Business Name</label>
                                                    <input class="form-control" name="businessName">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Contact Name</label>
                                                    <input class="form-control" name="contactName">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">GST Number</label>
                                                    <input class="form-control" name="gstNumber">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Shop Name</label>
                                                    <input class="form-control" name="shopName">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Alternate Mobile</label>
                                                    <input class="form-control" name="alternateMobile">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">City</label>
                                                    <input class="form-control" name="city">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">State</label>
                                                    <input class="form-control" name="state">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Pincode</label>
                                                    <input class="form-control" name="pincode">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Address</label>
                                                    <textarea class="form-control" rows="2" name="address"></textarea>
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Latitude</label>
                                                    <input class="form-control" name="latitude">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Longitude</label>
                                                    <input class="form-control" name="longitude">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Driver section -->
                                        <div id="driverSection" style="display:none;">
                                            <hr>
                                            <h4 class="mb-4">Driver Information</h4>
                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Driver Name</label>
                                                    <input class="form-control" name="driverName">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Driving License Number</label>
                                                    <input class="form-control" name="licenseNumber">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Aadhaar Number</label>
                                                    <input class="form-control" name="aadhaarNumber">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Vehicle Type</label>
                                                    <select class="form-select" name="vehicleType">
                                                        <option value="">Select</option>
                                                        <option>Bike</option>
                                                        <option>Scooter</option>
                                                        <option>Three Wheeler</option>
                                                        <option>Mini Truck</option>
                                                        <option>Pickup</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Vehicle Number</label>
                                                    <input class="form-control" name="vehicleNumber">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">City</label>
                                                    <input class="form-control" name="city">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">State</label>
                                                    <input class="form-control" name="state">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Pincode</label>
                                                    <input class="form-control" name="pincode">
                                                </div>
                                                <div class="col-12 mb-3">
                                                    <label class="form-label">Address</label>
                                                    <textarea class="form-control" rows="2" name="address"></textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Admin section -->
                                        <div id="adminSection" style="display:none;">
                                            <hr>
                                            <h4 class="mb-4">Admin Information</h4>
                                            <div class="row">
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Employee ID</label>
                                                    <input class="form-control" name="employeeId">
                                                </div>
                                                <div class="col-md-6 mb-3">
                                                    <label class="form-label">Department</label>
                                                    <input class="form-control" name="department">
                                                </div>
                                            </div>
                                        </div>

                                        <hr class="my-4">

                                        <div class="d-grid">
                                            <button type="submit" class="btn btn-primary btn-lg">Create Account</button>
                                        </div>

                                        <div class="text-center mt-4">
                                            <span class="text-muted">Already have an account?</span>
                                            <button class="btn btn-link p-0 fw-semibold" type="button"
                                                    onclick="bootstrap.Tab.getOrCreateInstance(document.getElementById('login-tab')).show()">
                                                Login Here
                                            </button>
                                        </div>

                                    </form>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/common/footer.jsp" %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const registerRole = document.getElementById('registerRole');
    const retailer = document.getElementById('retailerSection');
    const distributor = document.getElementById('distributorSection');
    const driver = document.getElementById('driverSection');
    const admin = document.getElementById('adminSection');

    function hideAll() {
        retailer.style.display = 'none';
        distributor.style.display = 'none';
        driver.style.display = 'none';
        admin.style.display = 'none';
    }

    if (registerRole) {
        registerRole.addEventListener('change', function () {
            hideAll();
            switch (this.value) {
                case 'ROLE_RETAILER':
                    retailer.style.display = 'block';
                    break;
                case 'ROLE_DISTRIBUTOR':
                    distributor.style.display = 'block';
                    break;
                case 'ROLE_DRIVER':
                    driver.style.display = 'block';
                    break;
                case 'ROLE_ADMIN':
                    admin.style.display = 'block';
                    break;
            }
        });
    }

    hideAll();
</script>

</body>
</html>
