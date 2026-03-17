<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt phòng khách sạn Việt Nam</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hotelList.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hotelDetail.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/room.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/my_booking.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/profile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_hotel.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/blog.css">
</head>

<body>

<!-- ===== TOP UTILITY BAR ===== -->
<div class="header-top">
    <div class="header-top-inner">
        <a href="${pageContext.request.contextPath}/home" class="header-logo">
            <span class="logo-text">HotelBooking<span class="logo-dot">.</span>com</span>
        </a>

        <div class="header-top-actions">
            <c:choose>
                <c:when test="${sessionScope.user == null}">
                    <a href="${pageContext.request.contextPath}/register" class="btn-header-outline">Đăng ký</a>
                    <a href="${pageContext.request.contextPath}/login" class="btn-header-solid">Đăng nhập</a>
                </c:when>
                <c:otherwise>
                    <div class="user-menu-wrapper">
                        <button class="user-menu-btn" onclick="toggleUserMenu()">
                            <i class="fa-solid fa-circle-user"></i>
                            <span>${sessionScope.user.fullName}</span>
                            <i class="fa-solid fa-chevron-down"></i>
                        </button>
                        <div class="user-dropdown" id="userDropdown">
                            <c:if test="${sessionScope.user.role=='USER'}">
                                <a href="${pageContext.request.contextPath}/profile"><i class="fa-solid fa-user"></i> Hồ sơ</a>
                                <a href="${pageContext.request.contextPath}/mybooking"><i class="fa-solid fa-calendar-check"></i> Đặt phòng của tôi</a>
                                <a href="${pageContext.request.contextPath}/contact"><i class="fa-solid fa-headset"></i> Liên hệ</a>
                            </c:if>
                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fa-solid fa-gauge"></i> Dashboard</a>
                                <a href="${pageContext.request.contextPath}/adminHotel"><i class="fa-solid fa-hotel"></i> Quản lý khách sạn</a>
                                <a href="${pageContext.request.contextPath}/admin/booking"><i class="fa-solid fa-book"></i> Quản lý đặt phòng</a>
                            </c:if>
                            <div class="dropdown-divider"></div>
                            <a href="${pageContext.request.contextPath}/logout" class="logout-link"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- ===== NAVIGATION TABS ===== -->
<div class="header-nav">
    <div class="header-nav-inner">
        <nav class="nav-tabs-booking">
            <a href="${pageContext.request.contextPath}/home" class="nav-tab active">
                <i class="fa-solid fa-bed"></i> Chỗ nghỉ
            </a>
            <a href="${pageContext.request.contextPath}/search" class="nav-tab">
                <i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm
            </a>
            <a href="${pageContext.request.contextPath}/blog" class="nav-tab">
                <i class="fa-solid fa-newspaper"></i> Blog Du lịch
            </a>
            <a href="${pageContext.request.contextPath}/contact" class="nav-tab">
                <i class="fa-solid fa-headset"></i> Hỗ trợ
            </a>
        </nav>
    </div>
</div>
