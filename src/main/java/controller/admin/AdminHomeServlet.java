package controller.admin;

import dao.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/index")
public class AdminHomeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReportDAO dao = new ReportDAO();

        // Lấy dữ liệu cho các thẻ thông số chỉ báo
        request.setAttribute("todayRevenue", dao.getTodayRevenue());
        request.setAttribute("pendingOrders", dao.getCount("orders WHERE status='Chờ xác nhận'"));
        request.setAttribute("totalProducts", dao.getCount("products"));

        // ĐÃ SỬA: Chỉ đếm những thành viên là Khách hàng (loại bỏ tài khoản Admin ra khỏi thống kê)
        request.setAttribute("totalUsers", dao.getCount("users WHERE role != 'admin'"));

        // Lấy dữ liệu xu hướng doanh thu 7 ngày gần nhất cho biểu đồ
        Map<String, Double> trend7Days = dao.getRecent7DaysRevenue();
        request.setAttribute("trend7Days", trend7Days);

        request.getRequestDispatcher("/admin/index.jsp").forward(request, response);
    }
}