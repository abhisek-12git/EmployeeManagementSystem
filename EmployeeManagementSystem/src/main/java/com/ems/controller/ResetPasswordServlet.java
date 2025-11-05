package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.dao.AdminDao;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();
        
        session.removeAttribute("successMsg");
        session.removeAttribute("errorMsg");
        
        AdminDao adminDao = new AdminDao();
        
        try {
            String email = (String) session.getAttribute("email");
            String otpVerified = (String) session.getAttribute("otpVerified");
            
            if (email == null || !"true".equals(otpVerified)) {
                session.setAttribute("errorMsg", "OTP verification required. Please request a new OTP.");
                response.sendRedirect("forgot-password.jsp");
                return;
            }
            
            if (!newPassword.equals(confirmPassword)) {
                session.setAttribute("errorMsg", "Passwords do not match.");
                response.sendRedirect("reset-password.jsp");
                return;
            }
            
            if (newPassword.length() < 8) {
                session.setAttribute("errorMsg", "Password must be at least 8 characters long.");
                response.sendRedirect("reset-password.jsp");
                return;
            }
            
            boolean passwordUpdated = adminDao.updatePassword(email, newPassword);
            
            if (passwordUpdated) {
                session.removeAttribute("email");
                session.removeAttribute("otpVerified");
                session.setAttribute("successMsg", "Password reset successfully! You can now login with your new password.");
                response.sendRedirect("login.jsp");
            } else {
                session.setAttribute("errorMsg", "Failed to reset password. Please try again.");
                response.sendRedirect("reset-password.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred. Please try again.");
            response.sendRedirect("reset-password.jsp");
        }
    }
}