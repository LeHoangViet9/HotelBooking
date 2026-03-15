/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BookingDAO;
import dal.HotelDAO;
import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.UserRole;

/**
 *
 * @author LE HOANG VIET
 */
public class AdminDashboardServlet extends HttpServlet {
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole()!=UserRole.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        UserDAO userDAO = new UserDAO();
        HotelDAO hotelDAO = new HotelDAO();

        request.setAttribute("totalUsers", userDAO.countUsers());
        request.setAttribute("totalHotels", hotelDAO.countHotels());
        request.setAttribute("totalBookings", bookingDAO.countBookings());
        request.setAttribute("totalRevenue", bookingDAO.totalRevenue());

        request.getRequestDispatcher("/views/admin_dashboard.jsp")
               .forward(request, response);
    } 



}
