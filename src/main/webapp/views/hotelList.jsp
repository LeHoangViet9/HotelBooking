<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp" />

<div class="wrapper">
<div class="hotel-list-page">

    <!-- ===== PAGE HEADER ===== -->
    <div class="list-page-header">
        <div class="list-page-header-inner">
            <h1>
                <i class="fa-solid fa-magnifying-glass"></i>
                Kết quả tìm kiếm
                <c:if test="${not empty param.city}">
                    tại <span class="city-highlight">${param.city}</span>
                </c:if>
            </h1>
            <p>
                <c:choose>
                    <c:when test="${empty hotels}">Không tìm thấy khách sạn phù hợp.</c:when>
                    <c:otherwise>Tìm thấy <strong>${totalHotels}</strong> khách sạn phù hợp với yêu cầu của bạn.</c:otherwise>
                </c:choose>
            </p>
        </div>
    </div>

    <!-- ===== SORT BAR ===== -->
    <div class="sort-bar">
        <div class="sort-bar-inner">
            <form method="get" action="${pageContext.request.contextPath}/search" class="sort-links" style="gap:10px;align-items:flex-end;flex:1;">
                <div style="display:flex;flex-direction:column;gap:6px;min-width:240px;flex:1;">
                    <span class="sort-label"><i class="fa-solid fa-filter"></i> Tìm theo tên</span>
                    <input class="hb-input" type="text" name="keyword" value="${param.keyword}" placeholder="VD: Vinpearl, Sunrise...">
                </div>

                <input type="hidden" name="city" value="${param.city}">
                <input type="hidden" name="checkin" value="${param.checkin}">
                <input type="hidden" name="checkout" value="${param.checkout}">

                <div style="display:flex;flex-direction:column;gap:6px;min-width:220px;">
                    <span class="sort-label"><i class="fa-solid fa-money-bill-wave"></i> Khoảng giá</span>
                    <select class="hb-input" name="priceRange">
                        <option value="" ${empty param.priceRange ? 'selected' : ''}>Tất cả</option>
                        <option value="0-500000" ${param.priceRange == '0-500000' ? 'selected' : ''}>0 - 500.000đ</option>
                        <option value="500000-1000000" ${param.priceRange == '500000-1000000' ? 'selected' : ''}>500.000đ - 1.000.000đ</option>
                        <option value="1000000-2000000" ${param.priceRange == '1000000-2000000' ? 'selected' : ''}>1.000.000đ - 2.000.000đ</option>
                        <option value="2000000-999999999" ${param.priceRange == '2000000-999999999' ? 'selected' : ''}>&gt; 2.000.000đ</option>
                    </select>
                </div>

                <div style="display:flex;flex-direction:column;gap:6px;min-width:220px;">
                    <span class="sort-label"><i class="fa-solid fa-arrow-up-wide-short"></i> Sắp xếp</span>
                    <select class="hb-input" name="sort">
                        <option value="" ${empty sort ? 'selected' : ''}>Mặc định</option>
                        <option value="name" ${sort == 'name' ? 'selected' : ''}>Tên A-Z</option>
                        <option value="rating" ${sort == 'rating' ? 'selected' : ''}>Đánh giá cao nhất</option>
                        <option value="priceAsc" ${sort == 'priceAsc' ? 'selected' : ''}>Giá thấp nhất</option>
                        <option value="priceDesc" ${sort == 'priceDesc' ? 'selected' : ''}>Giá cao nhất</option>
                    </select>
                </div>

                <button class="hb-btn hb-btn-primary" type="submit" style="height:42px;">
                    Lọc
                </button>
            </form>
        </div>
    </div>

    <div class="hotel-list-container">

        <!-- ===== NO RESULTS ===== -->
        <c:if test="${empty hotels}">
            <div class="no-results">
                <i class="fa-solid fa-magnifying-glass"></i>
                <h3>Không tìm thấy kết quả</h3>
                <p>Hãy thử thay đổi điểm đến, ngày hoặc mức giá và tìm lại.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn-back-home">
                    <i class="fa-solid fa-house"></i> Về trang chủ
                </a>
            </div>
        </c:if>

        <!-- ===== HOTEL CARDS ===== -->
        <c:forEach var="h" items="${hotels}">
            <div class="hotel-card">
                <div class="hotel-card-img-wrap">
                    <img src="${pageContext.request.contextPath}/img/${h.image}"
                         class="hotel-card-img"
                         alt="${h.name}"
                         onerror="this.src='';this.parentElement.classList.add('img-fallback');">
                    <div class="hotel-card-img-placeholder"><i class="fa-solid fa-hotel"></i></div>
                </div>

                <div class="hotel-card-body">
                    <div class="hotel-card-top">
                        <div>
                            <div class="hotel-card-name">${h.name}</div>
                            <div class="hotel-card-address">
                                <i class="fa-solid fa-location-dot" style="color:#0071c2"></i>
                                ${h.address}
                                <c:if test="${not empty h.city}">
                                    , ${h.city.name}
                                </c:if>
                            </div>
                        </div>
                        <div class="hotel-card-rating">
                            <span class="rating-score">${h.rating}</span>
                            <div class="rating-label">
                                <c:choose>
                                    <c:when test="${h.rating >= 4.5}">Xuất sắc</c:when>
                                    <c:when test="${h.rating >= 4.0}">Rất tốt</c:when>
                                    <c:when test="${h.rating >= 3.5}">Tốt</c:when>
                                    <c:otherwise>Ổn</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <p class="hotel-card-desc">${h.description}</p>

                    <div class="hotel-card-badges">
                        <span class="hotel-badge"><i class="fa-solid fa-wifi"></i> WiFi miễn phí</span>
                        <span class="hotel-badge"><i class="fa-solid fa-parking"></i> Có bãi đậu xe</span>
                        <span class="hotel-badge"><i class="fa-solid fa-mug-hot"></i> Bữa sáng</span>
                    </div>

                    <div class="hotel-card-bottom">
                        <div class="hotel-card-price">
                            <span class="price-label">Giá từ</span>
                            <span class="price-value">Liên hệ</span>
                            <span class="price-note">/ đêm</span>
                        </div>
                        <a href="hotel?id=${h.id}" class="hotel-detail-btn">
                            Xem chi tiết <i class="fa-solid fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- ===== PAGINATION ===== -->
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="?page=${currentPage - 1}&city=${param.city}&checkin=${param.checkin}&checkout=${param.checkout}&keyword=${param.keyword}&priceRange=${param.priceRange}&sort=${sort}"
                       class="page-btn">
                        <i class="fa-solid fa-chevron-left"></i>
                    </a>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="?page=${i}&city=${param.city}&checkin=${param.checkin}&checkout=${param.checkout}&keyword=${param.keyword}&priceRange=${param.priceRange}&sort=${sort}"
                       class="page-btn ${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${currentPage + 1}&city=${param.city}&checkin=${param.checkin}&checkout=${param.checkout}&keyword=${param.keyword}&priceRange=${param.priceRange}&sort=${sort}"
                       class="page-btn">
                        <i class="fa-solid fa-chevron-right"></i>
                    </a>
                </c:if>
            </div>
        </c:if>

    </div><!-- /.hotel-list-container -->
</div><!-- /.hotel-list-page -->
</div><!-- /.wrapper -->

<jsp:include page="/views/layout/footer.jsp" />
</html>
