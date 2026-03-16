<%-- 
    Document   : edit
    Author     : LE HOANG VIET
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Edit Hotel</title>


</head>

<body>

<jsp:include page="/views/layout/header.jsp" />

<div class="container">

    <h2>Edit Hotel</h2>

    <div class="form-box">

        <form action="adminHotel" method="post">

            <input type="hidden" name="id" value="${hotel.id}">

            <!-- NAME -->

            <div class="form-group">

                <label>Hotel Name</label>

                <input type="text"
                       name="name"
                       value="${hotel.name}"
                       required>

            </div>

            <!-- ADDRESS -->

            <div class="form-group">

                <label>Address</label>

                <input type="text"
                       name="address"
                       value="${hotel.address}"
                       required>

            </div>

            <!-- CITY -->

            <div class="form-group">

                <label>City</label>

                <select name="city_id">

                    <c:forEach var="c" items="${cities}">

                        <option value="${c.id}"
                            ${hotel.city.id == c.id ? "selected" : ""}>
                            ${c.name}
                        </option>

                    </c:forEach>

                </select>

            </div>

            <!-- RATING -->

            <div class="form-group">

                <label>Rating</label>

                <input type="number"
                       name="rating"
                       step="0.1"
                       min="0"
                       max="5"
                       value="${hotel.rating}">

            </div>

            <!-- IMAGE -->

            <div class="form-group">

                <label>Image File Name</label>

                <input type="text"
                       name="image"
                       id="imageInput"
                       value="${hotel.image}">

            </div>

            <!-- PREVIEW -->

            <div class="form-group">

                <label>Preview</label><br>

                <img id="preview"
                     src="${pageContext.request.contextPath}/img/${hotel.image}"
                     width="120">

            </div>

            <button type="submit" class="btn-primary">
                Update Hotel
            </button>

        </form>

    </div>

</div>

<jsp:include page="/views/layout/footer.jsp" />

<script>

document.getElementById("imageInput").oninput = function(){
    document.getElementById("preview").src =
    "${pageContext.request.contextPath}/img/" + this.value;
}

</script>

</body>
</html>