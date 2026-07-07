<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login | WholeMart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
</head>
<body class="wm-auth">
    <%@ include file="/WEB-INF/common/header.jsp" %>
    <%@ include file="/WEB-INF/views/_loginForm.jsp" %>
    <%@ include file="/WEB-INF/common/footer.jsp" %>
    <script src="${pageContext.request.contextPath}/js/login.js"></script>
</body>
</html>
