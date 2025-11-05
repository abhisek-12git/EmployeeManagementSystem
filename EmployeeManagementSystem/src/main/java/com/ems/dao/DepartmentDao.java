package com.ems.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.ems.model.Department;
import com.ems.util.DBConnection;

public class DepartmentDao {
    
	
	//Get all departments
    public List<Department> getAllDepartments() {
        List<Department> departments = new ArrayList<>();
        
        String sql = "SELECT * FROM departments ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Department dept = new Department();
                dept.setId(rs.getInt("id"));
                dept.setName(rs.getString("name"));
                dept.setCode(rs.getString("code"));
                dept.setManager(rs.getString("manager"));
                dept.setLocation(rs.getString("location"));
                dept.setDescription(rs.getString("description"));
                dept.setEmployeeCount(0); // Temporary set to 0
                
                departments.add(dept);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            return departments;
        }
        
        for (Department dept : departments) {
            int employeeCount = getEmployeeCountByDepartmentName(dept.getName());
            dept.setEmployeeCount(employeeCount);
        }
        
        return departments;
    }
    
    
    
    
    //Get employee count for each department
    public int getEmployeeCountByDepartmentName(String departmentName) {
        String sql = "SELECT COUNT(*) as employee_count FROM employee WHERE dept = ?";
        int count = 0;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, departmentName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("employee_count");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    
    
    
    
    
    //Add new dept
    public boolean addDepartment(Department department) {
        String sql = "INSERT INTO departments (name, code, manager, location, description) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, department.getName());
            stmt.setString(2, department.getCode());
            stmt.setString(3, department.getManager());
            stmt.setString(4, department.getLocation());
            stmt.setString(5, department.getDescription());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
    
    
    
    //JUpdate dept
    public boolean updateDepartment(Department department) {
        String sql = "UPDATE departments SET name = ?, code = ?, manager = ?, location = ?, description = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, department.getName());
            stmt.setString(2, department.getCode());
            stmt.setString(3, department.getManager());
            stmt.setString(4, department.getLocation());
            stmt.setString(5, department.getDescription());
            stmt.setInt(6, department.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
    
    
    //Delete dept
    public boolean deleteDepartment(int id) {
        String sql = "DELETE FROM departments WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
    
    
    //Get dept by ID
    public Department getDepartmentById(int id) {
        String sql = "SELECT * FROM departments WHERE id = ?";
        Department department = null;
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    department = new Department();
                    department.setId(rs.getInt("id"));
                    department.setName(rs.getString("name"));
                    department.setCode(rs.getString("code"));
                    department.setManager(rs.getString("manager"));
                    department.setLocation(rs.getString("location"));
                    department.setDescription(rs.getString("description"));
                    
                    int employeeCount = getEmployeeCountByDepartmentName(department.getName());
                    department.setEmployeeCount(employeeCount);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return department;
    }
}