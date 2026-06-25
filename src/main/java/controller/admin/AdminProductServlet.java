package controller.admin;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(name = "AdminProductServlet", value = "/admin/products")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class AdminProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO pDao = new ProductDAO();
        CategoryDAO cDao = new CategoryDAO();
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            pDao.deleteProduct(id);
            response.sendRedirect("products?message=deleted");
            return;
        }

        // Truyền danh sách sản phẩm và danh mục ra View
        List<Product> listP = pDao.getAllProducts();
        List<Category> listC = cDao.getAllCategories();

        request.setAttribute("listProducts", listP);
        request.setAttribute("listCategories", listC);
        request.getRequestDispatcher("/admin/products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String name = request.getParameter("name");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        double price = Double.parseDouble(request.getParameter("price"));
        int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
        String description = request.getParameter("description");

        // --- XỬ LÝ UPLOAD HÌNH ẢNH ---
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String imageUrl = request.getParameter("oldImage"); // Giữ ảnh cũ nếu không up ảnh mới

        if (fileName != null && !fileName.isEmpty()) {
            // Lưu file vào thư mục 'images' trong thư mục webapp đang chạy
            String uploadPath = getServletContext().getRealPath("/") + "images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String savePath = uploadPath + File.separator + fileName;
            filePart.write(savePath);
            imageUrl = "images/" + fileName; // Đường dẫn lưu vào CSDL
        }

        Product p = new Product(0, categoryId, name, description, price, stockQuantity, imageUrl);
        ProductDAO dao = new ProductDAO();

        if ("add".equals(action)) {
            dao.addProduct(p);
        } else if ("edit".equals(action)) {
            p.setId(Integer.parseInt(request.getParameter("id")));
            dao.updateProduct(p);
        }

        response.sendRedirect("products?message=success");
    }
}