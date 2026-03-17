<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp" />

<div class="wrapper">
    <!-- ===== HERO SECTION ===== -->
    <section class="hero-section">
        <div class="hero-overlay"></div>
        <div class="hero-content">
            <h1 class="hero-title">Tìm chỗ nghỉ hoàn hảo<br>cho chuyến đi của bạn</h1>
            <p class="hero-subtitle">Hàng nghìn khách sạn hàng đầu tại Việt Nam – giá tốt nhất, đặt phòng dễ dàng.</p>

            <!-- ===== SEARCH BOX ===== -->
            <div class="search-box">
                <form action="${pageContext.request.contextPath}/search" method="get" class="search-form-hero">

                    <div class="search-field">
                        <label><i class="fa-solid fa-location-dot"></i> Điểm đến</label>
                        <div class="search-input-wrap">
                            <input type="text" name="city" id="cityInput"
                                   placeholder="Bạn muốn đến đâu?"
                                   onkeyup="suggestCity()" autocomplete="off">
                            <div id="suggestions" class="suggestions-list"></div>
                        </div>
                    </div>

                    <div class="search-divider"></div>

                    <div class="search-field">
                        <label><i class="fa-regular fa-calendar"></i> Nhận phòng</label>
                        <input type="date" name="checkin" required>
                    </div>

                    <div class="search-divider"></div>

                    <div class="search-field">
                        <label><i class="fa-regular fa-calendar-check"></i> Trả phòng</label>
                        <input type="date" name="checkout" required>
                    </div>

                    <div class="search-divider"></div>

                    <div class="search-field">
                        <label><i class="fa-solid fa-tag"></i> Mức giá</label>
                        <select name="priceRange">
                            <option value="">Tất cả mức giá</option>
                            <option value="0-500000">Dưới 500.000đ</option>
                            <option value="500000-1000000">500k – 1 triệu</option>
                            <option value="1000000-2000000">1 – 2 triệu</option>
                            <option value="2000000-10000000">Trên 2 triệu</option>
                        </select>
                    </div>

                    <button type="submit" class="search-btn">
                        <i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
                    </button>

                </form>
            </div>
        </div>
    </section>

    <div class="main-content">

        <!-- ===== POPULAR DESTINATIONS ===== -->
        <section class="section-block">
            <div class="section-header">
                <h2>Điểm đến nổi bật tại Việt Nam</h2>
                <p>Khám phá các thành phố du lịch hàng đầu với hàng nghìn lựa chọn chỗ nghỉ</p>
            </div>
            <div class="destinations-grid">
                <a href="${pageContext.request.contextPath}/search?city=Ha+Noi" class="dest-card dest-large">
                    <img src="${pageContext.request.contextPath}/img/hanoi.jpg"
                         onerror="this.style.display='none'; this.parentElement.classList.add('dest-no-img');"
                         alt="Hà Nội">
                    <div class="dest-overlay">
                        <div class="dest-info">
                            <span class="dest-name">Hà Nội</span>
                            <span class="dest-count"><i class="fa-solid fa-hotel"></i> Khám phá ngay</span>
                        </div>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/search?city=Ho+Chi+Minh" class="dest-card">
                    <img src="${pageContext.request.contextPath}/img/hcm.jpg"
                         onerror="this.style.display='none';" alt="TP. Hồ Chí Minh">
                    <div class="dest-overlay">
                        <div class="dest-info">
                            <span class="dest-name">TP. Hồ Chí Minh</span>
                            <span class="dest-count"><i class="fa-solid fa-hotel"></i> Khám phá ngay</span>
                        </div>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/search?city=Da+Nang" class="dest-card">
                    <img src="${pageContext.request.contextPath}/img/danang.jpg"
                         onerror="this.style.display='none';" alt="Đà Nẵng">
                    <div class="dest-overlay">
                        <div class="dest-info">
                            <span class="dest-name">Đà Nẵng</span>
                            <span class="dest-count"><i class="fa-solid fa-hotel"></i> Khám phá ngay</span>
                        </div>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/search?city=Nha+Trang" class="dest-card">
                    <img src="${pageContext.request.contextPath}/img/nhatrang.jpg"
                         onerror="this.style.display='none';" alt="Nha Trang">
                    <div class="dest-overlay">
                        <div class="dest-info">
                            <span class="dest-name">Nha Trang</span>
                            <span class="dest-count"><i class="fa-solid fa-hotel"></i> Khám phá ngay</span>
                        </div>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/search?city=Da+Lat" class="dest-card">
                    <img src="${pageContext.request.contextPath}/img/dalat.jpg"
                         onerror="this.style.display='none';" alt="Đà Lạt">
                    <div class="dest-overlay">
                        <div class="dest-info">
                            <span class="dest-name">Đà Lạt</span>
                            <span class="dest-count"><i class="fa-solid fa-hotel"></i> Khám phá ngay</span>
                        </div>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/search?city=Phu+Quoc" class="dest-card">
                    <img src="${pageContext.request.contextPath}/img/phuquoc.jpg"
                         onerror="this.style.display='none';" alt="Phú Quốc">
                    <div class="dest-overlay">
                        <div class="dest-info">
                            <span class="dest-name">Phú Quốc</span>
                            <span class="dest-count"><i class="fa-solid fa-hotel"></i> Khám phá ngay</span>
                        </div>
                    </div>
                </a>
            </div>
        </section>

        <!-- ===== PROPERTY TYPES ===== -->
        <section class="section-block">
            <div class="section-header">
                <h2>Tìm theo loại chỗ nghỉ</h2>
                <p>Từ khách sạn sang trọng đến resort nghỉ dưỡng – chúng tôi đều có</p>
            </div>
            <div class="property-types-grid">
                <a href="${pageContext.request.contextPath}/search" class="property-type-card" style="--pt-color:#e8f0fe">
                    <div class="pt-icon" style="background:#003580"><i class="fa-solid fa-hotel"></i></div>
                    <span class="pt-name">Khách sạn</span>
                    <span class="pt-sub">Đa dạng hạng sao</span>
                </a>
                <a href="${pageContext.request.contextPath}/search" class="property-type-card" style="--pt-color:#fef6e4">
                    <div class="pt-icon" style="background:#e6a500"><i class="fa-solid fa-umbrella-beach"></i></div>
                    <span class="pt-name">Resort</span>
                    <span class="pt-sub">Nghỉ dưỡng cao cấp</span>
                </a>
                <a href="${pageContext.request.contextPath}/search" class="property-type-card" style="--pt-color:#e8fce8">
                    <div class="pt-icon" style="background:#2e7d32"><i class="fa-solid fa-house"></i></div>
                    <span class="pt-name">Villa & Homestay</span>
                    <span class="pt-sub">Cảm giác như nhà</span>
                </a>
                <a href="${pageContext.request.contextPath}/search" class="property-type-card" style="--pt-color:#fce8e8">
                    <div class="pt-icon" style="background:#c62828"><i class="fa-solid fa-gem"></i></div>
                    <span class="pt-name">Suite cao cấp</span>
                    <span class="pt-sub">Phòng tiêu chuẩn quốc tế</span>
                </a>
                <a href="${pageContext.request.contextPath}/search" class="property-type-card" style="--pt-color:#f3e5f5">
                    <div class="pt-icon" style="background:#6a1b9a"><i class="fa-solid fa-spa"></i></div>
                    <span class="pt-name">Spa & Wellness</span>
                    <span class="pt-sub">Thư giãn & chăm sóc</span>
                </a>
                <a href="${pageContext.request.contextPath}/search" class="property-type-card" style="--pt-color:#e0f7fa">
                    <div class="pt-icon" style="background:#00838f"><i class="fa-solid fa-water"></i></div>
                    <span class="pt-name">Bungalow & Ven biển</span>
                    <span class="pt-sub">Gần biển & thiên nhiên</span>
                </a>
            </div>
        </section>

        <!-- ===== WHY CHOOSE US ===== -->
        <section class="section-block why-us-section">
            <div class="why-us-banner">
                <div class="why-item">
                    <i class="fa-solid fa-shield-halved"></i>
                    <h4>Đặt phòng an toàn</h4>
                    <p>Thông tin bảo mật, thanh toán minh bạch</p>
                </div>
                <div class="why-divider"></div>
                <div class="why-item">
                    <i class="fa-solid fa-tag"></i>
                    <h4>Giá tốt nhất</h4>
                    <p>Cam kết giá cạnh tranh, nhiều ưu đãi</p>
                </div>
                <div class="why-divider"></div>
                <div class="why-item">
                    <i class="fa-solid fa-headset"></i>
                    <h4>Hỗ trợ 24/7</h4>
                    <p>Đội ngũ hỗ trợ luôn sẵn sàng giúp đỡ</p>
                </div>
                <div class="why-divider"></div>
                <div class="why-item">
                    <i class="fa-solid fa-star"></i>
                    <h4>Đánh giá thực tế</h4>
                    <p>Hàng nghìn đánh giá từ khách thực</p>
                </div>
            </div>
        </section>

        <!-- ===== SPECIAL OFFERS ===== -->
        <section class="section-block">
            <div class="section-header">
                <h2><i class="fa-solid fa-fire" style="color:#ff5a00"></i> Ưu đãi đặc biệt hôm nay</h2>
                <p>Đặt ngay để được giảm giá – số lượng có hạn!</p>
            </div>
            <div class="offers-grid">
                <div class="offer-card">
                    <div class="offer-badge">Giảm 20%</div>
                    <div class="offer-icon"><i class="fa-solid fa-moon"></i></div>
                    <h4>Đặt sớm tiết kiệm lớn</h4>
                    <p>Đặt phòng trước 7 ngày để nhận ưu đãi đặc biệt lên đến 20%.</p>
                    <a href="${pageContext.request.contextPath}/search" class="offer-btn">Đặt ngay</a>
                </div>
                <div class="offer-card">
                    <div class="offer-badge offer-badge-gold">Cuối tuần</div>
                    <div class="offer-icon" style="color:#FFB700"><i class="fa-solid fa-sun"></i></div>
                    <h4>Gói cuối tuần lý tưởng</h4>
                    <p>Check-in thứ 6, check-out chủ nhật – trải nghiệm 2 đêm thư giãn trọn vẹn.</p>
                    <a href="${pageContext.request.contextPath}/search" class="offer-btn">Xem ngay</a>
                </div>
                <div class="offer-card">
                    <div class="offer-badge offer-badge-green">Mới</div>
                    <div class="offer-icon" style="color:#2e7d32"><i class="fa-solid fa-leaf"></i></div>
                    <h4>Trải nghiệm sinh thái</h4>
                    <p>Khám phá những khu nghỉ dưỡng xanh thân thiện với môi trường.</p>
                    <a href="${pageContext.request.contextPath}/search" class="offer-btn">Khám phá</a>
                </div>
            </div>
        </section>

        <!-- ===== BLOG PREVIEW ===== -->
        <section class="section-block blog-preview-section">
            <div class="section-header">
                <h2><i class="fa-solid fa-newspaper" style="color:#003580"></i> Blog Du lịch</h2>
                <p>Cẩm nang, mẹo hay và những câu chuyện từ những chuyến đi đáng nhớ</p>
                <a href="${pageContext.request.contextPath}/blog" class="section-link">Xem tất cả bài viết <i class="fa-solid fa-arrow-right"></i></a>
            </div>
            <div class="blog-preview-grid">

                <a href="${pageContext.request.contextPath}/blog" class="blog-card blog-card-featured">
                    <div class="blog-card-img"
                         style="background:linear-gradient(135deg,#003580 0%,#0071c2 100%)">
                        <div class="blog-card-img-placeholder"><i class="fa-solid fa-map-location-dot"></i></div>
                    </div>
                    <div class="blog-card-body">
                        <span class="blog-tag">Cẩm nang</span>
                        <h3>Top 10 điểm du lịch không thể bỏ lỡ tại Việt Nam 2026</h3>
                        <p>Từ vịnh Hạ Long kỳ vĩ đến phố cổ Hội An lãng mạn – cùng khám phá những điểm đến tuyệt vời nhất đất nước hình chữ S.</p>
                        <div class="blog-meta">
                            <span><i class="fa-regular fa-calendar"></i> 10/03/2026</span>
                            <span><i class="fa-regular fa-clock"></i> 5 phút đọc</span>
                        </div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/blog" class="blog-card">
                    <div class="blog-card-img"
                         style="background:linear-gradient(135deg,#e6a500 0%,#FFB700 100%)">
                        <div class="blog-card-img-placeholder"><i class="fa-solid fa-utensils"></i></div>
                    </div>
                    <div class="blog-card-body">
                        <span class="blog-tag blog-tag-food">Ẩm thực</span>
                        <h3>Ăn gì ở Hà Nội? Những món phải thử một lần trong đời</h3>
                        <p>Phở, bún chả, bún đậu mắm tôm... khám phá ẩm thực đường phố Hà Nội qua lăng kính của người địa phương.</p>
                        <div class="blog-meta">
                            <span><i class="fa-regular fa-calendar"></i> 05/03/2026</span>
                            <span><i class="fa-regular fa-clock"></i> 4 phút đọc</span>
                        </div>
                    </div>
                </a>

                <a href="${pageContext.request.contextPath}/blog" class="blog-card">
                    <div class="blog-card-img"
                         style="background:linear-gradient(135deg,#2e7d32 0%,#43a047 100%)">
                        <div class="blog-card-img-placeholder"><i class="fa-solid fa-suitcase-rolling"></i></div>
                    </div>
                    <div class="blog-card-body">
                        <span class="blog-tag blog-tag-tips">Mẹo hay</span>
                        <h3>Bí kíp du lịch tiết kiệm mà vẫn sang chảnh cho giới trẻ</h3>
                        <p>Làm sao để có chuyến đi chất lượng với ngân sách eo hẹp? Những mẹo thực chiến từ những tay phượt dày dạn kinh nghiệm.</p>
                        <div class="blog-meta">
                            <span><i class="fa-regular fa-calendar"></i> 01/03/2026</span>
                            <span><i class="fa-regular fa-clock"></i> 6 phút đọc</span>
                        </div>
                    </div>
                </a>

            </div>
        </section>

        <!-- ===== APP BANNER ===== -->
        <section class="app-banner-section">
            <div class="app-banner-content">
                <div class="app-banner-text">
                    <h2>Đặt phòng dễ dàng hơn với ứng dụng VietNgủ</h2>
                    <p>Quản lý đặt phòng, nhận thông báo và ưu đãi riêng – mọi lúc mọi nơi.</p>
                    <div class="app-buttons">
                        <a href="#" class="app-btn">
                            <i class="fa-brands fa-apple"></i>
                            <span><small>Tải trên</small>App Store</span>
                        </a>
                        <a href="#" class="app-btn">
                            <i class="fa-brands fa-google-play"></i>
                            <span><small>Tải trên</small>Google Play</span>
                        </a>
                    </div>
                </div>
                <div class="app-banner-icons">
                    <i class="fa-solid fa-mobile-screen-button"></i>
                </div>
            </div>
        </section>

    </div><!-- /.main-content -->
