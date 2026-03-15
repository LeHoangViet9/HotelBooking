<%-- 
    Document   : edit
    Created on : Mar 11, 2026, 4:36:06 PM
    Author     : LE HOANG VIET
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="/views/layout/header.jsp" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Hotel</title>
    </head>
    <body>
        <h2>Edit Hotel</h2>

        <form action="adminHotel" method="post">

            <input type="hidden" name="id" value="${hotel.id}">

            Name:
            <input type="text" name="name" value="${hotel.name}">

            <br><br>

            Address:
            <input type="text" name="address" value="${hotel.address}">

            <br><br>

            <button type="submit">Update</button>

        </form>
    </body>
</html>
<jsp:include page="/views/layout/footer.jsp" />
