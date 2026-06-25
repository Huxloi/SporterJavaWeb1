package dao;

import context.DBContext;
import model.Contact;
import java.sql.*;
import java.util.*;

public class ContactDAO {

    public List<Contact> getAllContacts() {
        List<Contact> list = new ArrayList<>();
        String sql = "SELECT c.*, r.reply_content FROM contacts c " +
                "LEFT JOIN contact_replies r ON c.id = r.contact_id " +
                "ORDER BY c.sent_at DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Contact(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("subject"),
                        rs.getString("message_content"),
                        rs.getTimestamp("sent_at"),
                        rs.getInt("is_replied"),
                        rs.getString("reply_content")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Contact> getContactsByUserId(int userId) {
        List<Contact> list = new ArrayList<>();
        String sql = "SELECT c.*, r.reply_content FROM contacts c " +
                "LEFT JOIN contact_replies r ON c.id = r.contact_id " +
                "WHERE c.user_id = ? ORDER BY c.sent_at DESC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Contact(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("phone"),
                            rs.getString("subject"),
                            rs.getString("message_content"),
                            rs.getTimestamp("sent_at"),
                            rs.getInt("is_replied"),
                            rs.getString("reply_content")
                    ));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean addContact(int userId, String name, String phone, String subject, String message) {
        String sql = "INSERT INTO contacts (user_id, name, phone, subject, message_content) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, name);
            ps.setString(3, phone);
            ps.setString(4, subject);
            ps.setString(5, message);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public int countUnrepliedMessages() {
        String sql = "SELECT COUNT(*) FROM contacts WHERE is_replied = 0";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public Contact getContactById(int id) {
        String sql = "SELECT * FROM contacts WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Contact(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("phone"),
                            rs.getString("subject"),
                            rs.getString("message_content"),
                            rs.getTimestamp("sent_at"),
                            rs.getInt("is_replied")
                    );
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public void replyContact(int contactId, int adminId, String replyContent) {
        String insertReplySql = "INSERT INTO contact_replies (contact_id, admin_id, reply_content, replied_at) VALUES (?, ?, ?, NOW())";
        String updateContactSql = "UPDATE contacts SET is_replied = 1 WHERE id = ?";

        try (Connection conn = new DBContext().getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement ps1 = conn.prepareStatement(insertReplySql)) {
                ps1.setInt(1, contactId);
                ps1.setInt(2, adminId);
                ps1.setString(3, replyContent);
                ps1.executeUpdate();
            }

            try (PreparedStatement ps2 = conn.prepareStatement(updateContactSql)) {
                ps2.setInt(1, contactId);
                ps2.executeUpdate();
            }

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Contact> getTopUnrepliedMessages() {
        List<Contact> list = new ArrayList<>();
        String sql = "SELECT * FROM contacts WHERE is_replied = 0 ORDER BY sent_at DESC LIMIT 5";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Contact(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("subject"),
                        rs.getString("message_content"),
                        rs.getTimestamp("sent_at"),
                        rs.getInt("is_replied")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}