</div><!-- /.wrapper -->

<jsp:include page="/views/layout/footer.jsp" />

<script>
function suggestCity() {
    let keyword = document.getElementById("cityInput").value;
    if (keyword.length === 0) {
        document.getElementById("suggestions").innerHTML = "";
        document.getElementById("suggestions").style.display = "none";
        return;
    }
    fetch("suggestCity?keyword=" + encodeURIComponent(keyword))
        .then(response => response.text())
        .then(data => {
            const box = document.getElementById("suggestions");
            box.innerHTML = data;
            box.style.display = data.trim() ? "block" : "none";
        });
}

function selectCity(name) {
    document.getElementById("cityInput").value = name;
    document.getElementById("suggestions").innerHTML = "";
    document.getElementById("suggestions").style.display = "none";
}

// Set default dates (today + 1, today + 2)
(function() {
    const today = new Date();
    const tomorrow = new Date(today); tomorrow.setDate(today.getDate() + 1);
    const dayAfter = new Date(today); dayAfter.setDate(today.getDate() + 2);
    const fmt = d => d.toISOString().split('T')[0];
    const checkins = document.querySelectorAll('input[name="checkin"]');
    const checkouts = document.querySelectorAll('input[name="checkout"]');
    checkins.forEach(el => { el.value = fmt(tomorrow); el.min = fmt(today); });
    checkouts.forEach(el => { el.value = fmt(dayAfter); el.min = fmt(tomorrow); });
})();
</script>

</html>
