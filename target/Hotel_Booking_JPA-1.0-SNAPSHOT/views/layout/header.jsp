<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <meta charset="UTF-8">
    <title>Hotel Booking</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hotelList.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hotelDetail.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/room.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/booking.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/my_booking.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login_register.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_dashboard.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/contact.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_hotel.css">
</head>

<body>

    <div class="header">

        <div class="logo">
            <a href="${pageContext.request.contextPath}/home">Hotel Booking</a>
        </div>

        <div class="nav">

            <c:choose>

                <c:when test="${sessionScope.user == null}">
                    <a href="${pageContext.request.contextPath}/login">Login</a>
                    <a href="${pageContext.request.contextPath}/register">Register</a>
                </c:when>

                <c:otherwise>

                    <span class="welcome">
                        Hello, ${sessionScope.user.fullName}
                    </span>

                    <c:if test="${sessionScope.user.role=='USER'}">
                        <a href="${pageContext.request.contextPath}/profile">Profile</a>
                        <a href="${pageContext.request.contextPath}/contact">Contact</a>
                        <a href="${pageContext.request.contextPath}/mybooking">My Bookings</a>
                    </c:if>

                    <c:if test="${sessionScope.user.role == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard">
                            Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/adminHotel">
                            Manage Hotels
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/booking">
                            Manage Bookings
                        </a>
                    </c:if>


                    <a class="logout" href="${pageContext.request.contextPath}/logout">Logout</a>

                </c:otherwise>

            </c:choose>

        </div>

    </div>