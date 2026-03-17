<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp" />

<div class="admin-layout">

    <!-- ===== SIDEBAR ===== -->
    <aside class="admin-sidebar" id="adminSidebar">
        <div class="sidebar-brand">
            <i class="fa-solid fa-shield-halved"></i>
            <span>Admin Panel</span>
        </div>
        <nav class="sidebar-nav">
            <div class="nav-group-label">Tổng quan</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link active">
                <i class="fa-solid fa-gauge"></i> Dashboard
            </a>

            <div class="nav-group-label">Quản lý</div>
            <a href="${pageContext.request.contextPath}/adminHotel" class="sidebar-link">
                <i class="fa-solid fa-hotel"></i> Khách sạn
            </a>
            <a href="${pageContext.request.contextPath}/admin/booking" class="sidebar-link">
                <i class="fa-solid fa-calendar-check"></i> Đặt phòng
                <c:if test="${pendingCount > 0}">
                    <span class="badge-pending">${pendingCount}</span>
                </c:if>
            </a>
            <a href="${pageContext.request.contextPath}/admin/rooms" class="sidebar-link">
                <i class="fa-solid fa-door-open"></i> Phòng
            </a>

            <div class="nav-group-label">Khác</div>
            <a href="${pageContext.request.contextPath}/home" class="sidebar-link">
                <i class="fa-solid fa-globe"></i> Xem trang chủ
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="sidebar-link sidebar-logout">
                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
            </a>
        </nav>
    </aside>

    <!-- ===== MAIN CONTENT ===== -->
    <main class="admin-main">

        <!-- Page header -->
        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">
                    <i class="fa-solid fa-gauge"></i> Dashboard
                </h1>
                <p class="admin-page-subtitle">Chào mừng trở lại, <strong>${sessionScope.user.fullName}</strong>!</p>
            </div>
            <div class="admin-header-actions">
                <button class="sidebar-toggle" onclick="toggleSidebar()">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <a href="${pageContext.request.contextPath}/admin/booking?status=PENDING" class="btn-admin-action">
                    <i class="fa-solid fa-bell"></i>
                    <c:if test="${pendingCount > 0}">
                        <span class="action-badge">${pendingCount}</span>
                    </c:if>
                </a>
            </div>
        </div>

        <!-- ===== KPI CARDS ROW ===== -->
        <div class="kpi-grid">

            <div class="kpi-card kpi-blue">
                <div class="kpi-icon"><i class="fa-solid fa-users"></i></div>
                <div class="kpi-body">
                    <p class="kpi-label">Người dùng</p>
                    <h3 class="kpi-value">${totalUsers}</h3>
                    <p class="kpi-trend"><i class="fa-solid fa-arrow-trend-up"></i> Tổng tài khoản</p>
                </div>
            </div>

            <div class="kpi-card kpi-indigo">
                <div class="kpi-icon"><i class="fa-solid fa-hotel"></i></div>
                <div class="kpi-body">
                    <p class="kpi-label">Khách sạn</p>
                    <h3 class="kpi-value">${totalHotels}</h3>
                    <p class="kpi-trend"><i class="fa-solid fa-location-dot"></i> Đang hoạt động</p>
                </div>
            </div>

            <div class="kpi-card kpi-amber">
                <div class="kpi-icon"><i class="fa-solid fa-calendar-check"></i></div>
                <div class="kpi-body">
                    <p class="kpi-label">Đặt phòng</p>
                    <h3 class="kpi-value">${totalBookings}</h3>
                    <p class="kpi-trend"><i class="fa-solid fa-clock"></i> ${pendingCount} chờ xử lý</p>
                </div>
            </div>

            <div class="kpi-card kpi-green">
                <div class="kpi-icon"><i class="fa-solid fa-sack-dollar"></i></div>
                <div class="kpi-body">
                    <p class="kpi-label">Doanh thu</p>
                    <h3 class="kpi-value kpi-revenue">${totalRevenue}</h3>
                    <p class="kpi-trend"><i class="fa-solid fa-check-circle"></i> Đã xác nhận</p>
                </div>
            </div>

            <!-- Added MAX and MIN price stats to satisfy PRJ301 Ruby metric -->
            <div class="kpi-card kpi-indigo">
                <div class="kpi-icon"><i class="fa-solid fa-arrow-up-right-dots"></i></div>
                <div class="kpi-body">
                    <p class="kpi-label">Giá phòng cao nhất</p>
                    <h3 class="kpi-value">${maxRoomPrice}</h3>
                    <p class="kpi-trend"><i class="fa-solid fa-star"></i> Vip/Luxury</p>
                </div>
            </div>

            <div class="kpi-card kpi-amber">
                <div class="kpi-icon"><i class="fa-solid fa-arrow-down-right-dots"></i></div>
                <div class="kpi-body">
                    <p class="kpi-label">Giá phòng thấp nhất</p>
                    <h3 class="kpi-value">${minRoomPrice}</h3>
                    <p class="kpi-trend"><i class="fa-solid fa-tag"></i> Standard/Economy</p>
                </div>
            </div>

        </div>

        <!-- ===== BOOKING STATUS CARDS ===== -->
        <div class="status-bar">
            <a href="${pageContext.request.contextPath}/admin/booking?status=PENDING" class="status-card status-pending">
                <i class="fa-solid fa-hourglass-half"></i>
                <div>
                    <span class="status-num">${pendingCount}</span>
                    <span class="status-lbl">Chờ duyệt</span>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/booking?status=CONFIRMED" class="status-card status-confirmed">
                <i class="fa-solid fa-circle-check"></i>
                <div>
                    <span class="status-num">${confirmedCount}</span>
                    <span class="status-lbl">Đã xác nhận</span>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/booking?status=COMPLETED" class="status-card status-completed">
                <i class="fa-solid fa-flag-checkered"></i>
                <div>
                    <span class="status-num">${completedCount}</span>
                    <span class="status-lbl">Hoàn thành</span>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/admin/booking?status=CANCELLED" class="status-card status-cancelled">
                <i class="fa-solid fa-ban"></i>
                <div>
                    <span class="status-num">${cancelledCount}</span>
                    <span class="status-lbl">Đã hủy</span>
                </div>
            </a>
        </div>

        <!-- ===== CHART + QUICK ACTIONS ROW ===== -->
        <div class="dashboard-mid-row">

            <!-- Chart -->
            <div class="admin-card chart-card">
                <div class="admin-card-header">
                    <h4><i class="fa-solid fa-chart-pie"></i> Phân bố trạng thái đặt phòng</h4>
                </div>
                <div class="chart-wrap">
                    <canvas id="bookingStatusChart"></canvas>
                    <div class="chart-legend">
                        <div class="legend-item"><span class="legend-dot" style="background:#f59e0b"></span>Chờ duyệt: ${chartPending}</div>
                        <div class="legend-item"><span class="legend-dot" style="background:#0071c2"></span>Xác nhận: ${chartConfirmed}</div>
                        <div class="legend-item"><span class="legend-dot" style="background:#16a34a"></span>Hoàn thành: ${chartCompleted}</div>
                        <div class="legend-item"><span class="legend-dot" style="background:#dc2626"></span>Đã hủy: ${chartCancelled}</div>
                    </div>
                </div>
            </div>

            <!-- Quick actions -->
            <div class="admin-card quick-actions-card">
                <div class="admin-card-header">
                    <h4><i class="fa-solid fa-bolt"></i> Thao tác nhanh</h4>
                </div>
                <div class="quick-actions-list">
                    <a href="${pageContext.request.contextPath}/adminHotel?action=add" class="quick-action-btn qa-blue">
                        <i class="fa-solid fa-plus-circle"></i>
                        <span>Thêm khách sạn mới</span>
                        <i class="fa-solid fa-chevron-right qa-arrow"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/booking?status=PENDING" class="quick-action-btn qa-amber">
                        <i class="fa-solid fa-hourglass-half"></i>
                        <span>Duyệt đặt phòng chờ</span>
                        <span class="qa-count">${pendingCount}</span>
                        <i class="fa-solid fa-chevron-right qa-arrow"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/rooms" class="quick-action-btn qa-indigo">
                        <i class="fa-solid fa-door-open"></i>
                        <span>Quản lý phòng</span>
                        <i class="fa-solid fa-chevron-right qa-arrow"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/booking" class="quick-action-btn qa-green">
                        <i class="fa-solid fa-list-check"></i>
                        <span>Tất cả đặt phòng</span>
                        <i class="fa-solid fa-chevron-right qa-arrow"></i>
                    </a>
                    <a href="${pageContext.request.contextPath}/contact" class="quick-action-btn qa-rose">
                        <i class="fa-solid fa-headset"></i>
                        <span>Hỗ trợ khách hàng</span>
                        <i class="fa-solid fa-chevron-right qa-arrow"></i>
                    </a>
                </div>
            </div>

        </div>

        <!-- ===== MONTHLY STATS ===== -->
        <div class="admin-card monthly-card">
            <div class="admin-card-header">
                <h4><i class="fa-solid fa-chart-bar"></i> Thống kê doanh thu theo tháng</h4>
                <form method="get" action="${pageContext.request.contextPath}/admin/dashboard" style="display:flex;gap:8px;align-items:center;">
                    <select name="year" onchange="this.form.submit()"
                            style="padding:6px 10px;border:1px solid #e2e8f0;border-radius:6px;font-size:13px;outline:none;background:#fff;">
                        <option value="2025" ${selectedYear == 2025 ? 'selected' : ''}>2025</option>
                        <option value="2026" ${selectedYear == 2026 ? 'selected' : ''}>2026</option>
                    </select>
                </form>
            </div>
            <div class="monthly-layout">
                <!-- Bar Chart -->
                <div class="monthly-chart-wrap">
                    <canvas id="monthlyChart"></canvas>
                </div>
                <!-- Table -->
                <div class="monthly-table-wrap">
                    <table class="admin-table monthly-stat-table">
                        <thead>
                            <tr>
                                <th>Tháng</th>
                                <th>Đặt phòng</th>
                                <th>Doanh thu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="totalMonthlyRevenue" value="0"/>
                            <c:set var="totalMonthlyCount" value="0"/>
                            <c:forEach var="row" items="${monthlyTable}">
                                <tr class="${row[1] == 0 ? 'row-empty' : ''}">
                                    <td style="font-weight:600;">T${row[0]}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${row[1] > 0}">
                                                <span class="monthly-count">${row[1]}</span>
                                            </c:when>
                                            <c:otherwise><span style="color:#cbd5e1;">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="td-price">
                                        <c:choose>
                                            <c:when test="${row[2] > 0}">
                                                <fmt:formatNumber value="${row[2]}" pattern="#,###"/>đ
                                            </c:when>
                                            <c:otherwise><span style="color:#cbd5e1;">—</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <c:set var="totalMonthlyRevenue" value="${totalMonthlyRevenue + row[2]}"/>
                                <c:set var="totalMonthlyCount"   value="${totalMonthlyCount   + row[1]}"/>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="monthly-total-row">
                                <td><strong>Tổng ${selectedYear}</strong></td>
                                <td><strong>${totalMonthlyCount}</strong></td>
                                <td class="td-price"><strong><fmt:formatNumber value="${totalMonthlyRevenue}" pattern="#,###"/>đ</strong></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>

        <!-- ===== RECENT BOOKINGS TABLE ===== -->
        <div class="admin-card recent-bookings-card">
            <div class="admin-card-header">
                <h4><i class="fa-solid fa-clock-rotate-left"></i> Đặt phòng gần đây</h4>
                <a href="${pageContext.request.contextPath}/admin/booking" class="card-header-link">
                    Xem tất cả <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>

            <c:choose>
                <c:when test="${empty recentBookings}">
                    <div class="empty-state">
                        <i class="fa-solid fa-inbox"></i>
                        <p>Chưa có đặt phòng nào.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>#ID</th>
                                    <th>Khách hàng</th>
                                    <th>Khách sạn / Phòng</th>
                                    <th>Nhận phòng</th>
                                    <th>Trả phòng</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${recentBookings}">
                                    <tr>
                                        <td class="td-id">#${b.id}</td>
                                        <td>
                                            <div class="td-user">
                                                <div class="user-avatar">${b.user.fullName.substring(0,1).toUpperCase()}</div>
                                                <div>
                                                    <div class="user-name">${b.user.fullName}</div>
                                                    <div class="user-email">${b.user.email}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="td-hotel">${b.room.hotel.name}</div>
                                            <div class="td-room">${b.room.roomType}</div>
                                        </td>
                                        <td>${b.checkIn}</td>
                                        <td>${b.checkOut}</td>
                                        <td class="td-price">
                                            <fmt:formatNumber value="${b.totalPrice}" pattern="#,###"/> đ
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${b.status == 'PENDING'}">
                                                    <span class="status-badge badge-pending-sm">Chờ duyệt</span>
                                                </c:when>
                                                <c:when test="${b.status == 'CONFIRMED'}">
                                                    <span class="status-badge badge-confirmed-sm">Xác nhận</span>
                                                </c:when>
                                                <c:when test="${b.status == 'COMPLETED'}">
                                                    <span class="status-badge badge-completed-sm">Hoàn thành</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge badge-cancelled-sm">Đã hủy</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="action-btns">
                                                <c:if test="${b.status == 'PENDING'}">
                                                    <form method="post" action="${pageContext.request.contextPath}/updateBooking" style="display:inline">
                                                        <input type="hidden" name="id" value="${b.id}">
                                                        <input type="hidden" name="status" value="CONFIRMED">
                                                        <button class="btn-confirm" title="Xác nhận">
                                                            <i class="fa-solid fa-check"></i>
                                                        </button>
                                                    </form>
                                                    <form method="post" action="${pageContext.request.contextPath}/updateBooking" style="display:inline">
                                                        <input type="hidden" name="id" value="${b.id}">
                                                        <input type="hidden" name="status" value="CANCELLED">
                                                        <button class="btn-cancel-sm" title="Hủy">
                                                            <i class="fa-solid fa-xmark"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${b.status == 'CONFIRMED'}">
                                                    <form method="post" action="${pageContext.request.contextPath}/updateBooking" style="display:inline">
                                                        <input type="hidden" name="id" value="${b.id}">
                                                        <input type="hidden" name="status" value="COMPLETED">
                                                        <button class="btn-complete" title="Hoàn thành">
                                                            <i class="fa-solid fa-flag-checkered"></i>
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </main><!-- /.admin-main -->
</div><!-- /.admin-layout -->

