package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.service.OTPService;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otp = request.getParameter("otp");
        HttpSession session = request.getSession();
        
        session.removeAttribute("successMsg");
        session.removeAttribute("errorMsg");
        
        String email = (String) session.getAttribute("email");
        OTPService otpService = new OTPService();
        
        try {
            if (email == null) {
                session.setAttribute("errorMsg", "Session expired. Please request a new OTP.");
                response.sendRedirect("forgot-password.jsp");
                return;
            }
            
            if (otp == null || otp.trim().isEmpty() || otp.length() != 6) {
                session.setAttribute("errorMsg", "Please enter a valid 6-digit OTP.");
                response.sendRedirect("verify-otp.jsp");
                return;
            }
                        
            String validatedEmail = otpService.validateOTP(email, otp);
            
            if (validatedEmail != null) {
                boolean marked=otpService.markOTPAsUsed(email, otp);
                if(marked) {
                	session.setAttribute("otpVerified", "true");
                    session.setAttribute("successMsg", "OTP verified successfully! You can now reset your password.");
                    response.sendRedirect("reset-password.jsp");
                } else {
                	session.setAttribute("errorMsg", "Failed to mark OTP as used. Please try again.");
					response.sendRedirect("verify-otp.jsp");
                }
            } else {
                session.setAttribute("errorMsg", "Invalid or expired OTP. Please try again.");
                response.sendRedirect("verify-otp.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred. Please try again.");
            response.sendRedirect("verify-otp.jsp");
        }
    }
}