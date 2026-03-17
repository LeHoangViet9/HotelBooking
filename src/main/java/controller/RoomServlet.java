package controller;

import dal.HotelDAO;
import dal.RoomDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Hotel;
import model.Room;
import model.RoomStatus;
import model.User;
import model.UserRole;

public class RoomServlet extends HttpServlet {

    private final RoomDAO roomDAO = new RoomDAO();
    private final HotelDAO hotelDAO = new HotelDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() != UserRole.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String hotelIdRaw = request.getParameter("hotelId");
        List<Room> list;
        Hotel hotel = null;

        if (hotelIdRaw != null&&!hotelIdRaw.trim().isEmpty()) {
            int hotelId = Integer.parseInt(hotelIdRaw);
            list = roomDAO.getRoomsByHotelId(hotelId);
            hotel = hotelDAO.findById(hotelId);
        } else {
            list = roomDAO.getAllRooms();
        }

        request.setAttribute("rooms", list);
        request.setAttribute("currentHotel", hotel);
        request.setAttribute("hotels", hotelDAO.getAllHotel());
        request.getRequestDispatcher("/views/room.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null || user.getRole() != UserRole.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action    = request.getParameter("action");
        String hotelIdStr = request.getParameter("hotelId");

        if ("delete".equals(action)) {
            try {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                roomDAO.deleteRoom(roomId);
                session.setAttribute("message", "Xóa phòng thành công.");
            } catch (Exception e) {
                session.setAttribute("error", "Không thể xóa phòng này vì đang có dữ liệu (Ví dụ: Đặt phòng, Đánh giá,...) liên kết tới. Vui lòng kiểm tra lại!");
            }
        } else if ("update".equals(action)) {
            int roomId   = Integer.parseInt(request.getParameter("roomId"));
            Room room = roomDAO.findById(roomId);
            if (room != null) {
                room.setRoomType(request.getParameter("roomType"));
                String priceStr = request.getParameter("price");
                String quantityStr = request.getParameter("quantity");
                
                double parsedPrice = 0.0;
                if (priceStr != null && !priceStr.trim().isEmpty()) {
                    try {
                        parsedPrice = Double.parseDouble(priceStr);
                    } catch (NumberFormatException ignored) {}
                }
                
                int parsedQuantity = 0;
                if (quantityStr != null && !quantityStr.trim().isEmpty()) {
                    try {
                        parsedQuantity = Integer.parseInt(quantityStr);
                    } catch (NumberFormatException ignored) {}
                }

                room.setPrice(parsedPrice);
                room.setQuantity(parsedQuantity);
                room.setImage(request.getParameter("image"));
                String statusStr = request.getParameter("status");
                if (statusStr != null && !statusStr.isEmpty()) {
                    try { room.setStatus(RoomStatus.valueOf(statusStr)); }
                    catch (IllegalArgumentException ignored) {}
                }
                roomDAO.updateRoom(room);
            }
        } else {
            // ADD new room
            if (hotelIdStr == null) {
                response.sendRedirect(request.getContextPath() + "/admin/rooms");
                return;
            }
            int hotelId = Integer.parseInt(hotelIdStr);
            Hotel hotel = new Hotel();
            hotel.setId(hotelId);

            Room room = new Room();
            room.setHotel(hotel);
            room.setRoomType(request.getParameter("roomType"));
            String priceStr = request.getParameter("price");
            String quantityStr = request.getParameter("quantity");
            
            double parsedPrice = 0.0;
            if (priceStr != null && !priceStr.trim().isEmpty()) {
                try {
                    parsedPrice = Double.parseDouble(priceStr);
                } catch (NumberFormatException ignored) {}
            }
            
            int parsedQuantity = 0;
            if (quantityStr != null && !quantityStr.trim().isEmpty()) {
                try {
                    parsedQuantity = Integer.parseInt(quantityStr);
                } catch (NumberFormatException ignored) {}
            }
            
            room.setPrice(parsedPrice);
            room.setQuantity(parsedQuantity);
            room.setImage(request.getParameter("image"));
            roomDAO.addRoom(room);
        }

        String redirect = hotelIdStr != null
                ? request.getContextPath() + "/admin/rooms?hotelId=" + hotelIdStr
                : request.getContextPath() + "/admin/rooms";
        response.sendRedirect(redirect);
    }
}
