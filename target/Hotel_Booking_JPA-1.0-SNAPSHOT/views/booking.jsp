<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp"/>

<div class="hb-page">
    <div class="hb-container">
        <div class="booking-layout">
            <div class="hb-card">
                <div class="hb-card-header">
                    <h1 class="hb-title">Xác nhận đặt phòng</h1>
                    <p class="hb-subtitle">Chọn ngày nhận/trả phòng và xem tổng tiền.</p>
                </div>
                <div class="hb-card-body">
                    <div class="hb-alert" style="margin-bottom:14px;">
                        <b>Loại phòng:</b> ${room.roomType}
                        &nbsp;•&nbsp;
                        <span class="price-strong">Giá: $${room.price} / đêm</span>
                    </div>

                    <div class="rating-stars" style="margin-bottom:14px;">
                        <c:choose>
                            <c:when test="${room.hotel.rating != null}">
                                <c:forEach begin="1" end="5" var="i">
                                    <c:choose>
                                        <c:when test="${i <= room.hotel.rating}">★</c:when>
                                        <c:otherwise>☆</c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <span style="color:#334155;font-weight:800;font-size:13px;">(${room.hotel.rating}/5)</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color:#64748b;font-weight:800;font-size:13px;">Chưa có đánh giá</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <form action="booking" method="post">
                        <input type="hidden" name="roomId" value="${room.id}">

                        <div class="hb-field">
                            <label class="hb-label">Ngày nhận phòng</label>
                            <input class="hb-input" type="date"
                                   id="checkIn" name="checkIn"
                                   min="<%= java.time.LocalDate.now() %>"
                                   onchange="calculatePrice()" required>
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Ngày trả phòng</label>
                            <input class="hb-input" type="date"
                                   id="checkOut" name="checkOut"
                                   onchange="calculatePrice()" required>
                        </div>

                        <div class="hb-alert" style="display:flex;justify-content:space-between;gap:12px;flex-wrap:wrap;margin:14px 0;">
                            <span>Tổng tiền</span>
                            <span class="price-strong">$<span id="total">0</span></span>
                        </div>

                        <button class="hb-btn hb-btn-orange hb-btn-block" type="submit">
                            Đặt ngay
                        </button>
                    </form>
                </div>
            </div>

            <aside class="booking-summary">
                <div class="hb-card">
                    <div class="hb-card-header">
                        <h2 class="hb-title" style="font-size:18px;">Tóm tắt</h2>
                        <p class="hb-subtitle">Thông tin nhanh cho đặt phòng.</p>
                    </div>
                    <div class="hb-card-body">
                        <div style="display:grid;gap:10px;">
                            <div>
                                <div class="hb-help">Khách sạn</div>
                                <div style="font-weight:900;">${room.hotel.name}</div>
                            </div>
                            <div>
                                <div class="hb-help">Địa chỉ</div>
                                <div style="font-weight:800;color:#334155;">${room.hotel.address}</div>
                            </div>
                            <div>
                                <div class="hb-help">Giá / đêm</div>
                                <div class="price-strong">$${room.price}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </aside>
        </div>
    </div>
</div>

<jsp:include page="/views/layout/footer.jsp"/>

<script>
function calculatePrice() {
  const checkin = document.getElementById("checkIn").value;
  const checkout = document.getElementById("checkOut").value;
  const price = Number("${room.price}");

  if (checkin && checkout) {
    const d1 = new Date(checkin);
    const d2 = new Date(checkout);
    const days = (d2 - d1) / (1000 * 60 * 60 * 24);
    if (days <= 0) {
      alert("Check-out must be after Check-in");
      document.getElementById("total").innerText = 0;
      return;
    }
    document.getElementById("total").innerText = days * price;
  }
}
</script>

</html>