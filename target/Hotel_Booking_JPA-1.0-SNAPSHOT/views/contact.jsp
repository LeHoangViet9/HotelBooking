<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Contact Service</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/contact.css">
</head>

<body>

<jsp:include page="/views/layout/header.jsp" />

<div class="contact-container">

    <!-- INFO -->
    <div class="contact-info">

        <h2>Contact Service</h2>

        <p><b>Email:</b> admin@gmail.com</p>
        <p><b>Phone:</b> 0900 123 456</p>
        <p><b>Address:</b> Hanoi, Vietnam</p>

    </div>

    <!-- FORM -->
    <div class="contact-form">

        <form action="contact" method="post">

            <label>Name</label>
            <input type="text" name="name" required>

            <label>Email</label>
            <input type="email" name="email" required>

            <label>Content</label>
            <textarea name="message" rows="5"></textarea>

            <button type="submit">
                Send Contact
            </button>

        </form>

        <c:if test="${msg != null}">
            <p class="success-msg">${msg}</p>
        </c:if>

    </div>

</div>

<jsp:include page="/views/layout/footer.jsp" />

</body>
</html>