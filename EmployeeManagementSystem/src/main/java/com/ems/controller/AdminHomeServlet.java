package com.ems.controller;

import java.io.IOException;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.ems.model.ActivityLog;
import com.ems.model.Admin;
import com.ems.service.ActivityLogService;
import com.ems.service.StatsService;

@WebServlet("/AdminHomeServlet")
public class AdminHomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
     
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Admin currentAdmin = (Admin) request.getSession().getAttribute("currentAdmin");
            
            if (currentAdmin == null) {
                response.sendRedirect("index.jsp");
                return;
            }
            
            ActivityLogService activityService = new ActivityLogService();
            StatsService statsService = new StatsService();
            
            activityService.ensureActivitiesExist(currentAdmin.getUsername(), currentAdmin.getFullname());
            
            List<ActivityLog> recentActivities = activityService.getAllRecentActivities(5);
            
            int totalActivities = activityService.getTotalActivityCount();
            int totalEmployees = statsService.getTotalEmployeesCount();
            int totalDepartments = statsService.getTotalDepartmentsCount();
            
            request.setAttribute("recentActivities", recentActivities);
            request.setAttribute("totalActivities", totalActivities);
            request.setAttribute("totalEmployees", totalEmployees);
            request.setAttribute("totalDepartments", totalDepartments);
            
            request.getRequestDispatcher("adminhome.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("recentActivities", new ArrayList<ActivityLog>());
            request.setAttribute("totalActivities", 0);
            request.setAttribute("totalEmployees", 0);
            request.setAttribute("totalDepartments", 0);
            request.getRequestDispatcher("adminhome.jsp").forward(request, response);
        }
    }
}