<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8">
    <meta name="description" content="WholeMart connects retailers, distributors, drivers and administrators on one AI-powered platform for wholesale ordering, inventory, credit and delivery.">
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
            <body>
                <jsp:include page="/WEB-INF/common/retailer_header.jsp" />
                <section class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-lg-11">
                            <div class="card shadow-lg border-0 rounded-4">
                                <div class="card-body p-5">
                                    <div class="text-center mb-5">
                                        <h2 class="fw-bold"> Create Your W-Mart Account</h2>
                                        <p class="text-muted">Join as Retailer, Distributor or Delivery Partner</p>
                                    </div>

                                    <form:form action="${pageContext.request.contextPath}/register" method="post"
                                        modelAttribute="user">
                                        <h4 class="mb-4">Personal Information</h4>
                                        <div class="row">
                                            <div class="col-md-4 mb-3">
                                                <label>First Name *</label>
                                                <form:input path="personalInfo.firstName" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label>Middle Name</label>
                                                <form:input path="personalInfo.middleName" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label>Last Name *</label>
                                                <form:input path="personalInfo.lastName" cssClass="form-control" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label>Mobile Number *</label>
                                                <form:input path="personalInfo.mobileNumber" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label>Email *</label>
                                                <form:input path="personalInfo.email" cssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label>Password *</label>
                                                <form:password path="personalInfo.password" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label>Confirm Password *</label>
                                                <form:password path="personalInfo.confirmPassword"
                                                    cssClass="form-control" />
                                            </div>
                                        </div>
                                        <hr class="my-5">
                                        <h4 class="mb-4"> Business Information </h4>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label>Business Name</label>
                                                <form:input path="businessInfo.businessName" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label>Shop Name</label>
                                                <form:input path="businessInfo.shopName" cssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4 mb-3">
                                                <label>GSTIN</label>
                                                <form:input path="businessInfo.gstin" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label>PAN</label>
                                                <form:input path="businessInfo.panNumber" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label>Business Type</label>
                                                <form:select path="businessInfo.businessType" cssClass="form-select">
                                                    <form:option value="">Select</form:option>
                                                    <form:option value="PROPRIETORSHIP">Proprietorship</form:option>
                                                    <form:option value="PARTNERSHIP">Partnership</form:option>
                                                    <form:option value="PRIVATE_LIMITED">Private Limited</form:option>
                                                </form:select>
                                            </div>
                                        </div>
                                        <hr class="my-5">
                                        <h4 class="mb-4">Address</h4>
                                        <div class="row">
                                            <div class="col-md-4 mb-3">
                                                <label>Country</label>
                                                <form:input path="address.country" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label>State</label>
                                                <form:input path="address.state" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label>City</label>
                                                <form:input path="address.city" cssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label>Address Line 1</label>
                                                <form:input path="address.addressLine1" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label>Address Line 2</label>
                                                <form:input path="address.addressLine2" cssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4 mb-3">
                                                <label>District</label>
                                                <form:input path="address.district" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label>Area</label>
                                                <form:input path="address.area" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-4 mb-3">
                                                <label>Pincode</label>
                                                <form:input path="address.pinCode" cssClass="form-control" />
                                            </div>
                                        </div>
                                        <hr class="my-5">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label>Select Role *</label>
                                                <form:select path="personalInfo.role" cssClass="form-select">
                                                    <form:option value="">Select Role</form:option>
                                                    <form:option value="RETAILER">Retailer</form:option>
                                                    <form:option value="DISTRIBUTOR">Distributor</form:option>
                                                    <form:option value="DRIVER">Driver</form:option>
                                                </form:select>
                                            </div>
                                        </div>
                                        <div class="mt-5 text-center">
                                            <button class="btn btn-primary btn-lg px-5"> Register Account  </button>
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <jsp:include page="/WEB-INF/common/footer.jsp" />
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
                <script src="${pageContext.request.contextPath}/js/registration.js"></script>
            </body>
            </html>