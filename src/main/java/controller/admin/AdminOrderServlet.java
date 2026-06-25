package controller.admin;

import dao.OrderDAO;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderServlet", value = "/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrderDAO dao = new OrderDAO();
        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        // Xem chi tiết một đơn hàng
        if ("view".equals(action) && idParam != null) {
            int orderId = Integer.parseInt(idParam);
            Order order = dao.getOrderDetailsAdmin(orderId);
            request.setAttribute("order", order);
            request.getRequestDispatcher("/admin/order_detail.jsp").forward(request, response);
            return;
        }

        // Hiển thị danh sách toàn bộ đơn hàng
        List<Order> listOrders = dao.getAllOrders();
        request.setAttribute("listOrders", listOrders);
        request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        // Cập nhật trạng thái đơn hàng
        if ("update_status".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            OrderDAO dao = new OrderDAO();
            dao.updateOrderStatus(orderId, status);

            // Xử lý xong thì quay lại trang chi tiết của đơn hàng đó kèm thông báo
            response.sendRedirect("orders?action=view&id=" + orderId + "&message=updated");
        }
    }
}