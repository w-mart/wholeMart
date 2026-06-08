<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login | WholeMart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/common.css" rel="stylesheet">
    <link href="/css/wholemart.css?v=project-theme-refresh-30" rel="stylesheet">
</head>
<body class="wm-auth">
<main class="wm-auth-card">
    <div class="wm-brand"><div class="wm-logo">W</div><div><h1 class="h3 mb-0">WholeMart</h1><div class="text-muted">LocalB2B AI Marketplace</div></div></div>
    <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">${error}</div>
    </c:if>
    <form method="post" action="/web/auth/login" class="vstack gap-3">
        <div class="wm-form-group"><label class="wm-label">Name</label><input class="wm-input" name="name" placeholder="Business contact name"></div>
        <div class="wm-form-group">
            <label class="wm-label">Mobile</label>
            <input id="loginMobile" class="wm-input" name="mobile" type="tel" inputmode="numeric" pattern="[0-9]{10}" placeholder="Enter mobile number" required>
            <div id="mobileError" class="text-danger" style="display:none; font-size:0.9rem; margin-top:0.25rem;">Please enter a valid 10-digit mobile number.</div>
        </div>
        <div class="wm-form-group"><label class="wm-label">Role</label><select class="wm-select" name="role" required><c:forEach items="${roles}" var="role"><option value="${role}">${role}</option></c:forEach></select></div>
        <button class="btn wm-gradient-btn w-100 py-2" type="submit">Continue</button>
    </form>
</main>
<script>
document.addEventListener("DOMContentLoaded", function () {
    var role = document.querySelector("select[name='role']");
    var fields = document.querySelector(".wm-distributor-fields");
        var distributorInputs = fields.querySelectorAll("input, select, textarea");
        var mobileInput = document.getElementById("loginMobile");
        var mobileError = document.getElementById("mobileError");
        var form = document.querySelector("form");

        function syncDistributorFields() {
            var isDistributor = role.value === "ROLE_DISTRIBUTOR";
            fields.hidden = !isDistributor;
            distributorInputs.forEach(function (input) {
                input.disabled = !isDistributor;
                if (!isDistributor) {
                    input.value = "";
                }
            });
        }

        function normalizeMobile(value) {
            return (value || "").replace(/\D+/g, "").trim();
        }

        function validateMobile() {
            var normalized = normalizeMobile(mobileInput.value);
            var valid = /^[0-9]{10}$/.test(normalized);
            if (!valid) {
                mobileError.style.display = "block";
                mobileInput.classList.add("is-invalid");
            } else {
                mobileError.style.display = "none";
                mobileInput.classList.remove("is-invalid");
                mobileInput.value = normalized;
            }
            return valid;
        }

        role.addEventListener("change", syncDistributorFields);
        mobileInput.addEventListener("input", function () {
            if (mobileError.style.display === "block") {
                validateMobile();
            }
        });
        form.addEventListener("submit", function (event) {
            if (!validateMobile()) {
                event.preventDefault();
                event.stopPropagation();
                mobileInput.focus();
            }
        });

        syncDistributorFields();
    });
    </script>
</body>
</html>
