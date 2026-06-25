package controller.admin;

import dao.PostDAO;
import model.Post;
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

@WebServlet(name = "AdminPostServlet", value = "/admin/posts")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class AdminPostServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PostDAO dao = new PostDAO();
        String action = request.getParameter("action");

        // Xử lý XÓA bài viết
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deletePost(id);
            response.sendRedirect("posts?message=deleted");
            return;
        }

        // Tải danh sách bài viết lên bảng
        List<Post> listPosts = dao.getAllPostsAdmin();
        request.setAttribute("listPosts", listPosts);
        request.getRequestDispatcher("/admin/posts.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String title = request.getParameter("title");
        String summary = request.getParameter("summary");
        String content = request.getParameter("content");

        // Xử lý upload ảnh thumbnail bài viết
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String imageUrl = request.getParameter("oldImage"); // Giữ lại ảnh cũ nếu không đăng ảnh mới

        if (fileName != null && !fileName.isEmpty()) {
            String uploadPath = getServletContext().getRealPath("/") + "images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String savePath = uploadPath + File.separator + fileName;
            filePart.write(savePath);
            imageUrl = "images/" + fileName;
        }

        Post p = new Post(0, title, summary, content, imageUrl, null);
        PostDAO dao = new PostDAO();

        if ("add".equals(action)) {
            dao.addPost(p);
        } else if ("edit".equals(action)) {
            p.setId(Integer.parseInt(request.getParameter("id")));
            dao.updatePost(p);
        }

        response.sendRedirect("posts?message=success");
    }
}