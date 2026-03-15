<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Hotel List</title>
    </head>
    <body>

        <jsp:include page="/views/layout/header.jsp" />

        <h2 class="hotel-list-title">Available Hotels</h2>

        <!-- Nếu không có khách sạn -->
        <c:if test="${empty hotels}">
            <p>No hotels found.</p>
        </c:if>

        <!-- Nếu có khách sạn -->
        <c:forEach var="h" items="${hotels}">

            <div class="hotel-card">

                <!-- HOTEL IMAGE -->
                <img src="${pageContext.request.contextPath}/images/hotel.jpg"
                     class="hotel-img">

                <!-- HOTEL INFO -->
                <div class="hotel-info">

                    <div class="hotel-name">${h.name}</div>

                    <p><b>Address:</b> ${h.address}</p>

                    <p>${h.description}</p>

                    <div style="margin-top:10px;">
                        <a href="hotel?id=${h.id}" class="book-btn">
                            View Detail
                        </a>
                    </div>

                </div>

            </div>

        </c:forEach>

        <!-- ===== PHÂN TRANG ===== -->
        <div style="margin-top:20px; text-align:center;">

            <!-- Nút Previous -->
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}&city=${param.city}&sort=${sort}">
                    << Previous
                </a>
            </c:if>

            <!-- Danh sách số trang -->
            <c:forEach begin="1" end="${totalPages}" var="i">
                <a href="?page=${i}&city=${param.city}&sort=${sort}"
                   style="margin:5px; ${i == currentPage ? 'font-weight:bold;' : ''}">
                    ${i}
                </a>
            </c:forEach>

            <!-- Nút Next -->
            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}&city=${param.city}&sort=${sort}">
                    Next >>
                </a>
            </c:if>


        </div>

        <jsp:include page="/views/layout/footer.jsp" />

    </body>
</html>