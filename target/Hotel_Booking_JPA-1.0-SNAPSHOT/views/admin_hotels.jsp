<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <a href="${pageContext.request.contextPath}/adminHotel" class="sidebar-link active">
                <i class="fa-solid fa-hotel"></i> Khách sạn
            </a>
            <a href="${pageContext.request.contextPath}/admin/booking" class="sidebar-link">
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
                    <i class="fa-solid fa-hotel"></i> Quản lý Khách sạn
                </h1>
                <p class="admin-page-subtitle">Thêm, chỉnh sửa và xóa khách sạn trong hệ thống</p>
            </div>
            <button class="sidebar-toggle" onclick="toggleSidebar()">
                <i class="fa-solid fa-bars"></i>
            </button>
        </div>

        <!-- Hotel Table -->
        <div class="admin-card" style="margin-bottom:24px;">
            <div class="admin-card-header">
                <h4><i class="fa-solid fa-list"></i> Danh sách khách sạn (${hotels.size()})</h4>
            </div>
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Ảnh</th>
                            <th>Tên khách sạn</th>
                            <th>Địa chỉ</th>
                            <th>Thành phố</th>
                            <th>Đánh giá</th>
                            <th>Phòng</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty hotels}">
                            <tr><td colspan="7" style="text-align:center;padding:32px;color:#94a3b8;">
                                Chưa có khách sạn nào.
                            </td></tr>
                        </c:if>
                        <c:forEach var="h" items="${hotels}">
                            <tr>
                                <td>
                                    <img src="${pageContext.request.contextPath}/img/${h.image}"
                                         width="80" height="55" style="border-radius:6px;object-fit:cover;"
                                         onerror="this.style.display='none'">
                                </td>
                                <td>
                                    <div style="font-weight:600;color:#1e293b;">${h.name}</div>
                                </td>
                                <td style="color:#64748b;font-size:13px;">${h.address}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${h.city != null}">
                                            <span style="background:#e8f0fe;color:#003580;padding:3px 10px;border-radius:12px;font-size:12px;font-weight:600;">
                                                ${h.city.name}
                                            </span>
                                        </c:when>
                                        <c:otherwise><span style="color:#94a3b8;">N/A</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span style="background:#003580;color:#fff;padding:4px 10px;border-radius:6px;font-size:13px;font-weight:700;">
                                        ${h.rating} ★
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/rooms?hotelId=${h.id}"
                                       style="background:#dbeafe;color:#1d4ed8;padding:5px 12px;border-radius:6px;font-size:12px;font-weight:600;text-decoration:none;">
                                        <i class="fa-solid fa-door-open"></i> Xem phòng
                                    </a>
                                </td>
                                <td>
                                    <div class="action-btns">
                                        <a href="adminHotel?action=edit&id=${h.id}"
                                           style="background:#fef3c7;color:#92400e;width:30px;height:30px;border-radius:6px;display:flex;align-items:center;justify-content:center;text-decoration:none;font-size:13px;"
                                           title="Chỉnh sửa">
                                            <i class="fa-solid fa-pen"></i>
                                        </a>
                                        <a href="adminHotel?action=delete&id=${h.id}"
                                           style="background:#fee2e2;color:#991b1b;width:30px;height:30px;border-radius:6px;display:flex;align-items:center;justify-content:center;text-decoration:none;font-size:13px;"
                                           title="Xóa"
                                           onclick="return confirm('Xóa khách sạn \'${h.name}\'? Thao tác này không thể hoàn tác!')">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Add Hotel Form -->
        <div class="admin-card">
            <div class="admin-card-header">
                <h4><i class="fa-solid fa-plus-circle"></i> Thêm khách sạn mới</h4>
            </div>
            <div style="padding:24px;">
                <form action="adminHotel" method="post" style="display:grid;grid-template-columns:1fr 1fr;gap:18px;">

                    <div style="display:flex;flex-direction:column;gap:6px;">
                        <label style="font-size:13px;font-weight:600;color:#334155;">Tên khách sạn <span style="color:#dc2626">*</span></label>
                        <input type="text" name="name" placeholder="VD: Sunrise Hotel" required
                               style="padding:10px 14px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                    </div>

                    <div style="display:flex;flex-direction:column;gap:6px;">
                        <label style="font-size:13px;font-weight:600;color:#334155;">Địa chỉ <span style="color:#dc2626">*</span></label>
                        <input type="text" name="address" placeholder="VD: Hoan Kiem" required
                               style="padding:10px 14px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                    </div>

                    <div style="display:flex;flex-direction:column;gap:6px;">
                        <label style="font-size:13px;font-weight:600;color:#334155;">Thành phố <span style="color:#dc2626">*</span></label>
                        <select name="city_id" required
                                style="padding:10px 14px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;background:#fff;">
                            <c:forEach var="c" items="${cities}">
                                <option value="${c.id}">${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div style="display:flex;flex-direction:column;gap:6px;">
                        <label style="font-size:13px;font-weight:600;color:#334155;">Đánh giá (0–5)</label>
                        <input type="number" name="rating" step="0.1" min="0" max="5" placeholder="4.5"
                               style="padding:10px 14px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                    </div>

                    <div style="display:flex;flex-direction:column;gap:6px;">
                        <label style="font-size:13px;font-weight:600;color:#334155;">Tên file ảnh</label>
                        <input type="text" name="image" id="imageInput" placeholder="VD: hotel.webp"
                               style="padding:10px 14px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                    </div>

                    <div style="display:flex;flex-direction:column;gap:6px;">
                        <label style="font-size:13px;font-weight:600;color:#334155;">Mô tả</label>
                        <input type="text" name="description" placeholder="Mô tả ngắn về khách sạn"
                               style="padding:10px 14px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                    </div>

                    <div style="grid-column:span 2;">
                        <button type="submit"
                                style="background:#0071c2;color:#fff;border:none;padding:11px 28px;border-radius:8px;font-size:15px;font-weight:700;cursor:pointer;">
                            <i class="fa-solid fa-plus"></i> Thêm khách sạn
                        </button>
                    </div>

                </form>
            </div>
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
