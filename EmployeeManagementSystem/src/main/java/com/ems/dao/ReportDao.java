package com.ems.dao;

import java.sql.*;
import java.util.*;
import com.ems.model.*;
import com.ems.util.DBConnection;

public class ReportDao {
    
    public Report getDashboardReports() {
        Report reportData = new Report();
        
        try {
            reportData.setTotalEmployees(getTotalEmployeesCount());
            reportData.setActiveEmployees(getActiveEmployeesCount());
            reportData.setTotalDepartments(getTotalDepartmentsCount());
            reportData.setAverageSalary(getAverageSalary());
            
            reportData.setDepartmentDistribution(getDepartmentDistribution());
            reportData.setStatusDistribution(getStatusDistribution());
            
            reportData.setDepartmentStats(getDepartmentStats());
            reportData.setSalaryReports(getSalaryReports());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return reportData;
    }
    
    private int getTotalEmployeesCount() {
        String sql = "SELECT COUNT(*) FROM employee";
        return getCount(sql);
    }
    
    private int getActiveEmployeesCount() {
        String sql = "SELECT COUNT(*) FROM employee";
        return getCount(sql);
    }
    
    private int getTotalDepartmentsCount() {
        String sql = "SELECT COUNT(*) FROM departments";
        return getCount(sql);
    }
    
    private double getAverageSalary() {
        String sql = "SELECT AVG(total_salary) FROM employee WHERE total_salary > 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    private Map<String, Integer> getDepartmentDistribution() {
        Map<String, Integer> distribution = new HashMap<>();
        
        String deptSql = "SELECT name FROM departments WHERE name IS NOT NULL AND name != ''";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(deptSql);
             ResultSet rs = stmt.executeQuery()) {
                        
            while (rs.next()) {
                String deptName = rs.getString("name");
                if (deptName != null && !deptName.trim().isEmpty()) {
                    distribution.put(deptName.trim(), 0);
                }
            }
            
            String countSql = "SELECT dept, COUNT(*) as count FROM employee WHERE dept IS NOT NULL GROUP BY dept";
            try (PreparedStatement countStmt = conn.prepareStatement(countSql);
                 ResultSet countRs = countStmt.executeQuery()) {
                
                while (countRs.next()) {
                    String dept = countRs.getString("dept");
                    int count = countRs.getInt("count");
                    if (dept != null && !dept.trim().isEmpty()) {
                        distribution.put(dept.trim(), count);
                    }
                }
            }
            
            if (distribution.isEmpty()) {
                distribution.put("Information Technology", 0);
                distribution.put("Human Resources", 0);
                distribution.put("Finance", 0);
            }
                        
        } catch (SQLException e) {
            distribution.put("Information Technology", 0);
            distribution.put("Human Resources", 0);
            distribution.put("Finance", 0);
            distribution.put("Marketing", 0);
            distribution.put("Sales", 0);
        }
        return distribution;
    }

    private Map<String, Integer> getStatusDistribution() {
        Map<String, Integer> distribution = new HashMap<>();
        
        String[] employeeTypes = {"Full-Time", "Part-Time", "Contract", "Intern"};
        
        for (String type : employeeTypes) {
            distribution.put(type, 0);
        }
        
        String sql = "SELECT emp_type, COUNT(*) as count FROM employee WHERE emp_type IS NOT NULL GROUP BY emp_type";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                String empType = rs.getString("emp_type");
                int count = rs.getInt("count");
                if (empType != null && !empType.trim().isEmpty()) {
                    String trimmedType = empType.trim();
                    if (distribution.containsKey(trimmedType)) {
                        distribution.put(trimmedType, count);
                    }
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return distribution;
    }
    
    private List<DepartmentStats> getDepartmentStats() {
        List<DepartmentStats> stats = new ArrayList<>();
        String sql = "SELECT d.name as dept_name, " +
                     "COUNT(e.emp_id) as emp_count, " +
                     "AVG(e.total_salary) as avg_salary " +
                     "FROM departments d " +
                     "LEFT JOIN employee e ON d.name = e.dept " +
                     "GROUP BY d.name, d.id " +
                     "ORDER BY emp_count DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                DepartmentStats deptStat = new DepartmentStats();
                deptStat.setDepartmentName(rs.getString("dept_name"));
                deptStat.setEmployeeCount(rs.getInt("emp_count"));
                deptStat.setAverageSalary(rs.getDouble("avg_salary"));
                stats.add(deptStat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
    
    private List<SalaryReport> getSalaryReports() {
        List<SalaryReport> reports = new ArrayList<>();
        String sql = "SELECT emp_id, emp_name, dept, desg, basic_salary, allowances, pf, total_salary, emp_type " +
                     "FROM employee ORDER BY dept, total_salary DESC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                SalaryReport report = new SalaryReport();
                report.setEmpId(rs.getString("emp_id"));
                report.setEmpName(rs.getString("emp_name"));
                report.setDepartment(rs.getString("dept"));
                report.setDesignation(rs.getString("desg"));
                report.setBasicSalary(rs.getDouble("basic_salary"));
                report.setAllowances(rs.getDouble("allowances"));
                report.setPf(rs.getDouble("pf"));
                report.setTotalSalary(rs.getDouble("total_salary"));
                report.setEmpType(rs.getString("emp_type"));
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }
    
    private int getCount(String sql) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}