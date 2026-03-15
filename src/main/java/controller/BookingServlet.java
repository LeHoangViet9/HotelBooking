package controller;

import dal.BookingDAO;
import dal.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.Booking;
import model.BookingStatus;
import model.Room;
import model.User;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import model.UserRole;

public class BookingServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    //  Khi bấm "Đặt phòng"
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        Room room = roomDAO.findById(roomId);
        if (room.getQuantity() <= 0) {
            response.getWriter().println("The room is fully booked!");
            return;
        }
        request.setAttribute("room", room);
        request.getRequestDispatcher("views/booking.jsp")
                .forward(request, response);
    }

    //  Khi bấm Confirm đặt phòng
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (user.getRole() == UserRole.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        int roomId = Integer.parseInt(request.getParameter("roomId"));
        LocalDate checkIn = LocalDate.parse(request.getParameter("checkIn"));
        LocalDate checkOut = LocalDate.parse(request.getParameter("checkOut"));

        Room room = roomDAO.findById(roomId);

        if (room == null || room.getQuantity() <= 0) {
            response.sendRedirect("home");
            return;
        }

        //  Tính số ngày
        long days = ChronoUnit.DAYS.between(checkIn, checkOut);
        if (days <= 0) {
            response.sendRedirect("home");
            return;
        }

        double totalPrice = days * room.getPrice();

        Booking booking = new Booking();
        booking.setUser(user);
        booking.setRoom(room);
        booking.setCheckIn(checkIn);
        booking.setCheckOut(checkOut);
        booking.setTotalPrice(totalPrice);
        booking.setStatus(BookingStatus.PENDING);

        bookingDAO.save(booking);

        response.sendRedirect("mybooking");
    }
}
