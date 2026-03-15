<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Room List</title>
</head>
<jsp:include page="/views/layout/header.jsp" />
<body>

<center>
    <h1>Room List</h1>

    <table border="1" cellpadding="10">
        <tr>
            <th>ID</th>
            <th>Room Type</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

        <c:forEach var="r" items="${rooms}">
            <tr>
                <td>${r.id}</td>
                <td>${r.roomType}</td>
                <td>${r.price} $</td>
                <td>${r.quantity}</td>
                <td>${r.status}</td>

                <td>
                    <c:choose>
                        <c:when test="${r.quantity > 0}">
                            <a href="booking?roomId=${r.id}">
                                <button>Book room</button>
                            </a>
                        </c:when>

                        <c:otherwise>
                            <span style="color:red;">Fully booked</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </table>
</center>

</body>
</html>
<jsp:include page="/views/layout/footer.jsp" />