package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.EmpDao;
import com.ems.service.ActivityLogService;

@WebServlet("/EmpDeleteServlet")
public class EmpDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    private EmpDao dao;
    
    public void init() {
        dao = new EmpDao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String empId = request.getParameter("emp_id");
        
        if(empId == null || empId.trim().isEmpty()) {
            request.getSession().setAttribute("message", "Error: Missing Employee ID for deletion.");
            response.sendRedirect("EmpListServlet");
            return;
        }
        
        String employeeName = "Unknown Employee";
        String employeeDept = "Unknown Department";
        try {
            com.ems.model.Employee employee = dao.getEmployeeById(empId);
            if(employee != null) {
                employeeName = employee.getEmp_name();
                employeeDept = employee.getDept();
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        boolean isDeleted = false;
        try {
            isDeleted = dao.delete(empId);
        } catch(Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Database error during deletion of Employee ID: " + empId);
            response.sendRedirect("EmpListServlet");
            return;
        }
        
        if(isDeleted) {
            try {
                com.ems.model.Admin currentAdmin = (com.ems.model.Admin) request.getSession().getAttribute("currentAdmin");
                String adminUsername = (currentAdmin != null) ? currentAdmin.getUsername() : "system";
                String adminFullname = (currentAdmin != null) ? currentAdmin.getFullname() : "System Administrator";
                
                ActivityLogService activityService = new ActivityLogService();
                activityService.logActivity("delete", 
                    "Employee '" + employeeName + "' removed from " + employeeDept + " department", 
                    adminUsername, adminFullname, employeeName);
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getSession().setAttribute("message", "Employee ID " + empId + " deleted successfully!");
        } else {
            request.getSession().setAttribute("message", "Failed to delete Employee ID " + empId + ". Record may not exist.");
        }
        
        response.sendRedirect("EmpListServlet");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}