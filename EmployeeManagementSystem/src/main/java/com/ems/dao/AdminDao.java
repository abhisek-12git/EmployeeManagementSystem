package com.ems.dao;

import java.sql.*;
import java.util.Random;

import com.ems.model.Admin;
import com.ems.util.DBConnection;

public class AdminDao {

    // Register
    public boolean register(Admin a) {
        Connection con = null;
        PreparedStatement st = null;
        
        try {
            con = DBConnection.getConnection();
            
            String sql = "insert into admin(fullname, username, email, phone, password, profile_picture) values (?,?,?,?,?,?)";
            st = con.prepareStatement(sql);
            
            st.setString(1, a.getFullname());
            st.setString(2, a.getUsername());
            st.setString(3, a.getEmail());
            st.setString(4, a.getPhone());
            st.setString(5, a.getPassword());
            st.setString(6, a.getProfilePicture());
            
            return st.executeUpdate() > 0;
        } catch(Exception e) {
            System.out.println("Error in register: " + e);
            e.printStackTrace();
        } finally {
            try {
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return false;
    }
    
    
    

    // Login
    public Admin Login(String email, String password) {
        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.getConnection();
            
            String sql = "select * from admin where email=? and password=?";
            st = con.prepareStatement(sql);
            
            st.setString(1, email);
            st.setString(2, password);
            rs = st.executeQuery();
            
            if(rs.next()) {
                Admin a = new Admin();
                a.setId(rs.getInt("id"));
                a.setFullname(rs.getString("fullname"));
                a.setUsername(rs.getString("username"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setPassword(rs.getString("password"));
                a.setProfilePicture(rs.getString("profile_picture"));
                
                return a;
            }
        } catch(Exception e) {
            System.out.println("Error in login: " + e);
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return null;
    }
    
    
    
    

    // Update admin with profile picture
    public boolean updateAdminWithProfile(Admin admin) {
        Connection con = null;
        PreparedStatement st = null;
        
        try {
            con = DBConnection.getConnection();
            
            String sql = "update admin set fullname=?, username=?, email=?, phone=?, profile_picture=? where id=?";
            st = con.prepareStatement(sql);
            
            st.setString(1, admin.getFullname());
            st.setString(2, admin.getUsername());
            st.setString(3, admin.getEmail());
            st.setString(4, admin.getPhone());
            st.setString(5, admin.getProfilePicture());
            st.setInt(6, admin.getId());
            
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch(Exception e) {
            System.out.println("Error updating admin profile: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (st != null) st.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return false;
    }
    
    
    

    // Check username and email duplication - FIXED TABLE NAME
    public boolean isUsernameExists(String username) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM admin WHERE username = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.out.println("Error in isUsernameExists: " + e);
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    
    
    
    public boolean isEmailExists(String email) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.getConnection();
            String sql = "SELECT COUNT(*) FROM admin WHERE email = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            System.out.println("Error in isEmailExists: " + e);
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    
    
    
    
    
    //Generate 6-didgit verification code
    public String generateVerificationCode() {
    	Random random = new Random();
    	int code = 100000 + random.nextInt(900000);
    	return String.valueOf(code);
    }
    
    
    
    
    
    //Update Password
    public boolean updatePassword(String email, String newPassword) {
    	
    	Connection con=null;
    	PreparedStatement st=null;
    	
    	try {
    		con=DBConnection.getConnection();
    		
    		String sql="update admin set password = ? where email = ?";
    		st=con.prepareStatement(sql);
    		
    		st.setString(1, newPassword);
    		st.setString(2, email);
    		
    		int rowsUpdated=st.executeUpdate();
    		return rowsUpdated > 0;
    		
    	}catch(Exception e) {
    		System.out.println("Error updating password: "+e.getMessage());
    		e.printStackTrace();
    	}finally {
    		try {
    			if(st != null) st.close();
    			if(con != null) con.close();
    		}catch(SQLException e) {
    			e.printStackTrace();
    		}
    	}
    	
    	return false;
    }
    
    
    
    
    
    //Get admin by email
    public Admin getAdminByEmail(String email) {
        Connection con = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.getConnection();
            
            String sql = "select * from admin where email = ?";
            st = con.prepareStatement(sql);
            
            st.setString(1, email);
            rs = st.executeQuery();
            
            if(rs.next()) {
                Admin a = new Admin();
                a.setId(rs.getInt("id"));
                a.setFullname(rs.getString("fullname"));
                a.setUsername(rs.getString("username"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setPassword(rs.getString("password"));
                a.setProfilePicture(rs.getString("profile_picture"));
                
                return a;
            }
            
        } catch(Exception e) {
            System.out.println("Error in getAdminByEmail: " + e);
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(st != null) st.close();
                if(con != null) con.close();
            } catch(SQLException e) {
                e.printStackTrace();
            }
        }
        
        return null;    	
    }
    
    
    
    
    
    
    //Get user full name
    public String getUserFullName(String email) {
        String fullName = "";
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBConnection.getConnection();
            String query = "SELECT fullname FROM admin WHERE email = ?";
            preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, email);
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                fullName = resultSet.getString("fullname");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return fullName;
    }
}