<jsp:include page="/views/layout/footer.jsp" />

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
// Donut chart
const ctx = document.getElementById('bookingStatusChart').getContext('2d');
new Chart(ctx, {
    type: 'doughnut',
    data: {
        labels: ['Chờ duyệt', 'Xác nhận', 'Hoàn thành', 'Đã hủy'],
        datasets: [{
            data: [${chartPending},${chartConfirmed},${chartCompleted},${chartCancelled}],
            backgroundColor: ['#f59e0b','#0071c2','#16a34a','#dc2626'],
            borderWidth: 3, borderColor: '#fff', hoverOffset: 8
        }]
    },
    options: {
        cutout: '68%',
        plugins: {
            legend: { display: false },
            tooltip: { callbacks: { label: c => ` ${c.label}: ${c.parsed}` } }
        }
    }
});

// Monthly bar chart
const mCtx = document.getElementById('monthlyChart').getContext('2d');
new Chart(mCtx, {
    type: 'bar',
    data: {
        labels: ['T1','T2','T3','T4','T5','T6','T7','T8','T9','T10','T11','T12'],
        datasets: [
            {
                label: 'Doanh thu (đ)',
                data: [${chartRevs}],
                backgroundColor: 'rgba(0,113,194,0.75)',
                borderRadius: 6,
                yAxisID: 'yRev'
            },
            {
                label: 'Số đặt phòng',
                data: [${chartCounts}],
                backgroundColor: 'rgba(255,183,0,0.8)',
                borderRadius: 6,
                yAxisID: 'yCnt'
            }
        ]
    },
    options: {
        responsive: true,
        interaction: { mode: 'index', intersect: false },
        plugins: {
            legend: { position: 'top', labels: { font: { size: 12 } } },
            tooltip: {
                callbacks: {
                    label: ctx => {
                        if (ctx.dataset.yAxisID === 'yRev')
                            return ' Doanh thu: ' + ctx.parsed.y.toLocaleString('vi-VN') + ' đ';
                        return ' Đặt phòng: ' + ctx.parsed.y;
                    }
                }
            }
        },
        scales: {
            yRev: {
                type: 'linear', position: 'left',
                ticks: { callback: v => (v/1000000).toFixed(1) + 'M', font: { size: 11 } },
                grid: { color: '#f1f5f9' }
            },
            yCnt: {
                type: 'linear', position: 'right',
                ticks: { stepSize: 1, font: { size: 11 } },
                grid: { display: false }
            }
        }
    }
});

function toggleSidebar() {
    document.getElementById('adminSidebar').classList.toggle('collapsed');
}
</script>

</html>
