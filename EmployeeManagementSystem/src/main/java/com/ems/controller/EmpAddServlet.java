package com.ems.controller;

import java.io.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.ems.dao.EmpDao;
import com.ems.dao.DepartmentDao;
import com.ems.model.Employee;
import com.ems.model.Department;
import com.ems.util.IDGenerator;

@WebServlet("/EmpAddServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1, 
    maxFileSize = 1024 * 1024 * 5,      
    maxRequestSize = 1024 * 1024 * 10  
)
public class EmpAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private EmpDao dao;
    private DepartmentDao departmentDao;
    
    public void init() {
        dao = new EmpDao();
        departmentDao = new DepartmentDao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newEmpId = generateUniqueEmployeeId();
        if(newEmpId != null) {
            HttpSession session = request.getSession();
            session.setAttribute("pendingEmpId", newEmpId);
            request.setAttribute("generatedEmpId", newEmpId);
        } else {
            request.setAttribute("message", "Error: Failed to generate a unique Employee ID.");
        }
        
        List<Department> departments = departmentDao.getAllDepartments();
        request.setAttribute("departments", departments);
        
        request.getRequestDispatcher("addemp.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String newEmpId = (String) session.getAttribute("pendingEmpId");
        
        if(newEmpId == null) {
            newEmpId = generateUniqueEmployeeId();
            if(newEmpId == null) {
                 request.setAttribute("message", "Error: Failed to generate a unique Employee ID.");
                 request.getRequestDispatcher("addemp.jsp").forward(request, response);
                 return;
             }
        }
        
        session.removeAttribute("pendingEmpId");
        
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "documents";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        
        String empName = request.getParameter("emp_name");
        String gender = request.getParameter("gender");
        
        LocalDate empDob = null;
        LocalDate joinDate = null;
        
        try {
            empDob = LocalDate.parse(request.getParameter("emp_dob"));
            joinDate = LocalDate.parse(request.getParameter("joindate"));
        } catch(DateTimeParseException e) {
            request.setAttribute("message", "Error: Date fields must be valid and in yyyy-mm-dd format.");
            request.setAttribute("generatedEmpId", newEmpId);
            List<Department> departments = departmentDao.getAllDepartments();
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("addemp.jsp").forward(request, response);
            return;
        }
        
        String empEmail = request.getParameter("emp_email");
        String empPhone = request.getParameter("emp_phone");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pin = request.getParameter("pin");
        String dept = request.getParameter("dept");
        String desg = request.getParameter("desg");
        String empType = request.getParameter("emp_type");
        String shiftTime = request.getParameter("shift_time");
        String proofType = request.getParameter("proof_type");
        
        BigDecimal basicSalary = null;
        BigDecimal allowances = null;
        BigDecimal pf = null;
        BigDecimal totalSalary = null;
        
        try {
            basicSalary = new BigDecimal(request.getParameter("basic_salary"));
            allowances = new BigDecimal(request.getParameter("allowances"));
            pf = new BigDecimal(request.getParameter("pf"));
            totalSalary = new BigDecimal(request.getParameter("total_salary"));
        } catch(NumberFormatException ex) {
            request.setAttribute("message", "Error: Salary fields must be valid numbers.");
            request.setAttribute("generatedEmpId", newEmpId);
            List<Department> departments = departmentDao.getAllDepartments();
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("addemp.jsp").forward(request, response);
            return;
        }
        
        String proofDocumentName = null;
        try {
            Part filePart = request.getPart("proof_document");
            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = getFileName(filePart);
                String fileExtension = "";
                if(originalFileName.lastIndexOf(".") > 0) {
                    fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                }
                proofDocumentName = newEmpId + "_" + System.currentTimeMillis() + fileExtension;
                filePart.write(uploadPath + File.separator + proofDocumentName);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error uploading document: " + e.getMessage());
            request.setAttribute("generatedEmpId", newEmpId);
            List<Department> departments = departmentDao.getAllDepartments();
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("addemp.jsp").forward(request, response);
            return;
        }
        
        String proofInfo = proofType;
        if(proofDocumentName != null) {
            proofInfo += "::" + proofDocumentName;
        }
        
        Employee newEmployee = new Employee(
            newEmpId, empName, empDob, gender, empEmail, empPhone, address,
            city, state, pin, dept, desg, joinDate, empType, shiftTime, basicSalary, 
            allowances, pf, totalSalary, proofInfo, "active" // Default status
        );
        
        boolean isAdded = dao.add(newEmployee);
        
        if(isAdded) {
            try {
                com.ems.model.Admin currentAdmin = (com.ems.model.Admin) session.getAttribute("currentAdmin");
                String adminUsername = (currentAdmin != null) ? currentAdmin.getUsername() : "system";
                String adminFullname = (currentAdmin != null) ? currentAdmin.getFullname() : "System Administrator";
                
                com.ems.service.ActivityLogService activityService = new com.ems.service.ActivityLogService();
                activityService.logActivity("add", 
                    "New employee '" + empName + "' added to " + dept + " department as " + desg, 
                    adminUsername, adminFullname, empName);
                
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            session.setAttribute("successMsg", "Employee " + empName + " (ID: " + newEmpId + ") added successfully!");
            response.sendRedirect("AdminHomeServlet");
        } else {
            request.setAttribute("message", "Failed to add employee. A database error occurred");
            request.setAttribute("generatedEmpId", newEmpId);
            List<Department> departments = departmentDao.getAllDepartments();
            request.setAttribute("departments", departments);
            request.getRequestDispatcher("addemp.jsp").forward(request, response);
        }
    }
    
    private String generateUniqueEmployeeId() {
        String newEmpId = null;
        boolean idExists = true;
        int maxAttempts = 100;
        
        for(int i = 0; i < maxAttempts; i++) {
            String generatedId = IDGenerator.generateNewEmployeeId();
            if(!dao.isIdExists(generatedId)) {
                newEmpId = generatedId;
                idExists = false;
                break;
            }
        }
        
        return idExists ? null : newEmpId;
    }
    
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp != null) {
            String[] tokens = contentDisp.split(";");
            for (String token : tokens) {
                if (token.trim().startsWith("filename")) {
                    return token.substring(token.indexOf("=") + 2, token.length() - 1);
                }
            }
        }
        return "";
    }
}