package com.ems.service;

import java.sql.*;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;
import com.ems.util.DBConnection;

public class OTPService {
    
    public String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
    
    public boolean saveOTP(String email, String otp, Date expiryDate) {
        String sql = "INSERT INTO password_reset_otp (email, otp, expiry_date) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, otp);
            pstmt.setTimestamp(3, new Timestamp(expiryDate.getTime()));
            
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public String validateOTP(String email, String otp) {
        String sql = "SELECT email FROM password_reset_otp WHERE email = ? AND otp = ? AND used = FALSE AND expiry_date > ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, otp);
            pstmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("email");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean markOTPAsUsed(String email, String otp) {
        String sql = "UPDATE password_reset_otp SET used = TRUE WHERE email = ? AND otp = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            pstmt.setString(2, otp);
            int rows = pstmt.executeUpdate();
            return rows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public void cleanupExpiredOTPs() {
        String sql = "DELETE FROM password_reset_otp WHERE expiry_date < NOW() OR used = TRUE";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}