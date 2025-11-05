<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Details</title>
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
    
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .page-title {
        color: #333;
        margin: 0;
    }
    
    .btn {
        display: inline-block;
        background: #007bff;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        font-size: 14px;
        transition: background 0.3s;
        margin-left: 10px;
    }
    
    .btn:hover {
        background: #0056b3;
    }
    
    .btn-success {
        background: #28a745;
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
    
    .btn-danger {
        background: #dc3545;
    }
    
    .btn-danger:hover {
        background: #c82333;
    }
    
    .employee-details-card {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 30px;
    }
    
    .employee-header {
        display: flex;
        align-items: center;
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 2px solid #f8f9fa;
    }
    
    .employee-avatar {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: #007bff;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 24px;
        margin-right: 20px;
    }
    
    .employee-basic-info h2 {
        margin: 0 0 5px 0;
        color: #333;
    }
    
    .employee-basic-info p {
        margin: 5px 0;
        color: #666;
    }
    
    .details-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
    }
    
    .detail-section {
        background: #f8f9fa;
        padding: 20px;
        border-radius: 6px;
    }
    
    .detail-section h3 {
        margin-top: 0;
        margin-bottom: 15px;
        color: #007bff;
        font-size: 18px;
        border-bottom: 1px solid #dee2e6;
        padding-bottom: 8px;
    }
    
    .detail-row {
        display: flex;
        margin-bottom: 10px;
        padding: 8px 0;
        border-bottom: 1px solid #e9ecef;
    }
    
    .detail-label {
        font-weight: bold;
        width: 120px;
        color: #555;
        font-size: 14px;
    }
    
    .detail-value {
        color: #333;
        flex: 1;
        font-size: 14px;
    }
    
    .salary-section {
        background: #fff3cd;
        border-left: 4px solid #ffc107;
    }
    
    .salary-highlight {
        background: #d4edda;
        color: #155724;
        padding: 10px;
        border-radius: 4px;
        font-weight: bold;
        text-align: center;
        margin-top: 10px;
    }
    
    .action-buttons {
        display: flex;
        gap: 10px;
        justify-content: center;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid #dee2e6;
        flex-wrap: wrap;
    }
    
    .no-data {
        text-align: center;
        padding: 40px;
        color: #666;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .status-active {
        background: #d4edda;
        color: #155724;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .status-inactive {
        background: #f8d7da;
        color: #721c24;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .proof-section {
        background: #e7f3ff;
        border-left: 4px solid #007bff;
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
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    
    DecimalFormat salaryFormat = new DecimalFormat("₹ #,##0.00");
    
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

    <% if (message != null) { %>
        <div style="background: #d4edda; color: #155724; padding: 15px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
            <%= message %>
        </div>
    <% } %>
    
    <% if (error != null) { %>
        <div style="background: #f8d7da; color: #721c24; padding: 15px; border-radius: 4px; margin-bottom: 20px; border: 1px solid #f5c6cb;">
            <%= error %>
        </div>
    <% } %>

    <% if (employee != null) { 
        String initials = "";
        if (employee.getEmp_name() != null && !employee.getEmp_name().trim().isEmpty()) {
            String[] nameParts = employee.getEmp_name().split(" ");
            if (nameParts.length >= 2) {
                initials = nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1);
            } else {
                initials = employee.getEmp_name().substring(0, Math.min(2, employee.getEmp_name().length()));
            }
            initials = initials.toUpperCase();
        } else {
            initials = "NA";
        }
        
        String statusClass = "status-active";
        String statusText = "Active";
        if ("inactive".equals(employee.getStatus())) {
            statusClass = "status-inactive";
            statusText = "Inactive";
        }
    %>
    
    <div class="employee-details-card">
        <div class="employee-header">
            <div class="employee-avatar">
                <%= initials %>
            </div>
            <div class="employee-basic-info">
                <h2><%= employee.getEmp_name() != null ? employee.getEmp_name() : "N/A" %></h2>
                <p><strong>Employee ID:</strong> <%= employee.getEmp_id() != null ? employee.getEmp_id() : "N/A" %></p>
                <p><strong>Phone:</strong> <%= employee.getEmp_phone() != null ? employee.getEmp_phone() : "N/A" %></p>
                <p><strong>Department:</strong> <%= employee.getDept() != null ? employee.getDept() : "N/A" %></p>
                <p><span class="<%= statusClass %>"><%= statusText %></span></p>
            </div>
        </div>

        <div class="details-grid">
            <div class="detail-section">
                <h3>Personal Information</h3>
                <div class="detail-row">
                    <span class="detail-label">Full Name:</span>
                    <span class="detail-value"><%= employee.getEmp_name() != null ? employee.getEmp_name() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Date of Birth:</span>
                    <span class="detail-value"><%= employee.getEmp_dob() != null ? employee.getEmp_dob() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Gender:</span>
                    <span class="detail-value"><%= employee.getGender() != null ? employee.getGender() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Email:</span>
                    <span class="detail-value"><%= employee.getEmp_email() != null ? employee.getEmp_email() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Phone:</span>
                    <span class="detail-value"><%= employee.getEmp_phone() != null ? employee.getEmp_phone() : "Not provided" %></span>
                </div>
            </div>

            <div class="detail-section">
                <h3>Employment Details</h3>
                <div class="detail-row">
                    <span class="detail-label">Employee ID:</span>
                    <span class="detail-value"><%= employee.getEmp_id() != null ? employee.getEmp_id() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Department:</span>
                    <span class="detail-value"><%= employee.getDept() != null ? employee.getDept() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Designation:</span>
                    <span class="detail-value"><%= employee.getDesg() != null ? employee.getDesg() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Join Date:</span>
                    <span class="detail-value"><%= employee.getJoindate() != null ? employee.getJoindate() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Employment Type:</span>
                    <span class="detail-value"><%= employee.getEmp_type() != null ? employee.getEmp_type() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Shift Time:</span>
                    <span class="detail-value"><%= employee.getShift_time() != null ? employee.getShift_time() : "Not provided" %></span>
                </div>
            </div>
        </div>

        <div class="detail-section">
            <h3>Address Information</h3>
            <div class="detail-row">
                <span class="detail-label">Address:</span>
                <span class="detail-value"><%= employee.getAddress() != null ? employee.getAddress() : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">City:</span>
                <span class="detail-value"><%= employee.getCity() != null ? employee.getCity() : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">State:</span>
                <span class="detail-value"><%= employee.getState() != null ? employee.getState() : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">PIN Code:</span>
                <span class="detail-value"><%= employee.getPin() != null ? employee.getPin() : "Not provided" %></span>
            </div>
        </div>

        <div class="detail-section salary-section">
            <h3>Salary Details</h3>
            <div class="detail-row">
                <span class="detail-label">Basic Salary:</span>
                <span class="detail-value"><%= employee.getBasic_salary() != null ? salaryFormat.format(employee.getBasic_salary()) : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Allowances:</span>
                <span class="detail-value"><%= employee.getAllowances() != null ? salaryFormat.format(employee.getAllowances()) : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">PF Deduction:</span>
                <span class="detail-value"><%= employee.getPf() != null ? salaryFormat.format(employee.getPf()) : "Not provided" %></span>
            </div>
            <div class="salary-highlight">
                Total Salary: <%= employee.getTotal_salary() != null ? salaryFormat.format(employee.getTotal_salary()) : "Not provided" %>
            </div>
        </div>

        <div class="detail-section proof-section">
            <h3>Additional Information</h3>
            <div class="detail-row">
                <span class="detail-label">Identity Proof:</span>
                <span class="detail-value"><%= employee.getProof() != null ? employee.getProof() : "Not provided" %></span>
            </div>
        </div>

        <div class="action-buttons">
            <a href="EmpUpdateServlet?emp_id=<%= employee.getEmp_id() %>" class="btn btn-warning">Edit Employee</a>
        </div>
    </div>

    <% } else { %>
        <div class="no-data">
            <h3>Employee Not Found</h3>
            <p>The requested employee could not be found.</p>
            <a href="EmpListServlet" class="btn">Back to Employee List</a>
        </div>
    <% } %>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const detailSections = document.querySelectorAll('.detail-section');
        detailSections.forEach(section => {
            section.style.opacity = '0';
            section.style.transform = 'translateY(20px)';
            
            setTimeout(() => {
                section.style.transition = 'all 0.5s ease';
                section.style.opacity = '1';
                section.style.transform = 'translateY(0)';
            }, 100);
        });
    });
