package controller;

import dao.PostDAO;
import model.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "NewsServlet", value = "/news")
public class NewsServlet extends HttpServlet {
    private static final int POSTS_PER_PAGE = 6;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PostDAO dao = new PostDAO();

        // 1. Xác định trang hiện tại
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // 2. Tính toán tổng số trang
        int totalPosts = dao.getTotalPosts();
        int totalPages = (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE);

        if (currentPage > totalPages && totalPages > 0) {
            currentPage = totalPages;
        }
        if (currentPage < 1) {
            currentPage = 1;
        }

        // 3. Lấy dữ liệu theo trang
        int offset = (currentPage - 1) * POSTS_PER_PAGE;
        List<Post> listPosts = dao.getPostsByPage(offset, POSTS_PER_PAGE);

        // 4. Đẩy dữ liệu ra View
        request.setAttribute("listPosts", listPosts);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("news.jsp").forward(request, response);
    }
}