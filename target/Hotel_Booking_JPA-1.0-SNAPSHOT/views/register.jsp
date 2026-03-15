<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    </head>
    <body>

        <div class="auth-container">
            <div class="auth-box">
                <h2>Register</h2>

                <form action="${pageContext.request.contextPath}/register" method="post">

                    <input type="text" name="name" placeholder="Full Name" required>

                    <input type="text" name="email" placeholder="Email" required>

                    <input type="text" name="phone" placeholder="Phone" required>

                    <input type="password" name="pass" placeholder="Password" required>

                    <input type="password" name="confirm" placeholder="Confirm Password" required>

                    <button type="submit">REGISTER</button>

                    <p class="error">${error}</p>

                </form>
            </div>
        </div>

    </body>
</html>