package controller;

import dal.HotelDAO;
import dal.QuestionDAO;
import dal.ReviewDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Hotel;
import model.Question;
import model.Review;
import model.User;

public class HotelDetailServlet extends HttpServlet {

    private final HotelDAO hotelDAO       = new HotelDAO();
    private final QuestionDAO questionDAO = new QuestionDAO();
    private final ReviewDAO reviewDAO     = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Hotel hotel             = hotelDAO.findById(id);
        List<Question> questions = questionDAO.getByHotel(id);
        List<Review> reviews     = reviewDAO.getByHotel(id);
        long reviewCount         = reviewDAO.countByHotel(id);

        request.setAttribute("hotel",       hotel);
        request.setAttribute("questions",   questions);
        request.setAttribute("reviews",     reviews);
        request.setAttribute("reviewCount", reviewCount);

        // Check if current user can write a review
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                boolean canReview = reviewDAO.hasCompletedBooking(user.getId(), id)
                        && !reviewDAO.hasReviewed(user.getId(), id);
                request.setAttribute("canReview", canReview);
                request.setAttribute("hasReviewed", reviewDAO.hasReviewed(user.getId(), id));
            }
        }

        request.getRequestDispatcher("/views/hotel_detail.jsp").forward(request, response);
    }
}
