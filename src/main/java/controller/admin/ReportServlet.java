package controller.admin;

import dao.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/reports")
public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReportDAO dao = new ReportDAO();

        List<Map<String, Object>> categoryRevenue = dao.getCategoryRevenue();
        List<Map<String, Object>> top10Products = dao.getTop10Products();
        Map<String, Double> trend7Days = dao.getRecent7DaysRevenue();

        double totalRevenue = 0;
        for (Map<String, Object> map : categoryRevenue) {
            totalRevenue += (Double) map.get("total");
        }

        request.setAttribute("categoryRevenue", categoryRevenue);
        request.setAttribute("top10Products", top10Products);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("trend7Days", trend7Days); // Truyền dữ liệu biểu đồ đường

        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }
}