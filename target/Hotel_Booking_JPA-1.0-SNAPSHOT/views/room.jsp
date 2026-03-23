<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp" />

<div class="admin-layout">
    <!-- SIDEBAR -->
    <aside class="admin-sidebar" id="adminSidebar">
        <div class="sidebar-brand"><i class="fa-solid fa-shield-halved"></i><span>Admin Panel</span></div>
        <nav class="sidebar-nav">
            <div class="nav-group-label">Tổng quan</div>
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link"><i class="fa-solid fa-gauge"></i> Dashboard</a>
            <div class="nav-group-label">Quản lý</div>
            <a href="${pageContext.request.contextPath}/adminHotel" class="sidebar-link"><i class="fa-solid fa-hotel"></i> Khách sạn</a>
            <a href="${pageContext.request.contextPath}/admin/booking" class="sidebar-link"><i class="fa-solid fa-calendar-check"></i> Đặt phòng</a>
            <a href="${pageContext.request.contextPath}/admin/rooms" class="sidebar-link active"><i class="fa-solid fa-door-open"></i> Phòng</a>
            <div class="nav-group-label">Khác</div>
            <a href="${pageContext.request.contextPath}/home" class="sidebar-link"><i class="fa-solid fa-globe"></i> Xem trang chủ</a>
            <a href="${pageContext.request.contextPath}/logout" class="sidebar-link sidebar-logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
        </nav>
    </aside>

    <main class="admin-main">
        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title"><i class="fa-solid fa-door-open"></i> Quản lý Phòng
                    <c:if test="${currentHotel != null}">
                        – <span style="color:#0071c2">${currentHotel.name}</span>
                    </c:if>
                </h1>
                <p class="admin-page-subtitle">Thêm, cập nhật trạng thái và quản lý ảnh phòng</p>
            </div>
            <button class="sidebar-toggle" onclick="toggleSidebar()"><i class="fa-solid fa-bars"></i></button>
        </div>

        <!-- Filter by hotel -->
        <div class="admin-card" style="margin-bottom:20px;padding:16px 20px;">
            <form method="get" action="${pageContext.request.contextPath}/admin/rooms" style="display:flex;gap:12px;align-items:flex-end;flex-wrap:wrap;">
                <div>
                    <label style="font-size:12px;font-weight:700;color:#64748b;display:block;margin-bottom:4px;">Lọc theo khách sạn</label>
                    <select name="hotelId" onchange="this.form.submit()"
                            style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;background:#fff;min-width:220px;">
                        <option value="">-- Tất cả khách sạn --</option>
                        <c:forEach var="h" items="${hotels}">
                            <option value="${h.id}" ${currentHotel != null && currentHotel.id == h.id ? 'selected' : ''}>${h.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </form>
            
            <%-- Thông báo phản hồi xóa phòng --%>
            <c:if test="${not empty sessionScope.error}">
                <div style="background:#fef2f2;color:#ef4444;padding:12px;border-radius:6px;margin-top:10px;font-weight:600;">
                    <i class="fa-solid fa-circle-exclamation"></i> ${sessionScope.error}
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>
            <c:if test="${not empty sessionScope.message}">
                <div style="background:#f0fdf4;color:#16a34a;padding:12px;border-radius:6px;margin-top:10px;font-weight:600;">
                    <i class="fa-solid fa-circle-check"></i> ${sessionScope.message}
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>
        </div>

        <!-- Room table -->
        <div class="admin-card" style="margin-bottom:24px;">
            <div class="admin-card-header">
                <h4><i class="fa-solid fa-list"></i> Danh sách phòng (${rooms.size()})</h4>
            </div>
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Ảnh</th>
                            <th>#</th>
                            <th>Khách sạn</th>
                            <th>Loại phòng</th>
                            <th>Giá / đêm</th>
                            <th>Số lượng</th>
                            <th>Trạng thái</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty rooms}">
                            <tr><td colspan="8" style="text-align:center;padding:32px;color:#94a3b8;">Chưa có phòng nào.</td></tr>
                        </c:if>
                        <c:forEach var="r" items="${rooms}">
                            <tr>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty r.image}">
                                            <img src="${pageContext.request.contextPath}/img/${r.image}"
                                                 width="70" height="50" style="border-radius:6px;object-fit:cover;"
                                                 onerror="this.src='';this.style.display='none';">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width:70px;height:50px;background:#e8f0fe;border-radius:6px;display:flex;align-items:center;justify-content:center;color:#0071c2;">
                                                <i class="fa-solid fa-bed"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="td-id">#${r.id}</td>
                                <td style="font-size:13px;color:#334155;">${r.hotel.name}</td>
                                <td style="font-weight:600;">${r.roomType}</td>
                                <td class="td-price"><fmt:formatNumber value="${r.price}" pattern="#,###"/>đ</td>
                                <td>
                                    <span style="font-weight:700;color:${r.quantity <= 0 ? '#dc2626' : '#16a34a'};">
                                        ${r.quantity}
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.status == 'AVAILABLE'}">
                                            <span class="status-badge badge-confirmed-sm">Còn phòng</span>
                                        </c:when>
                                        <c:when test="${r.status == 'FULL'}">
                                            <span class="status-badge badge-cancelled-sm">Hết phòng</span>
                                        </c:when>
                                        <c:when test="${r.status == 'MAINTENANCE'}">
                                            <span class="status-badge badge-pending-sm">Bảo trì</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge" style="background:#f1f5f9;color:#64748b;">${r.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <button class="btn-confirm" onclick="openEditModal(${r.id},'${r.roomType}',${r.price},${r.quantity},'${r.status}','${r.image}')" title="Chỉnh sửa">
                                        <i class="fa-solid fa-pen"></i>
                                    </button>
                                    <form method="post" action="${pageContext.request.contextPath}/admin/rooms" style="display:inline"
                                          onsubmit="return confirm('Xóa phòng #${r.id}?')">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="roomId" value="${r.id}">
                                        <c:if test="${currentHotel != null}">
                                            <input type="hidden" name="hotelId" value="${currentHotel.id}">
                                        </c:if>
                                        <button class="btn-cancel-sm" title="Xóa"><i class="fa-solid fa-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Add Room Form -->
        <c:if test="${currentHotel != null}">
        <div class="admin-card">
            <div class="admin-card-header">
                <h4><i class="fa-solid fa-plus-circle"></i> Thêm phòng mới cho ${currentHotel.name}</h4>
            </div>
            <div style="padding:24px;">
                <form method="post" action="${pageContext.request.contextPath}/admin/rooms"
                      style="display:grid;grid-template-columns:1fr 1fr 1fr;gap:16px;align-items:end;">
                    <input type="hidden" name="hotelId" value="${currentHotel.id}">
                    <div style="display:flex;flex-direction:column;gap:5px;">
                        <label style="font-size:12px;font-weight:700;color:#334155;">Loại phòng</label>
                        <select name="roomType" style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                            <option>Standard</option><option>Deluxe</option>
                            <option>Suite</option><option>Villa</option>
                        </select>
                    </div>
                    <div style="display:flex;flex-direction:column;gap:5px;">
                        <label style="font-size:12px;font-weight:700;color:#334155;">Giá / đêm (đ)</label>
                        <input type="number" name="price" placeholder="500000" min="0"
                               style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                    </div>
                    <div style="display:flex;flex-direction:column;gap:5px;">
                        <label style="font-size:12px;font-weight:700;color:#334155;">Số lượng phòng</label>
                        <input type="number" name="quantity" placeholder="5" min="0"
                               style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                    </div>
                    <div style="display:flex;flex-direction:column;gap:5px;grid-column:span 2;">
                        <label style="font-size:12px;font-weight:700;color:#334155;">Tên file ảnh (đặt trong /img/)</label>
                        <input type="text" name="image" placeholder="VD: room_deluxe.jpg" id="newRoomImg"
                               style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;"
                               oninput="document.getElementById('newImgPreview').src='${pageContext.request.contextPath}/img/'+this.value">
                    </div>
                    <div style="display:flex;flex-direction:column;gap:5px;">
                        <label style="font-size:12px;font-weight:700;color:#334155;">Preview ảnh</label>
                        <img id="newImgPreview" src="" width="100" height="70"
                             style="border-radius:6px;object-fit:cover;border:1px solid #e2e8f0;"
                             onerror="this.style.opacity='0.2'">
                    </div>
                    <div style="grid-column:span 3;">
                        <button type="submit" style="background:#0071c2;color:#fff;border:none;padding:11px 28px;border-radius:8px;font-size:15px;font-weight:700;cursor:pointer;">
                            <i class="fa-solid fa-plus"></i> Thêm phòng
                        </button>
                    </div>
                </form>
            </div>
        </div>
        </c:if>

    </main>
