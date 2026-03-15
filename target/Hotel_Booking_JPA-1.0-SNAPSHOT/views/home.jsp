<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>       
    </head>
    <body>
        <div class="wrapper">
            <jsp:include page="/views/layout/header.jsp" />
            <div class="content">
                <div class="search-container">

                    <h2>Find and Book Hotels Online</h2>

                    <form action="${pageContext.request.contextPath}/search" method="get" class="search-form">

                        <div class="form-group">
                            <label>City</label>
                            <input type="text" name="city" id="cityInput"
                                   placeholder="Enter City..."
                                   onkeyup="suggestCity()">

                            <div id="suggestions"></div>
                        </div>

                        <div class="form-group">
                            <label>Check-in Date</label>
                            <input type="date" name="checkin" required>
                        </div>

                        <div class="form-group">
                            <label>Check-out Date</label>
                            <input type="date" name="checkout" required>
                        </div>

                        <div class="form-group">
                            <label>Price Range (đ / night)</label>
                            <select name="priceRange">
                                <option value="">All</option>
                                <option value="0-500000">Under 500k</option>
                                <option value="500000-1000000">500k - 1M</option>
                                <option value="1000000-2000000">1M - 2M</option>
                                <option value="2000000-10000000">Above 2M</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <button type="submit" class="btn-search">SEARCH</button>
                        </div>

                    </form>

                </div>
            </div>           

        </div>
        <jsp:include page="/views/layout/footer.jsp" />
    </body>

    <script>
        function suggestCity() {

            let keyword = document.getElementById("cityInput").value;

            if (keyword.length === 0) {
                document.getElementById("suggestions").innerHTML = "";
                return;
            }

            fetch("suggestCity?keyword=" + keyword)
                    .then(response => response.text())
                    .then(data => {
                        document.getElementById("suggestions").innerHTML = data;
                    });

        }

        function selectCity(name) {
            document.getElementById("cityInput").value = name;
            document.getElementById("suggestions").innerHTML = "";
        }
    </script>

</html>