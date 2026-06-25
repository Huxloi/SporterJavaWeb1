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

@WebServlet(name = "OrderDetailServlet", value = "/order_detail")
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("my_orders");
            return;
        }

        int orderId = Integer.parseInt(idParam);
        OrderDAO dao = new OrderDAO();
        Order order = dao.getOrderDetails(orderId, acc.getId());

        if (order == null) {
            response.sendRedirect("my_orders");
            return;
        }

        request.setAttribute("order", order);
        request.getRequestDispatcher("order_detail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        String idParam = request.getParameter("orderId");

        if ("cancel".equals(action) && idParam != null) {
            int orderId = Integer.parseInt(idParam);
            OrderDAO dao = new OrderDAO();
            boolean check = dao.cancelOrder(orderId, acc.getId());

            if (check) {
                request.setAttribute("message", "✅ Đơn hàng #" + orderId + " đã được hủy thành công.");
            } else {
                request.setAttribute("error", "❌ Không thể hủy đơn hàng này do trạng thái hiện tại đã thay đổi.");
            }
        }
        doGet(request, response);
    }
}