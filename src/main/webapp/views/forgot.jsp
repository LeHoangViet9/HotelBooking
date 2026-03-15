<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>Forgot Password</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>

<body>

<div class="auth-container">

    <div class="auth-box">

        <h2>Forgot Password</h2>

        <p>Enter your email to reset your password</p>

        <form action="${pageContext.request.contextPath}/forgot" method="post">

            <input type="email" name="email" placeholder="Enter your email" required>

            <button type="submit">Send Reset Link</button>

        </form>

        <p>
            <a href="login.jsp">Back to Login</a>
        </p>

    </div>

</div>

</body>
</html>