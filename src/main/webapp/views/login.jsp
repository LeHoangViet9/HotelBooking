<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>

<body>

<div class="auth-container">
    <div class="auth-box">
        <h2>Login</h2>

        <form action="${pageContext.request.contextPath}/login" method="post">

            <input type="text" name="user" placeholder="Email or Phone" required>

            <input type="password" name="pass" placeholder="Password" required>

            <button type="submit">LOGIN</button>

            <p class="error">${error}</p>

            <p class="switch">
                Don't have an account?:
                <a href="${pageContext.request.contextPath}/register">Register</a>
            </p>
            <p>
                Forgot password
                <a href="${pageContext.request.contextPath}/forgot">Forgot</a>
            </p>

        </form>
    </div>
</div>

</body>
</html>
