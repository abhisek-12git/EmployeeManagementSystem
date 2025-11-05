package com.ems.model;

public class DepartmentStats {

	private String departmentName;
	private int employeeCount;
	private double averageSalary;
	private double averageAttendance;
	private double averagePerformance;
	
	public DepartmentStats() {
	}

	public DepartmentStats(String departmentName, int employeeCount, double averageSalary, double averageAttendance,
			double averagePerformance) {
		super();
		this.departmentName = departmentName;
		this.employeeCount = employeeCount;
		this.averageSalary = averageSalary;
		this.averageAttendance = averageAttendance;
		this.averagePerformance = averagePerformance;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public int getEmployeeCount() {
		return employeeCount;
	}

	public void setEmployeeCount(int employeeCount) {
		this.employeeCount = employeeCount;
	}

	public double getAverageSalary() {
		return averageSalary;
	}

	public void setAverageSalary(double averageSalary) {
		this.averageSalary = averageSalary;
	}

	public double getAverageAttendance() {
		return averageAttendance;
	}

	public void setAverageAttendance(double averageAttendance) {
		this.averageAttendance = averageAttendance;
	}

	public double getAveragePerformance() {
		return averagePerformance;
	}

	public void setAveragePerformance(double averagePerformance) {
		this.averagePerformance = averagePerformance;
	}
	
	
	
}
