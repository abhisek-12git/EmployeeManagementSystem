<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="com.ems.model.Department" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Employee</title>
<style>
    body { 
        font-family: Arial, sans-serif; 
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }
    
    .header {
        background: #007bff;
        color: white;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        height: 70px;
        box-sizing: border-box;
    }
    
    .container {
        max-width: 1000px;
        margin: 100px auto 30px auto;
        padding: 0 20px;
        position: relative;
        z-index: 1;
    }
    
    .nav-links {
        display: flex;
        gap: 20px;
        align-items: center;
    }
    
    .nav-links a {
        color: white;
        text-decoration: none;
        padding: 8px 15px;
        border-radius: 4px;
        transition: background 0.3s;
    }
    
    .nav-links a:hover {
        background: rgba(255,255,255,0.2);
    }
    
    .profile-section {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-left: 20px;
        padding-left: 20px;
        border-left: 1px solid rgba(255,255,255,0.3);
    }
    
    .profile-picture {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid white;
        background: #fff;
        cursor: pointer;
        transition: transform 0.3s ease;
    }
    
    .profile-picture:hover {
        transform: scale(1.05);
    }
    
    .profile-initials {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 16px;
        border: 2px solid white;
        cursor: pointer;
        transition: transform 0.3s ease;
    }
    
    .profile-initials:hover {
        transform: scale(1.05);
    }
    
    .profile-info {
        display: flex;
        flex-direction: column;
    }
    
    .profile-name {
        font-weight: bold;
        font-size: 14px;
    }
    
    .profile-role {
        font-size: 12px;
        opacity: 0.8;
    }
    
    .form-container {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    
    .form-title {
        color: #333;
        margin-bottom: 30px;
        text-align: center;
        border-bottom: 2px solid #007bff;
        padding-bottom: 10px;
    }
    
    .form-section {
        margin-bottom: 30px;
        padding: 20px;
        border: 1px solid #e0e0e0;
        border-radius: 6px;
        background: #fafafa;
    }
    
    .section-title {
        color: #007bff;
        margin-bottom: 20px;
        font-size: 18px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .employee-id-display {
        background: #e7f3ff;
        padding: 15px;
        border-radius: 6px;
        border-left: 4px solid #007bff;
        margin-bottom: 20px;
        text-align: center;
    }
    
    .employee-id-label {
        font-weight: bold;
        color: #333;
        margin-right: 10px;
    }
    
    .employee-id-value {
        font-size: 18px;
        font-weight: bold;
        color: #007bff;
        background: white;
        padding: 5px 15px;
        border-radius: 4px;
        border: 1px solid #007bff;
    }
    
    .form-group {
        margin-bottom: 20px;
        display: flex;
        flex-direction: column;
    }
    
    .form-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333;
    }
    
    .form-group input[type="text"],
    .form-group input[type="email"],
    .form-group input[type="tel"],
    .form-group input[type="date"],
    .form-group input[type="number"],
    .form-group input[type="file"],
    .form-group select,
    .form-group textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
    }
    
    .form-group textarea {
        resize: vertical;
        min-height: 80px;
    }
    
    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0,123,255,0.3);
    }
    
    .required::after {
        content: " *";
        color: red;
    }
    
    .btn-group {
        display: flex;
        gap: 15px;
        justify-content: center;
        margin-top: 30px;
    }
    
    .btn {
        padding: 12px 30px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: all 0.3s;
        text-decoration: none;
        display: inline-block;
        text-align: center;
    }
    
    .btn-primary {
        background: #007bff;
        color: white;
    }
    
    .btn-primary:hover {
        background: #0056b3;
    }
    
    .btn-secondary {
        background: #6c757d;
        color: white;
    }
    
    .btn-secondary:hover {
        background: #545b62;
    }
    
    .btn-success {
        background: #28a745;
        color: white;
    }
    
    .btn-success:hover {
        background: #218838;
    }
    
    .btn-warning {
        background: #ffc107;
        color: #212529;
    }
    
    .btn-warning:hover {
        background: #e0a800;
    }
    
    .message {
        padding: 15px;
        margin-bottom: 20px;
        border-radius: 4px;
        text-align: center;
    }
    
    .message-success {
        background: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    
    .message-error {
        background: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    
    .auto-generated {
        background: #e9ecef;
        color: #495057;
        font-weight: bold;
    }
    
    .salary-calculator {
        background: #e7f3ff;
        padding: 15px;
        border-radius: 4px;
        margin-top: 10px;
        border-left: 4px solid #007bff;
    }
    
    .salary-result {
        font-weight: bold;
        color: #007bff;
        margin-top: 10px;
    }
    
    .form-hint {
        font-size: 12px;
        color: #666;
        margin-top: 5px;
    }
    
    .file-upload-container {
        border: 2px dashed #007bff;
        border-radius: 8px;
        padding: 20px;
        text-align: center;
        background: #f8f9fa;
        transition: all 0.3s;
        position: relative;
    }
    
    .file-upload-container.dragover {
        background: #e3f2fd;
        border-color: #0056b3;
        border-style: solid;
    }
    
    .file-upload-container.has-file {
        border-color: #28a745;
        background: #f0fff4;
        border-style: solid;
    }
    
    .file-upload-icon {
        font-size: 48px;
        color: #007bff;
        margin-bottom: 10px;
    }
    
    .file-input {
        display: none;
    }
    
    .file-upload-btn {
        background: #007bff;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin: 10px 0;
        font-size: 14px;
    }
    
    .file-upload-btn:hover {
        background: #0056b3;
    }
    
    .file-info {
        margin-top: 15px;
        padding: 15px;
        background: white;
        border-radius: 6px;
        border: 2px solid #28a745;
        text-align: left;
    }
    
    .file-name-display {
        font-weight: bold;
        color: #155724;
        font-size: 16px;
        margin-bottom: 5px;
        word-break: break-all;
    }
    
    .file-details {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 10px;
    }
    
    .file-size {
        color: #666;
        font-size: 14px;
    }
    
    .file-type {
        color: #007bff;
        font-size: 14px;
        background: #e7f3ff;
        padding: 2px 8px;
        border-radius: 12px;
    }
    
    .remove-file-btn {
        background: #dc3545;
        color: white;
        border: none;
        padding: 5px 10px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 12px;
        margin-left: 10px;
    }
    
    .remove-file-btn:hover {
        background: #c82333;
    }
    
    .selected-file-indicator {
        position: absolute;
        top: -10px;
        right: -10px;
        background: #28a745;
        color: white;
        border-radius: 50%;
        width: 24px;
        height: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        font-weight: bold;
    }
    
    .upload-status {
        margin-top: 10px;
        padding: 8px;
        border-radius: 4px;
        text-align: center;
        font-weight: bold;
    }
    
    .upload-success {
        background: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    
    @media (max-width: 768px) {
        .form-row {
            grid-template-columns: 1fr;
        }
        
        .btn-group {
            flex-direction: column;
        }
        
        .container {
            margin: 15px auto;
            padding: 0 10px;
        }
        
        .form-container {
            padding: 20px;
        }
        
        .file-details {
            flex-direction: column;
            align-items: flex-start;
            gap: 5px;
        }
        
        .remove-file-btn {
            margin-left: 0;
            margin-top: 5px;
        }
    }
</style>
</head>
<body>

<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    if (currentAdmin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    Employee employee = (Employee) request.getAttribute("employee");
    List<Department> departments = (List<Department>) request.getAttribute("departments");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    
    DecimalFormat salaryFormat = new DecimalFormat("₹ #,##0.00");
    
    if (employee == null) {
        response.sendRedirect("EmpListServlet");
        return;
    }
    
    String profilePicture = null;
    String adminName = "Admin";
    String adminInitials = "A";
    String randomColor = "#007bff";
    
    if (currentAdmin != null) {
        if (currentAdmin.getFullname() != null && !currentAdmin.getFullname().isEmpty()) {
            adminName = currentAdmin.getFullname();
        } else if (currentAdmin.getUsername() != null && !currentAdmin.getUsername().isEmpty()) {
            adminName = currentAdmin.getUsername();
        }
        
        if (currentAdmin.getProfilePicture() != null && !currentAdmin.getProfilePicture().isEmpty()) {
            profilePicture = request.getContextPath() + "/uploads/profiles/" + currentAdmin.getProfilePicture() + "?v=" + System.currentTimeMillis();
        }
        
        adminInitials = currentAdmin.getInitials();
        
        String colorSeed = String.valueOf(currentAdmin.getId()) + currentAdmin.getUsername();
        randomColor = ColorUtils.generateRandomColor(colorSeed);
    }
%>

<div class="header">
    <h1>Employee Management System</h1>
    <div class="nav-links">
        <a href="AdminHomeServlet">Home</a>
        <a href="EmpListServlet">Employees</a>
        <a href="LogoutServlet">Logout</a>
        
        <div class="profile-section">
            <% 
            String navProfilePicture = null;
            if (currentAdmin != null && currentAdmin.getProfilePicture() != null && !currentAdmin.getProfilePicture().isEmpty()) {
                navProfilePicture = request.getContextPath() + "/uploads/profiles/" + currentAdmin.getProfilePicture() + "?v=" + System.currentTimeMillis();
            }
            %>
            
            <% if (navProfilePicture != null) { %>
                <img src="<%= navProfilePicture %>" 
                     alt="Profile Picture" 
                     class="profile-picture" 
                     id="navProfilePicture"
                     onclick="window.location.href='adminprofile.jsp'"
                     onerror="this.style.display='none'; document.getElementById('navProfileInitials').style.display='flex';">
                <div id="navProfileInitials" class="profile-initials" style="display: none; background: <%= randomColor %>;"
                     onclick="window.location.href='adminprofile.jsp'">
                    <%= adminInitials %>
                </div>
            <% } else { %>
                <div class="profile-initials" style="background: <%= randomColor %>;"
                     onclick="window.location.href='adminprofile.jsp'">
                    <%= adminInitials %>
                </div>
            <% } %>
            
            <div class="profile-info">
                <div class="profile-name"><%= adminName %></div>
                <div class="profile-role">Administrator</div>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="form-container">
        <h2 class="form-title">Edit Employee Details</h2>
        
        <% if (message != null) { %>
            <div class="message <%= message.contains("Error") || message.contains("Failed") ? "message-error" : "message-success" %>">
                <%= message %>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="message message-error">
                <%= error %>
            </div>
        <% } %>
        
        <div class="employee-id-display">
            <span class="employee-id-label">Employee ID:</span>
            <span class="employee-id-value"><%= employee.getEmp_id() != null ? employee.getEmp_id() : "N/A" %></span>
            <div class="form-hint">Employee ID cannot be changed</div>
        </div>
        
        <form action="EmpUpdateServlet" method="post" id="employeeForm" enctype="multipart/form-data" onsubmit="return validateForm()">
            <input type="hidden" name="emp_id" value="<%= employee.getEmp_id() != null ? employee.getEmp_id() : "" %>">
            
            <div class="form-section">
                <h3 class="section-title">👤 Personal Details</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="emp_name" class="required">Full Name</label>
                        <input type="text" id="emp_name" name="emp_name" required 
                               value="<%= employee.getEmp_name() != null ? employee.getEmp_name() : "" %>"
                               placeholder="Enter employee's full name">
                    </div>
                    <div class="form-group">
                        <label for="emp_dob" class="required">Date of Birth</label>
                        <input type="date" id="emp_dob" name="emp_dob" required
                               value="<%= employee.getEmp_dob() != null ? employee.getEmp_dob() : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="gender" class="required">Gender</label>
                        <select id="gender" name="gender" required>
                            <option value="">Select Gender</option>
                            <option value="Male" <%= "Male".equals(employee.getGender()) ? "selected" : "" %>>Male</option>
                            <option value="Female" <%= "Female".equals(employee.getGender()) ? "selected" : "" %>>Female</option>
                            <option value="Other" <%= "Other".equals(employee.getGender()) ? "selected" : "" %>>Other</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3 class="section-title">📞 Contact Details</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="emp_email" class="required">Email Address</label>
                        <input type="email" id="emp_email" name="emp_email" required 
                               value="<%= employee.getEmp_email() != null ? employee.getEmp_email() : "" %>"
                               placeholder="employee@company.com">
                    </div>
                    <div class="form-group">
                        <label for="emp_phone" class="required">Phone Number</label>
                        <input type="tel" id="emp_phone" name="emp_phone" required 
                               value="<%= employee.getEmp_phone() != null ? employee.getEmp_phone() : "" %>"
                               placeholder="+91 1234567890" pattern="[0-9]{10}">
                        <div class="form-hint">10-digit phone number without spaces</div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="address" class="required">Address</label>
                        <textarea id="address" name="address" required 
                                  placeholder="Enter complete address"><%= employee.getAddress() != null ? employee.getAddress() : "" %></textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="city" class="required">City</label>
                        <input type="text" id="city" name="city" required 
                               value="<%= employee.getCity() != null ? employee.getCity() : "" %>"
                               placeholder="Enter city">
                    </div>
                    <div class="form-group">
                        <label for="state" class="required">State</label>
                        <input type="text" id="state" name="state" required 
                               value="<%= employee.getState() != null ? employee.getState() : "" %>"
                               placeholder="Enter state">
                    </div>
                    <div class="form-group">
                        <label for="pin" class="required">PIN Code</label>
                        <input type="text" id="pin" name="pin" required 
                               value="<%= employee.getPin() != null ? employee.getPin() : "" %>"
                               placeholder="6-digit PIN code" pattern="[0-9]{6}">
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3 class="section-title">💼 Job Details</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="dept" class="required">Department</label>
                        <select id="dept" name="dept" required>
                            <option value="">Select Department</option>
                            <%
                                if (departments != null && !departments.isEmpty()) {
                                    for (Department dept : departments) {
                                        boolean isSelected = dept.getName().equals(employee.getDept());
                            %>
                                <option value="<%= dept.getName() %>" <%= isSelected ? "selected" : "" %>>
                                    <%= dept.getName() %>
                                </option>
                            <%
                                    }
                                } else {
                            %>
                                <option value="IT" <%= "IT".equals(employee.getDept()) ? "selected" : "" %>>Information Technology</option>
                                <option value="HR" <%= "HR".equals(employee.getDept()) ? "selected" : "" %>>Human Resources</option>
                                <option value="Finance" <%= "Finance".equals(employee.getDept()) ? "selected" : "" %>>Finance</option>
                                <option value="Marketing" <%= "Marketing".equals(employee.getDept()) ? "selected" : "" %>>Marketing</option>
                                <option value="Sales" <%= "Sales".equals(employee.getDept()) ? "selected" : "" %>>Sales</option>
                                <option value="Operations" <%= "Operations".equals(employee.getDept()) ? "selected" : "" %>>Operations</option>
                                <option value="R&D" <%= "R&D".equals(employee.getDept()) ? "selected" : "" %>>Research & Development</option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="desg" class="required">Designation</label>
                        <input type="text" id="desg" name="desg" required 
                               value="<%= employee.getDesg() != null ? employee.getDesg() : "" %>"
                               placeholder="Enter designation">
                    </div>
                    <div class="form-group">
                        <label for="joindate" class="required">Join Date</label>
                        <input type="date" id="joindate" name="joindate" required
                               value="<%= employee.getJoindate() != null ? employee.getJoindate() : "" %>">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="emp_type" class="required">Employment Type</label>
                        <select id="emp_type" name="emp_type" required>
                            <option value="">Select Type</option>
                            <option value="Full-Time" <%= "Full-Time".equals(employee.getEmp_type()) ? "selected" : "" %>>Full-Time</option>
                            <option value="Part-Time" <%= "Part-Time".equals(employee.getEmp_type()) ? "selected" : "" %>>Part-Time</option>
                            <option value="Contract" <%= "Contract".equals(employee.getEmp_type()) ? "selected" : "" %>>Contract</option>
                            <option value="Intern" <%= "Intern".equals(employee.getEmp_type()) ? "selected" : "" %>>Intern</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="shift_time">Shift Time</label>
                        <select id="shift_time" name="shift_time">
                            <option value="">Select Shift</option>
                            <option value="Day Shift" <%= "Day Shift".equals(employee.getShift_time()) ? "selected" : "" %>>Day Shift (9 AM - 6 PM)</option>
                            <option value="Night Shift" <%= "Night Shift".equals(employee.getShift_time()) ? "selected" : "" %>>Night Shift (6 PM - 3 AM)</option>
                            <option value="Flexible" <%= "Flexible".equals(employee.getShift_time()) ? "selected" : "" %>>Flexible Hours</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3 class="section-title">💰 Salary Details</h3>
                <div class="salary-calculator">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="basic_salary" class="required">Basic Salary</label>
                            <input type="number" id="basic_salary" name="basic_salary" 
                                   step="0.01" min="0" required 
                                   value="<%= employee.getBasic_salary() != null ? employee.getBasic_salary() : "0.00" %>"
                                   placeholder="0.00" onchange="calculateTotalSalary()">
                        </div>
                        <div class="form-group">
                            <label for="allowances">Allowances</label>
                            <input type="number" id="allowances" name="allowances" 
                                   step="0.01" min="0" 
                                   value="<%= employee.getAllowances() != null ? employee.getAllowances() : "0.00" %>"
                                   placeholder="0.00" onchange="calculateTotalSalary()">
                        </div>
                        <div class="form-group">
                            <label for="pf">PF Contribution</label>
                            <input type="number" id="pf" name="pf" 
                                   step="0.01" min="0" 
                                   value="<%= employee.getPf() != null ? employee.getPf() : "0.00" %>"
                                   placeholder="0.00" onchange="calculateTotalSalary()">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="total_salary" class="required">Total Salary</label>
                            <input type="number" id="total_salary" name="total_salary" 
                                   step="0.01" min="0" required readonly
                                   value="<%= employee.getTotal_salary() != null ? employee.getTotal_salary() : "0.00" %>"
                                   class="auto-generated">
                        </div>
                    </div>
                    <div class="salary-result" id="salaryResult">
                        Total Salary: <%= employee.getTotal_salary() != null ? salaryFormat.format(employee.getTotal_salary()) : "₹0.00" %>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3 class="section-title">📄 Identity Proof Documents</h3>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="proof" class="required">Identity Proof Type</label>
                        <select id="proof" name="proof" required>
                            <option value="">Select Proof Type</option>
                            <option value="Aadhar Card" <%= "Aadhar Card".equals(employee.getProof()) ? "selected" : "" %>>Aadhar Card</option>
                            <option value="PAN Card" <%= "PAN Card".equals(employee.getProof()) ? "selected" : "" %>>PAN Card</option>
                            <option value="Passport" <%= "Passport".equals(employee.getProof()) ? "selected" : "" %>>Passport</option>
                            <option value="Driving License" <%= "Driving License".equals(employee.getProof()) ? "selected" : "" %>>Driving License</option>
                            <option value="Voter ID" <%= "Voter ID".equals(employee.getProof()) ? "selected" : "" %>>Voter ID</option>
                            <option value="Other" <%= "Other".equals(employee.getProof()) ? "selected" : "" %>>Other Government ID</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Upload New Identity Proof Document</label>
                    <div class="file-upload-container" id="fileUploadContainer">
                        <div class="file-upload-icon">📁</div>
                        <h4>Upload Identity Proof Document</h4>
                        <p>Current Document: <strong><%= employee.getProof() != null ? employee.getProof() : "Not specified" %></strong></p>
                        <p>Supported formats: PDF, JPG, PNG, JPEG, DOC, DOCX</p>
                        <p>Max file size: 5MB</p>
                        <input type="file" id="proof_document" name="proof_document" 
                               class="file-input" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" 
                               onchange="handleFileSelect(this)">
                        <button type="button" class="file-upload-btn" onclick="document.getElementById('proof_document').click()">
                            Choose File
                        </button>
                        
                        <div class="file-info" id="fileInfo" style="display: none;">
                            <div class="selected-file-indicator">✓</div>
                            <div class="file-name-display" id="fileNameDisplay"></div>
                            <div class="file-details">
                                <div>
                                    <span class="file-size" id="fileSizeDisplay"></span>
                                    <span class="file-type" id="fileTypeDisplay"></span>
                                </div>
                                <button type="button" class="remove-file-btn" onclick="removeFile()">
                                    Remove File
                                </button>
                            </div>
                        </div>
                        
                    </div>
                </div>

                <div class="form-hint">
                    <strong>Document Requirements:</strong>
                    <ul>
                        <li>File must be clear and readable</li>
                        <li>Maximum file size: 5MB</li>
                        <li>Accepted formats: PDF, JPG, JPEG, PNG, DOC, DOCX</li>
                        <li>Document should be valid and not expired</li>
                    </ul>
                </div>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-success">Update Employee</button>
                <button type="reset" class="btn btn-secondary" onclick="resetForm()">Reset Changes</button>
                <a href="ViewEmpServlet?emp_id=<%= employee.getEmp_id() %>" class="btn btn-warning">View Details</a>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        calculateTotalSalary();
        initializeDragAndDrop();
    });

    function calculateTotalSalary() {
        const basicSalary = parseFloat(document.getElementById('basic_salary').value) || 0;
        const allowances = parseFloat(document.getElementById('allowances').value) || 0;
        const pf = parseFloat(document.getElementById('pf').value) || 0;
        
        const totalSalary = basicSalary + allowances - pf;
        
        document.getElementById('total_salary').value = totalSalary.toFixed(2);
        document.getElementById('salaryResult').innerHTML = 'Total Salary: ₹' + totalSalary.toFixed(2);
    }

    function handleFileSelect(input) {
        const file = input.files[0];
        if (file) {
            displayFileInfo(file);
        }
    }

    function displayFileInfo(file) {
        const fileInfo = document.getElementById('fileInfo');
        const fileNameDisplay = document.getElementById('fileNameDisplay');
        const fileSizeDisplay = document.getElementById('fileSizeDisplay');
        const fileTypeDisplay = document.getElementById('fileTypeDisplay');
        const uploadContainer = document.getElementById('fileUploadContainer');
        
        fileNameDisplay.textContent = file.name;
        fileSizeDisplay.textContent = formatFileSize(file.size);
        fileTypeDisplay.textContent = getFileType(file.type);
        
        fileInfo.style.display = 'block';
        uploadContainer.classList.add('has-file');
    }

    function getFileType(mimeType) {
        const typeMap = {
            'application/pdf': 'PDF',
            'image/jpeg': 'JPEG Image',
            'image/jpg': 'JPG Image',
            'image/png': 'PNG Image',
            'application/msword': 'Word Document',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document': 'Word Document'
        };
        return typeMap[mimeType] || 'Document';
    }

    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    function removeFile() {
        const fileInput = document.getElementById('proof_document');
        const fileInfo = document.getElementById('fileInfo');
        const uploadContainer = document.getElementById('fileUploadContainer');
        
        fileInput.value = '';
        fileInfo.style.display = 'none';
        uploadContainer.classList.remove('has-file');
    }

    function initializeDragAndDrop() {
        const container = document.getElementById('fileUploadContainer');
        const fileInput = document.getElementById('proof_document');

        container.addEventListener('dragover', function(e) {
            e.preventDefault();
            container.classList.add('dragover');
        });

        container.addEventListener('dragleave', function() {
            container.classList.remove('dragover');
        });

        container.addEventListener('drop', function(e) {
            e.preventDefault();
            container.classList.remove('dragover');
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                fileInput.files = files;
                handleFileSelect(fileInput);
            }
        });
    }

    function validateForm() {
        const empDob = new Date(document.getElementById('emp_dob').value);
        const joinDate = new Date(document.getElementById('joindate').value);
        const today = new Date();
        
        const minDob = new Date();
        minDob.setFullYear(minDob.getFullYear() - 18);
        
        if (empDob > minDob) {
            alert('Employee must be at least 18 years old.');
            return false;
        }
        
        if (joinDate > today) {
            alert('Join date cannot be in the future.');
            return false;
        }
        
        if (joinDate < empDob) {
            alert('Join date cannot be before date of birth.');
            return false;
        }
        
        const phone = document.getElementById('emp_phone').value;
        if (!/^\d{10}$/.test(phone)) {
            alert('Please enter a valid 10-digit phone number.');
            return false;
        }
        
        const pin = document.getElementById('pin').value;
        if (!/^\d{6}$/.test(pin)) {
            alert('Please enter a valid 6-digit PIN code.');
            return false;
        }
        
        const basicSalary = parseFloat(document.getElementById('basic_salary').value);
        if (basicSalary < 0) {
            alert('Basic salary cannot be negative.');
            return false;
        }
        
        const proofType = document.getElementById('proof').value;
        if (!proofType) {
            alert('Please select an identity proof type.');
            return false;
        }
        
        const proofDocument = document.getElementById('proof_document').files[0];
        if (proofDocument) {
            if (proofDocument.size > 5 * 1024 * 1024) {
                alert('File size must be less than 5MB.');
                return false;
            }
            
            const allowedTypes = [
                'application/pdf', 
                'image/jpeg', 
                'image/jpg', 
                'image/png',
                'application/msword',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            ];
            if (!allowedTypes.includes(proofDocument.type)) {
                alert('Please upload a PDF, JPG, PNG, or Word document.');
                return false;
            }
        }
        
        return true;
    }

    function resetForm() {
        if (confirm('Are you sure you want to reset all changes? All modifications will be lost.')) {
            window.location.reload();
        }
    }

    document.getElementById('emp_phone').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 10) {
            value = value.substring(0, 10);
        }
        e.target.value = value;
    });

    document.getElementById('pin').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 6) {
            value = value.substring(0, 6);
        }
        e.target.value = value;
    });
