<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Room List</title>
    </head>

    <body>
        <jsp:include page="/views/layout/header.jsp" />
    <center>
        <h1>Room List</h1>

        <table border="1" cellpadding="10">
            <tr>
                <th>ID</th>
                <th>Room Type</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Status</th>
            </tr>

            <c:forEach var="r" items="${rooms}">
                <tr>
                    <td>${r.id}</td>
                    <td>${r.roomType}</td>
                    <td>${r.price} $</td>
                    <td>${r.quantity}</td>
                    <td>${r.status}</td>

                </tr>
            </c:forEach>
        </table>
    </center>

</body>
<jsp:include page="/views/layout/footer.jsp" />
</html>
