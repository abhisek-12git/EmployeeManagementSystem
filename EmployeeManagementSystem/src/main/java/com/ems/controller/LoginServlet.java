package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.ems.dao.AdminDao;
import com.ems.model.Admin;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email =request.getParameter("email");
		String password=request.getParameter("password");
		
		AdminDao dao=new AdminDao();
		Admin a = dao.Login(email, password);
		
		HttpSession session=request.getSession();
		
		if( a != null) {
		   session.setAttribute("currentAdmin", a);
		   session.setAttribute("successMsg", "Login successful! Welcome "+a.getFullname());
		   response.sendRedirect("AdminHomeServlet");
		} else {
			session.setAttribute("errorMsg", "Invalid email or password. Please try again");
			response.sendRedirect("login.jsp");
		}
	}
}