package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DbUtils;

public class OrderDAO {

    public OrderDTO getOrderById(int id) {
        String sql = "SELECT * FROM [Order] WHERE order_id = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new OrderDTO(
                    rs.getInt("order_id"),
                    rs.getInt("user_id"),
                    rs.getString("order_date"),
                    rs.getString("status"),
                    rs.getDouble("total_amount")
                );
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertOrder(OrderDTO order) {
        String sql = "INSERT INTO [Order] (user_id, order_date, status, total_amount) VALUES (?, ?, ?, ?)";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getOrderDate());
            ps.setString(3, order.getStatus());
            ps.setDouble(4, order.getTotalAmount());
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
}