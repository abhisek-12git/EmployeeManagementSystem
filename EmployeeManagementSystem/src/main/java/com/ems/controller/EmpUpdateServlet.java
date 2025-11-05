package com.ems.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.ems.dao.DepartmentDao;
import com.ems.dao.EmpDao;
import com.ems.model.Department;
import com.ems.model.Employee;

@WebServlet("/EmpUpdateServlet")
public class EmpUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    private EmpDao dao;
    private DepartmentDao departmentDao;
    
    public void init() {
        dao = new EmpDao();
        departmentDao = new DepartmentDao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String empId = request.getParameter("emp_id");
        
        if(empId == null || empId.trim().isEmpty()) {
            request.getSession().setAttribute("error", "Error: Missing Employee ID for updating");
            response.sendRedirect("EmpListServlet");
            return;
        }
        
        try {
            Employee existingEmployee = dao.getEmployeeById(empId);
            
            if(existingEmployee != null) {
                List<Department> departments = departmentDao.getAllDepartments();
                
                request.setAttribute("employee", existingEmployee);
                request.setAttribute("departments", departments); // Add departments to request
                RequestDispatcher rd = request.getRequestDispatcher("updateemp.jsp");
                rd.forward(request, response);
            } else {
                request.getSession().setAttribute("error", "Error: Employee ID "+empId+ " not found.");
                response.sendRedirect("EmpListServlet");
            }
        } catch(Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Database error fetching employee details for editing.");
            response.sendRedirect("EmpListServlet");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        if (!ServletFileUpload.isMultipartContent(request)) {
            request.getSession().setAttribute("error", "Error: Form must be multipart for file upload.");
            response.sendRedirect("EmpListServlet");
            return;
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        Employee updateEmployee = new Employee();
        String empId = null;
        String empName = null;

        try {
            List<FileItem> items = upload.parseRequest(request);
                        
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("UTF-8");
                    
                    switch (fieldName) {
                        case "emp_id":
                            empId = fieldValue;
                            updateEmployee.setEmp_id(fieldValue);
                            break;
                        case "emp_name":
                            empName = fieldValue;
                            updateEmployee.setEmp_name(fieldValue);
                            break;
                        case "gender":
                            updateEmployee.setGender(fieldValue);
                            break;
                        case "emp_email":
                            updateEmployee.setEmp_email(fieldValue);
                            break;
                        case "emp_phone":
                            updateEmployee.setEmp_phone(fieldValue);
                            break;
                        case "address":
                            updateEmployee.setAddress(fieldValue);
                            break;
                        case "city":
                            updateEmployee.setCity(fieldValue);
                            break;
                        case "state":
                            updateEmployee.setState(fieldValue);
                            break;
                        case "pin":
                            updateEmployee.setPin(fieldValue);
                            break;
                        case "dept":
                            updateEmployee.setDept(fieldValue);
                            break;
                        case "desg":
                            updateEmployee.setDesg(fieldValue);
                            break;
                        case "emp_type":
                            updateEmployee.setEmp_type(fieldValue);
                            break;
                        case "shift_time":
                            updateEmployee.setShift_time(fieldValue);
                            break;
                        case "proof":
                            updateEmployee.setProof(fieldValue);
                            break;
                        case "status":
                            updateEmployee.setStatus(fieldValue);
                            break;
                        case "emp_dob":
                            if(fieldValue != null && !fieldValue.trim().isEmpty()) {
                                updateEmployee.setEmp_dob(LocalDate.parse(fieldValue));
                            }
                            break;
                        case "joindate":
                            if(fieldValue != null && !fieldValue.trim().isEmpty()) {
                                updateEmployee.setJoindate(LocalDate.parse(fieldValue));
                            }
                            break;
                        case "basic_salary":
                            if(fieldValue != null && !fieldValue.trim().isEmpty()) {
                                updateEmployee.setBasic_salary(new BigDecimal(fieldValue));
                            }
                            break;
                        case "allowances":
                            if(fieldValue != null && !fieldValue.trim().isEmpty()) {
                                updateEmployee.setAllowances(new BigDecimal(fieldValue));
                            }
                            break;
                        case "pf":
                            if(fieldValue != null && !fieldValue.trim().isEmpty()) {
                                updateEmployee.setPf(new BigDecimal(fieldValue));
                            }
                            break;
                        case "total_salary":
                            if(fieldValue != null && !fieldValue.trim().isEmpty()) {
                                updateEmployee.setTotal_salary(new BigDecimal(fieldValue));
                            }
                            break;
                    }
                }
            }
            
            if (empName == null && empId != null) {
                Employee existingEmployee = dao.getEmployeeById(empId);
                if (existingEmployee != null) {
                    empName = existingEmployee.getEmp_name();
                }
            }
            
            if(empId == null || empId.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Error: Cannot update. Employee ID is missing.");
                response.sendRedirect("EmpListServlet");
                return;
            }
            
            if (updateEmployee.getStatus() == null) {
                Employee existingEmployee = dao.getEmployeeById(empId);
                if (existingEmployee != null) {
                    updateEmployee.setStatus(existingEmployee.getStatus());
                } else {
                    updateEmployee.setStatus("active");
                }
            }
            
            if (updateEmployee.getTotal_salary() == null) {
                BigDecimal basic = updateEmployee.getBasic_salary() != null ? updateEmployee.getBasic_salary() : BigDecimal.ZERO;
                BigDecimal allowances = updateEmployee.getAllowances() != null ? updateEmployee.getAllowances() : BigDecimal.ZERO;
                BigDecimal pf = updateEmployee.getPf() != null ? updateEmployee.getPf() : BigDecimal.ZERO;
                BigDecimal total = basic.add(allowances).subtract(pf);
                updateEmployee.setTotal_salary(total);
            }
            
        } catch(DateTimeParseException e) {
            request.setAttribute("error", "Error: Date fields must be in yyyy-MM-dd format.");
            if (empId != null) {
                Employee originalEmployee = dao.getEmployeeById(empId);
                request.setAttribute("employee", originalEmployee); 
            }
            request.getRequestDispatcher("updateemp.jsp").forward(request, response);
            return;
        } catch(NumberFormatException e) {
            request.setAttribute("error", "Error: Salary fields must be valid numbers.");
            if (empId != null) {
                Employee originalEmployee = dao.getEmployeeById(empId);
                request.setAttribute("employee", originalEmployee); 
            }
            request.getRequestDispatcher("updateemp.jsp").forward(request, response);
            return;
        } catch(Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: Invalid input data.");
            if (empId != null) {
                Employee originalEmployee = dao.getEmployeeById(empId);
                request.setAttribute("employee", originalEmployee); 
            }
            request.getRequestDispatcher("updateemp.jsp").forward(request, response);
            return;
        }
        
        boolean isUpdated = dao.update(updateEmployee);
        
        if(isUpdated) {
            try {
                com.ems.model.Admin currentAdmin = (com.ems.model.Admin) request.getSession().getAttribute("currentAdmin");
                String adminUsername = (currentAdmin != null) ? currentAdmin.getUsername() : "system";
                String adminFullname = (currentAdmin != null) ? currentAdmin.getFullname() : "System Administrator";
                
                com.ems.service.ActivityLogService activityService = new com.ems.service.ActivityLogService();
                activityService.logActivity("update", "Employee profile updated", adminUsername, adminFullname, empName);
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getSession().setAttribute("message", "Employee "+ empId + " updated successfully!");
        } else {
            request.getSession().setAttribute("error", "Failed to update Employee "+ empId +". Database error occurred.");
        }
        
        response.sendRedirect("EmpListServlet");
    }
}