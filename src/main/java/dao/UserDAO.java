package dao;

import context.DBContext;
import model.User;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // ==========================================
    // PHẦN 1: DÀNH CHO KHÁCH HÀNG (Đăng nhập/Đăng ký)
    // ==========================================

    public User checkLogin(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashedPassword = rs.getString("password");
                    if (BCrypt.checkpw(password, hashedPassword)) {
                        return new User(
                                rs.getInt("id"), rs.getString("username"),
                                rs.getString("email"), rs.getString("role")
                        );
                    }
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public boolean checkUserExist(String username, String email) {
        String sql = "SELECT id FROM users WHERE username = ? OR email = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return true;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean registerUser(String username, String password, String email) {
        if (checkUserExist(username, email)) return false;
        String sql = "INSERT INTO users (username, password, email, role) VALUES (?, ?, ?, 'customer')";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));
            ps.setString(1, username);
            ps.setString(2, hashedPassword);
            ps.setString(3, email);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    // ==========================================
    // PHẦN 2: DÀNH CHO ADMIN QUẢN LÝ
    // ==========================================

    // Lấy danh sách toàn bộ người dùng
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id, username, email, role FROM users ORDER BY id DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new User(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("role")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Xóa người dùng theo ID
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}