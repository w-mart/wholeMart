<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
<div class="login-wrapper">
    <div class="container">
        <div class="login-card">
            <div class="row g-0">
                <!-- LEFT PANEL -->
                <div class="col-lg-4 d-none d-lg-block">
                    <div class="left-panel">
                        <div class="brand">
                            <div class="logo-circle">WM</div>
                            <span>WholeMart</span>
                        </div>
                        <h1>Join the Future of B2B Commerce</h1>
                        <p class="subtitle">One platform for Retailers, Distributors, and Drivers to connect and grow.</p>
                        <div class="feature">
                            <i class="fa-solid fa-truck-fast"></i>
                            <div>
                                <h6>Efficient Logistics</h6>
                                <p>Streamline your delivery process.</p>
                            </div>
                        </div>
                        <div class="feature">
                            <i class="fa-solid fa-boxes-stacked"></i>
                            <div>
                                <h6>Inventory Management</h6>
                                <p>Manage stock with powerful tools.</p>
                            </div>
                        </div>
                        <div class="feature">
                            <i class="fa-solid fa-store"></i>
                            <div>
                                <h6>Wider Reach</h6>
                                <p>Connect with more business partners.</p>
                            </div>
                        </div>
                        <img class="warehouse" src="${pageContext.request.contextPath}/resources/images/warehouse.png">
                    </div>
                </div>

                <!-- RIGHT PANEL (REGISTRATION FORM) -->
                <div class="col-lg-8">
                    <div class="right-panel">
                        <div class="heading">
                            <div class="logo-circle">WM</div>
                            <div>
                                <h2>Create a New Account</h2>
                                <p>Join WholeMart and start growing your business.</p>
                            </div>
                        </div>

                        <%-- Display any success or error messages from the controller --%>
                        <% if (request.getAttribute("message") != null) { %>
                            <div class="alert alert-danger mt-3" role="alert">
                                ${message}
                            </div>
                        <% } %>

                        <form class="mt-4" action="${pageContext.request.contextPath}/register" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="firstName">First Name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" placeholder="John" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Doe" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="username">Username</label>
                                <input type="text" class="form-control" id="username" name="username" placeholder="johndoe" required>
                            </div>

                            <div class="mb-3">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="mobile">Mobile Number</label>
                                <input type="tel" class="form-control" id="mobile" name="mobile" placeholder="Enter Mobile Number" required>
                            </div>

                            <div class="mb-3">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>

                            <div class="mb-3">
                                <label for="role">Register as</label>
                                <select class="form-select" id="role" name="role" onchange="toggleRoleFields()">
                                    <option value="ROLE_RETAILER">Retailer</option>
                                    <option value="ROLE_DISTRIBUTOR">Distributor</option>
                                    <option value="ROLE_DRIVER">Driver</option>
                                </select>
                            </div>

                            <!-- Role-specific fields -->
                            <div id="distributor-fields" class="mb-3 d-none">
                                <label for="companyName">Company Name</label>
                                <input type="text" class="form-control" id="companyName" name="companyName">
                            </div>

                            <div id="retailer-fields" class="mb-3 d-none">
                                <label for="shopName">Shop Name</label>
                                <input type="text" class="form-control" id="shopName" name="shopName">
                            </div>

                            <div id="driver-fields" class="mb-3 d-none">
                                <label for="licenseNumber">License Number</label>
                                <input type="text" class="form-control" id="licenseNumber" name="licenseNumber">
                            </div>

                            <button class="btn btn-primary w-100" type="submit">Register</button>

                            <p class="text-center mt-3">
                                Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a>
                            </p>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleRoleFields() {
        const role = document.getElementById("role").value;
        const distributorFields = document.getElementById("distributor-fields");
        const retailerFields = document.getElementById("retailer-fields");
        const driverFields = document.getElementById("driver-fields");

        // Hide all role-specific fields
        distributorFields.classList.add("d-none");
        retailerFields.classList.add("d-none");
        driverFields.classList.add("d-none");

        // Make inputs not required
        document.getElementById("companyName").required = false;
        document.getElementById("shopName").required = false;
        document.getElementById("licenseNumber").required = false;

        // Show fields and set required based on selected role
        if (role === "ROLE_DISTRIBUTOR") {
            distributorFields.classList.remove("d-none");
            document.getElementById("companyName").required = true;
        } else if (role === "ROLE_RETAILER") {
            retailerFields.classList.remove("d-none");
            document.getElementById("shopName").required = true;
        } else if (role === "ROLE_DRIVER") {
            driverFields.classList.remove("d-none");
            document.getElementById("licenseNumber").required = true;
        }
    }
    // Run on page load to set the initial state
    window.onload = toggleRoleFields;
</script>
</body>
</html>
</body>
</html>