package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Booking;
import utils.JPAUtil;
import jakarta.persistence.EntityManager;

public class MockPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookingIdStr = request.getParameter("bookingId");
        if (bookingIdStr == null || bookingIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int bookingId = Integer.parseInt(bookingIdStr);

        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Booking booking = em.find(Booking.class, bookingId);
            if (booking != null) {
                booking.setPaymentStatus("PAID");
                em.merge(booking);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }

        request.getSession().setAttribute("message", "Thanh toán thành công!");
        response.sendRedirect(request.getContextPath() + "/mybooking");
    }
}
