<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<jsp:include page="/views/layout/header.jsp"/>

<div class="hb-page">
    <div class="hb-container" style="max-width: 600px; margin: 40px auto; text-align: center;">
        <div class="hb-card" style="padding: 40px;">
            <h1 style="color: #2563eb; margin-bottom: 20px;"><i class="fa-solid fa-credit-card"></i> Thanh Toán Điện Tử</h1>
            <p>Đơn hàng đặt phòng của bạn đã được ghi nhận.</p>
            <div style="font-size: 24px; font-weight: bold; margin: 20px 0;">
                Mã Đơn: #${bookingId} <br>
                Tổng tiền: $${totalAmount}
            </div>

            <div style="margin: 20px auto; padding: 15px; border: 1px dashed #cbd5e1; border-radius: 12px; display: inline-block; background: #f8fafc;">
                <p style="margin-bottom: 12px; font-weight: 600; color: #334155; font-size: 15px;">Quét mã QR để thanh toán nhanh</p>
                <!-- Using vietqr.io with a demo bank account or generic QR API -->
                <img src="https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=MockPayment_Booking_${bookingId}_Amount_${totalAmount}" 
                     alt="Demo QR Code" style="width: 200px; height: 200px; border-radius: 8px;">
            </div>
            
            <p style="color: #64748b; margin-bottom: 30px; font-size: 14px;">Sau khi quét mã thanh toán thành công, vui lòng bấm nút dưới đây để xác nhận hoàn tất.</p>

            <form action="${pageContext.request.contextPath}/mockPayment" method="post">
                <input type="hidden" name="bookingId" value="${bookingId}">
                <button type="submit" class="hb-btn hb-btn-orange" style="width: 100%; font-size: 18px; padding: 15px;">
                    Thanh Toán & Hoàn Tất
                </button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/views/layout/footer.jsp"/>
</html>
