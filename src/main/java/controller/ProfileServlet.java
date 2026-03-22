/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author LE HOANG VIET
 */
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Họ và tên không được để trống!");
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }

        if (phone == null || !phone.matches("^\\d{10,11}$")) {
            request.setAttribute("error", "Số điện thoại phải gồm 10 hoặc 11 chữ số!");
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }

        if (password == null || password.trim().length() < 6) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }

        user.setFullName(fullName.trim());
        user.setPhone(phone.trim());
        user.setPassword(password.trim());

        userDAO.update(user);

        session.setAttribute("user", user);

        request.setAttribute("message", "Cập nhật thông tin thành công!");
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }

}
