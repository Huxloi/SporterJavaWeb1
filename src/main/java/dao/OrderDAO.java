package dao;

import context.DBContext;
import model.Cart;
import model.Item;
import model.Order;
import model.OrderItem;
import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // ==========================================
    // PHẦN 1: CÁC HÀM DÀNH CHO KHÁCH HÀNG
    // ==========================================

    // 1. Tạo đơn hàng mới (Dùng Transaction để đảm bảo an toàn dữ liệu)
    public boolean createOrder(User acc, Cart cart, String address, String phone, String paymentMethod) {
        Connection conn = null;
        try {
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false); // Bắt đầu Transaction

            // Bước 1: Lưu thông tin chung vào bảng orders
            String sqlOrder = "INSERT INTO orders (user_id, total_amount, status, address, phone) VALUES (?, ?, 'Chờ xác nhận', ?, ?)";
            PreparedStatement psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, acc.getId());
            psOrder.setDouble(2, cart.getTotalMoney());
            psOrder.setString(3, address);
            psOrder.setString(4, phone);
            psOrder.executeUpdate();

            // Lấy ID của đơn hàng vừa tạo
            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Bước 2: Lưu từng sản phẩm vào bảng order_items
            String sqlDetail = "INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase, selected_size, selected_color) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement psDetail = conn.prepareStatement(sqlDetail);

            for (Item i : cart.getItems()) {
                psDetail.setInt(1, orderId);
                psDetail.setInt(2, i.getProduct().getId());
                psDetail.setInt(3, i.getQuantity());
                psDetail.setDouble(4, i.getPrice());
                psDetail.setString(5, i.getSize());
                psDetail.setString(6, i.getColor());
                psDetail.executeUpdate();
            }

            conn.commit(); // Xác nhận Transaction
            return true;
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            e.printStackTrace();
        } finally {
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (Exception e) { e.printStackTrace(); }
        }
        return false;
    }

    // 2. Lấy danh sách lịch sử đơn hàng của 1 Khách hàng cụ thể
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT id, user_id, order_date, total_amount, status, address, phone FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Order(
                            rs.getInt("id"),
                            rs.getInt("user_id"),
                            rs.getTimestamp("order_date"),
                            rs.getDouble("total_amount"),
                            rs.getString("status"),
                            rs.getString("address"),
                            rs.getString("phone")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Lấy thông tin chi tiết một đơn hàng theo ID (Bảo mật: Phải đúng user_id mới lấy được)
    public Order getOrderDetails(int orderId, int userId) {
        String sqlOrder = "SELECT id, user_id, order_date, total_amount, status, address, phone FROM orders WHERE id = ? AND user_id = ?";
        String sqlItems = "SELECT oi.*, p.name AS product_name, p.image_url FROM order_items oi " +
                "LEFT JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
        try (Connection conn = new DBContext().getConnection()) {
            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder)) {
                psOrder.setInt(1, orderId);
                psOrder.setInt(2, userId);
                try (ResultSet rsOrder = psOrder.executeQuery()) {
                    if (rsOrder.next()) {
                        Order order = new Order(
                                rsOrder.getInt("id"),
                                rsOrder.getInt("user_id"),
                                rsOrder.getTimestamp("order_date"),
                                rsOrder.getDouble("total_amount"),
                                rsOrder.getString("status"),
                                rsOrder.getString("address"),
                                rsOrder.getString("phone")
                        );

                        List<OrderItem> itemList = new ArrayList<>();
                        try (PreparedStatement psItems = conn.prepareStatement(sqlItems)) {
                            psItems.setInt(1, orderId);
                            try (ResultSet rsItems = psItems.executeQuery()) {
                                while (rsItems.next()) {
                                    itemList.add(new OrderItem(
                                            rsItems.getInt("id"),
                                            rsItems.getInt("order_id"),
                                            rsItems.getInt("product_id"),
                                            rsItems.getString("product_name"),
                                            rsItems.getString("image_url"),
                                            rsItems.getInt("quantity"),
                                            rsItems.getDouble("price_at_purchase"),
                                            rsItems.getString("selected_size"),
                                            rsItems.getString("selected_color")
                                    ));
                                }
                            }
                        }
                        order.setItems(itemList);
                        return order;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. Hủy đơn hàng (Chỉ cho phép khi trạng thái là 'Chờ xác nhận' hoặc 'Đang xử lý')
    public boolean cancelOrder(int orderId, int userId) {
        String sqlCheck = "SELECT status FROM orders WHERE id = ? AND user_id = ?";
        String sqlUpdate = "UPDATE orders SET status = 'Đã hủy' WHERE id = ? AND user_id = ?";
        try (Connection conn = new DBContext().getConnection()) {
            try (PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
                psCheck.setInt(1, orderId);
                psCheck.setInt(2, userId);
                try (ResultSet rs = psCheck.executeQuery()) {
                    if (rs.next()) {
                        String currentStatus = rs.getString("status");
                        if ("Chờ xác nhận".equals(currentStatus) || "Đang xử lý".equals(currentStatus)) {
                            try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate)) {
                                psUpdate.setInt(1, orderId);
                                psUpdate.setInt(2, userId);
                                return psUpdate.executeUpdate() > 0;
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ==========================================
    // PHẦN 2: CÁC HÀM DÀNH CHO ADMIN
    // ==========================================

    // 5. Lấy toàn bộ danh sách đơn hàng của tất cả khách (sắp xếp mới nhất lên đầu)
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT id, user_id, order_date, total_amount, status, address, phone FROM orders ORDER BY order_date DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Order(
                        rs.getInt("id"),
                        rs.getInt("user_id"),
                        rs.getTimestamp("order_date"),
                        rs.getDouble("total_amount"),
                        rs.getString("status"),
                        rs.getString("address"),
                        rs.getString("phone")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 6. Lấy chi tiết 1 đơn hàng cho Admin (không cần check user_id như của khách hàng)
    public Order getOrderDetailsAdmin(int orderId) {
        String sqlOrder = "SELECT id, user_id, order_date, total_amount, status, address, phone FROM orders WHERE id = ?";
        String sqlItems = "SELECT oi.*, p.name AS product_name, p.image_url FROM order_items oi LEFT JOIN products p ON oi.product_id = p.id WHERE oi.order_id = ?";
        try (Connection conn = new DBContext().getConnection()) {
            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder)) {
                psOrder.setInt(1, orderId);
                try (ResultSet rsOrder = psOrder.executeQuery()) {
                    if (rsOrder.next()) {
                        Order order = new Order(
                                rsOrder.getInt("id"), rsOrder.getInt("user_id"),
                                rsOrder.getTimestamp("order_date"), rsOrder.getDouble("total_amount"),
                                rsOrder.getString("status"), rsOrder.getString("address"), rsOrder.getString("phone")
                        );

                        List<OrderItem> itemList = new ArrayList<>();
                        try (PreparedStatement psItems = conn.prepareStatement(sqlItems)) {
                            psItems.setInt(1, orderId);
                            try (ResultSet rsItems = psItems.executeQuery()) {
                                while (rsItems.next()) {
                                    itemList.add(new OrderItem(
                                            rsItems.getInt("id"), rsItems.getInt("order_id"), rsItems.getInt("product_id"),
                                            rsItems.getString("product_name"), rsItems.getString("image_url"),
                                            rsItems.getInt("quantity"), rsItems.getDouble("price_at_purchase"),
                                            rsItems.getString("selected_size"), rsItems.getString("selected_color")
                                    ));
                                }
                            }
                        }
                        order.setItems(itemList);
                        return order;
                    }
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // 7. Cập nhật trạng thái đơn hàng (Admin dùng)
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}