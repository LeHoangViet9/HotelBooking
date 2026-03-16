package controller;

import dal.RoomDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Room;

public class RoomServlet extends HttpServlet {

    private RoomDAO roomDAO;

    @Override
    public void init() {
        roomDAO = new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String hotelIdRaw = request.getParameter("hotelId");

        List<Room> list;

        if (hotelIdRaw != null) {
            int hotelId = Integer.parseInt(hotelIdRaw);

            // lấy room theo hotel
            list = roomDAO.getRoomsByHotelId(hotelId);

        } else {

            // lấy tất cả room (admin)
            list = roomDAO.getAllRooms();
        }

        request.setAttribute("rooms", list);

        request.getRequestDispatcher("/views/room.jsp")
                .forward(request, response);
    }
}