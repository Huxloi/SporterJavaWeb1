package controller;

import dao.CommentDAO;
import dao.ProductDAO;
import dao.CategoryDAO;
import model.Product;
import model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductsServlet", urlPatterns = {"/products"})
public class ProductsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Thiết lập số lượng sản phẩm hiển thị trên 1 trang
        int limit = 6;

        // Đọc số trang từ URL (mặc định là trang 1)
        String indexPage = request.getParameter("page");
        int index = 1;
        if (indexPage != null && !indexPage.isEmpty()) {
            index = Integer.parseInt(indexPage);
        }

        // Tính toán tổng số trang
        int totalProducts = productDAO.getTotalProducts();
        int endPage = totalProducts / limit;
        if (totalProducts % limit != 0) {
            endPage++;
        }

        // Lấy danh sách sản phẩm phân trang và danh mục
        List<Product> listPaging = productDAO.getProductsPaging(index, limit);
        List<Category> listCategories = categoryDAO.getAllCategories();

        request.setAttribute("listP", listPaging);
        request.setAttribute("listC", listCategories); // Dùng cho phần jsp load danh mục nếu có
        request.setAttribute("listCC", listCategories); // Đồng bộ danh mục menu header

        // Gửi tham số phân trang sang JSP
        request.setAttribute("endP", endPage);
        request.setAttribute("tag", index);

        request.getRequestDispatcher("/products.jsp").forward(request, response);    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}