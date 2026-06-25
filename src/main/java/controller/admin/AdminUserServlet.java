package controller.admin;

import dao.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUserServlet", value = "/admin/users")
public class AdminUserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDAO dao = new UserDAO();
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        // Xử lý logic XÓA tài khoản
        if ("delete".equals(action) && idParam != null) {
            int userId = Integer.parseInt(idParam);

            // Lấy ID của tài khoản Admin đang đăng nhập hiện tại để tránh tự xóa chính mình
            User currentAdmin = (User) request.getSession().getAttribute("acc");

            if (currentAdmin.getId() == userId) {
                request.setAttribute("error", "❌ Không thể xóa tài khoản Admin đang đăng nhập!");
            } else {
                boolean check = dao.deleteUser(userId);
                if (check) {
                    request.setAttribute("message", "✅ Đã xóa tài khoản thành công!");
                } else {
                    request.setAttribute("error", "❌ Xóa thất bại. Tài khoản này có thể đang liên kết với đơn hàng/bình luận.");
                }
            }
        }

        // Tải danh sách người dùng lên giao diện
        List<User> listUsers = dao.getAllUsers();
        request.setAttribute("listUsers", listUsers);
        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }
}