<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:formatNumber value="${b.totalPrice}" type="number" groupingUsed="true"/>

<jsp:include page="/views/layout/header.jsp" />

<div class="hb-page">
    <div class="hb-container">
        <div class="hb-card">
            <div class="hb-card-header">
                <h1 class="hb-title">Đặt phòng của tôi</h1>
                <p class="hb-subtitle">Theo dõi tình trạng đặt phòng và hủy nếu cần.</p>
            </div>
            <div class="hb-card-body">
                <c:if test="${empty bookings}">
                    <div class="hb-alert">Bạn chưa có đặt phòng nào.</div>
                </c:if>

                <c:if test="${not empty bookings}">
                    <div class="hb-table-wrap">
                        <table class="hb-table">
                            <thead>
                                <tr>
                                    <th>Khách sạn</th>
                                    <th>Phòng</th>
                                    <th>Nhận phòng</th>
                                    <th>Trả phòng</th>
                                    <th>Tổng tiền</th>
                                    <th>Thanh toán</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${bookings}">
                                    <tr>
                                        <td>${b.room.hotel.name}</td>
                                        <td>${b.room.roomType}</td>
                                        <td>${b.checkIn}</td>
                                        <td>${b.checkOut}</td>
                                        <td><span class="price-strong"><fmt:formatNumber value="${b.totalPrice}" type="number" groupingUsed="true"/></span></td>
                                        <td>
                                            <div style="font-size: 13px;">
                                                <c:choose>
                                                    <c:when test="${b.paymentMethod == 'ONLINE'}">Online</c:when>
                                                    <c:otherwise>Tại quầy</c:otherwise>
                                                </c:choose>
                                                <br>
                                                <c:choose>
                                                    <c:when test="${b.paymentStatus == 'PAID'}">
                                                        <span style="color:#16a34a; font-weight:bold;">Đã thanh toán</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color:#ef4444; font-weight:bold;">Chưa thanh toán</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status == 'PENDING'}">
                                                    <span class="hb-badge hb-badge-pending">Đang xử lý</span>
                                                </c:when>
                                                <c:when test="${b.status == 'CONFIRMED'}">
                                                    <span class="hb-badge hb-badge-confirmed">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${b.status == 'CANCELLED'}">
                                                    <span class="hb-badge hb-badge-cancelled">Đã hủy</span>
                                                </c:when>
                                                <c:when test="${b.status == 'COMPLETED'}">
                                                    <span class="hb-badge" style="background:#ccfbf1;color:#115e59;">Hoàn tất</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="hb-badge">${b.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${b.status == 'PENDING' || b.status == 'CONFIRMED'}">
                                                <form action="${pageContext.request.contextPath}/cancel"
                                                      method="post"
                                                      onsubmit="return confirm('Bạn chắc chắn muốn hủy đặt phòng này?');"
                                                      style="margin:0;">
                                                    <input type="hidden" name="id" value="${b.id}" />
                                                    <button type="submit" class="hb-btn hb-btn-outline" style="padding:8px 12px;">
                                                        Hủy
                                                    </button>
                                                </form>
                                            </c:if>
                                            <c:if test="${b.status == 'CANCELLED'}">
                                                <span class="hb-help">Không có</span>
                                            </c:if>
                                            <c:if test="${b.status == 'COMPLETED'}">
                                                <a href="${pageContext.request.contextPath}/hotel?id=${b.room.hotel.id}#reviews" 
                                                   class="hb-btn hb-btn-primary" 
                                                   style="padding:8px 12px; text-decoration: none; font-size: 13px;">
                                                    Đánh giá
                                                </a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layout/footer.jsp" />