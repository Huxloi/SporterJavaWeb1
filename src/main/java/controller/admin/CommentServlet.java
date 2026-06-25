package controller.admin;

import dao.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

// URL mapping này phải khớp với link trên thanh địa chỉ của bạn
@WebServlet("/admin/comments")
public class CommentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommentDAO dao = new CommentDAO();

        // 1. Kiểm tra xem Admin có muốn thực hiện hành động xóa không
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteComment(id);
                // Sau khi xóa xong, redirect về trang danh sách để cập nhật
                response.sendRedirect(request.getContextPath() + "/admin/comments");
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // 2. Lấy danh sách tất cả bình luận từ Database
        List<Map<String, Object>> listComments = dao.getAllComments();

        // 3. Đẩy dữ liệu sang trang JSP với tên biến là "listComments"
        request.setAttribute("listComments", listComments);

        // 4. Chuyển hướng tới trang hiển thị
        request.getRequestDispatcher("/admin/comments.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}