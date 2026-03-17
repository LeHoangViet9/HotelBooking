<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!-- ===== FOOTER ===== -->
<footer class="site-footer">

    <!-- Newsletter Banner -->
    <div class="footer-newsletter">
        <div class="footer-newsletter-inner">
            <div class="newsletter-text">
                <h3><i class="fa-solid fa-envelope-open-text"></i>Nhận ưu đãi độc quyền</h3>
                <p>Đăng ký nhận bản tin để không bỏ lỡ khuyến mãi và mẹo du lịch mới nhất.</p>
            </div>
            <form class="newsletter-form" onsubmit="return false;">
                <input type="email" placeholder="Nhập email của bạn...">
                <button type="submit">Đăng kí</button>
            </form>
        </div>
    </div>

    <!-- Main Footer Links -->
    <div class="footer-main">
        <div class="footer-main-inner">

            <div class="footer-col footer-brand">
                <div class="footer-logo">HotelBooking<span>.</span>com</div>
                <p>Nền tảng đặt phòng khách sạn hàng đầu Việt Nam. Tìm kiếm, so sánh và đặt phòng ngay hôm nay.</p>
                <div class="footer-social">
                    <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" aria-label="Twitter"><i class="fa-brands fa-x-twitter"></i></a>
                    <a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
                </div>
            </div>

            <div class="footer-col">
                <h4>Khám phá</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/search?city=Ha+Noi">Khách sạn Hà Nội</a></li>
                    <li><a href="${pageContext.request.contextPath}/search?city=Ho+Chi+Minh">Khách sạn Hồ Chí Minh</a></li>
                    <li><a href="${pageContext.request.contextPath}/search?city=Da+Nang">Khách sạn Đà Nẵng</a></li>
                    <li><a href="${pageContext.request.contextPath}/search?city=Nha+Trang">Khách sạn Nha Trang</a></li>
                    <li><a href="${pageContext.request.contextPath}/search?city=Da+Lat">Khách sạn Đà Lạt</a></li>
                    <li><a href="${pageContext.request.contextPath}/search?city=Phu+Quoc">Khách sạn Phú Quốc</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>HotelBooking</h4>
                <ul>
                    <li><a href="#">Về chúng tôi</a></li>
                    <li><a href="${pageContext.request.contextPath}/blog">Blog Du lịch</a></li>
                    <li><a href="#">Cơ hội nghề nghiệp</a></li>
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Điều khoản sử dụng</a></li>
                    <li><a href="#">Đối tác của chúng tôi</a></li>
                </ul>
            </div>

        </div>
    </div>

    <!-- Footer Bottom Bar -->
    <div class="footer-bottom">
        <div class="footer-bottom-inner">
            <p>© 2026 HotelBooking.com – All rights reserved. Bản quyền thuộc về Le Hoang Viet.</p>
            <div class="footer-payments">
                <i class="fa-brands fa-cc-visa" title="Visa"></i>
                <i class="fa-brands fa-cc-mastercard" title="Mastercard"></i>
                <i class="fa-brands fa-cc-paypal" title="PayPal"></i>
                <i class="fa-brands fa-cc-apple-pay" title="Apple Pay"></i>
            </div>
        </div>
    </div>

</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function toggleUserMenu() {
  const dd = document.getElementById('userDropdown');
  if (dd) dd.classList.toggle('open');
}
document.addEventListener('click', function (e) {
  const wrapper = document.querySelector('.user-menu-wrapper');
  if (wrapper && !wrapper.contains(e.target)) {
    const dd = document.getElementById('userDropdown');
    if (dd) dd.classList.remove('open');
  }
});
</script>
