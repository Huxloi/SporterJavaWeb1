package controller;

import dao.PostDAO;
import model.Post;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "PostDetailServlet", value = "/post_detail")
public class PostDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("news");
            return;
        }

        try {
            int postId = Integer.parseInt(idParam);
            PostDAO dao = new PostDAO();
            Post post = dao.getPostById(postId);

            if (post != null) {
                request.setAttribute("post", post);
                request.getRequestDispatcher("post_detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("news");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("news");
        }
    }
}