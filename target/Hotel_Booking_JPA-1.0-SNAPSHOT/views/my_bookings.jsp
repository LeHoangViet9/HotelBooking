<%@ page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/layout/header.jsp" />


<div class="container mt-4">
    <h2 class="mb-4">My Bookings</h2>

    <c:if test="${empty bookings}">
        <div class="alert alert-info">
            You have no bookings yet.
        </div>
    </c:if>

    <c:if test="${not empty bookings}">
        <table class="table table-bordered table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Hotel</th>
                    <th>Room</th>
                    <th>Check In</th>
                    <th>Check Out</th>
                    <th>Total Price</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="b" items="${bookings}">
                    <tr>
                        <td>${b.room.hotel.name}</td>
                        <td>${b.room.roomType}</td>
                        <td>${b.checkIn}</td>
                        <td>${b.checkOut}</td>
                        <td>${b.totalPrice}</td>
                        <td>
                            <c:choose>
                                <c:when test="${b.status == 'PENDING'}">
                                    <span class="badge bg-warning text-dark">Pending</span>
                                </c:when>
                                <c:when test="${b.status == 'CONFIRMED'}">
                                    <span class="badge bg-success">Confirmed</span>
                                </c:when>
                                <c:when test="${b.status == 'CANCELLED'}">
                                    <span class="badge bg-danger">Cancelled</span>
                                </c:when>
                                <c:otherwise>
                                    ${b.status}
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${b.status == 'PENDING' || b.status == 'CONFIRMED'}">
                                <form action="${pageContext.request.contextPath}/cancel" 
                                      method="post"
                                      onsubmit="return confirm('Are you sure to cancel this booking?');">
                                    <input type="hidden" name="id" value="${b.id}" />
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        Cancel
                                    </button>
                                </form>
                            </c:if>

                            <c:if test="${b.status == 'CANCELLED'}">
                                <span class="text-muted">No action</span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>

<jsp:include page="/views/layout/footer.jsp" />