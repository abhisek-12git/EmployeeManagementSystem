package com.ems.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.dao.AdminDao;
import com.ems.service.OTPService;
import com.ems.util.EmailUtil;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        HttpSession session = request.getSession();
        
        session.removeAttribute("successMsg");
        session.removeAttribute("errorMsg");
        
        AdminDao adminDao = new AdminDao();
        OTPService otpService = new OTPService();
        
        try {
            if (!adminDao.isEmailExists(email)) {
                session.setAttribute("errorMsg", "No account found with this email address.");
                response.sendRedirect("forgot-password.jsp");
                return;
            }
            
            String otp = otpService.generateOTP();
            
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MINUTE, 10);
            Date expiryDate = cal.getTime();
            
            boolean otpSaved = otpService.saveOTP(email, otp, expiryDate);
            
            if (otpSaved) {
                String userName = adminDao.getUserFullName(email);
                
                String subject = "Your Password Reset OTP - WorkSphere Pro";
                String message = "<!DOCTYPE html>"
                    + "<html>"
                    + "<head>"
                    + "    <meta charset='UTF-8'>"
                    + "    <style>"
                    + "        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; margin: 0; padding: 20px; background: #ffffff; }"
                    + "        .container { max-width: 600px; margin: 0 auto; }"
                    + "        .main-heading { font-size: 30px; font-weight: bold; margin-bottom: 10px; color: #3498db; text-align: center; }"
                    + "        .sub-heading { font-size: 25px; font-weight: bold; margin-bottom: 25px; color: #666; text-align: center; }"
                    + "        .message { font-size: 13px; line-height: 1.6; margin-bottom: 15px; color: #333; }"
                    + "        .otp-container { text-align: center; margin: 25px 0; }"
                    + "        .otp-code { display: inline-block; background-color: #3498db; color: white; padding: 15px 30px; text-decoration: none; border-radius: 8px; font-size: 28px; font-weight: bold; border: none; letter-spacing: 5px; }"
                    + "        .security-note { background: #fff3cd; border: 1px solid #ffeaa7; border-radius: 6px; padding: 12px; margin: 20px 0; font-size: 12px; color: #856404; line-height: 1.5; }"
                    + "        .footer { margin-top: 30px; padding-top: 20px; border-top: 1px solid #e9ecef; font-size: 12px; color: #999; line-height: 1.5; }"
                    + "    </style>"
                    + "</head>"
                    + "<body>"
                    + "    <div class='container'>"
                    + "        <div class='main-heading'>WorkSphere Pro</div>"
                    + "        <div class='sub-heading'>Password Reset OTP</div>"
                    + "        "
                    + "        <div class='message'>"
                    + "            Hi " + userName + ","
                    + "        </div>"
                    + "        "
                    + "        <div class='message'>"
                    + "            You requested to reset the password for your WorkSphere Pro account. Use the following OTP to reset your password:"
                    + "        </div>"
                    + "        "
                    + "        <div class='otp-container'>"
                    + "            <div class='otp-code'>" + otp + "</div>"
                    + "        </div>"
                    + "        "
                    + "        <div class='security-note'>"
                    + "            This OTP will expire in 10 minutes for security reasons. Do not share this OTP with anyone."
                    + "        </div>"
                    + "        "
                    + "        <div class='message'>"
                    + "            If you did not request a password reset, please feel free to ignore this message."
                    + "        </div>"
                    + "        "
                    + "        <div class='footer'>"
                    + "            <div>Thanks,</div>"
                    + "            <div>The WorkSphere Pro Team</div>"
                    + "        </div>"
                    + "    </div>"
                    + "</body>"
                    + "</html>";
                
                boolean emailSent = EmailUtil.sendEmail(email, subject, message);
                
                if (emailSent) {
                    session.setAttribute("email", email);
                    session.setAttribute("successMsg", "OTP has been sent to your email. It is valid for 10 minutes.");
                    response.sendRedirect("verify-otp.jsp");
                } else {
                    session.setAttribute("errorMsg", "Failed to send OTP email. Please try again.");
                    response.sendRedirect("forgot-password.jsp");
                }
            } else {
                session.setAttribute("errorMsg", "Failed to process your request. Please try again.");
                response.sendRedirect("forgot-password.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "An error occurred. Please try again.");
            response.sendRedirect("forgot-password.jsp");
        }
    }
}