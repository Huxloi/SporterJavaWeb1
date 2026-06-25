package controller;

import dao.OrderDAO;
import dao.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ReviewServlet", value = "/review")
public class ReviewServlet extends HttpServlet {

    // Không cần dùng doGet phân giải dữ liệu sang review.jsp riêng biệt nữa
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("my_orders");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // Lấy thông tin tài khoản đăng nhập (tùy chỉnh cho khớp model của bạn)
        model.User acc = (model.User) session.getAttribute("acc");
        if (acc == null) {
            acc = (model.User) session.getAttribute("user");
        }
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            CommentDAO commentDAO = new CommentDAO();

            int index = 0;
            // Lặp lấy sản phẩm gửi lên từ form modal/trang review
            while (request.getParameter("products[" + index + "].productId") != null) {

                // Bọc kiểm tra giá trị null và ép kiểu an toàn cho từng thuộc tính
                String pIdStr = request.getParameter("products[" + index + "].productId");
                String ratingStr = request.getParameter("products[" + index + "].rating");

                if (pIdStr == null || pIdStr.trim().isEmpty() || ratingStr == null || ratingStr.trim().isEmpty()) {
                    index++;
                    continue; // Bỏ qua nếu dữ liệu không đầy đủ
                }

                int productId = Integer.parseInt(pIdStr);
                int rating = Integer.parseInt(ratingStr);

                String comment = request.getParameter("products[" + index + "].comment");
                String size = request.getParameter("products[" + index + "].size");
                String color = request.getParameter("products[" + index + "].color");

                // Lưu đánh giá sản phẩm tương ứng
                commentDAO.addProductReview(acc.getId(), productId, rating, comment, size, color, orderId);

                index++;
            }

            response.sendRedirect("my_orders?message=review_success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("my_orders?message=review_fail");
        }
    }
}