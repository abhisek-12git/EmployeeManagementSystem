package com.ems.controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.AdminDao;
import com.ems.model.Admin;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;	
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullname");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
    
        if (fullname == null || fullname.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            request.getSession().setAttribute("error", "All fields are required.");
            response.sendRedirect("registration.jsp");
            return;
        }
    
        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            request.getSession().setAttribute("error", "Password do not match.");
            response.sendRedirect("registration.jsp");
            return;
        }
        
        if (password.length() < 8) {
            request.getSession().setAttribute("error", "Password must be at least 8 characters long.");
            response.sendRedirect("registration.jsp");
            return;
        }
        
        if (!isValidUsername(username)) {
            request.getSession().setAttribute("error", "Username must contain alphabetics, digits, and special characters.");
            response.sendRedirect("registration.jsp");
            return;
        }
        
        if (!isValidPhone(phone)) {
            request.getSession().setAttribute("error", "Please enter a valid 10-digit phone number starting with 6-9.");
            response.sendRedirect("registration.jsp");
            return;
        }
        
        if (!isValidEmail(email)) {
            request.getSession().setAttribute("error", "Please enter a valid email address.");
            response.sendRedirect("registration.jsp");
            return;
        }
        
        AdminDao dao = new AdminDao();
        
        if (dao.isUsernameExists(username)) {
            request.getSession().setAttribute("error", "Username already registered! Please choose a different username.");
            response.sendRedirect("registration.jsp");
            return;
        }
        
        if (dao.isEmailExists(email)) {
            request.getSession().setAttribute("error", "Email already registered! Please use a different email address.");
            response.sendRedirect("registration.jsp");
            return;
        }
        
        Admin admin = new Admin();
        admin.setFullname(fullname.trim());
        admin.setUsername(username.trim());
        admin.setEmail(email.trim());
        admin.setPhone(phone.trim());
        admin.setPassword(password);
        admin.setProfilePicture(null);
        
        boolean success = dao.register(admin);
        
        if (success) {
            request.getSession().setAttribute("successMsg", "Welcome "+fullname+"! Your account is created. Please sign in to explore WorkSphere Pro.");
            response.sendRedirect("login.jsp");
        } else {
            request.getSession().setAttribute("error", "Registration failed. Please try again.");
            response.sendRedirect("registration.jsp");
        }
    }
    
    private boolean isValidUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        boolean hasAlpha = username.matches(".*[A-Za-z].*");
        boolean hasDigit = username.matches(".*\\d.*");
        boolean hasSpecial = username.matches(".*[^A-Za-z0-9\\s].*");
        
        return hasAlpha && hasDigit && hasSpecial;
    }
    
    private boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        return phone.matches("^[6-9]\\d{9}$");
    }
    
    private boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");
    }
}