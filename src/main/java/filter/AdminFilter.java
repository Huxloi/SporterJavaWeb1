package filter;

import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// Dấu * nghĩa là bảo vệ toàn bộ các đường dẫn bắt đầu bằng /admin/
@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession();

        User acc = (User) session.getAttribute("acc");

        // Nếu đã đăng nhập VÀ có quyền admin thì cho đi tiếp
        if (acc != null && acc.isAdmin()) {
            chain.doFilter(request, response);
        } else {
            // Nếu không, đá văng ra trang đăng nhập
            res.sendRedirect(req.getContextPath() + "/login");
        }
    }
}