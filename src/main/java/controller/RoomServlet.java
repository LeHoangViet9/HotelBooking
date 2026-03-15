/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Room;

/**
 *
 * @author LE HOANG VIET
 */
public class RoomServlet extends HttpServlet {
   
  
    private RoomDAO roomDAO;
    @Override
    public void init(){
        roomDAO=new RoomDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        List<Room> list=roomDAO.getAllRooms();
        request.setAttribute("rooms", list);
        request.getRequestDispatcher("views/room.jsp").forward(request, response);
    } 



}
