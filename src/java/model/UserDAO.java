package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DbUtils;

public class UserDAO {

    public List<UserDTO> getAll() throws Exception {
        List<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new UserDTO(
                    rs.getInt("user_id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("password_hash"),
                    rs.getString("address"),
                    rs.getString("phone_number"),
                    rs.getString("created_at"),
                    rs.getString("role")
                ));
            }
        }
        return list;
    }

    public UserDTO getById(int id) throws Exception {
        String sql = "SELECT * FROM [User] WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new UserDTO(
                        rs.getInt("user_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password_hash"),
                        rs.getString("address"),
                        rs.getString("phone_number"),
                        rs.getString("created_at"),
                        rs.getString("role")
                    );
                }
            }
        }
        return null;
    }

    public void insert(UserDTO user) throws Exception {
        String sql = "INSERT INTO [User](name, email, password_hash, address, phone_number, role) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getRole());
            ps.executeUpdate();
        }
    }

    public void update(UserDTO user) throws Exception {
        String sql = "UPDATE [User] SET name=?, email=?, password_hash=?, address=?, phone_number=?, role=? WHERE user_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getRole());
            ps.setInt(7, user.getUserId());
            ps.executeUpdate();
        }
    }

    public void delete(int id) throws Exception {
        String sql = "DELETE FROM [User] WHERE user_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}