package controller;

import dal.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Booking;
import model.User;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class MyBookingServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        //  Nếu chưa login thì đá về login
        if (user == null) {
            response.sendRedirect("views/login.jsp");
            return;
        }

        // Lấy booking theo user
        List<Booking> list = bookingDAO.findByUser(user.getId());

        request.setAttribute("bookings", list);
        request.getRequestDispatcher("views/my_bookings.jsp")
               .forward(request, response);
    }
}