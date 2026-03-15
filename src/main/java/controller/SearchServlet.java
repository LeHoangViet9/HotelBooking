/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.HotelDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import model.Hotel;

/**
 *
 * @author LE HOANG VIET
 */
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Nếu chưa login
        if (session.getAttribute("user") == null) {

            String queryString = request.getQueryString();
            String redirectURL = request.getRequestURI();

            if (queryString != null) {
                redirectURL += "?" + queryString;
            }

            session.setAttribute("redirectAfterLogin", redirectURL);

            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // ===== LẤY PARAMETER SEARCH =====
        String city = request.getParameter("city");
        String sort = request.getParameter("sort");
        LocalDate.parse(request.getParameter("checkin"));
        LocalDate.parse(request.getParameter("checkout"));
        Double price = null;
        String priceRange = request.getParameter("priceRange");

        Double min = null;
        Double max = null;

        if (priceRange != null && !priceRange.isEmpty()) {
            String[] prices = priceRange.split("-");
            min = Double.parseDouble(prices[0]);
            max = Double.parseDouble(prices[1]);
        }

        int page = 1;
        int pageSize = 5;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        HotelDAO dao = new HotelDAO();

        List<Hotel> hotels = dao.search(city, min, max, sort, page, pageSize);

        int totalHotels = dao.countSearch(city, min, max);

        int totalPages = (int) Math.ceil((double) totalHotels / pageSize);
        request.setAttribute("hotels", hotels);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sort", sort);

        request.getRequestDispatcher("/views/hotelList.jsp")
                .forward(request, response);
    }

}
