<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp" />

<div class="hb-page">
    <div class="hb-container">
        <div class="auth-page">
            <div class="auth-card">
                <div class="auth-card-header">
                    <h1>Quên mật khẩu</h1>
                    <p>Nhập email để nhận liên kết đặt lại mật khẩu.</p>
                </div>
                <div class="auth-card-body">
                    <form action="${pageContext.request.contextPath}/forgot" method="post" novalidate>
                        <div class="hb-field">
                            <label class="hb-label">Email</label>
                            <input class="hb-input" type="email" name="email" placeholder="vd: email@gmail.com" required>
                        </div>

                        <div class="auth-actions">
                            <button class="hb-btn hb-btn-primary hb-btn-block" type="submit">
                                Gửi liên kết khôi phục
                            </button>
                        </div>

                        <div class="auth-links">
                            <div class="auth-inline">
                                <span>Nhớ mật khẩu rồi?</span>
                                <a href="${pageContext.request.contextPath}/login">Quay lại đăng nhập</a>
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