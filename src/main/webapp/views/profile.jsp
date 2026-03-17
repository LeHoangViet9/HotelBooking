<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <form class="profile-form" method="post" action="${pageContext.request.contextPath}/profile">
                        <div class="hb-field">
                            <label class="hb-label">Họ và tên</label>
                            <input class="hb-input" type="text" name="fullName"
                                   value="${sessionScope.user.fullName}" />
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Số điện thoại</label>
                            <input class="hb-input" type="text" name="phone"
                                   value="${sessionScope.user.phone}" />
                        </div>

                        <div class="hb-field">
                            <label class="hb-label">Mật khẩu</label>
                            <input class="hb-input" type="password" name="password"
                                   value="${sessionScope.user.password}" />
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