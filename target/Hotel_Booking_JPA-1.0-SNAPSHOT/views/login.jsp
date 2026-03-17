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
                    <h1>Đăng nhập</h1>
                    <p>Đăng nhập để quản lý đặt phòng và cập nhật hồ sơ.</p>
                </div>
                <div class="auth-card-body">
                    <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
                        <div class="hb-field">
                            <label class="hb-label">Email hoặc số điện thoại</label>
                            <input class="hb-input" type="text" name="user" placeholder="vd: email@gmail.com" required>
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Mật khẩu</label>
                            <input class="hb-input" type="password" name="pass" placeholder="Nhập mật khẩu" required>
                        </div>

                        <div class="auth-actions">
                            <button class="hb-btn hb-btn-primary hb-btn-block" type="submit">Đăng nhập</button>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="hb-error">${error}</div>
                        </c:if>

                        <div class="auth-links">
                            <div class="auth-inline">
                                <span>Chưa có tài khoản?</span>
                                <a href="${pageContext.request.contextPath}/register">Tạo tài khoản</a>
                            </div>
                            <div class="auth-inline">
                                <span>Quên mật khẩu?</span>
                                <a href="${pageContext.request.contextPath}/forgot">Khôi phục</a>
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
