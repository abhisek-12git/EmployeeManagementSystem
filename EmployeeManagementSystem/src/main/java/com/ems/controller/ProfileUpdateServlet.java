package com.ems.controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.ems.dao.AdminDao;
import com.ems.model.Admin;

@WebServlet("/ProfileUpdateServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 15
)
public class ProfileUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private AdminDao adminDao;
    
    public void init() {
        adminDao = new AdminDao();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
        
        if (currentAdmin == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "profiles";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        try {
            String fullname = request.getParameter("fullname");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String removePicture = request.getParameter("removePicture");
            
            String fileName = currentAdmin.getProfilePicture();

            if ("true".equals(removePicture)) {
                if (fileName != null && !fileName.isEmpty()) {
                    String filePath = uploadPath + File.separator + fileName;
                    File oldFile = new File(filePath);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }
                fileName = null;
            } 
            else {
                Part filePart = request.getPart("profilePicture");
                if (filePart != null && filePart.getSize() > 0) {
                    if (fileName != null && !fileName.isEmpty()) {
                        String oldFilePath = uploadPath + File.separator + fileName;
                        File oldFile = new File(oldFilePath);
                        if (oldFile.exists()) {
                            oldFile.delete();
                        }
                    }
                    
                    fileName = System.currentTimeMillis() + "_" + currentAdmin.getId() + "_" + getFileName(filePart);
                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                }
            }
            
            currentAdmin.setFullname(fullname);
            currentAdmin.setUsername(username);
            currentAdmin.setEmail(email);
            currentAdmin.setPhone(phone);
            currentAdmin.setProfilePicture(fileName);
            
            boolean success = adminDao.updateAdminWithProfile(currentAdmin);
            
            if (success) {
                session.setAttribute("currentAdmin", currentAdmin);
                session.setAttribute("successMsg", "Profile updated successfully!");
                response.sendRedirect("AdminHomeServlet");
                return;
            } else {
                session.setAttribute("errorMsg", "Failed to update profile. Please try again.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "Error updating profile: " + e.getMessage());
        }
        
        response.sendRedirect("adminprofile.jsp");
    }
    
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}