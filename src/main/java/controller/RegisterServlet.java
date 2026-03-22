package controller;

import dal.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.UserRole;

public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
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

        String error = "";

        // 1️⃣ check empty
        if (fullName == null || email == null || phone == null
                || pass == null || confirm == null
                || fullName.trim().isEmpty()
                || email.trim().isEmpty()
                || phone.trim().isEmpty()
                || pass.trim().isEmpty()
                || confirm.trim().isEmpty()) {

            error += "All fields are required!<br>";
        }

        // 2️⃣ regex
        String emailRegex = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        String phoneRegex = "^0\\d{9}$";

        if (email != null && !email.matches(emailRegex)) {
            error += "Email không hợp lệ!<br>";
        }

        if (phone != null && !phone.matches(phoneRegex)) {
            error += "Số điện thoại không hợp lệ!<br>";
        }

        // 3️⃣ password
        if (pass != null && pass.length() < 6) {
            error += "Mật khẩu phải >= 6 ký tự!<br>";
        }

        // 4️⃣ confirm
        if (pass != null && confirm != null && !pass.equals(confirm)) {
            error += "Mật khẩu không khớp!<br>";
        }

        // ❗ nếu có lỗi → trả về JSP
        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
            return;
        }

        // 5️⃣ check email tồn tại
        if (userDAO.findByEmail(email) != null) {
            request.setAttribute("error", "Email already exists!");

            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
            return;
        }

        // 6️⃣ tạo user
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(pass);
        user.setRole(UserRole.USER);

        userDAO.register(user);

        // 7️⃣ chuyển trang
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
