package dao;

import context.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class ReportDAO {

    // 1. Lấy doanh thu hôm nay
    public double getTodayRevenue() {
        String sql = "SELECT SUM(total_amount) FROM orders WHERE DATE(order_date) = CURDATE() AND status = 'Đã hoàn thành'";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 2. Đếm số lượng tổng quát
    public int getCount(String sqlWhere) {
        String sql = "SELECT COUNT(*) FROM " + sqlWhere;
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // 3. Báo cáo doanh thu danh mục
    public List<Map<String, Object>> getCategoryRevenue() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT c.name, SUM(oi.price_at_purchase * oi.quantity) as total " +
                "FROM categories c JOIN products p ON c.id = p.category_id " +
                "JOIN order_items oi ON p.id = oi.product_id GROUP BY c.name";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", rs.getString("name"));
                map.put("total", rs.getDouble("total"));
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 4. Lấy danh sách 10 sản phẩm bán chạy
    public List<Map<String, Object>> getTop10Products() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.name, SUM(oi.quantity) as total_sold " +
                "FROM products p JOIN order_items oi ON p.id = oi.product_id " +
                "GROUP BY p.name ORDER BY total_sold DESC LIMIT 10";
        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("name", rs.getString("name"));
                map.put("total_sold", rs.getInt("total_sold"));
                list.add(map);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 5. MỚI: Lấy xu hướng doanh thu 7 ngày gần nhất (Tự động bù ngày doanh thu bằng 0)
    public Map<String, Double> getRecent7DaysRevenue() {
        Map<String, Double> trendMap = new LinkedHashMap<>();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM");

        // Tạo sẵn dữ liệu 7 ngày bằng 0đ
        for (int i = 6; i >= 0; i--) {
            trendMap.put(today.minusDays(i).format(formatter), 0.0);
        }

        String sql = "SELECT DATE_FORMAT(order_date, '%d/%m') as date_label, SUM(total_amount) as daily_total " +
                "FROM orders " +
                "WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND status = 'Đã hoàn thành' " +
                "GROUP BY DATE(order_date) " +
                "ORDER BY DATE(order_date) ASC";

        try (Connection conn = new DBContext().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String dateLabel = rs.getString("date_label");
                double dailyTotal = rs.getDouble("daily_total");
                if (trendMap.containsKey(dateLabel)) {
                    trendMap.put(dateLabel, dailyTotal);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return trendMap;
    }
}