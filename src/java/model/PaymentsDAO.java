package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DbUtils;

public class PaymentsDAO {

    public PaymentsDTO getPaymentById(int id) {
        String sql = "SELECT * FROM Payments WHERE payment_id = ?";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new PaymentsDTO(
                    rs.getInt("payment_id"),
                    rs.getInt("order_id"),
                    rs.getString("payment_date"),
                    rs.getString("payment_method"),
                    rs.getDouble("amount"),
                    rs.getString("payment_status")
                );
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean insertPayment(PaymentsDTO payment) {
        String sql = "INSERT INTO Payments (order_id, payment_date, payment_method, amount, payment_status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DbUtils.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, payment.getOrderId());
            ps.setString(2, payment.getPaymentDate());
            ps.setString(3, payment.getPaymentMethod());
            ps.setDouble(4, payment.getAmount());
            ps.setString(5, payment.getPaymentStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
}