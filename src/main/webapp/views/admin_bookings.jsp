<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin - Quản lý Booking</title>
    </head>
    <jsp:include page="/views/layout/header.jsp" />
    <body>

        <h2 class="admin-title">Booking Management</h2>

        <c:forEach var="b" items="${bookings}">

            <div class="booking-card">

                <p>
                    <b>User:</b> ${b.user.fullName} <br>
                    <b>Room:</b> ${b.room.roomType} <br>
                    <b>Date:</b> ${b.checkIn} - ${b.checkOut} <br>
                    <b>Total:</b> ${b.totalPrice} $ <br>

                    <b>Status:</b>

                    <c:choose>
                        <c:when test="${b.status == 'PENDING'}">
                            <span class="status pending">PENDING</span>
                        </c:when>

                        <c:when test="${b.status == 'CONFIRMED'}">
                            <span class="status confirmed">CONFIRMED</span>
                        </c:when>

                        <c:when test="${b.status == 'CANCELLED'}">
                            <span class="status cancelled">CANCELLED</span>
                        </c:when>

                        <c:otherwise>
                            <span class="status completed">COMPLETED</span>
                        </c:otherwise>
                    </c:choose>
                </p>

                <form class="booking-actions" 
                      action="${pageContext.request.contextPath}/updateBooking" 
                      method="post">

                    <input type="hidden" name="id" value="${b.id}">

                    <button class="btn-confirm" type="submit" name="status" value="CONFIRMED">
                        Confirm
                    </button>

                    <button class="btn-cancel" type="submit" name="status" value="CANCELLED">
                        Cancel
                    </button>

                </form>

            </div>

        </c:forEach>
    </body>
    <jsp:include page="/views/layout/footer.jsp" />
</html>