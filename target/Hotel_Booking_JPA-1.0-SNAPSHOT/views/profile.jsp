<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta charset="UTF-8">
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ</title>
</head>

<body>
<jsp:include page="/views/layout/header.jsp" />

<div class="hb-page">
    <div class="hb-container">
        <div class="profile-grid">
            <aside class="hb-card profile-side">
                <div class="profile-avatar">
                    ${sessionScope.user.fullName.substring(0,1).toUpperCase()}
                </div>
                <div class="profile-name">${sessionScope.user.fullName}</div>
                <p class="profile-meta">Quản lý thông tin cá nhân và bảo mật.</p>
                <div class="profile-actions">
                    <a class="hb-btn hb-btn-outline" href="${pageContext.request.contextPath}/mybooking">
                        Đặt phòng của tôi
                    </a>
                    <a class="hb-btn hb-btn-primary" href="${pageContext.request.contextPath}/home">
                        Về trang chủ
                    </a>
                </div>
            </aside>

            <main class="hb-card profile-main">
                <div class="hb-card-header" style="padding:0 0 14px;border-bottom:1px solid var(--hb-border);">
                    <h1 class="hb-title">Thông tin hồ sơ</h1>
                    <p class="hb-subtitle">Cập nhật tên, số điện thoại và mật khẩu.</p>
                </div>

                <div style="padding-top:14px;">
                    <c:if test="${not empty error}">
                        <div style="color: red; margin-bottom: 15px; padding: 10px; background-color: #ffe6e6; border: 1px solid #ffcccc; border-radius: 5px;">
                            ${error}
                        </div>
                    </c:if>
                    <c:if test="${not empty message}">
                        <div style="color: green; margin-bottom: 15px; padding: 10px; background-color: #e6ffe6; border: 1px solid #ccffcc; border-radius: 5px;">
                            ${message}
                        </div>
                    </c:if>
                    <form class="profile-form" method="post" action="${pageContext.request.contextPath}/profile">
                        <div class="hb-field">
                            <label class="hb-label">Họ và tên</label>
                            <input class="hb-input" type="text" name="fullName"
                                   value="${sessionScope.user.fullName}" required />
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Số điện thoại</label>
                            <input class="hb-input" type="text" name="phone"
                                   pattern="[0-9]{10,11}" title="Số điện thoại phải bao gồm 10 hoặc 11 chữ số"
                                   value="${sessionScope.user.phone}" required />
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Mật khẩu</label>
                            <input class="hb-input" type="password" name="password"
                                   minlength="6" title="Mật khẩu phải có ít nhất 6 ký tự"
                                   value="${sessionScope.user.password}" required />
                        </div>

                        <div class="hb-actions-row">
                            <a class="hb-btn hb-btn-outline" href="${pageContext.request.contextPath}/home">Hủy</a>
                            <button class="hb-btn hb-btn-primary" type="submit">Lưu thay đổi</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>
</div>

<jsp:include page="/views/layout/footer.jsp" />
</body>
</html>