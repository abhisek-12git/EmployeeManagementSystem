package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

import com.ems.dao.EmpDao;
import com.ems.model.Employee;

@WebServlet("/ViewEmpServlet")
public class ViewEmpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmpDao empDao;

    public void init() {
        empDao = new EmpDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String empId = request.getParameter("emp_id");
        
        if (empId != null && !empId.trim().isEmpty()) {
            try {
                Employee employee = empDao.getEmployeeById(empId);
                
                if (employee != null) {
                    request.setAttribute("employee", employee);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("viewemp.jsp");
                    dispatcher.forward(request, response);
                } else {
                    request.setAttribute("error", "Employee not found with ID: " + empId);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("emplist.jsp");
                    dispatcher.forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error retrieving employee details: " + e.getMessage());
                RequestDispatcher dispatcher = request.getRequestDispatcher("emplist.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            response.sendRedirect("EmpListServlet");
        }
    }
}