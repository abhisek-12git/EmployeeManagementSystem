package com.ems.model;

import java.util.*;

public class Report {
    private int totalEmployees;
    private int activeEmployees;
    private int totalDepartments;
    private double averageSalary;
    private Map<String, Integer> departmentDistribution;
    private Map<String, Integer> statusDistribution;
    private List<DepartmentStats> departmentStats;
    private List<SalaryReport> salaryReports;
    
    public int getTotalEmployees() {
        return totalEmployees;
    }
    public void setTotalEmployees(int totalEmployees) {
        this.totalEmployees = totalEmployees;
    }
    public int getActiveEmployees() {
        return activeEmployees;
    }
    public void setActiveEmployees(int activeEmployees) {
        this.activeEmployees = activeEmployees;
    }
    public int getTotalDepartments() {
        return totalDepartments;
    }
    public void setTotalDepartments(int totalDepartments) {
        this.totalDepartments = totalDepartments;
    }
    public double getAverageSalary() {
        return averageSalary;
    }
    public void setAverageSalary(double averageSalary) {
        this.averageSalary = averageSalary;
    }
    public Map<String, Integer> getDepartmentDistribution() {
        return departmentDistribution;
    }
    public void setDepartmentDistribution(Map<String, Integer> departmentDistribution) {
        this.departmentDistribution = departmentDistribution;
    }
    public Map<String, Integer> getStatusDistribution() {
        return statusDistribution;
    }
    public void setStatusDistribution(Map<String, Integer> statusDistribution) {
        this.statusDistribution = statusDistribution;
    }
    public List<DepartmentStats> getDepartmentStats() {
        return departmentStats;
    }
    public void setDepartmentStats(List<DepartmentStats> departmentStats) {
        this.departmentStats = departmentStats;
    }
    public List<SalaryReport> getSalaryReports() {
        return salaryReports;
    }
    public void setSalaryReports(List<SalaryReport> salaryReports) {
        this.salaryReports = salaryReports;
    }
}