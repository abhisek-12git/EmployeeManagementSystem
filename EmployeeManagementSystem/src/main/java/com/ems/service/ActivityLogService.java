package com.ems.service;

import java.util.*;
import java.sql.*;

import com.ems.model.ActivityLog;
import com.ems.util.DBConnection;

public class ActivityLogService {
    
	
	
	
	//get current activities
    public List<ActivityLog> getRecentActivitiesByAdmin(String adminUsername, int limit){
        List<ActivityLog> activities = new ArrayList<>();
        String sql = "SELECT * FROM activity_log WHERE admin_username = ? ORDER BY timestamp DESC LIMIT ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, adminUsername);
            st.setInt(2, limit);
            ResultSet rs = st.executeQuery();
            
            while(rs.next()) {
                ActivityLog activity = new ActivityLog();
                activity.setId(rs.getInt("id"));
                activity.setActionType(rs.getString("action_type"));
                activity.setActionDescription(rs.getString("action_description"));
                activity.setEmployeeName(rs.getString("employee_name"));
                activity.setAdminUsername(rs.getString("admin_username"));
                activity.setAdminFullname(rs.getString("admin_fullname"));
                activity.setTimestamp(rs.getTimestamp("timestamp"));
                activities.add(activity);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return activities;
    }
    
    
    
    
    
    //log activity
    public boolean logActivity(String actionType, String description, String adminUsername, String adminFullname, String employeeName) {
        String sql = "INSERT INTO activity_log (action_type, action_description, employee_name, admin_username, admin_fullname, timestamp) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement st = con.prepareStatement(sql)) {
            
            st.setString(1, actionType);
            st.setString(2, description);
            st.setString(3, employeeName != null ? employeeName : "System");
            st.setString(4, adminUsername != null ? adminUsername : "system");
            st.setString(5, adminFullname != null ? adminFullname : "System Administrator");
            
            st.setTimestamp(6, new java.sql.Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
            
        } catch(Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
    
    //get all current activities
    public List<ActivityLog> getAllRecentActivities(int limit) {
        List<ActivityLog> activities = new ArrayList<>();
        String sql = "SELECT * FROM activity_log ORDER BY timestamp DESC LIMIT ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                ActivityLog activity = new ActivityLog();
                activity.setId(rs.getInt("id"));
                activity.setActionType(rs.getString("action_type"));
                activity.setActionDescription(rs.getString("action_description"));
                activity.setEmployeeName(rs.getString("employee_name"));
                activity.setAdminUsername(rs.getString("admin_username"));
                activity.setAdminFullname(rs.getString("admin_fullname"));
                activity.setTimestamp(rs.getTimestamp("timestamp"));
                activities.add(activity);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return activities;
    }
    
    
    
    
    
    
    //get current activities with fallback
    public List<ActivityLog> getRecentActivitiesWithFallback(String adminUsername, int limit) {
        List<ActivityLog> activities = getAllRecentActivities(limit);
        if(activities.isEmpty()) {
            return new ArrayList<>();
        }
        return activities;
    }
    
    
    
    
    
    
    //count total activities
    public int getTotalActivityCount() {
        String sql = "SELECT COUNT(*) as total FROM activity_log";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    
    
    
    
    //activity exists
    public void ensureActivitiesExist(String adminUsername, String adminFullname) {
        try {
            String countSql = "SELECT COUNT(*) as count FROM activity_log";
            Connection conn = DBConnection.getConnection();
            PreparedStatement countStmt = conn.prepareStatement(countSql);
            ResultSet rs = countStmt.executeQuery();
            
            if (rs.next() && rs.getInt("count") == 0) {
                String[][] samples = {
                    {"login", "Admin logged into the system", "System"},
                    {"add", "New employee 'John Doe' added to IT department", "John Doe"},
                    {"add", "New employee 'Jane Smith' added to HR department", "Jane Smith"}, 
                    {"update", "Employee profile information updated", "John Doe"},
                    {"login", "Admin logged into the system", "System"}
                };
                
                String insertSql = "INSERT INTO activity_log (action_type, action_description, employee_name, admin_username, admin_fullname, timestamp) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                
                long currentTime = System.currentTimeMillis();
                
                for (int i=0; i< samples.length; i++) {
                	String[] sample = samples[i];
                    insertStmt.setString(1, sample[0]);
                    insertStmt.setString(2, sample[1]);
                    insertStmt.setString(3, sample[2]);
                    insertStmt.setString(4, adminUsername);
                    insertStmt.setString(5, adminFullname);
                    
                    long sampleTime = currentTime - (i * 3600000L);
                    insertStmt.setTimestamp(6, new java.sql.Timestamp(sampleTime));
                    insertStmt.addBatch();
                }
                
                insertStmt.executeBatch();
                insertStmt.close();
            }
            
            rs.close();
            countStmt.close();
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}