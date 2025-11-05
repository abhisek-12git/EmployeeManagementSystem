package com.ems.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;

public class Employee {

//	Personal details
	private String emp_id;
	private String emp_name;
	private LocalDate emp_dob;
	private String gender;

//	Contact Details
	private String emp_email;
	private String emp_phone;
	private String address;
	private String city;
	private String state;
	private String pin;

//	Job Details
	private String dept;
	private String desg;
	private LocalDate joindate ;
	private String emp_type;
	private String shift_time;

//	Salary Details
	private BigDecimal  basic_salary;
	private BigDecimal  allowances;
	private BigDecimal  pf;
	private BigDecimal  total_salary;
    
//	Documents proof
	private String proof;
	
//  Status
	private String status;

	public Employee() {
	
	}

	public Employee(String emp_id, String emp_name, LocalDate emp_dob, String gender,
			String emp_email, String emp_phone, String address, String city, String state, String pin, String dept,
			String desg, LocalDate joindate, String emp_type, String shift_time, BigDecimal basic_salary,
			BigDecimal allowances, BigDecimal pf, BigDecimal total_salary, String proof, String status) {
		this.emp_id = emp_id;
		this.emp_name = emp_name;
		this.emp_dob = emp_dob;
		this.gender = gender;
		this.emp_email = emp_email;
		this.emp_phone = emp_phone;
		this.address = address;
		this.city = city;
		this.state = state;
		this.pin = pin;
		this.dept = dept;
		this.desg = desg;
		this.joindate = joindate;
		this.emp_type = emp_type;
		this.shift_time = shift_time;
		this.basic_salary = basic_salary;
		this.allowances = allowances;
		this.pf = pf;
		this.total_salary = total_salary;
		this.proof = proof;
		this.status = status;
	}

	public String getEmp_id() {
		return emp_id;
	}

	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public LocalDate getEmp_dob() {
		return emp_dob;
	}

	public void setEmp_dob(LocalDate emp_dob) {
		this.emp_dob = emp_dob;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmp_email() {
		return emp_email;
	}

	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}

	public String getEmp_phone() {
		return emp_phone;
	}

	public void setEmp_phone(String emp_phone) {
		this.emp_phone = emp_phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPin() {
		return pin;
	}

	public void setPin(String pin) {
		this.pin = pin;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getDesg() {
		return desg;
	}

	public void setDesg(String desg) {
		this.desg = desg;
	}

	public LocalDate getJoindate() {
		return joindate;
	}

	public void setJoindate(LocalDate joindate) {
		this.joindate = joindate;
	}

	public String getEmp_type() {
		return emp_type;
	}

	public void setEmp_type(String emp_type) {
		this.emp_type = emp_type;
	}

	public String getShift_time() {
		return shift_time;
	}

	public void setShift_time(String shift_time) {
		this.shift_time = shift_time;
	}

	public BigDecimal getBasic_salary() {
		return basic_salary;
	}

	public void setBasic_salary(BigDecimal basic_salary) {
		this.basic_salary = basic_salary;
	}

	public BigDecimal getAllowances() {
		return allowances;
	}

	public void setAllowances(BigDecimal allowances) {
		this.allowances = allowances;
	}

	public BigDecimal getPf() {
		return pf;
	}

	public void setPf(BigDecimal pf) {
		this.pf = pf;
	}

	public BigDecimal getTotal_salary() {
		return total_salary;
	}

	public void setTotal_salary(BigDecimal total_salary) {
		this.total_salary = total_salary;
	}

	public String getProof() {
		return proof;
	}

	public void setProof(String proof) {
		this.proof = proof;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String toString() {
		return "Employee [emp_id=" + emp_id + ", emp_name=" + emp_name + ", emp_dob=" + emp_dob + ", gender=" + gender
				+ ", emp_email=" + emp_email + ", emp_phone=" + emp_phone + ", address=" + address + ", city=" + city
				+ ", state=" + state + ", pin=" + pin + ", dept=" + dept + ", desg=" + desg + ", joindate=" + joindate
				+ ", emp_type=" + emp_type + ", shift_time=" + shift_time + ", basic_salary=" + basic_salary
				+ ", allowances=" + allowances + ", pf=" + pf + ", total_salary=" + total_salary + ", proof=" + proof
				+ ", status=" + status + "]";
	}

	
}
