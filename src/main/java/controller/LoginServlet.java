package controller;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    // Hiển thị trang giao diện đăng nhập (login.jsp)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // Xử lý dữ liệu khi người dùng nhấn nút "ĐĂNG NHẬP"
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cấu hình đọc dữ liệu tiếng Việt từ form (nếu có ký tự đặc biệt)
        request.setCharacterEncoding("UTF-8");

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User account = dao.checkLogin(user, pass);

        if (account == null) {
            // Trường hợp thất bại: Đẩy thông báo lỗi ngược về trang login.jsp
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            // Trường hợp thành công: Khởi tạo Session và lưu thông tin tài khoản
            HttpSession session = request.getSession();
            session.setAttribute("acc", account);

            // Xử lý phân luồng điều hướng dựa trên quyền hạn (Role) của User
            if (account.isAdmin()) {
                // Nếu là tài khoản Quản trị viên -> Chuyển hướng đến trang Dashboard Admin
                response.sendRedirect(request.getContextPath() + "/admin/index");
            } else {
                // Nếu là tài khoản Khách hàng -> Chuyển hướng về Trang chủ mua sắm
                response.sendRedirect(request.getContextPath() + "/index");
            }
        }
    }
}