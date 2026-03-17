<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp" />

<div class="hb-page">
    <div class="hb-container">
        <div class="auth-page">
            <div class="auth-card">
                <div class="auth-card-header">
                    <h1>Tạo tài khoản</h1>
                    <p>Đăng ký để đặt phòng nhanh hơn và theo dõi lịch sử đặt phòng.</p>
                </div>
                <div class="auth-card-body">
                    <form action="${pageContext.request.contextPath}/register" method="post" novalidate>
                        <div class="hb-field">
                            <label class="hb-label">Họ và tên</label>
                            <input class="hb-input" type="text" name="name" placeholder="vd: Lê Hoàng Việt" required>
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Email</label>
                            <input class="hb-input" type="email" name="email" placeholder="vd: email@gmail.com" required>
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Số điện thoại</label>
                            <input class="hb-input" type="text" name="phone" placeholder="vd: 09xx xxx xxx" required>
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Mật khẩu</label>
                            <input class="hb-input" type="password" name="pass" placeholder="Tối thiểu 6 ký tự" required>
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Nhập lại mật khẩu</label>
                            <input class="hb-input" type="password" name="confirm" placeholder="Nhập lại mật khẩu" required>
                        </div>

                        <div class="auth-actions">
                            <button class="hb-btn hb-btn-primary hb-btn-block" type="submit">Đăng ký</button>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="hb-error">${error}</div>
                        </c:if>

                        <div class="auth-links">
                            <div class="auth-inline">
                                <span>Đã có tài khoản?</span>
                                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/layout/footer.jsp" />
</html>