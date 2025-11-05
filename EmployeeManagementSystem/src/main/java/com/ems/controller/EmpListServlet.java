package com.ems.controller;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.EmpDao;
import com.ems.model.Employee;


@WebServlet("/EmpListServlet")
public class EmpListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private EmpDao dao;
	
	public void init() {
		dao=new EmpDao();
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
            String search = request.getParameter("search");
            String department = request.getParameter("department");
            String status = request.getParameter("status");
            
			List<Employee> list;
			
            if ((search != null && !search.trim().isEmpty()) || 
                (department != null && !department.trim().isEmpty()) ||
                (status != null && !status.trim().isEmpty())) {
                
                list = dao.searchEmployees(search, department, status);
            } else {
                list = dao.getAllEmployees();
            }
            
            String successMessage = (String) request.getSession().getAttribute("message");
            String errorMessage = (String) request.getSession().getAttribute("error");
            
            if (successMessage != null) {
                request.setAttribute("message", successMessage);
                request.getSession().removeAttribute("message");
            }
            
            if (errorMessage != null) {
                request.setAttribute("error", errorMessage);
                request.getSession().removeAttribute("error");
            }
            
            request.setAttribute("list", list);
            request.setAttribute("search", search);
            request.setAttribute("department", department);
            request.setAttribute("status", status);
            
            RequestDispatcher rd = request.getRequestDispatcher("emplist.jsp");
            rd.forward(request, response);
		} catch(Exception e) {
			System.out.println(e);
			request.setAttribute("message", "Error retrieving employee list: "+e.getMessage());
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
