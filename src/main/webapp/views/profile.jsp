<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>

<body>

<jsp:include page="/views/layout/header.jsp" />

<div class="auth-container">

    <div class="auth-box">

        <h2>My Profile</h2>

        <form method="post">

            <label>Full Name</label>
            <input type="text" name="fullName"
                   value="${sessionScope.user.fullName}" />

            <label>Phone</label>
            <input type="text" name="phone"
                   value="${sessionScope.user.phone}" />

            <label>Password</label>
            <input type="password" name="password"
                   value="${sessionScope.user.password}" />

            <button type="submit">Update</button>

        </form>

    </div>

</div>

<jsp:include page="/views/layout/footer.jsp" />

</body>
</html>