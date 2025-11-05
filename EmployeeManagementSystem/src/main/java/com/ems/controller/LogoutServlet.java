package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	       
		try {
			HttpSession session=request.getSession(false);
			
			if(session != null) {
				session.invalidate();
				
				HttpSession newSession=request.getSession();
				newSession.setAttribute("successMsg", "Logout successful! You have been securely signed out.");
			}
			
			response.sendRedirect("login.jsp");
		} catch(Exception e) {
			System.out.println("Error during logout: "+e.getMessage());
			response.sendRedirect("login.jsp");
		}
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
