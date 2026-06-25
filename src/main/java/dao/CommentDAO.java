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
        String sql = "SELECT u.username, co.comment_text, co.created_at " +
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
}