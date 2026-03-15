<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Book a Room</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
              rel="stylesheet">

        <style>

            body{
                background:#f5f5f5;
            }

            .booking-card{
                max-width:600px;
                margin:auto;
                margin-top:60px;
            }

            .price{
                font-size:20px;
                color:#ff6600;
                font-weight:bold;
            }

            .rating{
                color:#ffc107;
                font-size:18px;
            }

        </style>
    </head>

    <body>

        <jsp:include page="/views/layout/header.jsp"/>

        <div class="container">

            <div class="card shadow booking-card p-4">

                <h3 class="mb-3">Book a Room</h3>

       
                <p><b>Room type:</b> ${room.roomType}</p>

                <p class="price">
                    Price: $${room.price} / day
                </p>

                <!-- Rating -->
                <div class="rating mb-3">

                    <c:choose>

                        <c:when test="${room.hotel.rating != null}">

                            <c:forEach begin="1" end="5" var="i">

                                <c:choose>

                                    <c:when test="${i <= room.hotel.rating}">
                                        ⭐
                                    </c:when>

                                    <c:otherwise>
                                        ☆
                                    </c:otherwise>

                                </c:choose>

                            </c:forEach>

                            <span style="color:black">
                                (${room.hotel.rating}/5)
                            </span>

                        </c:when>

                        <c:otherwise>
                            No rating yet
                        </c:otherwise>

                    </c:choose>

                </div>

                <!-- Booking Form -->
                <form action="booking" method="post">

                    <input type="hidden" name="roomId" value="${room.id}">

                    <!-- Check-in -->
                    <div class="mb-3">
                        <label class="form-label">Check-in</label>
                        <input type="date"
                               class="form-control"
                               id="checkIn"
                               name="checkIn"
                               min="<%= java.time.LocalDate.now() %>"
                               onchange="calculatePrice()"
                               required>
                    </div>

                    <!-- Check-out -->
                    <div class="mb-3">
                        <label class="form-label">Check-out</label>
                        <input type="date"
                               class="form-control"
                               id="checkOut"
                               name="checkOut"
                               onchange="calculatePrice()"
                               required>
                    </div>

                    <!-- Total -->
                    <p class="fw-bold">
                        Total price: $<span id="total">0</span>
                    </p>

                    <button class="btn btn-primary w-100">
                        Reservation Confirmation
                    </button>

                </form>

            </div>

        </div>

        <jsp:include page="/views/layout/footer.jsp"/>

        <script>

            function calculatePrice() {

                let checkin = document.getElementById("checkIn").value;
                let checkout = document.getElementById("checkOut").value;

                let price = ${room.price};

                if (checkin && checkout) {

                    let d1 = new Date(checkin);
                    let d2 = new Date(checkout);

                    let days = (d2 - d1) / (1000 * 60 * 60 * 24);

                    if (days <= 0) {
                        alert("Check-out must be after Check-in");
                        document.getElementById("total").innerText = 0;
                        return;
                    }

                    let total = days * price;

                    document.getElementById("total").innerText = total;
                }
            }

        </script>

    </body>
</html>