</script>

</body>
</html> --%>
















<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="com.ems.model.Department" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    if (currentAdmin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    Employee employee = (Employee) request.getAttribute("employee");
    List<Department> departments = (List<Department>) request.getAttribute("departments");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    
    DecimalFormat salaryFormat = new DecimalFormat("₹ #,##0.00");
    
    if (employee == null) {
        response.sendRedirect("EmpListServlet");
        return;
    }
    
    String profilePicture = null;
    String adminName = "Admin";
    String adminInitials = "A";
    String gradientColor1 = "#3498db";
    String gradientColor2 = "#2980b9";
    
    String[][] gradientColors = {
        {"#FF6B6B", "#FF8E8E"},
        {"#4ECDC4", "#44A08D"},
        {"#45B7D1", "#96C93D"},
        {"#FDC830", "#F37335"},
        {"#834D9B", "#D04ED6"},
        {"#00B4DB", "#0083B0"},
        {"#FF9A9E", "#FAD0C4"},
        {"#A1C4FD", "#C2E9FB"},
        {"#FFECD2", "#FCB69F"},
        {"#667EEA", "#764BA2"},
        {"#F093FB", "#F5576C"},
        {"#4FACFE", "#00F2FE"},
        {"#43E97B", "#38F9D7"},
        {"#FA709A", "#FEE140"},
        {"#30CFD0", "#330867"},
        {"#FF9D6C", "#BB4E75"},
        {"#A3B1F6", "#6964DE"},
        {"#F6D365", "#FDA085"},
        {"#5EE7DF", "#B490CA"},
        {"#D299C2", "#FEF9D7"},
        {"#FF5858", "#F09819"},
        {"#00CDAC", "#02AAB0"},
        {"#C471F5", "#FA71CD"},
        {"#48C6EF", "#6F86D6"},
        {"#F77062", "#FE5196"}
    };
    
    if (currentAdmin != null) {
        if (currentAdmin.getFullname() != null && !currentAdmin.getFullname().isEmpty()) {
            adminName = currentAdmin.getFullname();
        } else if (currentAdmin.getUsername() != null && !currentAdmin.getUsername().isEmpty()) {
            adminName = currentAdmin.getUsername();
        }
        
        if (currentAdmin.getProfilePicture() != null && !currentAdmin.getProfilePicture().isEmpty()) {
            profilePicture = request.getContextPath() + "/uploads/profiles/" + currentAdmin.getProfilePicture() + "?v=" + System.currentTimeMillis();
        }
        
        adminInitials = currentAdmin.getInitials();
        
        int colorIndex = Math.abs(currentAdmin.getId() % gradientColors.length);
        String[] colors = gradientColors[colorIndex];
        gradientColor1 = colors[0];
        gradientColor2 = colors[1];
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WorkSphere Pro - Update Employee</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body { 
        font-family: 'Poppins', sans-serif; 
        margin: 0;
        padding: 0;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        min-height: 100vh;
        overflow-x: hidden;
    }
    
    .message-container {
        position: fixed;
        top: 90px;
        left: 50%;
        transform: translateX(-50%);
        z-index: 1000;
        width: 90%;
        max-width: 500px;
    }
    
    .message-success {
        padding: 15px 20px 15px 50px;
        border-radius: 8px;
        text-align: left;
        font-weight: 500;
        margin-bottom: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        animation: slideDown 0.3s ease-out;
        position: relative;
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    
    .message-error {
        padding: 15px 20px 15px 50px;
        border-radius: 8px;
        text-align: left;
        font-weight: 500;
        margin-bottom: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        animation: slideDown 0.3s ease-out;
        position: relative;
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    
    .message-info {
        padding: 15px 20px 15px 50px;
        border-radius: 8px;
        text-align: left;
        font-weight: 500;
        margin-bottom: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        animation: slideDown 0.3s ease-out;
        position: relative;
        background-color: #d1ecf1;
        color: #0c5460;
        border: 1px solid #bee5eb;
    }
    
    .message-icon {
        position: absolute;
        left: 18px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 1.2rem;
    }
    
    .message-success .message-icon {
        color: #155724;
    }
    
    .message-error .message-icon {
        color: #721c24;
    }
    
    .message-info .message-icon {
        color: #0c5460;
    }
    
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .message-hide {
        animation: slideUp 0.3s ease-in;
    }
    
    @keyframes slideUp {
        from {
            opacity: 1;
            transform: translateY(0);
        }
        to {
            opacity: 0;
            transform: translateY(-20px);
        }
    }
    
    .header {
        background: rgba(255, 255, 255, 0.70);
        color: #2c3e50;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
        height: 70px;
        box-sizing: border-box;
        backdrop-filter: blur(10px);
        border-bottom: 1px solid rgba(255,255,255,0.2);
    }
    
    .logo-container {
        display: flex;
        align-items: center;
        gap: 15px;
        text-decoration: none;
    }
    
    .logo-icon {
        width: 50px;
        height: 50px;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
        box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
        overflow: hidden;
    }
    
    .logo-icon::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(255,255,255,0.3) 0%, transparent 50%);
    }
    
    .logo-icon i {
        color: white;
        font-size: 24px;
        filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));
        z-index: 1;
    }
    
    .logo-text {
        display: flex;
        flex-direction: column;
        line-height: 1;
        position: relative;
    }
    
    .logo-main {
        display: flex;
        align-items: baseline;
        gap: 4px;
        font-weight: 800;
        letter-spacing: -0.5px;
        position: relative;
    }
    
    .worksphere-text {
        font-size: 1.9rem;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-shadow: 0 2px 10px rgba(52, 152, 219, 0.3);
        position: relative;
    }
    
    .worksphere-text::after {
        content: '';
        position: absolute;
        bottom: -2px;
        left: 0;
        width: 100%;
        height: 2px;
        background: linear-gradient(90deg, #3498db, transparent);
        opacity: 0.7;
    }
    
    .pro-text {
        font-size: 1.5rem;
        background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        text-shadow: 0 2px 8px rgba(255, 107, 53, 0.3);
        font-weight: 900;
        position: relative;
        padding: 0 4px;
    }
    
    .pro-text::before {
        content: '';
        position: absolute;
        top: -2px;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(135deg, rgba(255, 107, 53, 0.1) 0%, transparent 50%);
        border-radius: 4px;
        z-index: -1;
    }
    
    .logo-tagline {
        font-size: 0.65rem;
        font-weight: 700;
        color: #7f8c8d;
        letter-spacing: 2px;
        text-transform: uppercase;
        margin-top: 3px;
        position: relative;
        padding-left: 2px;
    }
    
    .logo-tagline::before {
        content: '✦';
        position: absolute;
        left: -10px;
        top: 50%;
        transform: translateY(-50%);
        color: #3498db;
        font-size: 0.5rem;
    }
    
    .container {
        max-width: 1200px;
        margin: 100px auto 30px auto;
        padding: 0 20px;
        position: relative;
        z-index: 1;
    }
    
    .nav-links {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    
    .nav-links a {
        color: #2c3e50;
        text-decoration: none;
        padding: 10px 20px;
        border-radius: 25px;
        transition: all 0.3s ease;
        font-weight: 500;
        border: 2px solid transparent;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .nav-links a:hover {
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
    }
    
    .nav-links a.active {
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
    }
    
    .profile-section {
        display: flex;
        align-items: center;
        gap: 15px;
        margin-left: 25px;
        padding-left: 25px;
        border-left: 1px solid rgba(44, 62, 80, 0.2);
    }
    
    .profile-picture {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #3498db;
        background: #fff;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    
    .profile-picture:hover {
        transform: scale(1.1) rotate(5deg);
        box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
        border-color: #2980b9;
    }
    
    .profile-initials {
        width: 45px;
        height: 45px;
        border-radius: 50%;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 18px;
        border: 2px solid rgba(255,255,255,0.3);
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        position: relative;
        overflow: hidden;
    }
    
    .profile-initials:hover {
        transform: scale(1.1) rotate(5deg);
        box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        border-color: rgba(255,255,255,0.5);
    }
    
    .profile-info {
        display: flex;
        flex-direction: column;
    }
    
    .profile-name {
        font-weight: 600;
        font-size: 14px;
        color: #2c3e50;
    }
    
    .profile-role {
        font-size: 12px;
        color: #7f8c8d;
    }
    
    .form-container {
        background: rgba(255, 255, 255, 0.95);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        animation: fadeInUp 0.8s ease-out;
        position: relative;
        overflow: hidden;
    }
    
    .form-container::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .form-container:hover::before {
        left: 100%;
    }
    
    .form-title {
        color: #2c3e50;
        margin-bottom: 30px;
        text-align: center;
        font-size: 2.2rem;
        font-weight: 700;
        background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        position: relative;
        padding-bottom: 15px;
    }
    
    .form-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 100px;
        height: 4px;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        border-radius: 2px;
    }
    
    .form-section {
        margin-bottom: 35px;
        padding: 30px;
        border-radius: 16px;
        background: rgba(248, 249, 250, 0.7);
        border: 1px solid rgba(255,255,255,0.5);
        box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }
    
    .form-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 5px;
        height: 100%;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
    }
    
    .form-section:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(52, 152, 219, 0.15);
    }
    
    .section-title {
        color: #2c3e50;
        margin-bottom: 25px;
        font-size: 1.4rem;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 12px;
        background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .section-title i {
        font-size: 1.2rem;
    }
    
    .employee-id-display {
        background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
        padding: 25px;
        border-radius: 16px;
        margin-bottom: 30px;
        text-align: center;
        border: 2px dashed #3498db;
        animation: pulse 2s infinite;
        position: relative;
        overflow: hidden;
    }
    
    .employee-id-label {
        font-weight: 600;
        color: #2c3e50;
        margin-right: 15px;
        font-size: 1.1rem;
    }
    
    .employee-id-value {
        font-size: 1.8rem;
        font-weight: 800;
        color: #3498db;
        background: rgba(255,255,255,0.9);
        padding: 12px 25px;
        border-radius: 12px;
        border: 2px solid #3498db;
        display: inline-block;
        margin-top: 10px;
        box-shadow: 0 4px 15px rgba(52, 152, 219, 0.2);
        transition: all 0.3s ease;
    }
    
    .employee-id-value:hover {
        transform: scale(1.05);
        box-shadow: 0 6px 20px rgba(52, 152, 219, 0.3);
    }
    
    .form-hint {
        font-size: 0.85rem;
        color: #7f8c8d;
        margin-top: 8px;
        font-style: italic;
    }
    
    .form-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 25px;
        margin-bottom: 25px;
    }
    
    .form-group {
        margin-bottom: 0;
        display: flex;
        flex-direction: column;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #2c3e50;
        font-size: 0.95rem;
    }
    
    .required::after {
        content: " *";
        color: #e74c3c;
    }
    
    .form-group input[type="text"],
    .form-group input[type="email"],
    .form-group input[type="tel"],
    .form-group input[type="date"],
    .form-group input[type="number"],
    .form-group input[type="file"],
    .form-group select,
    .form-group textarea {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #e0e0e0;
        border-radius: 12px;
        box-sizing: border-box;
        font-size: 15px;
        font-family: 'Poppins', sans-serif;
        transition: all 0.3s ease;
        background: rgba(255,255,255,0.9);
    }
    
     .form-group input:-webkit-autofill,
     .form-group input:-webkit-autofill:hover, 
     .form-group input:-webkit-autofill:focus,
     .form-group input:-webkit-autofill:active,
     .form-group textarea:-webkit-autofill,
     .form-group textarea:-webkit-autofill:hover,
     .form-group textarea:-webkit-autofill:focus,
     .form-group textarea:-webkit-autofill:active {
         -webkit-text-fill-color: #2c3e50 !important;
         -webkit-box-shadow: 0 0 0px 1000px rgba(255,255,255,0.9) inset !important;
         transition: background-color 5000s ease-in-out 0s;
     }

     .form-group input[type="text"],
     .form-group input[type="email"],
     .form-group input[type="tel"],
     .form-group input[type="date"],
     .form-group input[type="number"],
     .form-group select,
     .form-group textarea {
         color: #2c3e50 !important;
     }
    
    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
        outline: none;
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        transform: translateY(-2px);
    }
    
    .form-group textarea {
        resize: vertical;
        min-height: 100px;
    }
    
    .auto-generated {
        background: #f8f9fa !important;
        color: #6c757d !important;
        font-weight: 600;
        border-color: #dee2e6 !important;
    }
    
    .btn-group {
        display: flex;
        gap: 20px;
        justify-content: center;
        margin-top: 40px;
    }
    
    .btn {
        padding: 16px 40px;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 600;
        transition: all 0.4s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        min-width: 160px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        position: relative;
        overflow: hidden;
    }
    
    .btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        transition: left 0.5s;
    }
    
    .btn:hover::before {
        left: 100%;
    }
    
    .btn-secondary {
        background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
        color: white;
    }
    
    .btn-secondary:hover {
        background: linear-gradient(135deg, #5a6268 0%, #343a40 100%);
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
    }
    
    .btn-success {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
    }
    
    .btn-success:hover {
        background: linear-gradient(135deg, #218838 0%, #1e9e8a 100%);
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
    }
    
    .btn-warning {
        background: linear-gradient(135deg, #ffc107 0%, #ffca2c 100%);
        color: #212529;
    }
    
    .btn-warning:hover {
        background: linear-gradient(135deg, #e0a800 0%, #ffc720 100%);
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(255, 193, 7, 0.3);
    }
    
    .salary-calculator {
        background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
        padding: 25px;
        border-radius: 12px;
        margin-top: 15px;
        border-left: 4px solid #3498db;
    }
    
    .salary-result {
        font-weight: 700;
        color: #2c3e50;
        margin-top: 15px;
        font-size: 1.1rem;
        text-align: center;
        padding: 12px;
        background: rgba(255,255,255,0.7);
        border-radius: 8px;
        border: 2px solid #3498db;
    }
    
    .file-upload-container {
        border: 3px dashed #3498db;
        border-radius: 16px;
        padding: 30px;
        text-align: center;
        background: rgba(248, 249, 250, 0.7);
        transition: all 0.4s ease;
        position: relative;
        cursor: pointer;
    }
    
    .file-upload-container.dragover {
        background: rgba(227, 242, 253, 0.7);
        border-color: #2980b9;
        border-style: solid;
        transform: scale(1.02);
    }
    
    .file-upload-container.has-file {
        border-color: #28a745;
        background: rgba(240, 255, 244, 0.7);
        border-style: solid;
    }
    
    .file-upload-icon {
        font-size: 3.5rem;
        color: #3498db;
        margin-bottom: 15px;
        transition: all 0.3s ease;
    }
    
    .file-upload-container:hover .file-upload-icon {
        transform: scale(1.1);
    }
    
    .file-input {
        display: none;
    }
    
    .file-upload-btn {
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        margin: 15px 0;
        font-size: 15px;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
    }
    
    .file-upload-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
    }
    
    .file-info {
        margin-top: 20px;
        padding: 20px;
        background: rgba(255,255,255,0.9);
        border-radius: 12px;
        border: 2px solid #28a745;
        text-align: left;
        animation: slideDown 0.3s ease-out;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    
    .file-name-display {
        font-weight: 700;
        color: #155724;
        font-size: 1.1rem;
        margin-bottom: 8px;
        word-break: break-all;
    }
    
    .file-details {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 12px;
        flex-wrap: wrap;
        gap: 10px;
    }
    
    .file-size {
        color: #6c757d;
        font-size: 0.9rem;
        font-weight: 500;
    }
    
    .file-type {
        color: #3498db;
        font-size: 0.85rem;
        background: rgba(52, 152, 219, 0.1);
        padding: 4px 12px;
        border-radius: 20px;
        font-weight: 600;
    }
    
    .remove-file-btn {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        border: none;
        padding: 8px 16px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 0.85rem;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .remove-file-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
    }
    
    .selected-file-indicator {
        position: absolute;
        top: -12px;
        right: -12px;
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        border-radius: 50%;
        width: 28px;
        height: 28px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 0.8rem;
        font-weight: bold;
        box-shadow: 0 3px 10px rgba(40, 167, 69, 0.4);
        animation: pulse 1.5s infinite;
    }
    
    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    @keyframes pulse {
        0% {
            transform: scale(1);
            box-shadow: 0 0 0 0 rgba(52, 152, 219, 0.7);
        }
        70% {
            transform: scale(1.05);
            box-shadow: 0 0 0 10px rgba(52, 152, 219, 0);
        }
        100% {
            transform: scale(1);
            box-shadow: 0 0 0 0 rgba(52, 152, 219, 0);
        }
    }
    
    @media (max-width: 768px) {
        .header {
            padding: 15px 20px;
            flex-direction: column;
            height: auto;
            gap: 15px;
        }
        
        .nav-links {
            gap: 5px;
        }
        
        .nav-links a {
            padding: 8px 15px;
            font-size: 0.9rem;
        }
        
        .container {
            margin: 140px auto 30px auto;
        }
        
        .worksphere-text {
            font-size: 1.5rem;
        }
        
        .pro-text {
            font-size: 1.2rem;
        }
        
        .logo-tagline {
            font-size: 0.6rem;
        }
        
        .profile-section {
            margin-left: 0;
            padding-left: 0;
            border-left: none;
        }
        
        .form-container {
            padding: 25px;
        }
        
        .form-row {
            grid-template-columns: 1fr;
        }
        
        .btn-group {
            flex-direction: column;
        }
        
        .btn {
            width: 100%;
        }
        
        .file-details {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .remove-file-btn {
            margin-top: 10px;
        }
    }
</style>
</head>
<body>

<div class="message-container" id="messageContainer">
    <% if (message != null) { %>
        <div class="message-success" id="successMessage">
            <i class="fas fa-check-circle message-icon"></i>
            <%= message %>
        </div>
    <% } %>
    <% if (error != null) { %>
        <div class="message-error" id="errorMessage">
            <i class="fas fa-exclamation-triangle message-icon"></i>
            <%= error %>
        </div>
    <% } %>
</div>

<div class="header">
    <a href="AdminHomeServlet" class="logo-container">
        <div class="logo-icon">
            <i class="fas fa-globe-americas"></i>
        </div>
        <div class="logo-text">
            <div class="logo-main">
                <span class="worksphere-text">WorkSphere</span>
                <span class="pro-text">Pro</span>
            </div>
            <div class="logo-tagline">Enterprise Suite</div>
        </div>
    </a>
    
    <div class="nav-links">
        <a href="AdminHomeServlet">
            <i class="fas fa-home"></i>Home
        </a>
        <a href="EmpListServlet">
            <i class="fas fa-users"></i>Employees
        </a>
        <a href="LogoutServlet">
            <i class="fas fa-sign-out-alt"></i>Sign Out
        </a>
        
        <div class="profile-section">
            <% 
            String navProfilePicture = null;
            if (currentAdmin != null && currentAdmin.getProfilePicture() != null && !currentAdmin.getProfilePicture().isEmpty()) {
                navProfilePicture = request.getContextPath() + "/uploads/profiles/" + currentAdmin.getProfilePicture() + "?v=" + System.currentTimeMillis();
            }
            %>
            
            <% if (navProfilePicture != null) { %>
                <img src="<%= navProfilePicture %>" 
                     alt="Profile Picture" 
                     class="profile-picture" 
                     id="navProfilePicture"
                     onclick="window.location.href='adminprofile.jsp'"
                     onerror="this.style.display='none'; document.getElementById('navProfileInitials').style.display='flex';">
                <div id="navProfileInitials" class="profile-initials" style="display: none; background: linear-gradient(135deg, <%= gradientColor1 %> 0%, <%= gradientColor2 %> 100%);"
                     onclick="window.location.href='adminprofile.jsp'">
                    <%= adminInitials %>
                </div>
            <% } else { %>
                <div class="profile-initials" style="background: linear-gradient(135deg, <%= gradientColor1 %> 0%, <%= gradientColor2 %> 100%);"
                     onclick="window.location.href='adminprofile.jsp'">
                    <%= adminInitials %>
                </div>
            <% } %>
            
            <div class="profile-info">
                <div class="profile-name"><%= adminName %></div>
                <div class="profile-role">Administrator</div>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="form-container">
        <h2 class="form-title">Update Employee Details</h2>
        
        <div class="employee-id-display">
            <span class="employee-id-label">Employee ID:</span>
            <div class="employee-id-value" id="displayEmpId"><%= employee.getEmp_id() != null ? employee.getEmp_id() : "N/A" %></div>
            <div class="form-hint">Employee ID cannot be changed</div>
        </div>
        
        <form action="EmpUpdateServlet" method="post" id="employeeForm" enctype="multipart/form-data" onsubmit="return validateForm()">
            <input type="hidden" name="emp_id" value="<%= employee.getEmp_id() != null ? employee.getEmp_id() : "" %>">
            
            <div class="form-section">
                <h3 class="section-title"><i class="fas fa-user-circle"></i>Personal Details</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="emp_name" class="required">Full Name</label>
                        <input type="text" id="emp_name" name="emp_name" required 
                               value="<%= employee.getEmp_name() != null ? employee.getEmp_name() : "" %>"
                               placeholder="Enter employee's full name">
                    </div>
                    <div class="form-group">
                        <label for="emp_dob" class="required">Date of Birth</label>
                        <input type="date" id="emp_dob" name="emp_dob" required
                               value="<%= employee.getEmp_dob() != null ? employee.getEmp_dob() : "" %>">
                    </div>
                    <div class="form-group">
                        <label for="gender" class="required">Gender</label>
                        <select id="gender" name="gender" required>
                            <option value="">Select Gender</option>
                            <option value="Male" <%= "Male".equals(employee.getGender()) ? "selected" : "" %>>Male</option>
                            <option value="Female" <%= "Female".equals(employee.getGender()) ? "selected" : "" %>>Female</option>
                            <option value="Other" <%= "Other".equals(employee.getGender()) ? "selected" : "" %>>Other</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3 class="section-title"><i class="fas fa-address-book"></i>Contact Details</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="emp_email" class="required">Email Address</label>
                        <input type="email" id="emp_email" name="emp_email" required 
                               value="<%= employee.getEmp_email() != null ? employee.getEmp_email() : "" %>"
                               placeholder="employee@company.com">
                    </div>
                    <div class="form-group">
                        <label for="emp_phone" class="required">Phone Number</label>
                        <input type="tel" id="emp_phone" name="emp_phone" required 
                               value="<%= employee.getEmp_phone() != null ? employee.getEmp_phone() : "" %>"
                               placeholder="+91 1234567890" pattern="[0-9]{10}">
                        <div class="form-hint">10-digit phone number without spaces</div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="address" class="required">Address</label>
                        <textarea id="address" name="address" required 
                                  placeholder="Enter complete address"><%= employee.getAddress() != null ? employee.getAddress() : "" %></textarea>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="city" class="required">City</label>
                        <input type="text" id="city" name="city" required 
                               value="<%= employee.getCity() != null ? employee.getCity() : "" %>"
                               placeholder="Enter city">
                    </div>
                    <div class="form-group">
                        <label for="state" class="required">State</label>
                        <input type="text" id="state" name="state" required 
                               value="<%= employee.getState() != null ? employee.getState() : "" %>"
                               placeholder="Enter state">
                    </div>
                    <div class="form-group">
                        <label for="pin" class="required">PIN Code</label>
                        <input type="text" id="pin" name="pin" required 
                               value="<%= employee.getPin() != null ? employee.getPin() : "" %>"
                               placeholder="6-digit PIN code" pattern="[0-9]{6}">
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3 class="section-title"><i class="fas fa-briefcase"></i>Job Details</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label for="dept" class="required">Department</label>
                        <select id="dept" name="dept" required>
                            <option value="">Select Department</option>
                            <%
                                if (departments != null && !departments.isEmpty()) {
                                    for (Department dept : departments) {
                                        boolean isSelected = dept.getName().equals(employee.getDept());
                            %>
                                <option value="<%= dept.getName() %>" <%= isSelected ? "selected" : "" %>>
                                    <%= dept.getName() %>
                                </option>
                            <%
                                    }
                                } else {
                            %>
                                <option value="IT" <%= "IT".equals(employee.getDept()) ? "selected" : "" %>>Information Technology</option>
                                <option value="HR" <%= "HR".equals(employee.getDept()) ? "selected" : "" %>>Human Resources</option>
                                <option value="Finance" <%= "Finance".equals(employee.getDept()) ? "selected" : "" %>>Finance</option>
                                <option value="Marketing" <%= "Marketing".equals(employee.getDept()) ? "selected" : "" %>>Marketing</option>
                                <option value="Sales" <%= "Sales".equals(employee.getDept()) ? "selected" : "" %>>Sales</option>
                                <option value="Operations" <%= "Operations".equals(employee.getDept()) ? "selected" : "" %>>Operations</option>
                                <option value="R&D" <%= "R&D".equals(employee.getDept()) ? "selected" : "" %>>Research & Development</option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="desg" class="required">Designation</label>
                        <input type="text" id="desg" name="desg" required 
                               value="<%= employee.getDesg() != null ? employee.getDesg() : "" %>"
                               placeholder="Enter designation">
                    </div>
                    <div class="form-group">
                        <label for="joindate" class="required">Join Date</label>
                        <input type="date" id="joindate" name="joindate" required
                               value="<%= employee.getJoindate() != null ? employee.getJoindate() : "" %>">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="emp_type" class="required">Employment Type</label>
                        <select id="emp_type" name="emp_type" required>
                            <option value="">Select Type</option>
                            <option value="Full-Time" <%= "Full-Time".equals(employee.getEmp_type()) ? "selected" : "" %>>Full-Time</option>
                            <option value="Part-Time" <%= "Part-Time".equals(employee.getEmp_type()) ? "selected" : "" %>>Part-Time</option>
                            <option value="Contract" <%= "Contract".equals(employee.getEmp_type()) ? "selected" : "" %>>Contract</option>
                            <option value="Intern" <%= "Intern".equals(employee.getEmp_type()) ? "selected" : "" %>>Intern</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="shift_time">Shift Time</label>
                        <select id="shift_time" name="shift_time">
                            <option value="">Select Shift</option>
                            <option value="Day Shift" <%= "Day Shift".equals(employee.getShift_time()) ? "selected" : "" %>>Day Shift (9 AM - 6 PM)</option>
                            <option value="Night Shift" <%= "Night Shift".equals(employee.getShift_time()) ? "selected" : "" %>>Night Shift (6 PM - 3 AM)</option>
                            <option value="Flexible" <%= "Flexible".equals(employee.getShift_time()) ? "selected" : "" %>>Flexible Hours</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3 class="section-title"><i class="fas fa-money-bill-wave"></i>Salary Details</h3>
                <div class="salary-calculator">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="basic_salary" class="required">Basic Salary</label>
                            <input type="number" id="basic_salary" name="basic_salary" 
                                   step="0.01" min="0" required 
                                   value="<%= employee.getBasic_salary() != null ? employee.getBasic_salary() : "0.00" %>"
                                   placeholder="0.00" onchange="calculateTotalSalary()">
                        </div>
                        <div class="form-group">
                            <label for="allowances">Allowances</label>
                            <input type="number" id="allowances" name="allowances" 
                                   step="0.01" min="0" 
                                   value="<%= employee.getAllowances() != null ? employee.getAllowances() : "0.00" %>"
                                   placeholder="0.00" onchange="calculateTotalSalary()">
                        </div>
                        <div class="form-group">
                            <label for="pf">PF Contribution</label>
                            <input type="number" id="pf" name="pf" 
                                   step="0.01" min="0" 
                                   value="<%= employee.getPf() != null ? employee.getPf() : "0.00" %>"
                                   placeholder="0.00" onchange="calculateTotalSalary()">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="total_salary" class="required">Total Salary</label>
                            <input type="number" id="total_salary" name="total_salary" 
                                   step="0.01" min="0" required readonly
                                   value="<%= employee.getTotal_salary() != null ? employee.getTotal_salary() : "0.00" %>"
                                   class="auto-generated">
                        </div>
                    </div>
                    <div class="salary-result" id="salaryResult">
                        Total Salary: <%= employee.getTotal_salary() != null ? salaryFormat.format(employee.getTotal_salary()) : "₹0.00" %>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <h3 class="section-title"><i class="fas fa-id-card"></i>Identity Proof Documents</h3>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="proof" class="required">Identity Proof Type</label>
                        <select id="proof" name="proof" required>
                            <option value="">Select Proof Type</option>
                            <option value="Aadhar Card" <%= "Aadhar Card".equals(employee.getProof()) ? "selected" : "" %>>Aadhar Card</option>
                            <option value="PAN Card" <%= "PAN Card".equals(employee.getProof()) ? "selected" : "" %>>PAN Card</option>
                            <option value="Passport" <%= "Passport".equals(employee.getProof()) ? "selected" : "" %>>Passport</option>
                            <option value="Driving License" <%= "Driving License".equals(employee.getProof()) ? "selected" : "" %>>Driving License</option>
                            <option value="Voter ID" <%= "Voter ID".equals(employee.getProof()) ? "selected" : "" %>>Voter ID</option>
                            <option value="Other" <%= "Other".equals(employee.getProof()) ? "selected" : "" %>>Other Government ID</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label>Upload New Identity Proof Document</label>
                    <div class="file-upload-container" id="fileUploadContainer">
                        <div class="file-upload-icon">📁</div>
                        <h4>Upload Identity Proof Document</h4>
                        <p>Current Document: <strong><%= employee.getProof() != null ? employee.getProof() : "Not specified" %></strong></p>
                        <p>Supported formats: PDF, JPG, PNG, JPEG, DOC, DOCX</p>
                        <p>Max file size: 5MB</p>
                        <input type="file" id="proof_document" name="proof_document" 
                               class="file-input" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" 
                               onchange="handleFileSelect(this)">
                        <button type="button" class="file-upload-btn" onclick="document.getElementById('proof_document').click()">
                            Choose File
                        </button>
                        
                        <div class="file-info" id="fileInfo" style="display: none;">
                            <div class="selected-file-indicator">✓</div>
                            <div class="file-name-display" id="fileNameDisplay"></div>
                            <div class="file-details">
                                <div>
                                    <span class="file-size" id="fileSizeDisplay"></span>
                                    <span class="file-type" id="fileTypeDisplay"></span>
                                </div>
                                <button type="button" class="remove-file-btn" onclick="removeFile()">
                                    Remove File
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-user-edit"></i>Update Employee
                </button>
                <button type="button" class="btn btn-secondary" onclick="showResetConfirmation()">
                    <i class="fas fa-redo"></i>Reset Changes
                </button>
                <a href="ViewEmpServlet?emp_id=<%= employee.getEmp_id() %>" class="btn btn-warning">
                    <i class="fas fa-eye"></i>View Details
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        
        const maxDob = new Date();
        maxDob.setFullYear(maxDob.getFullYear() - 18);
        document.getElementById('emp_dob').max = maxDob.toISOString().split('T')[0];
        
        calculateTotalSalary();
        initializeDragAndDrop();
        
        const successMessage = document.getElementById('successMessage');
        const errorMessage = document.getElementById('errorMessage');
        
        if (successMessage) {
            setTimeout(() => {
                successMessage.classList.add('message-hide');
                setTimeout(() => {
                    successMessage.remove();
                }, 300);
            }, 5000);
        }
        
        if (errorMessage) {
            setTimeout(() => {
                errorMessage.classList.add('message-hide');
                setTimeout(() => {
                    errorMessage.remove();
                }, 300);
            }, 5000);
        }
    });

    function calculateTotalSalary() {
        const basicSalary = parseFloat(document.getElementById('basic_salary').value) || 0;
        const allowances = parseFloat(document.getElementById('allowances').value) || 0;
        const pf = parseFloat(document.getElementById('pf').value) || 0;
        const totalSalary = basicSalary + allowances - pf;
        document.getElementById('total_salary').value = totalSalary.toFixed(2);
        document.getElementById('salaryResult').innerHTML = 'Total Salary: ₹' + totalSalary.toFixed(2);
    }

    function handleFileSelect(input) {
        const file = input.files[0];
        if (file) {
            displayFileInfo(file);
        }
    }

    function displayFileInfo(file) {
        const fileInfo = document.getElementById('fileInfo');
        const fileNameDisplay = document.getElementById('fileNameDisplay');
        const fileSizeDisplay = document.getElementById('fileSizeDisplay');
        const fileTypeDisplay = document.getElementById('fileTypeDisplay');
        const uploadContainer = document.getElementById('fileUploadContainer');
        
        fileNameDisplay.textContent = file.name;
        fileSizeDisplay.textContent = formatFileSize(file.size);
        fileTypeDisplay.textContent = getFileType(file.type);
        fileInfo.style.display = 'block';
        uploadContainer.classList.add('has-file');
    }

    function getFileType(mimeType) {
        const typeMap = {
            'application/pdf': 'PDF',
            'image/jpeg': 'JPEG Image',
            'image/jpg': 'JPG Image',
            'image/png': 'PNG Image',
            'application/msword': 'Word Document',
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document': 'Word Document'
        };
        return typeMap[mimeType] || 'Document';
    }

    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    function removeFile() {
        const fileInput = document.getElementById('proof_document');
        const fileInfo = document.getElementById('fileInfo');
        const uploadContainer = document.getElementById('fileUploadContainer');
        fileInput.value = '';
        fileInfo.style.display = 'none';
        uploadContainer.classList.remove('has-file');
    }

    function initializeDragAndDrop() {
        const container = document.getElementById('fileUploadContainer');
        const fileInput = document.getElementById('proof_document');

        container.addEventListener('dragover', function(e) {
            e.preventDefault();
            container.classList.add('dragover');
        });

        container.addEventListener('dragleave', function() {
            container.classList.remove('dragover');
        });

        container.addEventListener('drop', function(e) {
            e.preventDefault();
            container.classList.remove('dragover');
            const files = e.dataTransfer.files;
            if (files.length > 0) {
                fileInput.files = files;
                handleFileSelect(fileInput);
            }
        });
    }

    function validateForm() {
        const empDob = new Date(document.getElementById('emp_dob').value);
        const joinDate = new Date(document.getElementById('joindate').value);
        const today = new Date();
        const minDob = new Date();
        minDob.setFullYear(minDob.getFullYear() - 18);
        
        if (empDob > minDob) {
            showErrorMessage('Employee must be at least 18 years old.');
            return false;
        }
        
        if (joinDate > today) {
            showErrorMessage('Join date cannot be in the future.');
            return false;
        }
        
        if (joinDate < empDob) {
            showErrorMessage('Join date cannot be before date of birth.');
            return false;
        }
        
        const phone = document.getElementById('emp_phone').value;
        if (!/^\d{10}$/.test(phone)) {
            showErrorMessage('Please enter a valid 10-digit phone number.');
            return false;
        }
        
        const pin = document.getElementById('pin').value;
        if (!/^\d{6}$/.test(pin)) {
            showErrorMessage('Please enter a valid 6-digit PIN code.');
            return false;
        }
        
        const basicSalary = parseFloat(document.getElementById('basic_salary').value);
        if (basicSalary < 0) {
            showErrorMessage('Basic salary cannot be negative.');
            return false;
        }
        
        const proofType = document.getElementById('proof').value;
        const proofDocument = document.getElementById('proof_document').files[0];
        
        if (!proofType) {
            showErrorMessage('Please select an identity proof type.');
            return false;
        }
        
        if (proofDocument) {
            if (proofDocument.size > 5 * 1024 * 1024) {
                showErrorMessage('File size must be less than 5MB.');
                return false;
            }
            
            const allowedTypes = [
                'application/pdf', 
                'image/jpeg', 
                'image/jpg', 
                'image/png',
                'application/msword',
                'application/vnd.openxmlformats-officedocument.wordprocessingml.document'
            ];
            if (!allowedTypes.includes(proofDocument.type)) {
                showErrorMessage('Please upload a PDF, JPG, PNG, or Word document.');
                return false;
            }
        }
        
        return true;
    }

    function showResetConfirmation() {
        const resetMessage = document.createElement('div');
        resetMessage.className = 'message-info';
        resetMessage.innerHTML = `
            <i class="fas fa-info-circle message-icon"></i>
            Are you sure you want to reset all changes? All modifications will be lost.
            <div style="margin-top: 10px; display: flex; gap: 10px; justify-content: center;">
                <button type="button" class="btn btn-success" style="padding: 8px 16px; font-size: 14px;" onclick="resetForm()">Yes, Reset</button>
                <button type="button" class="btn btn-secondary" style="padding: 8px 16px; font-size: 14px;" onclick="this.parentElement.parentElement.remove()">Cancel</button>
            </div>
        `;
        
        const messageContainer = document.getElementById('messageContainer');
        messageContainer.appendChild(resetMessage);
        
        setTimeout(() => {
            if (resetMessage.parentElement) {
                resetMessage.classList.add('message-hide');
                setTimeout(() => {
                    if (resetMessage.parentElement) {
                        resetMessage.remove();
                    }
                }, 300);
            }
        }, 5000);
    }

    function resetForm() {
        document.getElementById('employeeForm').reset();
        removeFile();
        calculateTotalSalary();
        
        const messageContainer = document.getElementById('messageContainer');
        const existingMessages = messageContainer.querySelectorAll('.message-info, .message-error');
        existingMessages.forEach(msg => msg.remove());
        
        const resetSuccess = document.createElement('div');
        resetSuccess.className = 'message-success';
        resetSuccess.innerHTML = `
            <i class="fas fa-check-circle message-icon"></i>
            Form has been reset successfully.
        `;
        messageContainer.appendChild(resetSuccess);
        
        setTimeout(() => {
            resetSuccess.classList.add('message-hide');
            setTimeout(() => {
                resetSuccess.remove();
            }, 300);
        }, 3000);
    }

    function showErrorMessage(message) {
        const messageContainer = document.getElementById('messageContainer');
        const existingError = messageContainer.querySelector('.message-error');
        if (existingError) {
            existingError.remove();
        }
        
        const errorMessage = document.createElement('div');
        errorMessage.className = 'message-error';
        errorMessage.innerHTML = `
            <i class="fas fa-exclamation-triangle message-icon"></i>
            ${message}
        `;
        messageContainer.appendChild(errorMessage);
        
        setTimeout(() => {
            errorMessage.classList.add('message-hide');
            setTimeout(() => {
                errorMessage.remove();
            }, 300);
        }, 5000);
    }

    document.getElementById('emp_phone').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 10) value = value.substring(0, 10);
        e.target.value = value;
    });

    document.getElementById('pin').addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 6) value = value.substring(0, 6);
        e.target.value = value;
    });
</script>

</body>
</html>