package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.EmpDao;

@WebServlet("/EmpStatusServlet")
public class EmpStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private EmpDao dao;
	
	public void init() {
		dao=new EmpDao();
	}
     
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String empId = request.getParameter("emp_id");
		String status = request.getParameter("status");
		
		if(empId != null && status != null && (status.equals("active") || status.equals("inactive"))) {
			boolean success = dao.updateStatus(empId, status);
			
			if(success) {
				try {
                    com.ems.model.Admin currentAdmin = (com.ems.model.Admin) request.getSession().getAttribute("currentAdmin");
                    String adminUsername = (currentAdmin != null) ? currentAdmin.getUsername() : "system";
                    String adminFullname = (currentAdmin != null) ? currentAdmin.getFullname() : "System Administrator";
                    
                    com.ems.model.Employee employee = dao.getEmployeeById(empId);
                    String empName = (employee != null) ? employee.getEmp_name() : empId;
                    
                    com.ems.service.ActivityLogService activityService = new com.ems.service.ActivityLogService();
                    String action = status.equals("active") ? "activated" : "deactivated";
                    activityService.logActivity("status_update", 
                        "Employee '" + empName + "' " + action, 
                        adminUsername, adminFullname, empName);
                    
                } catch (Exception e) {
                    e.printStackTrace();
                }
				request.getSession().setAttribute("message", "Employee status updated successfully!");
			}else {
				request.getSession().setAttribute("error", "Failed to update employee status");
			}
		}else {
			request.getSession().setAttribute("error", "Missing parameters for status update.");
		}
		
		response.sendRedirect("EmpListServlet");
	}

}
