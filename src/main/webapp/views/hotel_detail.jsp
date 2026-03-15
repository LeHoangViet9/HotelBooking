<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hotel Detail</title>

        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/css/hotel_detail.css">
    </head>

    <body>

        <jsp:include page="/views/layout/header.jsp"/>

        <div class="hotel-container">

            <!-- HOTEL INFO -->
            <div class="hotel-header">
                <h1>${hotel.name}</h1>
                <p class="hotel-location">
                    ${hotel.city.name} • ${hotel.address}
                </p>
            </div>


            <!-- ROOM SECTION -->
            <h2 class="section-title">Available Rooms</h2>

            <div class="room-list">

                <c:forEach var="r" items="${hotel.rooms}">

                    <div class="room-card">

                        <div class="room-info">
                            <h3>${r.roomType}</h3>
                            <p class="price">$${r.price} / night</p>
                        </div>


                        <c:if test="${sessionScope.user.role == 'USER'}">
                            <div class="room-action">
                                <a class="book-btn"
                                   href="${pageContext.request.contextPath}/booking?roomId=${r.id}">
                                    Book now
                                </a>
                            </div>
                        </c:if>

                    </div>

                </c:forEach>

            </div>


            <!-- QUESTION SECTION -->
            <h2 class="section-title">Ask a Question</h2>

            <c:if test="${sessionScope.user != null}">

                <form class="question-form"
                      action="${pageContext.request.contextPath}/askQuestion"
                      method="post">

                    <input type="hidden" name="hotelId" value="${hotel.id}">

                    <textarea name="content"
                              placeholder="Ask something about this hotel..."
                              required></textarea>

                    <button type="submit">Ask Question</button>

                </form>

            </c:if>

            <c:if test="${sessionScope.user == null}">
                <p class="login-note">
                    Please <a href="login">login</a> to ask a question.
                </p>
            </c:if>



            <!-- QUESTIONS -->
            <h2 class="section-title">
                Questions (${fn:length(questions)})
            </h2>

            <c:forEach var="q" items="${questions}">

                <div class="question-card">

                    <div class="question-user">
                        ${q.user.fullName}
                    </div>

                    <div class="question-content">
                        ${q.content}
                    </div>


                    <!-- ANSWERS -->
                    <div class="answer-list">

                        <c:forEach var="a" items="${q.answers}">

                            <div class="answer-item">
                                <b>${a.user.fullName}</b>
                                <p>${a.content}</p>
                            </div>

                        </c:forEach>

                    </div>


                    <!-- ANSWER FORM -->
                    <c:if test="${sessionScope.user != null}">

                        <form class="answer-form"
                              action="${pageContext.request.contextPath}/answer"
                              method="post">

                            <input type="hidden" name="qid" value="${q.id}">

                            <textarea name="content"
                                      placeholder="Write your answer..."
                                      required></textarea>

                            <button type="submit">Answer</button>

                        </form>

                    </c:if>

                </div>

            </c:forEach>

        </div>

        <jsp:include page="/views/layout/footer.jsp"/>

    </body>
</html>