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
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">
                <i class="fa-solid fa-gauge"></i> Dashboard
            </a>
            <div class="nav-group-label">Quản lý</div>
            <a href="${pageContext.request.contextPath}/adminHotel" class="sidebar-link">
                <i class="fa-solid fa-hotel"></i> Khách sạn
            </a>
            <a href="${pageContext.request.contextPath}/admin/booking" class="sidebar-link active">
                <i class="fa-solid fa-calendar-check"></i> Đặt phòng
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

    <!-- ===== MAIN ===== -->
    <main class="admin-main">
        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">
                    <i class="fa-solid fa-calendar-check"></i> Quản lý Đặt phòng
                </h1>
                <p class="admin-page-subtitle">Duyệt, xác nhận và theo dõi tất cả đặt phòng</p>
            </div>
            <button class="sidebar-toggle" onclick="toggleSidebar()">
                <i class="fa-solid fa-bars"></i>
            </button>
        </div>

        <!-- Filter / Search Bar -->
        <div class="admin-card" style="margin-bottom:20px;">
            <div style="padding:16px 20px; display:flex; gap:12px; flex-wrap:wrap; align-items:flex-end;">
                <form method="get" action="${pageContext.request.contextPath}/admin/booking"
                      style="display:flex; gap:12px; flex-wrap:wrap; align-items:flex-end; width:100%">
                    <div style="flex:1; min-width:200px;">
                        <label style="font-size:12px;font-weight:700;color:#64748b;display:block;margin-bottom:4px;">
                            <i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
                        </label>
                        <input type="text" name="keyword" value="${keyword}"
                               placeholder="Tên khách, tên khách sạn..."
                               style="width:100%;padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                    </div>
                    <div>
                        <label style="font-size:12px;font-weight:700;color:#64748b;display:block;margin-bottom:4px;">
                            <i class="fa-solid fa-filter"></i> Trạng thái
                        </label>
                        <select name="status"
                                style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;background:#fff;min-width:160px;">
                            <option value="">Tất cả</option>
                            <option value="PENDING"   ${statusFilter == 'PENDING'   ? 'selected' : ''}>Chờ duyệt</option>
                            <option value="CONFIRMED" ${statusFilter == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
                            <option value="COMPLETED" ${statusFilter == 'COMPLETED' ? 'selected' : ''}>Hoàn thành</option>
                            <option value="CANCELLED" ${statusFilter == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                    </div>
                    <button type="submit" style="background:#0071c2;color:#fff;border:none;padding:9px 20px;border-radius:7px;font-size:14px;font-weight:600;cursor:pointer;height:38px;">
                        Lọc
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/booking"
                       style="padding:9px 16px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;color:#555;text-decoration:none;height:38px;display:flex;align-items:center;">
                        Xóa lọc
                    </a>
                </form>
            </div>
        </div>

        <!-- Bookings Table -->
        <div class="admin-card">
            <div class="admin-card-header">
                <h4><i class="fa-solid fa-list"></i> Danh sách đặt phòng
                    <span style="font-size:13px;font-weight:400;color:#64748b;margin-left:8px;">
                        (${bookings.size()} kết quả)
                    </span>
                </h4>
            </div>

            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="empty-state">
                        <i class="fa-solid fa-inbox"></i>
                        <p>Không có đặt phòng nào phù hợp.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>#</th>
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
                                <c:forEach var="b" items="${bookings}">
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
                                                    <form method="post" action="${pageContext.request.contextPath}/updateBooking" style="display:inline">
                                                        <input type="hidden" name="id" value="${b.id}">
                                                        <input type="hidden" name="status" value="CANCELLED">
                                                        <button class="btn-cancel-sm" title="Hủy xác nhận">
                                                            <i class="fa-solid fa-xmark"></i>
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

    </main>
</div>

<jsp:include page="/views/layout/footer.jsp" />

<script>
function toggleSidebar() {
    document.getElementById('adminSidebar').classList.toggle('collapsed');
}
</script>
</html>
