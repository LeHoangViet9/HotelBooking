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
                    <h1>Đặt lại mật khẩu</h1>
                    <p>Tạo mật khẩu mới để đăng nhập lại tài khoản.</p>
                </div>
                <div class="auth-card-body">
                    <form action="${pageContext.request.contextPath}/reset" method="post" novalidate>
                        <div class="hb-field">
                            <label class="hb-label">Mật khẩu mới</label>
                            <input class="hb-input" type="password" name="password" placeholder="Nhập mật khẩu mới" required>
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Xác nhận mật khẩu</label>
                            <input class="hb-input" type="password" name="confirm" placeholder="Nhập lại mật khẩu" required>
                        </div>

                        <div class="auth-actions">
                            <button class="hb-btn hb-btn-primary hb-btn-block" type="submit">
                                Lưu mật khẩu mới
                            </button>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="hb-error">${error}</div>
                        </c:if>

                        <div class="auth-links">
                            <div class="auth-inline">
                                <span>Quay lại</span>
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