</script>

</body>
</html> --%>









<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    if (currentAdmin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    Employee employee = (Employee) request.getAttribute("employee");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    
    DecimalFormat salaryFormat = new DecimalFormat("₹ #,##0.00");
    
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
<title>WorkSphere Pro - Employee Details</title>
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
    
    .message-success, .message-error {
        padding: 15px 20px 15px 50px;
        border-radius: 8px;
        text-align: left;
        font-weight: 500;
        margin-bottom: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        animation: slideDown 0.3s ease-out;
        position: relative;
    }
    
    .message-success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    
    .message-error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
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
    
    .page-header {
        background: rgba(255, 255, 255, 0.95);
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        margin-bottom: 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        animation: fadeInUp 0.8s ease-out;
        position: relative;
        overflow: hidden;
    }
    
    .page-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .page-header:hover::before {
        left: 100%;
    }
    
    .page-title {
        color: #2c3e50;
        margin: 0;
        font-size: 2.2rem;
        font-weight: 700;
        background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        position: relative;
        padding-bottom: 10px;
    }
    
    .page-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 80px;
        height: 4px;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        border-radius: 2px;
    }
    
    .btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        padding: 12px 24px;
        text-decoration: none;
        border-radius: 12px;
        border: none;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: all 0.4s ease;
        box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
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
    
    .btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
    }
    
    .btn-success {
        background: linear-gradient(135deg, #28a745 0%, #218838 100%);
        box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
    }
    
    .btn-success:hover {
        box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
    }
    
    .btn-warning {
        background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
        color: #212529;
        box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
    }
    
    .btn-warning:hover {
        box-shadow: 0 8px 25px rgba(255, 193, 7, 0.4);
    }
    
    .btn-danger {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
    }
    
    .btn-danger:hover {
        box-shadow: 0 8px 25px rgba(220, 53, 69, 0.4);
    }
    
    .btn-info {
        background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
        box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);
    }
    
    .btn-info:hover {
        box-shadow: 0 8px 25px rgba(23, 162, 184, 0.4);
    }
    
    .btn-secondary {
        background: linear-gradient(135deg, #6c757d 0%, #545b62 100%);
        box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
    }
    
    .btn-secondary:hover {
        box-shadow: 0 8px 25px rgba(108, 117, 125, 0.4);
    }
    
    .employee-details-card {
        background: rgba(255, 255, 255, 0.95);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        margin-bottom: 30px;
        animation: fadeInUp 0.8s ease-out 0.2s both;
        position: relative;
        overflow: hidden;
    }
    
    .employee-details-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .employee-details-card:hover::before {
        left: 100%;
    }
    
    .employee-header {
        display: flex;
        align-items: center;
        margin-bottom: 40px;
        padding-bottom: 30px;
        border-bottom: 2px solid rgba(233, 236, 239, 0.7);
        animation: fadeInUp 0.8s ease-out 0.4s both;
    }
    
    .employee-avatar {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 32px;
        margin-right: 30px;
        box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
        transition: all 0.4s ease;
        position: relative;
        overflow: hidden;
    }
    
    .employee-avatar::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        transition: left 0.5s;
    }
    
    .employee-avatar:hover::before {
        left: 100%;
    }
    
    .employee-avatar:hover {
        transform: scale(1.05) rotate(5deg);
        box-shadow: 0 12px 35px rgba(52, 152, 219, 0.4);
    }
    
    .employee-basic-info h2 {
        margin: 0 0 10px 0;
        font-size: 2.2rem;
        font-weight: 700;
        background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .employee-basic-info p {
        margin: 8px 0;
        color: #7f8c8d;
        font-size: 1rem;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .details-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }
    
    .detail-section {
        background: rgba(248, 249, 250, 0.7);
        padding: 25px;
        border-radius: 16px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        transition: all 0.4s ease;
        position: relative;
        overflow: hidden;
        animation: fadeInUp 0.8s ease-out 0.6s both;
    }
    
    .detail-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .detail-section:hover::before {
        left: 100%;
    }
    
    .detail-section:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(52, 152, 219, 0.15);
    }
    
    .detail-section h3 {
        margin-top: 0;
        margin-bottom: 20px;
        color: #2c3e50;
        font-size: 1.3rem;
        font-weight: 600;
        border-bottom: 2px solid rgba(52, 152, 219, 0.2);
        padding-bottom: 12px;
        position: relative;
    }
    
    .detail-section h3::after {
        content: '';
        position: absolute;
        bottom: -2px;
        left: 0;
        width: 50px;
        height: 2px;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        border-radius: 1px;
    }
    
    .detail-row {
        display: flex;
        margin-bottom: 15px;
        padding: 12px 0;
        border-bottom: 1px solid rgba(233, 236, 239, 0.7);
        transition: all 0.3s ease;
    }
    
    .detail-row:hover {
        background: rgba(255, 255, 255, 0.5);
        border-radius: 8px;
        padding: 12px;
        transform: translateX(5px);
    }
    
    .detail-label {
        font-weight: 600;
        width: 150px;
        color: #2c3e50;
        font-size: 0.95rem;
        flex-shrink: 0;
    }
    
    .detail-value {
        color: #7f8c8d;
        flex: 1;
        font-size: 0.95rem;
        font-weight: 500;
    }
    
    .salary-section {
        background: linear-gradient(135deg, rgba(255, 243, 205, 0.7) 0%, rgba(255, 234, 167, 0.7) 100%);
        border-left: 4px solid #ffc107;
    }
    
    .salary-highlight {
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        color: #155724;
        padding: 15px;
        border-radius: 12px;
        font-weight: 700;
        text-align: center;
        margin-top: 15px;
        font-size: 1.2rem;
        box-shadow: 0 4px 12px rgba(40, 167, 69, 0.2);
        transition: all 0.3s ease;
    }
    
    .salary-highlight:hover {
        transform: scale(1.02);
        box-shadow: 0 6px 20px rgba(40, 167, 69, 0.3);
    }
    
    .action-buttons {
        display: flex;
        gap: 15px;
        justify-content: center;
        margin-top: 40px;
        padding-top: 30px;
        border-top: 1px solid rgba(222, 226, 230, 0.5);
        flex-wrap: wrap;
        animation: fadeInUp 0.8s ease-out 0.8s both;
    }
    
    .no-data {
        text-align: center;
        padding: 60px 40px;
        color: #7f8c8d;
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
    }
    
    .no-data h3 {
        font-size: 1.8rem;
        margin-bottom: 15px;
        color: #2c3e50;
    }
    
    .no-data p {
        font-size: 1.1rem;
        margin-bottom: 25px;
    }
    
    .status-active {
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        color: #155724;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-block;
        box-shadow: 0 2px 8px rgba(40, 167, 69, 0.2);
    }
    
    .status-inactive {
        background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
        color: #721c24;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.85rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-block;
        box-shadow: 0 2px 8px rgba(220, 53, 69, 0.2);
    }
    
    .proof-section {
        background: linear-gradient(135deg, rgba(231, 243, 255, 0.7) 0%, rgba(206, 229, 255, 0.7) 100%);
        border-left: 4px solid #3498db;
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
    
    @keyframes float {
        0%, 100% {
            transform: translateY(0);
        }
        50% {
            transform: translateY(-8px);
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
        
        .page-header {
            flex-direction: column;
            gap: 20px;
            align-items: flex-start;
            padding: 25px;
        }
        
        .employee-header {
            flex-direction: column;
            text-align: center;
            gap: 20px;
        }
        
        .employee-avatar {
            margin-right: 0;
        }
        
        .details-grid {
            grid-template-columns: 1fr;
        }
        
        .detail-row {
            flex-direction: column;
            gap: 5px;
        }
        
        .detail-label {
            width: 100%;
        }
        
        .action-buttons {
            flex-direction: column;
            align-items: center;
        }
        
        .btn {
            width: 100%;
            max-width: 250px;
            justify-content: center;
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
        <a href="EmpListServlet" class="active">
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

    <div class="page-header">
        <h1 class="page-title">Employee Details</h1>
        <a href="EmpListServlet" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i>Back to Employees
        </a>
    </div>

    <% if (employee != null) { 
        String initials = "";
        if (employee.getEmp_name() != null && !employee.getEmp_name().trim().isEmpty()) {
            String[] nameParts = employee.getEmp_name().split(" ");
            if (nameParts.length >= 2) {
                initials = nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1);
            } else {
                initials = employee.getEmp_name().substring(0, Math.min(2, employee.getEmp_name().length()));
            }
            initials = initials.toUpperCase();
        } else {
            initials = "NA";
        }
        
        String statusClass = "status-active";
        String statusText = "Active";
        if ("inactive".equals(employee.getStatus())) {
            statusClass = "status-inactive";
            statusText = "Inactive";
        }
    %>
    
    <div class="employee-details-card">
        <div class="employee-header">
            <div class="employee-avatar">
                <%= initials %>
            </div>
            <div class="employee-basic-info">
                <h2><%= employee.getEmp_name() != null ? employee.getEmp_name() : "N/A" %></h2>
                <p><i class="fas fa-id-card"></i><strong>Employee ID:</strong> <%= employee.getEmp_id() != null ? employee.getEmp_id() : "N/A" %></p>
                <p><i class="fas fa-phone"></i><strong>Phone:</strong> <%= employee.getEmp_phone() != null ? employee.getEmp_phone() : "N/A" %></p>
                <p><i class="fas fa-building"></i><strong>Department:</strong> <%= employee.getDept() != null ? employee.getDept() : "N/A" %></p>
                <p><span class="<%= statusClass %>"><i class="fas fa-circle"></i><%= statusText %></span></p>
            </div>
        </div>

        <div class="details-grid">
            <div class="detail-section">
                <h3><i class="fas fa-user"></i> Personal Information</h3>
                <div class="detail-row">
                    <span class="detail-label">Full Name:</span>
                    <span class="detail-value"><%= employee.getEmp_name() != null ? employee.getEmp_name() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Date of Birth:</span>
                    <span class="detail-value"><%= employee.getEmp_dob() != null ? employee.getEmp_dob() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Gender:</span>
                    <span class="detail-value"><%= employee.getGender() != null ? employee.getGender() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Email:</span>
                    <span class="detail-value"><%= employee.getEmp_email() != null ? employee.getEmp_email() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Phone:</span>
                    <span class="detail-value"><%= employee.getEmp_phone() != null ? employee.getEmp_phone() : "Not provided" %></span>
                </div>
            </div>

            <div class="detail-section">
                <h3><i class="fas fa-briefcase"></i> Employment Details</h3>
                <div class="detail-row">
                    <span class="detail-label">Employee ID:</span>
                    <span class="detail-value"><%= employee.getEmp_id() != null ? employee.getEmp_id() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Department:</span>
                    <span class="detail-value"><%= employee.getDept() != null ? employee.getDept() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Designation:</span>
                    <span class="detail-value"><%= employee.getDesg() != null ? employee.getDesg() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Join Date:</span>
                    <span class="detail-value"><%= employee.getJoindate() != null ? employee.getJoindate() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Employment Type:</span>
                    <span class="detail-value"><%= employee.getEmp_type() != null ? employee.getEmp_type() : "Not provided" %></span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Shift Time:</span>
                    <span class="detail-value"><%= employee.getShift_time() != null ? employee.getShift_time() : "Not provided" %></span>
                </div>
            </div>
        </div>

        <div class="detail-section">
            <h3><i class="fas fa-map-marker-alt"></i> Address Information</h3>
            <div class="detail-row">
                <span class="detail-label">Address:</span>
                <span class="detail-value"><%= employee.getAddress() != null ? employee.getAddress() : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">City:</span>
                <span class="detail-value"><%= employee.getCity() != null ? employee.getCity() : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">State:</span>
                <span class="detail-value"><%= employee.getState() != null ? employee.getState() : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">PIN Code:</span>
                <span class="detail-value"><%= employee.getPin() != null ? employee.getPin() : "Not provided" %></span>
            </div>
        </div>

        <div class="detail-section salary-section">
            <h3><i class="fas fa-money-bill-wave"></i> Salary Details</h3>
            <div class="detail-row">
                <span class="detail-label">Basic Salary:</span>
                <span class="detail-value"><%= employee.getBasic_salary() != null ? salaryFormat.format(employee.getBasic_salary()) : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">Allowances:</span>
                <span class="detail-value"><%= employee.getAllowances() != null ? salaryFormat.format(employee.getAllowances()) : "Not provided" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">PF Deduction:</span>
                <span class="detail-value"><%= employee.getPf() != null ? salaryFormat.format(employee.getPf()) : "Not provided" %></span>
            </div>
            <div class="salary-highlight">
                Total Salary: <%= employee.getTotal_salary() != null ? salaryFormat.format(employee.getTotal_salary()) : "Not provided" %>
            </div>
        </div>

        <div class="detail-section proof-section">
            <h3><i class="fas fa-info-circle"></i> Additional Information</h3>
            <div class="detail-row">
                <span class="detail-label">Identity Proof:</span>
                <span class="detail-value"><%= employee.getProof() != null ? employee.getProof() : "Not provided" %></span>
            </div>
        </div>

        <div class="action-buttons">
            <a href="EmpUpdateServlet?emp_id=<%= employee.getEmp_id() %>" class="btn btn-warning">
                <i class="fas fa-edit"></i>Edit Employee
            </a>
        </div>
    </div>

    <% } else { %>
        <div class="no-data">
            <h3>Employee Not Found</h3>
            <p>The requested employee could not be found.</p>
            <a href="EmpListServlet" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>Back to Employee List
            </a>
        </div>
    <% } %>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const successMessage = document.getElementById('successMessage');
        const errorMessage = document.getElementById('errorMessage');
        const messageContainer = document.getElementById('messageContainer');
        
        function hideMessage(messageElement) {
            if (messageElement) {
                messageElement.classList.add('message-hide');
                setTimeout(() => {
                    messageElement.remove();
                    if (messageContainer && messageContainer.children.length === 0) {
                        messageContainer.remove();
                    }
                }, 200);
            }
        }
        
        if (successMessage) {
            setTimeout(() => {
                hideMessage(successMessage);
            }, 2000);
        }
        
        if (errorMessage) {
            setTimeout(() => {
                hideMessage(errorMessage);
            }, 2000);
        }
        
        if (successMessage) {
            successMessage.addEventListener('click', function() {
                hideMessage(successMessage);
            });
        }
        
        if (errorMessage) {
            errorMessage.addEventListener('click', function() {
                hideMessage(errorMessage);
            });
        }
        
        setInterval(() => {
            const profileImg = document.getElementById('navProfilePicture');
            if (profileImg && profileImg.src) {
                const newSrc = profileImg.src.split('?')[0] + '?v=' + new Date().getTime();
                profileImg.src = newSrc;
            }
        }, 120000);
    });
</script>

</body>
</html>