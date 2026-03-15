<%@ page contentType="text/html;charset=UTF-8" %>
<jsp:include page="/views/layout/header.jsp" />

<div class="container mt-4">
    <h2>Admin Dashboard</h2>

    <div class="row mt-4">

        <div class="col-md-3">
            <div class="card bg-primary text-white p-3">
                <h5>Total Users</h5>
                <h3>${totalUsers}</h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-success text-white p-3">
                <h5>Total Hotels</h5>
                <h3>${totalHotels}</h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-warning text-white p-3">
                <h5>Total Bookings</h5>
                <h3>${totalBookings}</h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card bg-danger text-white p-3">
                <h5>Total Revenue</h5>
                <h3>${totalRevenue} $</h3>
            </div>
        </div>

    </div>
</div>

<jsp:include page="/views/layout/footer.jsp" />