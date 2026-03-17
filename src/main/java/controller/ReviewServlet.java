package controller;

import dal.ReviewDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Hotel;
import model.Review;
import model.User;

public class ReviewServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String hotelIdStr = request.getParameter("hotelId");
        String ratingStr  = request.getParameter("rating");
        String comment    = request.getParameter("comment");

        if (hotelIdStr == null || ratingStr == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int hotelId = Integer.parseInt(hotelIdStr);
        int rating  = Integer.parseInt(ratingStr);

        // Validation
        if (rating < 1 || rating > 5) {
            response.sendRedirect(request.getContextPath() + "/hotel?id=" + hotelId + "&reviewError=invalid");
            return;
        }
        if (reviewDAO.hasReviewed(user.getId(), hotelId)) {
            response.sendRedirect(request.getContextPath() + "/hotel?id=" + hotelId + "&reviewError=duplicate");
            return;
        }
        if (!reviewDAO.hasCompletedBooking(user.getId(), hotelId)) {
            response.sendRedirect(request.getContextPath() + "/hotel?id=" + hotelId + "&reviewError=noStay");
            return;
        }

        Hotel hotel = new Hotel();
        hotel.setId(hotelId);

        Review review = new Review();
        review.setUser(user);
        review.setHotel(hotel);
        review.setRating(rating);
        review.setComment(comment != null ? comment.trim() : "");

        reviewDAO.addReview(review);

        response.sendRedirect(request.getContextPath() + "/hotel?id=" + hotelId + "&reviewSuccess=1");
    }
}
