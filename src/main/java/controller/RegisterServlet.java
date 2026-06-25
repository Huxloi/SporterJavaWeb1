package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String user = request.getParameter("username");
        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        UserDAO dao = new UserDAO();
        boolean success = dao.registerUser(user, pass, email);

        if (success) {
            // Đăng ký thành công, đính kèm thông báo và chuyển hướng về trang Đăng nhập
            request.setAttribute("success", "✅ Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Thất bại (Trùng username hoặc email)
            request.setAttribute("error", "❌ Tên đăng nhập hoặc Email đã được sử dụng!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}