<%-- 
    Document   : admin_hotels
    Author     : LE HOANG VIET
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin - Hotel Management</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/style.css">

    </head>

    <body>

        <jsp:include page="/views/layout/header.jsp" />

        <div class="container">

            <h2>Hotel Management</h2>

            <!-- HOTEL TABLE -->

            <table class="table table-bordered table-striped table-hover">

                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Name</th>
                        <th>City</th>
                        <th>Rating</th>
                        <th>Room</th>
                        <th>Edit</th>
                        <th>Delete</th>
                    </tr>
                </thead>

                <tbody>

                    <c:if test="${empty hotels}">
                        <tr>
                            <td colspan="6" style="text-align:center">
                                No hotels available
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="h" items="${hotels}">
                        <tr>

                            <td>
                                <img src="${pageContext.request.contextPath}/img/${h.image}"
                                     class="hotel-img"  width="90" height="65">
                            </td>

                            <td>${h.name}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${h.city != null}">
                                        ${h.city.name}
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${h.rating}</td>

                            <td>
                                <a class="room-btn"
                                   href="${pageContext.request.contextPath}/admin/rooms?hotelId=${h.id}">
                                    View Rooms
                                </a>
                            </td>
                            <td>
                                <a class="btn btn-warning"
                                   href="adminHotel?action=edit&id=${h.id}">
                                    Edit
                                </a>
                            </td>

                            <td>
                                <a class="btn btn-danger"
                                   href="adminHotel?action=delete&id=${h.id}"
                                   onclick="return confirm('Delete this hotel?')">
                                    Delete
                                </a>
                            </td>

                        </tr>
                    </c:forEach>

                </tbody>

            </table>


            <!-- ADD HOTEL FORM -->

            <div class="form-box">

                <h3>Add New Hotel</h3>

                <form action="adminHotel" method="post">

                    <div class="form-group">

                        <label>Hotel Name</label>

                        <input type="text"
                               name="name"
                               placeholder="Enter hotel name"
                               required>

                    </div>

                    <div class="form-group">

                        <label>Address</label>

                        <input type="text"
                               name="address"
                               placeholder="Enter address"
                               required>

                    </div>

                    <div class="form-group">

                        <label>City</label>

                        <select name="city_id" required>

                            <c:forEach var="c" items="${cities}">

                                <option value="${c.id}">
                                    ${c.name}
                                </option>

                            </c:forEach>

                        </select>

                    </div>

                    <div class="form-group">

                        <label>Rating</label>

                        <input type="number"
                               name="rating"
                               step="0.1"
                               min="0"
                               max="5"
                               placeholder="0 - 5">

                    </div>

                    <div class="form-group">

                        <label>Image URL</label>

                        <input type="text"
                               name="image"
                               id="imageInput"
                               placeholder="Paste image URL">

                    </div>

                    <div class="form-group">

                        <label>Preview</label><br>

                        <img id="preview"
                             src="${pageContext.request.contextPath}/images/no-image.png"
                             width="120">

                    </div>

                    <button type="submit" class="btn btn-primary">
                        Add Hotel
                    </button>

                </form>

            </div>

        </div>

        <jsp:include page="/views/layout/footer.jsp" />

        <script>

            document.getElementById("imageInput").oninput = function () {
                document.getElementById("preview").src = this.value;
            }

        </script>

    </body>
</html>