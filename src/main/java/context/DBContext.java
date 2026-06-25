package context;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {

    // Hàm này làm nhiệm vụ tạo kết nối đến XAMPP
    public Connection getConnection() throws Exception {
        // Tên database của bạn là the_thao_shop
        String url = "jdbc:mysql://localhost:3306/the_thao_shop";
        String userID = "root";
        String password = ""; // XAMPP mặc định mật khẩu để trống

        // Gọi driver kết nối (chính là cái file .jar bạn vừa kéo vào lib đó)
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, userID, password);
    }

    // Hàm main này để chạy test thử xem kết nối thành công chưa
    public static void main(String[] args) {
        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            if (conn != null) {
                System.out.println("CHÚC MỪNG! KẾT NỐI DATABASE THÀNH CÔNG!");
            }
        } catch (Exception e) {
            System.out.println("Lỗi kết nối rồi, kiểm tra lại: " + e.getMessage());
        }
    }
}