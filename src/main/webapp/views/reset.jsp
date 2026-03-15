<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Reset Password</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/auth.css">

    </head>

    <body>

        <div class="auth-container">

            <div class="auth-box">

                <h2>Reset Password</h2>

                <p>Enter your new password</p>

                <form action="reset" method="post">

                    <input type="password"
                           name="password"
                           placeholder="New Password"
                           required>

                    <input type="password"
                           name="confirm"
                           placeholder="Confirm Password"
                           required>

                    <button type="submit">Reset Password</button>

                </form>

                <p class="error">${error}</p>

                <div class="auth-links">
                    <a href="login">Back to Login</a>
                </div>

            </div>

        </div>

    </body>
</html>