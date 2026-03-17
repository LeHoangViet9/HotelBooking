<%-- 
    Document   : edit
    Author     : LE HOANG VIET
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp" />

<div class="hb-page">
    <div class="hb-container" style="width: min(920px, calc(100% - 32px));">
        <div class="hb-card">
                <div class="hb-card-header">
                    <h1 class="hb-title">Chỉnh sửa khách sạn</h1>
                    <p class="hb-subtitle">Cập nhật thông tin và hình ảnh khách sạn.</p>
                </div>
                <div class="hb-card-body">

                    <form action="adminHotel" method="post">

            <input type="hidden" name="id" value="${hotel.id}">

            <!-- NAME -->

                        <div class="hb-field">
                            <label class="hb-label">Tên khách sạn</label>
                            <input class="hb-input" type="text"
                                   name="name"
                                   value="${hotel.name}"
                                   required>
                        </div>

            <!-- ADDRESS -->

                        <div class="hb-field">
                            <label class="hb-label">Địa chỉ</label>
                            <input class="hb-input" type="text"
                                   name="address"
                                   value="${hotel.address}"
                                   required>
                        </div>

            <!-- CITY -->

                        <div class="hb-field">
                            <label class="hb-label">Thành phố</label>
                            <select class="hb-input" name="city_id">

                    <c:forEach var="c" items="${cities}">

                        <option value="${c.id}"
                            ${hotel.city.id == c.id ? "selected" : ""}>
                            ${c.name}
                        </option>

                    </c:forEach>

                            </select>
                        </div>

            <!-- RATING -->

                        <div class="hb-field">
                            <label class="hb-label">Đánh giá (0–5)</label>
                            <input class="hb-input" type="number"
                                   name="rating"
                                   step="0.1"
                                   min="0"
                                   max="5"
                                   value="${hotel.rating}">
                        </div>

            <!-- IMAGE -->

                        <div class="hb-field">
                            <label class="hb-label">Tên file ảnh</label>
                            <input class="hb-input" type="text"
                                   name="image"
                                   id="imageInput"
                                   value="${hotel.image}">
                            <div class="hb-help">Ảnh nằm trong thư mục `/img/`.</div>
                        </div>

            <!-- PREVIEW -->

                        <div class="hb-field">
                            <label class="hb-label">Xem trước</label>
                            <img id="preview"
                                 src="${pageContext.request.contextPath}/img/${hotel.image}"
                                 width="140" height="96"
                                 style="border-radius:12px;object-fit:cover;border:1px solid var(--hb-border);"
                                 onerror="this.style.opacity='0.2'">
                        </div>

                        <div class="hb-actions-row" style="justify-content:flex-end;">
                            <a class="hb-btn hb-btn-outline" href="${pageContext.request.contextPath}/adminHotel">Hủy</a>
                            <button type="submit" class="hb-btn hb-btn-primary">
                                Lưu
                            </button>
                        </div>

                    </form>

                </div>
            </div>
    </div>
</div>

<jsp:include page="/views/layout/footer.jsp" />

<script>

document.getElementById("imageInput").oninput = function(){
    document.getElementById("preview").src =
    "${pageContext.request.contextPath}/img/" + this.value;
}

</script>
</html>