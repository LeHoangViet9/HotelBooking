<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp" />

<div class="wrapper">
    <!-- ===== BLOG HERO ===== -->
    <section class="blog-hero">
        <div class="blog-hero-content">
            <span class="blog-hero-label"><i class="fa-solid fa-newspaper"></i>Hotel Blog</span>
            <h1>Khám phá & Trải nghiệm Việt Nam</h1>
            <p>Cẩm nang du lịch, mẹo đặt phòng, ẩm thực và những câu chuyện đáng nhớ từ khắp nơi trên đất nước hình chữ S.</p>
            <div class="blog-search-bar">
                <input type="text" placeholder="Tìm kiếm bài viết...">
                <button><i class="fa-solid fa-magnifying-glass"></i></button>
            </div>
        </div>
    </section>

    <div class="blog-main">

        <!-- ===== CATEGORY TABS ===== -->
        <div class="blog-categories">
            <button class="cat-btn active" onclick="filterPosts('all', this)">Tất cả</button>
            <button class="cat-btn" onclick="filterPosts('camnan', this)">📍 Cẩm nang</button>
            <button class="cat-btn" onclick="filterPosts('amthuc', this)">🍜 Ẩm thực</button>
            <button class="cat-btn" onclick="filterPosts('meohay', this)">💡 Mẹo hay</button>
            <button class="cat-btn" onclick="filterPosts('nghiduong', this)">🏖 Nghỉ dưỡng</button>
            <button class="cat-btn" onclick="filterPosts('vanboa', this)">🏛 Văn hóa</button>
        </div>

        <!-- ===== FEATURED POST ===== -->
        <article class="blog-featured-post post-item" data-cat="camnan">
            <div class="featured-img">
                <div class="featured-img-placeholder" style="background:linear-gradient(135deg,#003580,#0071c2)">
                    <i class="fa-solid fa-map-location-dot"></i>
                </div>
                <span class="featured-label">Bài viết nổi bật</span>
            </div>
            <div class="featured-body">
                <span class="blog-cat-badge">📍 Cẩm nang</span>
                <h2>Top 10 điểm du lịch không thể bỏ lỡ tại Việt Nam 2026</h2>
                <p>Từ vịnh Hạ Long kỳ vĩ đến phố cổ Hội An lãng mạn, từ núi rừng Sa Pa mờ sương đến bãi biển Phú Quốc trong xanh – Việt Nam là điểm đến tuyệt vời cho mọi loại hình du lịch. Bài viết này tổng hợp 10 địa điểm du lịch được yêu thích nhất năm 2026 mà bạn nhất định không thể bỏ qua trong chuyến hành trình khám phá Việt Nam.</p>
                <div class="blog-post-meta">
                    <span><i class="fa-solid fa-circle-user" style="color:#0071c2"></i> Lê Hoàng Việt</span>
                    <span><i class="fa-regular fa-calendar" style="color:#0071c2"></i> 10 tháng 3, 2026</span>
                    <span><i class="fa-regular fa-clock" style="color:#0071c2"></i> 5 phút đọc</span>
                    <span><i class="fa-regular fa-eye" style="color:#0071c2"></i> 2,840 lượt xem</span>
                </div>
                <a href="#" class="blog-read-more">Đọc tiếp <i class="fa-solid fa-arrow-right"></i></a>
            </div>
        </article>

        <!-- ===== POST GRID ===== -->
        <div class="blog-posts-grid">

            <!-- Post 1 -->
            <article class="blog-post-card post-item" data-cat="amthuc">
                <div class="post-card-img" style="background:linear-gradient(135deg,#e6a500,#FFB700)">
                    <i class="fa-solid fa-utensils"></i>
                </div>
                <div class="post-card-body">
                    <span class="blog-cat-badge blog-cat-food">🍜 Ẩm thực</span>
                    <h3>Ăn gì ở Hà Nội? 15 món đặc sản nhất định phải thử</h3>
                    <p>Phở bò truyền thống, bún chả kiểu Hà Nội, bún đậu mắm tôm đậm đà... Khám phá ẩm thực đường phố thủ đô qua góc nhìn của người địa phương.</p>
                    <div class="blog-post-meta">
                        <span><i class="fa-regular fa-calendar"></i> 05/03/2026</span>
                        <span><i class="fa-regular fa-clock"></i> 4 phút</span>
                    </div>
                    <a href="#" class="post-card-link">Đọc bài <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </article>

            <!-- Post 2 -->
            <article class="blog-post-card post-item" data-cat="meohay">
                <div class="post-card-img" style="background:linear-gradient(135deg,#2e7d32,#43a047)">
                    <i class="fa-solid fa-suitcase-rolling"></i>
                </div>
                <div class="post-card-body">
                    <span class="blog-cat-badge blog-cat-tips">💡 Mẹo hay</span>
                    <h3>Bí kíp đặt phòng khách sạn giá rẻ chất lượng cao</h3>
                    <p>Đặt trước bao lâu để được giá tốt nhất? Các yếu tố nào quyết định giá phòng? Tổng hợp những mẹo đặt phòng thực chiến từ những "tay phượt" kinh nghiệm.</p>
                    <div class="blog-post-meta">
                        <span><i class="fa-regular fa-calendar"></i> 01/03/2026</span>
                        <span><i class="fa-regular fa-clock"></i> 6 phút</span>
                    </div>
                    <a href="#" class="post-card-link">Đọc bài <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </article>

            <!-- Post 3 -->
            <article class="blog-post-card post-item" data-cat="nghiduong">
                <div class="post-card-img" style="background:linear-gradient(135deg,#00838f,#00acc1)">
                    <i class="fa-solid fa-umbrella-beach"></i>
                </div>
                <div class="post-card-body">
                    <span class="blog-cat-badge blog-cat-resort">🏖 Nghỉ dưỡng</span>
                    <h3>Phú Quốc – Thiên đường biển đảo của Việt Nam</h3>
                    <p>Nước biển trong vắt, bãi cát trắng mịn, resort 5 sao tầm nhìn hướng biển – Phú Quốc thực sự là viên ngọc xanh của vùng vịnh Thái Lan.</p>
                    <div class="blog-post-meta">
                        <span><i class="fa-regular fa-calendar"></i> 25/02/2026</span>
                        <span><i class="fa-regular fa-clock"></i> 5 phút</span>
                    </div>
                    <a href="#" class="post-card-link">Đọc bài <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </article>

            <!-- Post 4 -->
            <article class="blog-post-card post-item" data-cat="camnan">
                <div class="post-card-img" style="background:linear-gradient(135deg,#4527a0,#7e57c2)">
                    <i class="fa-solid fa-mountain-sun"></i>
                </div>
                <div class="post-card-body">
                    <span class="blog-cat-badge">📍 Cẩm nang</span>
                    <h3>Sa Pa mùa nào đẹp nhất? Lịch trình 3 ngày 2 đêm</h3>
                    <p>Hoa mận trắng tháng Giêng, ruộng bậc thang mùa lúa chín tháng 9 – Sa Pa bốn mùa đều có vẻ đẹp riêng. Hướng dẫn lịch trình chi tiết cho chuyến đi hoàn hảo.</p>
                    <div class="blog-post-meta">
                        <span><i class="fa-regular fa-calendar"></i> 20/02/2026</span>
                        <span><i class="fa-regular fa-clock"></i> 7 phút</span>
                    </div>
                    <a href="#" class="post-card-link">Đọc bài <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </article>

            <!-- Post 5 -->
            <article class="blog-post-card post-item" data-cat="vanboa">
                <div class="post-card-img" style="background:linear-gradient(135deg,#bf360c,#f4511e)">
                    <i class="fa-solid fa-torii-gate"></i>
                </div>
                <div class="post-card-body">
                    <span class="blog-cat-badge blog-cat-culture">🏛 Văn hóa</span>
                    <h3>Hội An – Thành phố cổ đẹp nhất châu Á</h3>
                    <p>Những chiếc đèn lồng lung linh, những con phố cổ yên bình và ẩm thực đặc trưng của vùng đất cảng thương thuyền xưa – Hội An là điểm đến không thể bỏ qua.</p>
                    <div class="blog-post-meta">
                        <span><i class="fa-regular fa-calendar"></i> 15/02/2026</span>
                        <span><i class="fa-regular fa-clock"></i> 4 phút</span>
                    </div>
                    <a href="#" class="post-card-link">Đọc bài <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </article>

            <!-- Post 6 -->
            <article class="blog-post-card post-item" data-cat="amthuc">
                <div class="post-card-img" style="background:linear-gradient(135deg,#c62828,#ef5350)">
                    <i class="fa-solid fa-bowl-food"></i>
                </div>
                <div class="post-card-body">
                    <span class="blog-cat-badge blog-cat-food">🍜 Ẩm thực</span>
                    <h3>Bún bò Huế – Hương vị đậm đà của đất cố đô</h3>
                    <p>Màu đỏ của ớt, vị ngọt của xương hầm, mùi thơm của sả và mắm ruốc đặc trưng – bún bò Huế là một tuyệt phẩm ẩm thực mang đậm hồn Huế.</p>
                    <div class="blog-post-meta">
                        <span><i class="fa-regular fa-calendar"></i> 10/02/2026</span>
                        <span><i class="fa-regular fa-clock"></i> 3 phút</span>
                    </div>
                    <a href="#" class="post-card-link">Đọc bài <i class="fa-solid fa-arrow-right"></i></a>
                </div>
            </article>

        </div>

        <!-- ===== SIDEBAR + EXTRA ===== -->
        <div class="blog-extra-row">

            <!-- Popular Tags -->
            <div class="blog-sidebar-card">
                <h4><i class="fa-solid fa-tags"></i> Chủ đề phổ biến</h4>
                <div class="tag-cloud">
                    <a href="#" class="tag-pill">Hà Nội</a>
                    <a href="#" class="tag-pill">Hồ Chí Minh</a>
                    <a href="#" class="tag-pill">Đà Nẵng</a>
                    <a href="#" class="tag-pill">Phú Quốc</a>
                    <a href="#" class="tag-pill">Sa Pa</a>
                    <a href="#" class="tag-pill">Hội An</a>
                    <a href="#" class="tag-pill">Đà Lạt</a>
                    <a href="#" class="tag-pill">Nha Trang</a>
                    <a href="#" class="tag-pill">Vịnh Hạ Long</a>
                    <a href="#" class="tag-pill">Du lịch bụi</a>
                    <a href="#" class="tag-pill">Ẩm thực</a>
                    <a href="#" class="tag-pill">Resort 5 sao</a>
                    <a href="#" class="tag-pill">Mẹo tiết kiệm</a>
                    <a href="#" class="tag-pill">Gia đình</a>
                </div>
            </div>

            <!-- Newsletter sidebar -->
            <div class="blog-sidebar-card blog-newsletter-card">
                <div class="newsletter-icon"><i class="fa-solid fa-paper-plane"></i></div>
                <h4>Nhận bài viết mới nhất</h4>
                <p>Đăng ký để không bỏ lỡ bất kỳ mẹo du lịch hay ưu đãi khách sạn nào.</p>
                <form onsubmit="return false;" class="sidebar-newsletter-form">
                    <input type="email" placeholder="Email của bạn...">
                    <button type="submit">Đăng ký ngay</button>
                </form>
            </div>

            <!-- Quick links -->
            <div class="blog-sidebar-card">
                <h4><i class="fa-solid fa-bolt"></i> Đặt phòng ngay</h4>
                <p style="color:#6b7280;font-size:14px;margin-bottom:14px;">Tìm khách sạn ưng ý tại các điểm đến trong bài viết.</p>
                <div class="quick-dest-list">
                    <a href="${pageContext.request.contextPath}/search?city=Ha+Noi" class="quick-dest-item">
                        <i class="fa-solid fa-location-dot" style="color:#0071c2"></i> Khách sạn Hà Nội
                        <i class="fa-solid fa-chevron-right"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/search?city=Ho+Chi+Minh" class="quick-dest-item">
                        <i class="fa-solid fa-location-dot" style="color:#0071c2"></i> Khách sạn TP.HCM
                        <i class="fa-solid fa-chevron-right"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/search?city=Da+Nang" class="quick-dest-item">
                        <i class="fa-solid fa-location-dot" style="color:#0071c2"></i> Khách sạn Đà Nẵng
                        <i class="fa-solid fa-chevron-right"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/search?city=Phu+Quoc" class="quick-dest-item">
                        <i class="fa-solid fa-location-dot" style="color:#0071c2"></i> Khách sạn Phú Quốc
                        <i class="fa-solid fa-chevron-right"></i>
                    </a>
                </div>
            </div>

        </div>

        <!-- ===== LOAD MORE ===== -->
        <div class="blog-load-more">
            <button class="load-more-btn" id="loadMoreBtn">
                <i class="fa-solid fa-rotate"></i> Tải thêm bài viết
            </button>
        </div>

    </div><!-- /.blog-main -->
</div><!-- /.wrapper -->

<jsp:include page="/views/layout/footer.jsp" />

<script>
function filterPosts(cat, btn) {
    document.querySelectorAll('.cat-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');

    document.querySelectorAll('.post-item').forEach(item => {
        if (cat === 'all' || item.dataset.cat === cat) {
            item.style.display = '';
            item.style.animation = 'fadeInUp 0.3s ease both';
        } else {
            item.style.display = 'none';
        }
    });
}

document.getElementById('loadMoreBtn').addEventListener('click', function() {
    this.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Đang tải...';
    setTimeout(() => {
        this.innerHTML = '<i class="fa-solid fa-check"></i> Đã tải hết bài viết';
        this.disabled = true;
        this.style.opacity = '0.6';
    }, 1200);
});
</script>

</html>
