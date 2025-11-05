package com.ems.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.ems.dao.DepartmentDao;
import com.ems.model.Department;

@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DepartmentDao departmentDao;

    public void init() {
        departmentDao = new DepartmentDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Department> departments = departmentDao.getAllDepartments();
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("departments.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error loading departments: " + e.getMessage());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("departments.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        try {
            switch (action) {
                case "add":
                    addDepartment(request, response);
                    break;
                case "update":
                    updateDepartment(request, response);
                    break;
                case "delete":
                    deleteDepartment(request, response);
                    break;
                default:
                    response.sendRedirect("DepartmentServlet");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Operation failed: " + e.getMessage());
            request.setAttribute("messageType", "error");
            doGet(request, response);
        }
    }

    private void addDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String code = request.getParameter("code");
        String manager = request.getParameter("manager");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        
        Department department = new Department();
        department.setName(name);
        department.setCode(code);
        department.setManager(manager);
        department.setLocation(location);
        department.setDescription(description);
        
        boolean success = departmentDao.addDepartment(department);
        
        if (success) {
            request.setAttribute("message", "Department added successfully!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Failed to add department. Department code might already exist.");
            request.setAttribute("messageType", "error");
        }
        
        doGet(request, response);
    }

    private void updateDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String code = request.getParameter("code");
        String manager = request.getParameter("manager");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        
        Department department = new Department();
        department.setId(id);
        department.setName(name);
        department.setCode(code);
        department.setManager(manager);
        department.setLocation(location);
        department.setDescription(description);
        
        boolean success = departmentDao.updateDepartment(department);
        
        if (success) {
            request.setAttribute("message", "Department updated successfully!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Failed to update department.");
            request.setAttribute("messageType", "error");
        }
        
        doGet(request, response);
    }

    private void deleteDepartment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = departmentDao.deleteDepartment(id);
        
        if (success) {
            request.setAttribute("message", "Department deleted successfully!");
            request.setAttribute("messageType", "success");
        } else {
            request.setAttribute("message", "Failed to delete department. It might have employees assigned.");
            request.setAttribute("messageType", "error");
        }
        
        doGet(request, response);
    }
}