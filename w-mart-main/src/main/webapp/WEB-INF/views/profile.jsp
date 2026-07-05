<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Profile | WholeMart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="<c:url value='/css/dashboard.css'/>" rel="stylesheet">
</head>
<body class="wm-dashboard">
    <%@ include file="/WEB-INF/common/header.jsp" %>
    <div class="wm-dashboard-shell">
        <section class="wm-dashboard-panel">
            <h2>Profile details</h2>
            <p>User profile and account preferences are managed here.</p>
            <div class="wm-dashboard-chart">Profile overview placeholder</div>
        </section>
    </div>
    <%@ include file="/WEB-INF/common/footer.jsp" %>
</body>
</html>
