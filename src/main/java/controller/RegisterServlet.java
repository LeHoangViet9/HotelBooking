/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.UserRole;

/**
 *
 * @author LE HOANG VIET
 */
public class RegisterServlet extends HttpServlet {
   
   
    private UserDAO userDAO;
    @Override
    public void init(){
        userDAO=new UserDAO();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("views/register.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String pass = request.getParameter("pass");
        String confirm = request.getParameter("confirm");

        if (fullName == null || email == null || phone == null
                || pass == null || confirm == null
                || fullName.isEmpty() || email.isEmpty()
                || phone.isEmpty() || pass.isEmpty()) {

            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("views/register.jsp")
                   .forward(request, response);
            return;
        }

        // 2️⃣ kiểm tra confirm password
        if (!pass.equals(confirm)) {
            request.setAttribute("error", "Password does not match!");
            request.getRequestDispatcher("views/register.jsp")
                   .forward(request, response);
            return;
        }

        // 3️⃣ kiểm tra email tồn tại
        if (userDAO.findByEmail(email) != null) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("views/register.jsp")
                   .forward(request, response);
            return;
        }

        // 4️⃣ tạo user mới
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(pass);
        user.setRole(UserRole.USER); // mặc định

        userDAO.register(user);

        // 5️⃣ chuyển sang login
        response.sendRedirect(request.getContextPath() + "/login");
    }
    

}
