package controller;

import dao.OrderDAO;
import dao.ProductDAO;
import model.Cart;
import model.Item;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("acc");
        Cart cart = (Cart) session.getAttribute("cart");

        // 1. Kiểm tra đăng nhập
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }
        // 2. Kiểm tra giỏ hàng có trống không
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("acc");
        Cart cart = (Cart) session.getAttribute("cart");

        if (acc != null && cart != null && !cart.getItems().isEmpty()) {
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String paymentMethod = request.getParameter("payment_method");

            OrderDAO dao = new OrderDAO();
            boolean isSuccess = dao.createOrder(acc, cart, address, phone, paymentMethod);

            if (isSuccess) {
                // TRỪ TỒN KHO SẢN PHẨM SAU KHI ĐẶT HÀNG THÀNH CÔNG
                ProductDAO productDAO = new ProductDAO();
                for (Item item : cart.getItems()) {
                    productDAO.reduceStock(item.getProduct().getId(), item.getQuantity());
                }

                // Xóa giỏ hàng sau khi đặt thành công
                session.removeAttribute("cart");
                // Chuyển hướng trang thông báo thành công
                response.sendRedirect("index?message=OrderSuccess");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại!");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("login");
        }
    }
}