</div>

<!-- Edit Room Modal -->
<div id="editModal" style="display:none;position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:9999;align-items:center;justify-content:center;">
    <div style="background:#fff;border-radius:14px;padding:32px;min-width:480px;max-width:560px;width:90%;">
        <h3 style="margin:0 0 20px;font-size:18px;color:#0f172a;"><i class="fa-solid fa-pen"></i> Chỉnh sửa phòng</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/rooms">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="roomId" id="editRoomId">
            <c:if test="${currentHotel != null}">
                <input type="hidden" name="hotelId" value="${currentHotel.id}">
            </c:if>
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:14px;">
                <div style="display:flex;flex-direction:column;gap:5px;">
                    <label style="font-size:12px;font-weight:700;color:#334155;">Loại phòng</label>
                    <select id="editRoomType" name="roomType" style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                        <option>Standard</option><option>Deluxe</option><option>Suite</option><option>Villa</option>
                    </select>
                </div>
                <div style="display:flex;flex-direction:column;gap:5px;">
                    <label style="font-size:12px;font-weight:700;color:#334155;">Trạng thái</label>
                    <select id="editStatus" name="status" style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                        <option value="AVAILABLE">Còn phòng</option>
                        <option value="FULL">Hết phòng</option>
                        <option value="MAINTENANCE">Bảo trì</option>
                        <option value="INACTIVE">Tạm dừng</option>
                    </select>
                </div>
                <div style="display:flex;flex-direction:column;gap:5px;">
                    <label style="font-size:12px;font-weight:700;color:#334155;">Giá / đêm (đ)</label>
                    <input id="editPrice" type="number" name="price" style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                </div>
                <div style="display:flex;flex-direction:column;gap:5px;">
                    <label style="font-size:12px;font-weight:700;color:#334155;">Số lượng phòng</label>
                    <input id="editQty" type="number" name="quantity" style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;">
                </div>
                <div style="display:flex;flex-direction:column;gap:5px;grid-column:span 2;">
                    <label style="font-size:12px;font-weight:700;color:#334155;">Tên file ảnh</label>
                    <input id="editImg" type="text" name="image" placeholder="room_deluxe.jpg"
                           style="padding:9px 12px;border:1px solid #e2e8f0;border-radius:7px;font-size:14px;outline:none;"
                           oninput="document.getElementById('editImgPreview').src='${pageContext.request.contextPath}/img/'+this.value">
                </div>
            </div>
            <img id="editImgPreview" src="" width="120" height="80"
                 style="border-radius:8px;object-fit:cover;border:1px solid #e2e8f0;margin-bottom:16px;"
                 onerror="this.style.opacity='0.1'">
            <div style="display:flex;gap:10px;justify-content:flex-end;">
                <button type="button" onclick="closeEditModal()"
                        style="padding:10px 20px;border:1px solid #e2e8f0;border-radius:7px;background:#fff;cursor:pointer;font-size:14px;">
                    Hủy
                </button>
                <button type="submit"
                        style="padding:10px 24px;background:#0071c2;color:#fff;border:none;border-radius:7px;font-size:14px;font-weight:700;cursor:pointer;">
                    <i class="fa-solid fa-save"></i> Lưu thay đổi
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/views/layout/footer.jsp" />
<script>
function toggleSidebar() { document.getElementById('adminSidebar').classList.toggle('collapsed'); }

function openEditModal(id, type, price, qty, status, img) {
    document.getElementById('editRoomId').value = id;
    document.getElementById('editRoomType').value = type;
    document.getElementById('editPrice').value = price;
    document.getElementById('editQty').value = qty;
    document.getElementById('editStatus').value = status;
    document.getElementById('editImg').value = img || '';
    document.getElementById('editImgPreview').src = img ? '${pageContext.request.contextPath}/img/' + img : '';
    document.getElementById('editModal').style.display = 'flex';
}
function closeEditModal() { document.getElementById('editModal').style.display = 'none'; }
document.getElementById('editModal').addEventListener('click', function(e) {
    if (e.target === this) closeEditModal();
});
</script>
</html>
