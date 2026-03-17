<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp" />

<div class="wrapper">
<div class="hotel-detail-page">

    <!-- ===== HOTEL HERO ===== -->
    <div class="hotel-hero">
        <c:if test="${not empty hotel.image}">
            <img src="${pageContext.request.contextPath}/img/${hotel.image}"
                 class="hotel-hero-img" alt="${hotel.name}"
                 onerror="this.parentElement.classList.add('hero-no-img');">
        </c:if>
        <div class="hotel-hero-overlay"></div>
        <div class="hotel-hero-content">
            <div class="hotel-breadcrumb">
                <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
                <i class="fa-solid fa-chevron-right"></i>
                <a href="${pageContext.request.contextPath}/search?city=${hotel.city.name}">${hotel.city.name}</a>
                <i class="fa-solid fa-chevron-right"></i>
                <span>${hotel.name}</span>
            </div>
            <h1 class="hotel-hero-name">${hotel.name}</h1>
            <div class="hotel-hero-meta">
                <span><i class="fa-solid fa-location-dot"></i> ${hotel.address}, ${hotel.city.name}</span>
                <div class="hotel-rating-badge">
                    <span class="rating-score-lg">${hotel.rating}</span>
                    <div>
                        <div class="rating-stars">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fa-${i <= hotel.rating ? 'solid' : 'regular'} fa-star"></i>
                            </c:forEach>
                        </div>
                        <small>${reviewCount} đánh giá</small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="hotel-detail-body">

        <!-- ===== LEFT COLUMN ===== -->
        <div class="hotel-detail-main">

            <!-- About -->
            <div class="detail-card">
                <h2 class="detail-section-title"><i class="fa-solid fa-circle-info"></i> Giới thiệu</h2>
                <p class="hotel-desc-text">${hotel.description}</p>
                <div class="hotel-amenities">
                    <span class="amenity-tag"><i class="fa-solid fa-wifi"></i> WiFi miễn phí</span>
                    <span class="amenity-tag"><i class="fa-solid fa-parking"></i> Bãi đậu xe</span>
                    <span class="amenity-tag"><i class="fa-solid fa-mug-hot"></i> Bữa sáng</span>
                    <span class="amenity-tag"><i class="fa-solid fa-snowflake"></i> Điều hòa</span>
                    <span class="amenity-tag"><i class="fa-solid fa-swimming-pool"></i> Hồ bơi</span>
                    <span class="amenity-tag"><i class="fa-solid fa-dumbbell"></i> Phòng gym</span>
                </div>
            </div>

            <!-- ===== ROOMS ===== -->
            <div class="detail-card">
                <h2 class="detail-section-title"><i class="fa-solid fa-door-open"></i> Các loại phòng</h2>
                <c:if test="${empty hotel.rooms}">
                    <p style="color:#888;">Chưa có thông tin phòng.</p>
                </c:if>
                <div class="room-grid">
                    <c:forEach var="r" items="${hotel.rooms}">
                        <div class="room-detail-card ${r.status == 'FULL' ? 'room-full' : ''}">
                            <div class="room-card-img">
                                <c:choose>
                                    <c:when test="${not empty r.image}">
                                        <img src="${pageContext.request.contextPath}/img/${r.image}"
                                             alt="${r.roomType}"
                                             onerror="this.style.display='none';this.nextElementSibling.style.display='flex';">
                                        <div class="room-img-placeholder" style="display:none">
                                            <i class="fa-solid fa-bed"></i>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="room-img-placeholder">
                                            <i class="fa-solid fa-bed"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${r.status == 'FULL'}">
                                    <span class="room-sold-out">Hết phòng</span>
                                </c:if>
                            </div>
                            <div class="room-card-body">
                                <div class="room-type-name">${r.roomType}</div>
                                <div class="room-features">
                                    <span><i class="fa-solid fa-user-group"></i> 2 khách</span>
                                    <span><i class="fa-solid fa-bed"></i> 1 giường đôi</span>
                                    <span><i class="fa-solid fa-bath"></i> Phòng tắm riêng</span>
                                </div>
                                <div class="room-price-row">
                                    <div>
                                        <span class="room-price-tag">
                                            <fmt:formatNumber value="${r.price}" pattern="#,###"/>đ
                                        </span>
                                        <span class="per-night">/ đêm</span>
                                    </div>
                                    <c:choose>
                                        <c:when test="${r.status == 'FULL'}">
                                            <span class="btn-room-full">Hết phòng</span>
                                        </c:when>
                                        <c:when test="${sessionScope.user != null && sessionScope.user.role == 'USER'}">
                                            <a class="btn-book-room"
                                               href="${pageContext.request.contextPath}/booking?roomId=${r.id}">
                                                Đặt phòng
                                            </a>
                                        </c:when>
                                        <c:when test="${sessionScope.user == null}">
                                            <a class="btn-book-room btn-book-login"
                                               href="${pageContext.request.contextPath}/login">
                                                Đăng nhập để đặt
                                            </a>
                                        </c:when>
                                    </c:choose>
                                </div>
                                <div class="room-qty">
                                    <i class="fa-solid fa-circle" style="color:${r.status == 'FULL' ? '#dc2626' : '#16a34a'};font-size:8px;"></i>
                                    Còn ${r.quantity} phòng trống
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- ===== REVIEWS ===== -->
            <div class="detail-card" id="reviews">
                <div class="reviews-header">
                    <h2 class="detail-section-title">
                        <i class="fa-solid fa-star" style="color:#FFB700"></i>
                        Đánh giá từ khách hàng
                        <span class="review-count-badge">${reviewCount}</span>
                    </h2>
                    <div class="avg-rating-display">
                        <span class="avg-score">${hotel.rating}</span>
                        <div>
                            <div class="rating-stars">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="fa-${i <= hotel.rating ? 'solid' : 'regular'} fa-star"></i>
                                </c:forEach>
                            </div>
                            <small style="color:#64748b;">${reviewCount} lượt đánh giá</small>
                        </div>
                    </div>
                </div>

                <!-- Alert messages -->
                <c:if test="${param.reviewSuccess == '1'}">
                    <div class="review-alert alert-success">
                        <i class="fa-solid fa-check-circle"></i> Cảm ơn bạn đã đánh giá! Đánh giá của bạn đã được ghi nhận.
                    </div>
                </c:if>
                <c:if test="${param.reviewError == 'duplicate'}">
                    <div class="review-alert alert-error">
                        <i class="fa-solid fa-circle-exclamation"></i> Bạn đã đánh giá khách sạn này rồi.
                    </div>
                </c:if>
                <c:if test="${param.reviewError == 'noStay'}">
                    <div class="review-alert alert-error">
                        <i class="fa-solid fa-circle-exclamation"></i> Chỉ khách đã hoàn thành lưu trú mới được đánh giá.
                    </div>
                </c:if>

                <!-- Review Form -->
                <c:choose>
                    <c:when test="${canReview == true}">
                        <div class="review-form-card">
                            <h4>Chia sẻ trải nghiệm của bạn</h4>
                            <form action="${pageContext.request.contextPath}/review" method="post">
                                <input type="hidden" name="hotelId" value="${hotel.id}">
                                <div class="star-rating-input">
                                    <span>Đánh giá của bạn:</span>
                                    <div class="star-group">
                                        <c:forEach begin="5" end="1" step="-1" var="s">
                                            <input type="radio" name="rating" id="star${s}" value="${s}" ${s == 5 ? 'checked' : ''}>
                                            <label for="star${s}"><i class="fa-solid fa-star"></i></label>
                                        </c:forEach>
                                    </div>
                                </div>
                                <textarea name="comment" placeholder="Chia sẻ cảm nhận của bạn về khách sạn này..." rows="4"></textarea>
                                <button type="submit" class="btn-submit-review">
                                    <i class="fa-solid fa-paper-plane"></i> Gửi đánh giá
                                </button>
                            </form>
                        </div>
                    </c:when>
                    <c:when test="${hasReviewed == true}">
                        <div class="review-alert" style="background:#f0fdf4;border-color:#86efac;color:#166534;">
                            <i class="fa-solid fa-check-circle"></i> Bạn đã đánh giá khách sạn này.
                        </div>
                    </c:when>
                    <c:when test="${sessionScope.user == null}">
                        <div class="review-login-note">
                            <i class="fa-solid fa-lock"></i>
                            <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> để đánh giá khách sạn này.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="review-login-note" style="background:#f8fafc;color:#64748b;">
                            <i class="fa-solid fa-info-circle"></i>
                            Chỉ khách đã hoàn thành lưu trú mới được viết đánh giá.
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- Review List -->
                <c:choose>
                    <c:when test="${empty reviews}">
                        <div class="empty-reviews">
                            <i class="fa-regular fa-star"></i>
                            <p>Chưa có đánh giá nào. Hãy là người đầu tiên!</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="reviews-list">
                            <c:forEach var="rv" items="${reviews}">
                                <div class="review-item">
                                    <div class="reviewer-avatar">${rv.user.fullName.substring(0,1).toUpperCase()}</div>
                                    <div class="review-content">
                                        <div class="reviewer-name">${rv.user.fullName}</div>
                                        <div class="review-stars">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fa-${i <= rv.rating ? 'solid' : 'regular'} fa-star"></i>
                                            </c:forEach>
                                            <span class="review-date">
                                                ${fn:substring(rv.createdAt.toString(), 0, 10)}
                                            </span>
                                        </div>
                                        <p class="review-text">${rv.comment}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- ===== Q&A ===== -->
            <div class="detail-card">
                <h2 class="detail-section-title">
                    <i class="fa-solid fa-comments"></i> Hỏi & Đáp
                    <span class="review-count-badge">${fn:length(questions)}</span>
                </h2>

                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <form class="question-form" action="${pageContext.request.contextPath}/askQuestion" method="post">
                            <input type="hidden" name="hotelId" value="${hotel.id}">
                            <textarea name="content" placeholder="Bạn có câu hỏi gì về khách sạn này?" required></textarea>
                            <button type="submit"><i class="fa-solid fa-paper-plane"></i> Gửi câu hỏi</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="review-login-note">
                            <i class="fa-solid fa-lock"></i>
                            <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> để đặt câu hỏi.
                        </div>
                    </c:otherwise>
                </c:choose>

                <c:if test="${empty questions}">
                    <p style="color:#888;text-align:center;padding:20px;">Chưa có câu hỏi nào.</p>
                </c:if>
                <c:forEach var="q" items="${questions}">
                    <div class="question-card">
                        <div class="question-user">
                            <div class="reviewer-avatar" style="background:#7c3aed;">${q.user.fullName.substring(0,1).toUpperCase()}</div>
                            <div>
                                <span class="reviewer-name">${q.user.fullName}</span>
                                <span class="review-date">${fn:substring(q.createdAt.toString(), 0, 10)}</span>
                            </div>
                        </div>
                        <div class="question-content">${q.content}</div>

                        <div class="answer-list">
                            <c:forEach var="a" items="${q.answers}">
                                <div class="answer-item">
                                    <div class="reviewer-avatar" style="background:#003580;width:28px;height:28px;font-size:12px;">${a.user.fullName.substring(0,1).toUpperCase()}</div>
                                    <div>
                                        <b>${a.user.fullName}</b>
                                        <p>${a.content}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <c:if test="${sessionScope.user != null}">
                            <form class="answer-form" action="${pageContext.request.contextPath}/answer" method="post">
                                <input type="hidden" name="qid" value="${q.id}">
                                <input type="hidden" name="hotelId" value="${hotel.id}">
                                <textarea name="content" placeholder="Viết câu trả lời..." required></textarea>
                                <button type="submit">Trả lời</button>
                            </form>
                        </c:if>
                    </div>
                </c:forEach>
            </div>

        </div><!-- /.hotel-detail-main -->

        <!-- ===== RIGHT SIDEBAR ===== -->
        <aside class="hotel-detail-sidebar">
            <div class="sidebar-book-card">
                <h4>Đặt phòng ngay</h4>
                <p style="color:#64748b;font-size:13px;margin-bottom:16px;">Chọn phòng phù hợp và đặt trực tiếp</p>
                <a href="#rooms" class="btn-book-now">
                    <i class="fa-solid fa-calendar-check"></i> Chọn phòng
                </a>
                <a href="#reviews" class="btn-see-reviews">
                    <i class="fa-solid fa-star"></i> Xem đánh giá (${reviewCount})
                </a>
            </div>

            <div class="sidebar-info-card">
                <h5>Thông tin khách sạn</h5>
                <div class="info-row"><i class="fa-solid fa-location-dot"></i> ${hotel.address}, ${hotel.city.name}</div>
                <div class="info-row"><i class="fa-solid fa-star" style="color:#FFB700"></i> Điểm đánh giá: <strong>${hotel.rating}/5</strong></div>
                <div class="info-row"><i class="fa-solid fa-door-open"></i> ${fn:length(hotel.rooms)} loại phòng</div>
                <div class="info-row"><i class="fa-solid fa-comments"></i> ${fn:length(questions)} câu hỏi</div>
            </div>
        </aside>

    </div><!-- /.hotel-detail-body -->
</div>
</div><!-- /.wrapper -->

<jsp:include page="/views/layout/footer.jsp" />

<script>
// Scroll to rooms section
document.querySelectorAll('a[href="#rooms"]').forEach(a => {
    a.addEventListener('click', e => {
        e.preventDefault();
        document.querySelector('.room-grid')?.scrollIntoView({behavior:'smooth', block:'start'});
    });
});
</script>
</html>
