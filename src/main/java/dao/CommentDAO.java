package dao;

import context.DBContext;
import java.sql.*;
import java.util.*;

public class CommentDAO {

    public void deleteComment(int id) {
        String sql = "DELETE FROM comments WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<Map<String, Object>> getAllComments() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT co.id, u.username, p.name AS product_name, co.comment_text, co.created_at " +
                "FROM comments co " +
                "LEFT JOIN users u ON co.user_id = u.id " +
                "LEFT JOIN products p ON co.product_id = p.id " +
                "ORDER BY co.created_at DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", rs.getInt("id"));
                map.put("username", rs.getString("username"));
                map.put("productName", rs.getString("product_name"));
                map.put("commentText", rs.getString("comment_text"));
                map.put("createdAt", rs.getTimestamp("created_at"));
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Map<String, Object>> getCommentsByProductId(int productId) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT u.username, co.comment_text, co.rating, co.size, co.color, co.created_at " +
                "FROM comments co " +
                "LEFT JOIN users u ON co.user_id = u.id " +
                "WHERE co.product_id = ? " +
                "ORDER BY co.created_at DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("username", rs.getString("username"));
                map.put("commentText", rs.getString("comment_text"));
                map.put("rating", rs.getInt("rating"));
                map.put("size", rs.getString("size"));
                map.put("color", rs.getString("color"));
                map.put("createdAt", rs.getTimestamp("created_at"));
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void addComment(int userId, int productId, String content) {
        String sql = "INSERT INTO comments (user_id, product_id, comment_text, created_at) VALUES (?, ?, ?, NOW())";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setString(3, content);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // Hàm lưu đánh giá sản phẩm sau khi mua (Bổ sung thêm cột order_id)
    public void addProductReview(int userId, int productId, int rating, String comment, String size, String color, int orderId) {
        String sql = "INSERT INTO comments (user_id, product_id, rating, comment_text, size, color, order_id, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setInt(3, rating);
            ps.setString(4, comment);
            ps.setString(5, size);
            ps.setString(6, color);
            ps.setInt(7, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Kiểm tra xem user đã đánh giá sản phẩm này trong đơn hàng cụ thể chưa với các thuộc tính phân loại
    public boolean hasUserReviewedProduct(int userId, int productId, int orderId, String size, String color) {
        String sql = "SELECT 1 FROM comments WHERE user_id = ? AND product_id = ? AND order_id = ? AND size = ? AND color = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setInt(3, orderId);
            ps.setString(4, size);
            ps.setString(5, color);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
} 