package controller;

import dal.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Booking;
import model.User;
import java.io.IOException;
import java.util.List;
import model.UserRole;

public class AdminBookingsServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != UserRole.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String statusFilter = request.getParameter("status");
        String keyword = request.getParameter("keyword");

        List<Booking> list = bookingDAO.searchAndFilter(keyword, statusFilter);

        request.setAttribute("bookings", list);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/views/admin_bookings.jsp").forward(request, response);
    }
}
