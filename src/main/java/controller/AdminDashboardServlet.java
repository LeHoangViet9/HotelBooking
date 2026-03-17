package controller;

import dal.BookingDAO;
import dal.HotelDAO;
import dal.UserDAO;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.BookingStatus;
import model.User;
import model.UserRole;

public class AdminDashboardServlet extends HttpServlet {

    private static final String[] MONTH_NAMES = {
            "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6",
            "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"
    };

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != UserRole.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        BookingDAO bookingDAO = new BookingDAO();
        UserDAO userDAO = new UserDAO();
        HotelDAO hotelDAO = new HotelDAO();
        dal.RoomDAO roomDAO = new dal.RoomDAO();

        // --- KPI ---
        long totalUsers = userDAO.countUsers();
        long totalHotels = hotelDAO.countHotels();
        long totalBookings = bookingDAO.countBookings();
        double totalRevenue = bookingDAO.totalRevenue();

        long pendingCount = bookingDAO.countByStatus(BookingStatus.PENDING);
        long confirmedCount = bookingDAO.countByStatus(BookingStatus.CONFIRMED);
        long cancelledCount = bookingDAO.countByStatus(BookingStatus.CANCELLED);
        long completedCount = bookingDAO.countByStatus(BookingStatus.COMPLETED);

        NumberFormat vndFmt = NumberFormat.getNumberInstance(new Locale("vi", "VN"));
        String revenueFormatted = vndFmt.format((long) totalRevenue) + " đ";

        // --- Monthly stats (2 years) ---
        int selectedYear = 2026;
        String yearParam = request.getParameter("year");
        if (yearParam != null) {
            try {
                selectedYear = Integer.parseInt(yearParam);
            } catch (NumberFormatException ignored) {
            }
        }

        List<Object[]> rawMonthly = bookingDAO.getMonthlyRevenue(selectedYear);

        long[] monthlyCounts = new long[12];
        double[] monthlyRevenues = new double[12];

        for (Object[] row : rawMonthly) {
            int month = ((Number) row[0]).intValue() - 1; // 0-indexed
            monthlyCounts[month] = ((Number) row[1]).longValue();
            monthlyRevenues[month] = ((Number) row[2]).doubleValue();
        }

        // Build display list for table
        List<long[]> monthlyTable = new ArrayList<>();
        for (int i = 0; i < 12; i++) {
            monthlyTable.add(new long[] { i + 1, monthlyCounts[i], (long) monthlyRevenues[i] });
        }

        // Build JSON strings for Chart.js
        StringBuilder chartCounts = new StringBuilder();
        StringBuilder chartRevs = new StringBuilder();
        for (int i = 0; i < 12; i++) {
            chartCounts.append(monthlyCounts[i]);
            chartRevs.append((long) monthlyRevenues[i]);
            if (i < 11) {
                chartCounts.append(",");
                chartRevs.append(",");
            }
        }

        // --- Set attributes ---
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalHotels", totalHotels);
        request.setAttribute("totalBookings", totalBookings);
        request.setAttribute("totalRevenue", revenueFormatted);

        // --- Min/Max room price ---
        double maxRoomPrice = roomDAO.getMaxPrice();
        double minRoomPrice = roomDAO.getMinPrice();
        request.setAttribute("maxRoomPrice", vndFmt.format(maxRoomPrice) + " đ");
        request.setAttribute("minRoomPrice", vndFmt.format(minRoomPrice) + " đ");

        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("confirmedCount", confirmedCount);
        request.setAttribute("cancelledCount", cancelledCount);
        request.setAttribute("completedCount", completedCount);

        request.setAttribute("recentBookings", bookingDAO.getRecent(8));

        request.setAttribute("chartPending", pendingCount);
        request.setAttribute("chartConfirmed", confirmedCount);
        request.setAttribute("chartCancelled", cancelledCount);
        request.setAttribute("chartCompleted", completedCount);

        request.setAttribute("monthlyTable", monthlyTable);
        request.setAttribute("chartCounts", chartCounts.toString());
        request.setAttribute("chartRevs", chartRevs.toString());
        request.setAttribute("selectedYear", selectedYear);
        request.setAttribute("monthNames", MONTH_NAMES);

        request.getRequestDispatcher("/views/admin_dashboard.jsp").forward(request, response);
    }
}
