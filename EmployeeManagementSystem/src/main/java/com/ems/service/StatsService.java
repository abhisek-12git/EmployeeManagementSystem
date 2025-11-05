package com.ems.service;

import java.sql.*;
import com.ems.util.DBConnection;

public class StatsService {
    
    public int getTotalEmployeesCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) as total FROM employee";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return count;
    }
    
    public int getActiveEmployeesCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) as active FROM employee WHERE status = 'active'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt("active");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return count;
    }
    
    public int getActiveEmployeesCountAdvanced() {
        int count = 0;
        String sql = "SELECT COUNT(*) as active FROM employee WHERE status = 'active'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt("active");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return count;
    }
    
    public int getNewEmployeesThisMonth() {
        int count = 0;
        String sql = "SELECT COUNT(*) as new_employees FROM employee WHERE MONTH(joindate) = MONTH(CURRENT_DATE()) AND YEAR(joindate) = YEAR(CURRENT_DATE()) AND status = 'active'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt("new_employees");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return count;
    }
    
    public int getTotalDepartmentsCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) as departments FROM departments";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt("departments");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return count;
    }
    
    public int getInactiveEmployeesCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) as inactive FROM employee WHERE status = 'inactive'";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                count = rs.getInt("inactive");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return count;
    }
}