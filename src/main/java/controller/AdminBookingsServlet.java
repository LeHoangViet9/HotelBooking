package controller;

import dal.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Booking;
import model.User;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.UserRole;

@WebServlet("/admin/bookings")
public class AdminBookingsServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

       if (user == null || user.getRole() != UserRole.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        List<Booking> list = bookingDAO.findAll();

        request.setAttribute("bookings", list);
        request.getRequestDispatcher("/views/admin_bookings.jsp")
               .forward(request, response);
    }
}