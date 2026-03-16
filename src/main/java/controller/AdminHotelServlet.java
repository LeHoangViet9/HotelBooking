/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CityDAO;
import dal.HotelDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.City;
import model.Hotel;

/**
 *
 * @author LE HOANG VIET
 */
public class AdminHotelServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminHotelServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminHotelServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CityDAO citydao = new CityDAO();
        List<City> cities = citydao.getAllCity();
        request.setAttribute("cities", cities);
        HotelDAO dao = new HotelDAO();
        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "delete":
                int idDelete = Integer.parseInt(request.getParameter("id"));
                dao.deleteHotel(idDelete);
                response.sendRedirect("adminHotel");
                break;

            case "edit":
                int idEdit = Integer.parseInt(request.getParameter("id"));
                Hotel hotel = dao.findById(idEdit);

                request.setAttribute("hotel", hotel);
                request.getRequestDispatcher("/views/edit.jsp").forward(request, response);
                break;

            default:
                List<Hotel> list = dao.getAllHotel();
                request.setAttribute("hotels", list);
                request.getRequestDispatcher("/views/admin_hotels.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String cityId = request.getParameter("city_id");
        String rating = request.getParameter("rating");
        String image = request.getParameter("image");

        HotelDAO dao = new HotelDAO();
        CityDAO citydao = new CityDAO();
        City city = citydao.findById(Integer.parseInt(cityId));

        if (id == null) {

            Hotel h = new Hotel();
            h.setName(name);
            h.setAddress(address);
            h.setCity(city);
            h.setRating(Double.parseDouble(rating));
            h.setImage(image);

            dao.addHotel(h);

        } else {
            Hotel h = dao.findById(Integer.parseInt(id));

            h.setName(name);
            h.setAddress(address);
            h.setCity(city);
            h.setRating(Double.parseDouble(rating));
            h.setImage(image);

            dao.updateHotel(h);
        }

        response.sendRedirect("adminHotel");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
