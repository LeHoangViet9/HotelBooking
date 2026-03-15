/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BookingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.BookingStatus;

/**
 *
 * @author LE HOANG VIET
 */
public class UpdateBookingServlet extends HttpServlet {
   
    


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    private BookingDAO bookingDAO=new BookingDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");
        if(status!=null){
        BookingStatus newStatus=BookingStatus.valueOf(status);
        bookingDAO.updateStatus(id, newStatus);
        }

        response.sendRedirect(request.getContextPath() + "/admin/booking");
    }



}
