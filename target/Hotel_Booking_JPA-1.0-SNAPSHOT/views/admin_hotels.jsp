<%-- 
    Document   : admin_hotels
    Created on : Mar 11, 2026, 4:28:07 PM
    Author     : LE HOANG VIET
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<jsp:include page="/views/layout/header.jsp" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Hotel</title>
    </head>
    <body>
        <h2>Hotel List</h2>

        <table border="1">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Address</th>
                <th>Action</th>
            </tr>

            <c:forEach var="h" items="${hotels}">
                <tr>
                    <td>${h.id}</td>
                    <td>${h.name}</td>
                    <td>${h.address}</td>

                    <td>
                        <a href="adminHotel?action=edit&id=${h.id}">Edit</a>
                        <a href="adminHotel?action=delete&id=${h.id}">Delete</a>
                    </td>

                </tr>
            </c:forEach>

        </table>
        <h3>Add Hotel</h3>

        <form action="adminHotel" method="post">

            Name:
            <input type="text" name="name">

            Address:
            <input type="text" name="address">

            <button type="submit">Add</button>

        </form>
    </body>
</html>
<jsp:include page="/views/layout/footer.jsp" />
