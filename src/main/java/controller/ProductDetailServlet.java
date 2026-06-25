package controller;

import dao.CommentDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/product_detail")
public class ProductDetailServlet extends HttpServlet {
    private CommentDAO commentDAO = new CommentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("id"));

            request.setAttribute("product", new ProductDAO().getProductById(productId));
            request.setAttribute("comments", commentDAO.getCommentsByProductId(productId));

            // Lấy điểm trung bình thực tế từ CSDL
            double avgRating = commentDAO.getAverageRatingByProductId(productId);
            int totalReviews = commentDAO.getCommentsByProductId(productId).size();

            // Ép điểm trung bình sang số nguyên (từ 0 đến 5) để hiển thị số sao chính xác
            int intAvgRating = (int) Math.round(avgRating);

            request.setAttribute("avgRating", avgRating); // Điểm chính xác (vd: 4.5)
            request.setAttribute("intAvgRating", intAvgRating); // Số nguyên dùng để vẽ sao (vd: 5)
            request.setAttribute("totalReviews", totalReviews);

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("/product_detail.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object acc = session.getAttribute("acc");
        if (acc == null) { response.sendRedirect("login"); return; }

        try {
            int productId = Integer.parseInt(request.getParameter("product_id"));
            String commentText = request.getParameter("comment_text");
            int userId = (int) acc.getClass().getMethod("getId").invoke(acc);

            commentDAO.addComment(userId, productId, commentText);
            response.sendRedirect("product_detail?id=" + productId);
        } catch (Exception e) { e.printStackTrace(); }
    }
}