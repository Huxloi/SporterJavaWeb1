package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeController", value = "/index")
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // 1. Lấy danh sách toàn bộ danh mục để làm Menu Dropdown công cụ lọc
        List<Category> listCategory = categoryDAO.getAllCategories();
        request.setAttribute("listCC", listCategory);

        // 2. Kiểm tra các tham số lọc hoặc tìm kiếm từ client gửi lên
        String categoryIdParam = request.getParameter("catId");
        String searchParam = request.getParameter("search");

        List<Product> listProduct;

        if (searchParam != null && !searchParam.trim().isEmpty()) {
            // Nếu có từ khóa tìm kiếm
            listProduct = productDAO.searchProductsByName(searchParam.trim());
            request.setAttribute("titlePage", "Kết quả tìm kiếm cho: '" + searchParam + "'");
        } else if (categoryIdParam != null && !categoryIdParam.trim().isEmpty()) {
            // Nếu click chọn danh mục cụ thể
            try {
                int catId = Integer.parseInt(categoryIdParam);
                listProduct = productDAO.getProductsByCategoryId(catId);

                String catName = "Danh mục";
                for (Category c : listCategory) {
                    if (c.getId() == catId) {
                        catName = c.getName();
                        break;
                    }
                }
                request.setAttribute("titlePage", catName);
            } catch (NumberFormatException e) {
                listProduct = productDAO.getAllProducts();
                request.setAttribute("titlePage", "Tất cả Sản phẩm");
            }
        } else {
            // Mặc định hiển thị trang chủ khi mới truy cập
            listProduct = productDAO.getAllProducts();
            request.setAttribute("titlePage", "Sản phẩm Mới nhất");
        }

        // Đẩy danh sách sản phẩm ra thuộc tính request để JSP hiển thị
        request.setAttribute("listP", listProduct);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}