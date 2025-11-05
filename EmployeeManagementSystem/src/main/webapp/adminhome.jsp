<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.ActivityLog" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WorkSphere Pro - Home</title>
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
        max-width: 1200px;
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
    
    .welcome-section {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 30px;
        text-align: center;
    }
    
    .welcome-title {
        color: #333;
        margin-bottom: 10px;
    }
    
    .welcome-subtitle {
        color: #666;
        font-size: 16px;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        text-align: center;
        transition: transform 0.3s ease;
    }
    
    .stat-card:hover {
        transform: translateY(-3px);
    }
    
    .stat-icon {
        font-size: 36px;
        margin-bottom: 15px;
    }
    
    .stat-number {
        font-size: 32px;
        font-weight: bold;
        margin-bottom: 5px;
        color: #007bff;
    }
    
    .stat-label {
        color: #666;
        font-size: 14px;
        font-weight: 500;
    }
    
    .quick-actions {
        background: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 30px;
    }
    
    .section-title {
        color: #333;
        margin-bottom: 20px;
        text-align: center;
    }
    
    .actions-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
    }
    
    .action-card {
        background: #f8f9fa;
        padding: 20px;
        border-radius: 6px;
        text-align: center;
        text-decoration: none;
        color: #333;
        transition: all 0.3s ease;
        border: 1px solid #e9ecef;
    }
    
    .action-card:hover {
        background: #007bff;
        color: white;
        transform: translateY(-2px);
    }
    
    .action-icon {
        font-size: 24px;
        margin-bottom: 10px;
    }
    
    .action-text {
        font-weight: 500;
    }
    
    .recent-activity {
        background: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .activity-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .activity-item {
        padding: 15px;
        border-bottom: 1px solid #e9ecef;
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .activity-item:last-child {
        border-bottom: none;
    }
    
    .activity-icon {
        font-size: 18px;
        color: #007bff;
        width: 30px;
        text-align: center;
    }
    
    .activity-content {
        flex: 1;
    }
    
    .activity-title {
        font-weight: bold;
        margin-bottom: 5px;
    }
    
    .activity-description {
        color: #666;
        font-size: 14px;
    }
    
    .activity-meta {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 5px;
    }
    
    .activity-admin {
        font-size: 12px;
        color: #888;
    }
    
    .activity-time {
        color: #666;
        font-size: 12px;
    }
    
    .no-activities {
        text-align: center;
        color: #666;
        padding: 40px;
        font-style: italic;
    }
    
    .activity-badge {
        display: inline-block;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 11px;
        font-weight: 500;
        margin-right: 8px;
    }
    
    .badge-login {
        background: #d4edda;
        color: #155724;
    }
    
    .badge-add {
        background: #d1ecf1;
        color: #0c5460;
    }
    
    .badge-update {
        background: #fff3cd;
        color: #856404;
    }
    
    .badge-delete {
        background: #f8d7da;
        color: #721c24;
    }
</style>
</head>
<body>

<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    List<ActivityLog> recentActivities = (List<ActivityLog>) request.getAttribute("recentActivities");
    Integer totalEmployees = (Integer) request.getAttribute("totalEmployees");
    Integer totalDepartments = (Integer) request.getAttribute("totalDepartments");

    if (currentAdmin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    if (recentActivities == null) recentActivities = new java.util.ArrayList<>();
    if (totalEmployees == null) totalEmployees = 0;
    if (totalDepartments == null) totalDepartments = 0;
    
    SimpleDateFormat timeFormat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
    
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
        <a href="AdminHomeServlet" style="background: rgba(255,255,255,0.2);">Home</a>
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
    <div class="welcome-section">
        <h1 class="welcome-title" id="greetingTitle">Welcome, <%= adminName %></h1>
        <p class="welcome-subtitle">Here's what's happening with your organization today.</p>
    </div>
    
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-number"><%= totalEmployees %></div>
            <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">💼</div>
            <div class="stat-number"><%= totalDepartments %></div>
            <div class="stat-label">Departments</div>
        </div>
    </div>
    
    <div class="quick-actions">
        <h2 class="section-title">Quick Actions</h2>
        <div class="actions-grid">
            <a href="addemp.jsp" class="action-card">
                <div class="action-icon">➕</div>
                <div class="action-text">Add Employee</div>
            </a>
            <a href="EmpListServlet" class="action-card">
                <div class="action-icon">👀</div>
                <div class="action-text">View Employees</div>
            </a>
            <a href="DepartmentServlet" class="action-card">
                <div class="action-icon">🏢</div>
                <div class="action-text">Manage Departments</div>
            </a>
            <a href="ReportsServlet" class="action-card">
                <div class="action-icon">📊</div>
                <div class="action-text">View Reports</div>
            </a>
        </div>
    </div>

    <div class="recent-activity">
        <h2 class="section-title">Recent Activity</h2>
        <% if (recentActivities != null && !recentActivities.isEmpty()) { %>
            <ul class="activity-list">
                <% for (ActivityLog activity : recentActivities) { 
                    String badgeClass = "badge-login";
                    String icon = "🔐";
                    
                    if (activity.getActionType() != null) {
                        switch(activity.getActionType().toLowerCase()) {
                            case "add":
                                badgeClass = "badge-add";
                                icon = "➕";
                                break;
                            case "update":
                                badgeClass = "badge-update";
                                icon = "✏️";
                                break;
                            case "delete":
                                badgeClass = "badge-delete";
                                icon = "🗑️";
                                break;
                            default:
                                badgeClass = "badge-login";
                                icon = "🔐";
                        }
                    }
                %>
                <li class="activity-item">
                    <div class="activity-icon"><%= icon %></div>
                    <div class="activity-content">
                        <div class="activity-title">
                            <span class="activity-badge <%= badgeClass %>">
                                <%= activity.getActionType() != null ? activity.getActionType().toUpperCase() : "ACTION" %>
                            </span>
                            <%= activity.getActionDescription() != null ? activity.getActionDescription() : "Activity performed" %>
                        </div>
                        <div class="activity-meta">
                            <% if (activity.getEmployeeName() != null && !activity.getEmployeeName().equals("System")) { %>
                                <span class="activity-admin">Employee: <%= activity.getEmployeeName() %></span>
                            <% } %>
                            <span class="activity-time">
                                <% if (activity.getTimestamp() != null) { %>
                                    <%= timeFormat.format(activity.getTimestamp()) %>
                                <% } else { %>
                                    Just now
                                <% } %>
                            </span>
                        </div>
                    </div>
                </li>
                <% } %>
            </ul>
        <% } else { %>
            <div class="no-activities">
                <p>No recent activities found. Activities will appear here as you use the system.</p>
            </div>
        <% } %>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const hour = new Date().getHours();
        const greetingTitle = document.getElementById('greetingTitle');
        let greeting = '';
        
        if (hour < 12) {
            greeting = 'Good Morning';
        } else if (hour < 18) {
            greeting = 'Good Afternoon';
        } else {
            greeting = 'Good Evening';
        }
        
        greetingTitle.textContent = greeting + ', <%= adminName %>';
        
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
</html> --%>
 
 
 
 
 
 
 
 
 
 
 
 
 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.ActivityLog" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    List<ActivityLog> recentActivities = (List<ActivityLog>) request.getAttribute("recentActivities");
    Integer totalEmployees = (Integer) request.getAttribute("totalEmployees");
    Integer totalDepartments = (Integer) request.getAttribute("totalDepartments");

    if (currentAdmin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    if (recentActivities == null) recentActivities = new java.util.ArrayList<>();
    if (totalEmployees == null) totalEmployees = 0;
    if (totalDepartments == null) totalDepartments = 0;
    
    SimpleDateFormat timeFormat = new SimpleDateFormat("MMM dd, yyyy 'at' hh:mm a");
    
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
<title>WorkSphere Pro - Dashboard</title>
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
    
    .welcome-section {
        background: rgba(255, 255, 255, 0.95);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        margin-bottom: 30px;
        text-align: center;
        animation: fadeInUp 0.8s ease-out;
        position: relative;
        overflow: hidden;
    }
    
    .welcome-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .welcome-section:hover::before {
        left: 100%;
    }
    
    .welcome-title {
        color: #2c3e50;
        margin-bottom: 15px;
        font-size: 2.5rem;
        font-weight: 700;
        background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        position: relative;
        padding-bottom: 15px;
    }
    
    .welcome-title::after {
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
    
    .welcome-subtitle {
        color: #7f8c8d;
        font-size: 1.1rem;
        font-weight: 400;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: rgba(255, 255, 255, 0.95);
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        text-align: center;
        transition: all 0.4s ease;
        position: relative;
        overflow: hidden;
        animation: fadeInUp 0.8s ease-out 0.2s both;
    }
    
    .stat-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .stat-card:hover::before {
        left: 100%;
    }
    
    .stat-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 40px rgba(52, 152, 219, 0.2);
    }
    
    .stat-icon {
        font-size: 2.8rem;
        margin-bottom: 20px;
        display: inline-block;
        animation: float 3s ease-in-out infinite;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .stat-number {
        font-size: 3rem;
        font-weight: 800;
        margin-bottom: 10px;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .stat-label {
        color: #7f8c8d;
        font-size: 1rem;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    .quick-actions {
        background: rgba(255, 255, 255, 0.95);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        margin-bottom: 30px;
        animation: fadeInUp 0.8s ease-out 0.4s both;
        position: relative;
        overflow: hidden;
    }
    
    .quick-actions::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .quick-actions:hover::before {
        left: 100%;
    }
    
    .section-title {
        color: #2c3e50;
        margin-bottom: 30px;
        text-align: center;
        font-size: 1.8rem;
        font-weight: 700;
        background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        position: relative;
        padding-bottom: 15px;
    }
    
    .section-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 80px;
        height: 4px;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        border-radius: 2px;
    }
    
    .actions-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 20px;
    }
    
    .action-card {
        background: rgba(248, 249, 250, 0.7);
        padding: 30px 20px;
        border-radius: 16px;
        text-align: center;
        text-decoration: none;
        color: #2c3e50;
        transition: all 0.4s ease;
        border: 2px solid transparent;
        position: relative;
        overflow: hidden;
    }
    
    .action-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .action-card:hover::before {
        left: 100%;
    }
    
    .action-card:hover {
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        transform: translateY(-5px);
        box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
        border-color: #3498db;
    }
    
    .action-icon {
        font-size: 2.2rem;
        margin-bottom: 15px;
        display: inline-block;
        transition: all 0.3s ease;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .action-card:hover .action-icon {
        transform: scale(1.2) rotate(5deg);
        color: white;
        -webkit-text-fill-color: white;
        background: none;
    }
    
    .action-text {
        font-weight: 600;
        font-size: 1.1rem;
    }
    
    .recent-activity {
        background: rgba(255, 255, 255, 0.95);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        animation: fadeInUp 0.8s ease-out 0.6s both;
        position: relative;
        overflow: hidden;
    }
    
    .recent-activity::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .recent-activity:hover::before {
        left: 100%;
    }
    
    .activity-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .activity-item {
        padding: 20px;
        border-bottom: 1px solid rgba(233, 236, 239, 0.7);
        display: flex;
        align-items: center;
        gap: 20px;
        transition: all 0.3s ease;
        border-radius: 12px;
        margin-bottom: 10px;
    }
    
    .activity-item:last-child {
        border-bottom: none;
        margin-bottom: 0;
    }
    
    .activity-item:hover {
        background: rgba(248, 249, 250, 0.7);
        transform: translateX(5px);
    }
    
    .activity-icon {
        font-size: 1.3rem;
        width: 50px;
        height: 50px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 12px;
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        flex-shrink: 0;
        transition: all 0.3s ease;
    }
    
    .activity-item:hover .activity-icon {
        transform: scale(1.1) rotate(5deg);
    }
    
    .activity-content {
        flex: 1;
    }
    
    .activity-title {
        font-weight: 600;
        margin-bottom: 8px;
        color: #2c3e50;
        display: flex;
        align-items: center;
        gap: 10px;
        flex-wrap: wrap;
    }
    
    .activity-description {
        color: #7f8c8d;
        font-size: 0.95rem;
        line-height: 1.5;
    }
    
    .activity-meta {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 10px;
        flex-wrap: wrap;
        gap: 10px;
    }
    
    .activity-admin {
        font-size: 0.85rem;
        color: #7f8c8d;
        font-weight: 500;
    }
    
    .activity-time {
        color: #3498db;
        font-size: 0.85rem;
        font-weight: 500;
    }
    
    .no-activities {
        text-align: center;
        color: #7f8c8d;
        padding: 40px;
        font-style: italic;
        font-size: 1.1rem;
    }
    
    .activity-badge {
        display: inline-block;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    .badge-login {
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        color: #155724;
    }
    
    .badge-add {
        background: linear-gradient(135deg, #d1ecf1 0%, #bee5eb 100%);
        color: #0c5460;
    }
    
    .badge-update {
        background: linear-gradient(135deg, #fff3cd 0%, #ffeaa7 100%);
        color: #856404;
    }
    
    .badge-delete {
        background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
        color: #721c24;
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
            transform: translateY(-10px);
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
        
        .welcome-section,
        .quick-actions,
        .recent-activity {
            padding: 25px;
        }
        
        .welcome-title {
            font-size: 2rem;
        }
        
        .stats-grid {
            grid-template-columns: 1fr;
        }
        
        .actions-grid {
            grid-template-columns: 1fr;
        }
        
        .activity-meta {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .activity-item {
            flex-direction: column;
            align-items: flex-start;
            gap: 15px;
        }
        
        .activity-icon {
            align-self: flex-start;
        }
    }
</style>
</head>
<body>

<div class="message-container" id="messageContainer">
    <%
        String successMsg = (String) session.getAttribute("successMsg");
        String errorMsg = (String) session.getAttribute("errorMsg");
        
        if (successMsg != null) { 
    %>
        <div class="message-success" id="successMessage">
            <i class="fas fa-check-circle message-icon"></i>
            <%= successMsg %>
        </div>
        <% session.removeAttribute("successMsg"); %>
    <% } %>
    
    <% if (errorMsg != null) { %>
        <div class="message-error" id="errorMessage">
            <i class="fas fa-exclamation-triangle message-icon"></i>
            <%= errorMsg %>
        </div>
        <% session.removeAttribute("errorMsg"); %>
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
        <a href="AdminHomeServlet" class="active">
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
    <div class="welcome-section">
        <h1 class="welcome-title" id="greetingTitle">Welcome, <%= adminName %></h1>
        <p class="welcome-subtitle">Here's what's happening with your organization today.</p>
    </div>
    
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-user-friends"></i></div>
            <div class="stat-number"><%= totalEmployees %></div>
            <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-building"></i></div>
            <div class="stat-number"><%= totalDepartments %></div>
            <div class="stat-label">Departments</div>
        </div>
    </div>
    
    <div class="quick-actions">
        <h2 class="section-title">Quick Actions</h2>
        <div class="actions-grid">
            <a href="addemp.jsp" class="action-card">
                <div class="action-icon"><i class="fas fa-user-plus"></i></div>
                <div class="action-text">Add Employee</div>
            </a>
            <a href="EmpListServlet" class="action-card">
                <div class="action-icon"><i class="fas fa-list-ul"></i></div>
                <div class="action-text">View Employees</div>
            </a>
            <a href="DepartmentServlet" class="action-card">
                <div class="action-icon"><i class="fas fa-sitemap"></i></div>
                <div class="action-text">Manage Departments</div>
            </a>
            <a href="ReportsServlet" class="action-card">
                <div class="action-icon"><i class="fas fa-chart-bar"></i></div>
                <div class="action-text">View Reports</div>
            </a>
        </div>
    </div>

    <div class="recent-activity">
    <h2 class="section-title">Recent Activity</h2>
    <% if (recentActivities != null && !recentActivities.isEmpty()) { %>
        <ul class="activity-list">
            <% for (ActivityLog activity : recentActivities) { 
                String badgeClass = "badge-login";
                String icon = "fas fa-sign-in-alt";
                String activityDesc = activity.getActionDescription() != null ? activity.getActionDescription().toLowerCase() : "";
                
                if (activity.getActionType() != null) {
                    String actionType = activity.getActionType().toLowerCase();
                    
                    switch(actionType) {
                        case "add":
                            badgeClass = "badge-add";
                            if (activityDesc.contains("employee")) {
                                icon = "fas fa-user-plus";
                            } else if (activityDesc.contains("department")) {
                                icon = "fas fa-building-plus";
                            } else if (activityDesc.contains("admin")) {
                                icon = "fas fa-user-shield";
                            } else {
                                icon = "fas fa-plus-circle";
                            }
                            break;
                            
                        case "update":
                            badgeClass = "badge-update";
                            if (activityDesc.contains("employee") || activityDesc.contains("profile")) {
                                icon = "fas fa-user-edit";
                            } else if (activityDesc.contains("department")) {
                                icon = "fas fa-building-edit";
                            } else if (activityDesc.contains("salary")) {
                                icon = "fas fa-money-bill-wave";
                            } else {
                                icon = "fas fa-edit";
                            }
                            break;
                            
                        case "delete":
                            badgeClass = "badge-delete";
                            if (activityDesc.contains("employee")) {
                                icon = "fas fa-user-minus";
                            } else if (activityDesc.contains("department")) {
                                icon = "fas fa-building-flag";
                            } else {
                                icon = "fas fa-trash-alt";
                            }
                            break;
                            
                        case "login":
                            badgeClass = "badge-login";
                            if (activityDesc.contains("login") || activityDesc.contains("sign in")) {
                                icon = "fas fa-sign-in-alt";
                            } else if (activityDesc.contains("logout") || activityDesc.contains("sign out")) {
                                icon = "fas fa-sign-out-alt";
                            } else {
                                icon = "fas fa-user-clock";
                            }
                            break;
                            
                        case "view":
                            badgeClass = "badge-login";
                            if (activityDesc.contains("employee") || activityDesc.contains("list")) {
                                icon = "fas fa-users";
                            } else if (activityDesc.contains("report")) {
                                icon = "fas fa-chart-bar";
                            } else if (activityDesc.contains("profile")) {
                                icon = "fas fa-id-card";
                            } else {
                                icon = "fas fa-eye";
                            }
                            break;
                            
                        case "download":
                            badgeClass = "badge-add";
                            icon = "fas fa-file-download";
                            break;
                            
                        case "upload":
                            badgeClass = "badge-add";
                            icon = "fas fa-file-upload";
                            break;
                            
                        case "search":
                            badgeClass = "badge-login";
                            icon = "fas fa-search";
                            break;
                            
                        case "export":
                            badgeClass = "badge-add";
                            icon = "fas fa-file-export";
                            break;
                            
                        case "import":
                            badgeClass = "badge-add";
                            icon = "fas fa-file-import";
                            break;
                            
                        default:
                            badgeClass = "badge-login";
                            if (activityDesc.contains("error") || activityDesc.contains("failed")) {
                                icon = "fas fa-exclamation-triangle";
                            } else if (activityDesc.contains("success") || activityDesc.contains("completed")) {
                                icon = "fas fa-check-circle";
                            } else if (activityDesc.contains("system")) {
                                icon = "fas fa-cog";
                            } else {
                                icon = "fas fa-history";
                            }
                    }
                }
            %>
            <li class="activity-item">
                <div class="activity-icon"><i class="<%= icon %>"></i></div>
                <div class="activity-content">
                    <div class="activity-title">
                        <span class="activity-badge <%= badgeClass %>">
                            <%= activity.getActionType() != null ? activity.getActionType().toUpperCase() : "ACTION" %>
                        </span>
                        <%= activity.getActionDescription() != null ? activity.getActionDescription() : "Activity performed" %>
                    </div>
                    <div class="activity-meta">
                        <% if (activity.getEmployeeName() != null && !activity.getEmployeeName().equals("System")) { %>
                            <span class="activity-admin">Employee: <%= activity.getEmployeeName() %></span>
                        <% } %>
                        <span class="activity-time">
                            <% if (activity.getTimestamp() != null) { %>
                                <%= timeFormat.format(activity.getTimestamp()) %>
                            <% } else { %>
                                Just now
                            <% } %>
                        </span>
                    </div>
                </div>
            </li>
            <% } %>
        </ul>
    <% } else { %>
        <div class="no-activities">
            <p>No recent activities found. Activities will appear here as you use the system.</p>
        </div>
    <% } %>
</div>
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
        
        const hour = new Date().getHours();
        const greetingTitle = document.getElementById('greetingTitle');
        let greeting = '';
        
        if (hour < 12) {
            greeting = 'Good Morning';
        } else if (hour < 18) {
            greeting = 'Good Afternoon';
        } else {
            greeting = 'Good Evening';
        }
        
        greetingTitle.textContent = greeting + ', <%= adminName %>';
        
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