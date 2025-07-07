package util;

import java.sql.Connection;
import util.DbUtils;

public class TestDB {
    public static void main(String[] args) {
        try (Connection conn = DbUtils.getConnection()) {
            if (conn != null) {
                System.out.println("✅ Kết nối thành công đến cơ sở dữ liệu!");
            } else {
                System.out.println("❌ Không thể kết nối.");
            }
        } catch (Exception e) {
            System.err.println("❌ Lỗi khi kết nối: " + e.getMessage());
        }
    }
}
