package com.ems.dao;

import java.sql.*;
import java.util.*;

import com.ems.model.Employee;
import com.ems.util.DBConnection;

public class EmpDao {

    // Add new emp
    public boolean add(Employee emp) {
        String sql = "INSERT INTO employee (emp_id, emp_name, emp_dob, gender, emp_email, emp_phone, address, city, state, pin, dept, desg, joindate, emp_type, shift_time, basic_salary, allowances, pf, total_salary, proof, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, emp.getEmp_id());
            stmt.setString(2, emp.getEmp_name());
            stmt.setDate(3, java.sql.Date.valueOf(emp.getEmp_dob()));
            stmt.setString(4, emp.getGender());
            stmt.setString(5, emp.getEmp_email());
            stmt.setString(6, emp.getEmp_phone());
            stmt.setString(7, emp.getAddress());
            stmt.setString(8, emp.getCity());
            stmt.setString(9, emp.getState());
            stmt.setString(10, emp.getPin());
            stmt.setString(11, emp.getDept());
            stmt.setString(12, emp.getDesg());
            stmt.setDate(13, java.sql.Date.valueOf(emp.getJoindate()));
            stmt.setString(14, emp.getEmp_type());
            stmt.setString(15, emp.getShift_time());
            stmt.setBigDecimal(16, emp.getBasic_salary());
            stmt.setBigDecimal(17, emp.getAllowances());
            stmt.setBigDecimal(18, emp.getPf());
            stmt.setBigDecimal(19, emp.getTotal_salary());
            stmt.setString(20, emp.getProof());
            stmt.setString(21, "active");
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
    // View all employee
    public List<Employee> getAllEmployees(){
        List<Employee> employeeList = new ArrayList<>();
        
        try {
            Connection con=DBConnection.getConnection();
            String sql="select * from employee";
            
            PreparedStatement st=con.prepareStatement(sql);
            ResultSet rs=st.executeQuery();
            
            while(rs.next()) {
                Employee e=new Employee();
                
                e.setEmp_id(rs.getString("emp_id"));
                e.setEmp_name(rs.getString("emp_name"));
                e.setEmp_dob(rs.getDate("emp_dob").toLocalDate());
                e.setGender(rs.getString("gender"));
                e.setEmp_email(rs.getString("emp_email"));
                e.setEmp_phone(rs.getString("emp_phone"));
                e.setAddress(rs.getString("address"));
                e.setCity(rs.getString("city"));
                e.setState(rs.getString("state"));
                e.setPin(rs.getString("pin"));
                e.setDept(rs.getString("dept"));
                e.setDesg(rs.getString("desg"));
                e.setJoindate(rs.getDate("joindate").toLocalDate());
                e.setEmp_type(rs.getString("emp_type"));
                e.setShift_time(rs.getString("shift_time"));
                e.setBasic_salary(rs.getBigDecimal("basic_salary"));
                e.setAllowances(rs.getBigDecimal("allowances"));
                e.setPf(rs.getBigDecimal("pf"));
                e.setTotal_salary(rs.getBigDecimal("total_salary"));
                e.setProof(rs.getString("proof"));
                e.setStatus(rs.getString("status"));
                
                employeeList.add(e);
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }
        
        return employeeList;
    }
    
    
    
    // Update existing employee
    public boolean update(Employee e) {
        boolean success =false;
        
        try {
            Connection con=DBConnection.getConnection();
            
            String sql="update employee set "
                        +"emp_name=?, emp_dob=?, gender=?, "
                        +"emp_email=?, emp_phone=?, address=?, city=?, state=?, pin=?, "
                        +"dept=?, desg=?, joindate=?, emp_type=?, shift_time=?, "
                        +"basic_salary=?, allowances=?, pf=?, total_salary=?, "
                        +"proof=?, status=? "
                        +"where emp_id=?";
            
            PreparedStatement st=con.prepareStatement(sql);
            
            st.setString(1, e.getEmp_name());
            st.setDate(2, java.sql.Date.valueOf(e.getEmp_dob()));
            st.setString(3, e.getGender());
            st.setString(4, e.getEmp_email());
            st.setString(5, e.getEmp_phone());
            st.setString(6, e.getAddress());
            st.setString(7, e.getCity());
            st.setString(8, e.getState());
            st.setString(9, e.getPin());
            st.setString(10, e.getDept());
            st.setString(11, e.getDesg());
            st.setDate(12, java.sql.Date.valueOf(e.getJoindate()));
            st.setString(13, e.getEmp_type());
            st.setString(14, e.getShift_time());
            st.setBigDecimal(15, e.getBasic_salary());
            st.setBigDecimal(16, e.getAllowances());
            st.setBigDecimal(17, e.getPf());
            st.setBigDecimal(18, e.getTotal_salary());
            st.setString(19, e.getProof());
            st.setString(20, e.getStatus() != null ? e.getStatus() : "active");
            st.setString(21, e.getEmp_id());

            int rowsAffected = st.executeUpdate();
            if(rowsAffected > 0) {
                success = true;
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }
    
        return success;
    }
    
    
    
    // Update employee status only
    public boolean updateStatus(String empId, String status) {
        boolean success = false;
        
        try {
            Connection con = DBConnection.getConnection();
            String sql = "update employee set status = ? where emp_id = ?";
            
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, status);
            st.setString(2, empId);
            
            int rowsAffected = st.executeUpdate();
            if(rowsAffected > 0) {
                success = true;
            }
        } catch(Exception ex) {
            ex.printStackTrace();
        }
        
        return success;
    }
    
    
    
    // Delete existing employee
    public boolean delete(String empId) {
        boolean success=false;
        
        try {
            Connection con=DBConnection.getConnection();
            String sql="delete from employee where emp_id=?";
            PreparedStatement st=con.prepareStatement(sql);
            st.setString(1, empId);
            int rowsAffected=st.executeUpdate();
            if(rowsAffected > 0) {
                success=true;
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }
        
        return success;
    }
    
    
    
    // Check if emp ID exists
    public boolean isIdExists(String empId) {
        boolean exists=false;
        try {
            Connection con = DBConnection.getConnection();
            String sql="select emp_id from employee where emp_id=?";
            PreparedStatement st=con.prepareStatement(sql);
            st.setString(1, empId);
            ResultSet rs=st.executeQuery();
            exists =rs.next();
        }catch(SQLException ex) {
            ex.printStackTrace();
        }
        return exists;
    }
    
    
    
    // Get employee by ID
    public Employee getEmployeeById(String empId) {
        Employee e=null;
        try {
            Connection con = DBConnection.getConnection();
            String sql="select * from employee where emp_id=?";
            PreparedStatement st=con.prepareStatement(sql);
            st.setString(1, empId);
            ResultSet rs=st.executeQuery();
            if(rs.next()) {
                e = new Employee();
                e.setEmp_id(rs.getString("emp_id"));
                e.setEmp_name(rs.getString("emp_name"));
                e.setEmp_dob(rs.getDate("emp_dob").toLocalDate());
                e.setGender(rs.getString("gender"));
                e.setEmp_email(rs.getString("emp_email"));
                e.setEmp_phone(rs.getString("emp_phone"));
                e.setAddress(rs.getString("address"));
                e.setCity(rs.getString("city"));
                e.setState(rs.getString("state"));
                e.setPin(rs.getString("pin"));
                e.setDept(rs.getString("dept"));
                e.setDesg(rs.getString("desg"));
                e.setJoindate(rs.getDate("joindate").toLocalDate());
                e.setEmp_type(rs.getString("emp_type"));
                e.setShift_time(rs.getString("shift_time"));
                e.setBasic_salary(rs.getBigDecimal("basic_salary"));
                e.setAllowances(rs.getBigDecimal("allowances"));
                e.setPf(rs.getBigDecimal("pf"));
                e.setTotal_salary(rs.getBigDecimal("total_salary"));
                e.setProof(rs.getString("proof"));
                e.setStatus(rs.getString("status"));
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }
        return e;
    }
    
    
    
    // Search employee to see easily
    public List<Employee> searchEmployees(String search, String department, String status){
        List<Employee> employeeList = new ArrayList<>();
        
        try {
            Connection con = DBConnection.getConnection();
            StringBuilder sql= new StringBuilder("select * from employee where 1=1");
            List<Object> parameters = new ArrayList<>();
            
            if(search != null && !search.trim().isEmpty()) {
                sql.append(" AND(emp_name LIKE ? OR emp_email LIKE ? OR emp_id LIKE ?)");
                String searchPattern ="%" +search+ "%";
                parameters.add(searchPattern);
                parameters.add(searchPattern);
                parameters.add(searchPattern);
            }
            
            if(department != null && !department.trim().isEmpty()) {
                sql.append(" AND dept = ?");
                parameters.add(department);
            }
            
            if(status != null && !status.trim().isEmpty()) {
                sql.append(" AND status = ?");
                parameters.add(status);
            }
            
            sql.append(" ORDER BY emp_name");
            PreparedStatement st=con.prepareStatement(sql.toString());
            
            for(int i = 0; i<parameters.size(); i++) {
                st.setObject(i + 1, parameters.get(i));
            }
            
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                Employee e = new Employee();
                e.setEmp_id(rs.getString("emp_id"));
                e.setEmp_name(rs.getString("emp_name"));
                e.setEmp_dob(rs.getDate("emp_dob").toLocalDate());
                e.setGender(rs.getString("gender"));
                e.setEmp_email(rs.getString("emp_email"));
                e.setEmp_phone(rs.getString("emp_phone"));
                e.setAddress(rs.getString("address"));
                e.setCity(rs.getString("city"));
                e.setState(rs.getString("state"));
                e.setPin(rs.getString("pin"));
                e.setDept(rs.getString("dept"));
                e.setDesg(rs.getString("desg"));
                e.setJoindate(rs.getDate("joindate").toLocalDate());
                e.setEmp_type(rs.getString("emp_type"));
                e.setShift_time(rs.getString("shift_time"));
                e.setBasic_salary(rs.getBigDecimal("basic_salary"));
                e.setAllowances(rs.getBigDecimal("allowances"));
                e.setPf(rs.getBigDecimal("pf"));
                e.setTotal_salary(rs.getBigDecimal("total_salary"));
                e.setProof(rs.getString("proof"));
                e.setStatus(rs.getString("status"));
                employeeList.add(e);
            }
        }catch(Exception ex) {
            ex.printStackTrace();
        }
        return employeeList;
    }
}