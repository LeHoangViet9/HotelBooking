<%-- 
    Document   : profile
    Created on : Feb 27, 2026, 8:55:03 PM
    Author     : LE HOANG VIET
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <jsp:include page="/views/layout/header.jsp" />
    <body>
        <h2>My Profile</h2>

        <form method="post">
            Full Name: <input type="text" name="fullName" value="${sessionScope.user.fullName}" /><br>
            Phone: <input type="text" name="phone" value="${sessionScope.user.phone}" /><br>
            Password: <input type="text" name="password" value="${sessionScope.user.password}" /><br>
            <button type="submit">Update</button>
        </form>
    </body>
</html>
<jsp:include page="/views/layout/footer.jsp" />