package controller.admin;

import dao.CategoryDAO;
import model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryServlet", value = "/admin/categories")
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoryDAO dao = new CategoryDAO();
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        // Xử lý XÓA danh mục
        if ("delete".equals(action) && idParam != null) {
            int id = Integer.parseInt(idParam);
            boolean check = dao.deleteCategory(id);
            if (check) {
                request.setAttribute("message", "✅ Xóa danh mục ID #" + id + " thành công!");
            } else {
                request.setAttribute("error", "❌ Không thể xóa danh mục này do đang chứa sản phẩm bên trong!");
            }
        }

        // Tải lại danh sách danh mục để hiển thị lên bảng
        List<Category> list = dao.getAllCategories();
        request.setAttribute("listCategories", list);
        request.getRequestDispatcher("/admin/categories.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        CategoryDAO dao = new CategoryDAO();

        // Xử lý THÊM danh mục
        if (request.getParameter("add_category") != null) {
            String name = request.getParameter("name");
            if (name != null && !name.trim().isEmpty()) {
                dao.addCategory(name.trim());
                request.setAttribute("message", "✅ Đã thêm danh mục: " + name);
            }
        }
        // Xử lý SỬA danh mục
        else if (request.getParameter("edit_category") != null) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            if (name != null && !name.trim().isEmpty()) {
                dao.updateCategory(id, name.trim());
                request.setAttribute("message", "✅ Đã cập nhật thành công!");
            }
        }

        // Sau khi thêm/sửa, gọi lại doGet để load lại bảng danh sách
        doGet(request, response);
    }
}