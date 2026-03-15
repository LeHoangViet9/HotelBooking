/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CityDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.City;

/**
 *
 * @author LE HOANG VIET
 */
public class SuggestCityServlet extends HttpServlet {
   
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String keyword = request.getParameter("keyword");

        CityDAO dao = new CityDAO();
        List<City> list = dao.searchCity(keyword);

        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        for(City c : list){
            out.println("<div onclick=\"selectCity('" + c.getName() + "')\">" 
                        + c.getName() + "</div>");
    } 
    }



}
