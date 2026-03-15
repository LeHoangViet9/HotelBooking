/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BookingDAO;
import jakarta.persistence.EntityManager;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Booking;
import model.User;
import utils.JPAUtil;

/**
 *
 * @author LE HOANG VIET
 */
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int bookingId = Integer.parseInt(request.getParameter("id"));

        EntityManager em = JPAUtil.getEntityManager();
        Booking booking = em.find(Booking.class, bookingId);

        if (booking != null
                && booking.getUser().getId() == user.getId()) {

            BookingDAO dao = new BookingDAO();
            dao.cancelBooking(bookingId);
        }

        em.close();

        response.sendRedirect(request.getContextPath() + "/mybooking");
    }


}
