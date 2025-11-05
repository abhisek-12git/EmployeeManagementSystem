package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ems.model.Admin;
import com.ems.model.Report;
import com.ems.service.ReportService;

@WebServlet("/ReportsServlet")
public class ReportsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReportService reportService;
    
    public void init() {
        reportService = new ReportService();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
        
        if (currentAdmin == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            Report reportData = reportService.getDashboardReports();
            
            request.setAttribute("reportData", reportData);
            request.setAttribute("departmentDistribution", reportData.getDepartmentDistribution());
            request.setAttribute("statusDistribution", reportData.getStatusDistribution());
            request.setAttribute("departmentStats", reportData.getDepartmentStats());
            request.setAttribute("salaryReports", reportData.getSalaryReports());
            
            request.getRequestDispatcher("reports.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error generating reports: " + e.getMessage());
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}