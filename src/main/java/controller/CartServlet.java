package controller;

import dao.ProductDAO;
import model.Cart;
import model.Item;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {

    // Xử lý hiển thị giỏ hàng, cập nhật số lượng hoặc xóa item
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }

        String action = request.getParameter("action");

        // 1. Xử lý cập nhật số lượng ngầm (AJAX)
        if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                // Lấy thông tin cũ để tìm đúng item trong giỏ
                String oldSize = request.getParameter("oldSize");
                String oldColor = request.getParameter("oldColor");

                // Lấy thông tin mới người dùng vừa chọn
                String newSize = request.getParameter("newSize");
                String newColor = request.getParameter("newColor");

                // Tìm kiếm sản phẩm trong giỏ hàng
                for (Item item : cart.getItems()) {
                    if (item.getProduct().getId() == id && item.getSize().equals(oldSize) && item.getColor().equals(oldColor)) {
                        // Cập nhật lại thuộc tính
                        item.setSize(newSize);
                        item.setColor(newColor);
                        item.setQuantity(quantity);
                        break;
                    }
                }
                session.setAttribute("cart", cart);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("cart");
            return;
        }

        // 2. Xử lý xóa sản phẩm
        if ("delete".equals(action) || "remove".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String size = request.getParameter("size");
                String color = request.getParameter("color");
                cart.removeItem(id, size, color);
                session.setAttribute("cart", cart);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("cart");
            return;
        }

        // 3. Xử lý khi bấm nút Tiến hành thanh toán
        if ("checkout".equals(action)) {
            // Kiểm tra an toàn: Nếu giỏ hàng thực sự có sản phẩm mới cho phép qua
            if (cart.getItems() != null && !cart.getItems().isEmpty()) {
                // Nạp lại cart vào session cho chắc chắn dữ liệu khớp hoàn toàn
                session.setAttribute("cart", cart);
                // Forward trực tiếp sang trang checkout.jsp, URL trên trình duyệt sẽ giữ nguyên /cart?action=checkout
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            } else {
                // Giỏ hàng rỗng -> điều hướng về lại trang giỏ hàng
                response.sendRedirect("cart");
                return;
            }
        }

        // Mặc định trả về trang giỏ hàng nếu không khớp action nào
        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    // Xử lý khi nhấn nút Thêm vào giỏ từ trang Product Detail
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String size = request.getParameter("size");
            String color = request.getParameter("color");

            ProductDAO dao = new ProductDAO();
            Product product = dao.getProductById(productId);

            if (product != null) {
                Item item = new Item(product, quantity, size, color, product.getPrice());
                cart.addItem(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart");
    }
}