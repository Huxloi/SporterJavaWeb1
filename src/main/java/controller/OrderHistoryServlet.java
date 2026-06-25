package controller;

import dao.OrderDAO;
import model.Order;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderHistoryServlet", value = "/my_orders")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("acc");

        // Nếu chưa đăng nhập thì đẩy về trang login
        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        OrderDAO dao = new OrderDAO();
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        // Xử lý xem chi tiết đơn hàng
        if ("view".equals(action) && idParam != null) {
            int orderId = Integer.parseInt(idParam);
            Order order = dao.getOrderDetails(orderId, acc.getId());
            request.setAttribute("order", order);
            request.getRequestDispatcher("order_detail.jsp").forward(request, response);
            return;
        }

        // Xử lý hủy đơn hàng
        if ("cancel".equals(action) && idParam != null) {
            int orderId = Integer.parseInt(idParam);
            boolean check = dao.cancelOrder(orderId, acc.getId());
            if (check) {
                response.sendRedirect("my_orders?message=cancel_success");
            } else {
                response.sendRedirect("my_orders?message=cancel_fail");
            }
            return;
        }

        // Mặc định tải toàn bộ lịch sử đơn hàng đổ ra giao diện hộp
        List<Order> listO = dao.getOrdersByUserId(acc.getId());
        request.setAttribute("listO", listO);
        request.getRequestDispatcher("my_orders.jsp").forward(request, response);
    }
}