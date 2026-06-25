package dao;

import context.DBContext;
import model.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {

    // 1. Lấy tổng số bài viết để làm phân trang phía khách hàng (Đã có)
    public int getTotalPosts() {
        String sql = "SELECT COUNT(*) FROM posts";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 2. Lấy danh sách bài viết theo trang (Đã có)
    public List<Post> getPostsByPage(int offset, int limit) {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT id, title, summary, content, image_url, created_at FROM posts ORDER BY created_at DESC LIMIT ? OFFSET ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ps.setInt(2, offset);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Post(
                            rs.getInt("id"), rs.getString("title"), rs.getString("summary"),
                            rs.getString("content"), rs.getString("image_url"), rs.getTimestamp("created_at")
                    ));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 3. Lấy chi tiết 1 bài viết theo ID (Đã có)
    public Post getPostById(int id) {
        String sql = "SELECT id, title, summary, content, image_url, created_at FROM posts WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Post(
                            rs.getInt("id"), rs.getString("title"), rs.getString("summary"),
                            rs.getString("content"), rs.getString("image_url"), rs.getTimestamp("created_at")
                    );
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    // ==========================================
    // CÁC HÀM BỔ SUNG DÀNH CHO ADMIN
    // ==========================================

    // 4. Lấy tất cả bài viết không phân trang để hiện lên bảng quản trị
    public List<Post> getAllPostsAdmin() {
        List<Post> list = new ArrayList<>();
        String sql = "SELECT id, title, summary, content, image_url, created_at FROM posts ORDER BY id DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Post(
                        rs.getInt("id"), rs.getString("title"), rs.getString("summary"),
                        rs.getString("content"), rs.getString("image_url"), rs.getTimestamp("created_at")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 5. Thêm bài viết mới
    public boolean addPost(Post p) {
        String sql = "INSERT INTO posts (title, summary, content, image_url) VALUES (?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getSummary());
            ps.setString(3, p.getContent());
            ps.setString(4, p.getImageUrl());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // 6. Cập nhật bài viết
    public boolean updatePost(Post p) {
        String sql = "UPDATE posts SET title = ?, summary = ?, content = ?, image_url = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getSummary());
            ps.setString(3, p.getContent());
            ps.setString(4, p.getImageUrl());
            ps.setInt(5, p.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // 7. Xóa bài viết
    public boolean deletePost(int id) {
        String sql = "DELETE FROM posts WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}