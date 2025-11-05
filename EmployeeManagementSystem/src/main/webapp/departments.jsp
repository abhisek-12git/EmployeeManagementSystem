<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.Department" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Department</title>
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
    
    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }
    
    .page-title {
        color: #333;
        margin: 0;
    }
    
    .btn {
        display: inline-block;
        background: #007bff;
        color: white;
        padding: 12px 25px;
        text-decoration: none;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        font-size: 16px;
        transition: background 0.3s;
        margin: 5px;
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
    
    .btn-sm {
        padding: 8px 15px;
        font-size: 14px;
    }
    
    .departments-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
        gap: 25px;
        margin-bottom: 40px;
    }
    
    .department-card {
        background: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border-left: 4px solid #007bff;
    }
    
    .department-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 25px rgba(0,0,0,0.15);
    }
    
    .department-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }
    
    .department-name {
        font-size: 20px;
        font-weight: bold;
        color: #333;
        margin: 0;
    }
    
    .department-code {
        background: #e9ecef;
        color: #495057;
        padding: 4px 8px;
        border-radius: 4px;
        font-size: 12px;
        font-weight: bold;
    }
    
    .department-info {
        margin-bottom: 20px;
    }
    
    .info-row {
        display: flex;
        margin-bottom: 8px;
        padding: 5px 0;
    }
    
    .info-label {
        font-weight: bold;
        width: 120px;
        color: #555;
        font-size: 14px;
    }
    
    .info-value {
        color: #333;
        font-size: 14px;
        flex: 1;
    }
    
    .employee-count {
        font-weight: bold;
        color: #007bff;
    }
    
    .department-actions {
        display: flex;
        gap: 10px;
        justify-content: flex-end;
    }
    
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
    }
    
    .modal-content {
        background-color: white;
        margin: 5% auto;
        padding: 0;
        border-radius: 8px;
        width: 90%;
        max-width: 500px;
        box-shadow: 0 5px 25px rgba(0,0,0,0.2);
    }
    
    .modal-header {
        padding: 20px 25px;
        border-bottom: 1px solid #e9ecef;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .modal-title {
        margin: 0;
        color: #333;
        font-size: 20px;
    }
    
    .close {
        color: #aaa;
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
        background: none;
        border: none;
    }
    
    .close:hover {
        color: #333;
    }
    
    .modal-body {
        padding: 25px;
    }
    
    .form-group {
        margin-bottom: 20px;
    }
    
    .form-label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #333;
    }
    
    .form-control {
        width: 100%;
        padding: 10px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
        box-sizing: border-box;
    }
    
    .form-control:focus {
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
    }
    
    .modal-footer {
        padding: 20px 25px;
        border-top: 1px solid #e9ecef;
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }
    
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 0 15px rgba(0,0,0,0.1);
        grid-column: 1 / -1;
    }
    
    .empty-icon {
        font-size: 64px;
        color: #6c757d;
        margin-bottom: 20px;
    }
    
    .empty-text {
        color: #6c757d;
        font-size: 18px;
        margin-bottom: 25px;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        text-align: center;
    }
    
    .stat-number {
        font-size: 32px;
        font-weight: bold;
        color: #007bff;
        margin-bottom: 5px;
    }
    
    .stat-label {
        color: #666;
        font-size: 14px;
    }
    
    .alert {
        padding: 15px 20px;
        border-radius: 4px;
        margin-bottom: 20px;
        border-left: 4px solid;
    }
    
    .alert-success {
        background-color: #d4edda;
        border-color: #28a745;
        color: #155724;
    }
    
    .alert-error {
        background-color: #f8d7da;
        border-color: #dc3545;
        color: #721c24;
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
    
    List<Department> departments = (List<Department>) request.getAttribute("departments");
    String message = (String) request.getAttribute("message");
    String messageType = (String) request.getAttribute("messageType");
    
    if (departments == null) {
        departments = new ArrayList<>();
    }
    
    int totalDepartments = departments.size();
    int totalEmployees = 0;
    int totalManagers = 0;
    
    for (Department dept : departments) {
        totalEmployees += dept.getEmployeeCount();
        if (dept.getManager() != null && !dept.getManager().trim().isEmpty()) {
            totalManagers++;
        }
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
    <div class="page-header">
        <h2 class="page-title">Department Management</h2>
        <button class="btn btn-success" onclick="openAddModal()">➕ Add New Department</button>
    </div>

    <% if (message != null) { %>
        <div class="alert alert-<%= messageType != null ? messageType : "success" %>">
            <%= message %>
        </div>
    <% } %>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number"><%= totalDepartments %></div>
            <div class="stat-label">Total Departments</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= totalEmployees %></div>
            <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= totalManagers %></div>
            <div class="stat-label">Managers Assigned</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= totalDepartments > 0 ? String.format("%.1f", (double) totalEmployees / totalDepartments) : 0 %></div>
            <div class="stat-label">Avg Employees/Dept</div>
        </div>
    </div>

    <div class="departments-grid">
        <% if (departments != null && !departments.isEmpty()) { 
            for (Department dept : departments) { 
        %>
            <div class="department-card">
                <div class="department-header">
                    <h3 class="department-name"><%= dept.getName() %></h3>
                    <span class="department-code"><%= dept.getCode() %></span>
                </div>
                
                <div class="department-info">
                    <div class="info-row">
                        <span class="info-label">Manager:</span>
                        <span class="info-value"><%= dept.getManager() != null ? dept.getManager() : "Not assigned" %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Employees:</span>
                        <span class="info-value">
                            <span class="employee-count"><%= dept.getEmployeeCount() %></span> 
                            employee<%= dept.getEmployeeCount() != 1 ? "s" : "" %>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Location:</span>
                        <span class="info-value"><%= dept.getLocation() != null ? dept.getLocation() : "Main Office" %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Description:</span>
                        <span class="info-value"><%= dept.getDescription() != null ? dept.getDescription() : "No description provided" %></span>
                    </div>
                </div>
                
                <div class="department-actions">
                    <button class="btn btn-warning btn-sm" onclick="openEditModal(<%= dept.getId() %>, '<%= dept.getName().replace("'", "\\'") %>', '<%= dept.getCode().replace("'", "\\'") %>', '<%= dept.getManager() != null ? dept.getManager().replace("'", "\\'") : "" %>', '<%= dept.getLocation() != null ? dept.getLocation().replace("'", "\\'") : "" %>', '<%= dept.getDescription() != null ? dept.getDescription().replace("'", "\\'").replace("\"", "&quot;") : "" %>')">Edit</button>
                    <button class="btn btn-danger btn-sm" onclick="confirmDelete(<%= dept.getId() %>, '<%= dept.getName().replace("'", "\\'") %>')">Delete</button>
                </div>
            </div>
        <% } 
        } else { %>
        <div class="empty-state">
            <div class="empty-icon">🏢</div>
            <h3 class="empty-text">No Departments Found</h3>
            <p>Get started by creating your first department.</p>
            <button class="btn btn-success" onclick="openAddModal()">Create First Department</button>
        </div>
        <% } %>
    </div>
</div>

<div id="addModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Add New Department</h3>
            <button class="close" onclick="closeAddModal()">&times;</button>
        </div>
        <form id="addDepartmentForm" action="DepartmentServlet" method="POST">
            <input type="hidden" name="action" value="add">
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label" for="deptName">Department Name *</label>
                    <input type="text" class="form-control" id="deptName" name="name" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="deptCode">Department Code *</label>
                    <input type="text" class="form-control" id="deptCode" name="code" required maxlength="10">
                </div>
                <div class="form-group">
                    <label class="form-label" for="deptManager">Manager</label>
                    <input type="text" class="form-control" id="deptManager" name="manager">
                </div>
                <div class="form-group">
                    <label class="form-label" for="deptLocation">Location</label>
                    <input type="text" class="form-control" id="deptLocation" name="location">
                </div>
                <div class="form-group">
                    <label class="form-label" for="deptDescription">Description</label>
                    <textarea class="form-control" id="deptDescription" name="description" rows="3"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn" onclick="closeAddModal()">Cancel</button>
                <button type="submit" class="btn btn-success">Add Department</button>
            </div>
        </form>
    </div>
</div>

<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3 class="modal-title">Edit Department</h3>
            <button class="close" onclick="closeEditModal()">&times;</button>
        </div>
        <form id="editDepartmentForm" action="DepartmentServlet" method="POST">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editDeptId" name="id">
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label" for="editDeptName">Department Name *</label>
                    <input type="text" class="form-control" id="editDeptName" name="name" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="editDeptCode">Department Code *</label>
                    <input type="text" class="form-control" id="editDeptCode" name="code" required maxlength="10">
                </div>
                <div class="form-group">
                    <label class="form-label" for="editDeptManager">Manager</label>
                    <input type="text" class="form-control" id="editDeptManager" name="manager">
                </div>
                <div class="form-group">
                    <label class="form-label" for="editDeptLocation">Location</label>
                    <input type="text" class="form-control" id="editDeptLocation" name="location">
                </div>
                <div class="form-group">
                    <label class="form-label" for="editDeptDescription">Description</label>
                    <textarea class="form-control" id="editDeptDescription" name="description" rows="3"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn" onclick="closeEditModal()">Cancel</button>
                <button type="submit" class="btn btn-success">Update Department</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openAddModal() {
        document.getElementById('addModal').style.display = 'block';
    }
    
    function closeAddModal() {
        document.getElementById('addModal').style.display = 'none';
        document.getElementById('addDepartmentForm').reset();
    }
    
    function openEditModal(id, name, code, manager, location, description) {
        document.getElementById('editDeptId').value = id;
        document.getElementById('editDeptName').value = name;
        document.getElementById('editDeptCode').value = code;
        document.getElementById('editDeptManager').value = manager || '';
        document.getElementById('editDeptLocation').value = location || '';
        document.getElementById('editDeptDescription').value = description || '';
        document.getElementById('editModal').style.display = 'block';
    }
    
    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
    }
    
    function confirmDelete(id, name) {
        if (confirm('Are you sure you want to delete the department "' + name + '"? This action cannot be undone.')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'DepartmentServlet';
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';
            form.appendChild(actionInput);
            
            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = id;
            form.appendChild(idInput);
            
            document.body.appendChild(form);
            form.submit();
        }
    }
    
    window.onclick = function(event) {
        const addModal = document.getElementById('addModal');
        const editModal = document.getElementById('editModal');
        
        if (event.target === addModal) {
            closeAddModal();
        }
        if (event.target === editModal) {
            closeEditModal();
        }
    }
    
    document.getElementById('deptName').addEventListener('input', function() {
        const name = this.value;
        const codeInput = document.getElementById('deptCode');
        
        if (name && !codeInput.value) {
            const code = name.substring(0, 3).toUpperCase();
            codeInput.value = code;
        }
    });
</script>

</body>
</html> --%>














<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.Department" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    
    if (currentAdmin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    List<Department> departments = (List<Department>) request.getAttribute("departments");
    String message = (String) request.getAttribute("message");
    String messageType = (String) request.getAttribute("messageType");
    
    if (departments == null) {
        departments = new ArrayList<>();
    }
    
    int totalDepartments = departments.size();
    int totalEmployees = 0;
    int totalManagers = 0;
    
    for (Department dept : departments) {
        totalEmployees += dept.getEmployeeCount();
        if (dept.getManager() != null && !dept.getManager().trim().isEmpty()) {
            totalManagers++;
        }
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
<title>WorkSphere Pro - Department Management</title>
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
        max-width: 1400px;
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
        padding: 16px 30px;
        text-decoration: none;
        border-radius: 12px;
        border: none;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: all 0.4s ease;
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
    
    .btn:hover {
        transform: translateY(-3px);
    }
    
    .btn-success {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
    }
    
    .btn-success:hover {
        box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
    }
    
    .btn-warning {
        background: linear-gradient(135deg, #ffc107 0%, #ffca2c 100%);
        color: #212529;
        box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
    }
    
    .btn-warning:hover {
        box-shadow: 0 8px 25px rgba(255, 193, 7, 0.4);
    }
    
    .btn-danger {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
    }
    
    .btn-danger:hover {
        box-shadow: 0 8px 25px rgba(220, 53, 69, 0.4);
    }
    
    .btn-sm {
        padding: 10px 20px;
        font-size: 12px;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }
    
    .stat-card {
        background: rgba(255, 255, 255, 0.95);
        padding: 25px;
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
        font-size: 2.5rem;
        margin-bottom: 15px;
        display: inline-block;
        animation: float 3s ease-in-out infinite;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .stat-number {
        font-size: 2.5rem;
        font-weight: 800;
        margin-bottom: 8px;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .stat-label {
        color: #7f8c8d;
        font-size: 0.9rem;
        font-weight: 500;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    
    .departments-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
        gap: 25px;
        margin-bottom: 40px;
    }
    
    .department-card {
        background: rgba(255, 255, 255, 0.95);
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        transition: all 0.4s ease;
        position: relative;
        overflow: hidden;
        animation: fadeInUp 0.8s ease-out 0.4s both;
        border-left: 5px solid #3498db;
    }
    
    .department-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .department-card:hover::before {
        left: 100%;
    }
    
    .department-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 40px rgba(52, 152, 219, 0.2);
    }
    
    .department-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .department-name {
        font-size: 1.5rem;
        font-weight: 700;
        color: #2c3e50;
        margin: 0;
    }
    
    .department-code {
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
    }
    
    .department-info {
        margin-bottom: 25px;
    }
    
    .info-row {
        display: flex;
        margin-bottom: 12px;
        padding: 8px 0;
        border-bottom: 1px solid rgba(222, 226, 230, 0.5);
    }
    
    .info-label {
        font-weight: 600;
        width: 120px;
        color: #7f8c8d;
        font-size: 0.9rem;
    }
    
    .info-value {
        color: #2c3e50;
        font-size: 0.9rem;
        flex: 1;
    }
    
    .employee-count {
        font-weight: 700;
        color: #3498db;
        font-size: 1rem;
    }
    
    .department-actions {
        display: flex;
        gap: 10px;
        justify-content: flex-end;
    }
    
    .empty-state {
        text-align: center;
        padding: 80px 40px;
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        grid-column: 1 / -1;
        animation: fadeInUp 0.8s ease-out;
    }
    
    .empty-icon {
        font-size: 4rem;
        margin-bottom: 20px;
        background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        animation: float 3s ease-in-out infinite;
    }
    
    .empty-text {
        color: #2c3e50;
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 15px;
    }
    
    .empty-subtext {
        color: #7f8c8d;
        font-size: 1rem;
        margin-bottom: 30px;
    }
    
    .modal {
        display: none;
        position: fixed;
        z-index: 2000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.7);
        backdrop-filter: blur(5px);
        animation: fadeIn 0.3s ease-out;
    }
    
    .modal-content {
        background-color: white;
        margin: 5% auto;
        border-radius: 20px;
        box-shadow: 0 25px 80px rgba(0, 0, 0, 0.4);
        max-width: 550px;
        width: 90%;
        overflow: hidden;
        animation: modalSlideIn 0.4s ease-out;
        position: relative;
        max-height: 85vh;
        overflow-y: auto;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
    
    @keyframes modalSlideIn {
        from {
            opacity: 0;
            transform: translateY(-60px) scale(0.9);
        }
        to {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
    }
    
    .modal-header {
        padding: 25px 30px 20px 30px;
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
        position: sticky;
        top: 0;
        z-index: 10;
    }
    
    .modal-header h3 {
        margin: 0;
        font-size: 1.4rem;
        font-weight: 700;
        letter-spacing: -0.5px;
    }
    
    .close {
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
        line-height: 1;
        transition: all 0.3s ease;
        background: none;
        border: none;
        color: white;
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
    }
    
    .close:hover {
        transform: scale(1.1);
        background: rgba(255, 255, 255, 0.2);
    }
    
    .modal-body {
        padding: 30px;
        border-bottom: 1px solid rgba(222, 226, 230, 0.5);
        max-height: calc(85vh - 200px);
        overflow-y: auto;
    }
    
    .form-group {
        margin-bottom: 25px;
    }
    
    .form-label {
        display: block;
        margin-bottom: 10px;
        font-weight: 600;
        color: #2c3e50;
        font-size: 0.95rem;
    }
    
    .form-control {
        width: 100%;
        padding: 15px 18px;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        box-sizing: border-box;
        font-size: 15px;
        font-family: 'Poppins', sans-serif;
        transition: all 0.3s ease;
        background: #f8f9fa;
        color: #2c3e50;
    }
    
    .form-control:focus {
        outline: none;
        border-color: #3498db;
        background: white;
        box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.15);
        transform: translateY(-2px);
        color: #2c3e50;
    }
    
    .form-control:-webkit-autofill,
    .form-control:-webkit-autofill:hover,
    .form-control:-webkit-autofill:focus,
    .form-control:-webkit-autofill:active {
        -webkit-box-shadow: 0 0 0 30px #f8f9fa inset !important;
        -webkit-text-fill-color: #2c3e50 !important;
        background-color: #f8f9fa !important;
        border: 2px solid #e9ecef !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 15px !important;
     }

    .form-control:-webkit-autofill:focus {
        -webkit-box-shadow: 0 0 0 30px white inset, 0 0 0 4px rgba(52, 152, 219, 0.15) !important;
        border: 2px solid #3498db !important;
     }
    
    textarea.form-control {
        resize: vertical;
        min-height: 100px;
        line-height: 1.5;
    }
    
    .modal-footer {
        padding: 25px 30px;
        display: flex;
        justify-content: flex-end;
        gap: 15px;
        background: #f8f9fa;
        position: sticky;
        bottom: 0;
    }
    
    .btn-secondary {
        background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
        color: white;
        padding: 14px 28px;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-secondary:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(108, 117, 125, 0.3);
    }
    
    .delete-modal .modal-header {
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
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
        
        .departments-grid {
            grid-template-columns: 1fr;
        }
        
        .department-actions {
            flex-direction: column;
        }
        
        .btn-sm {
            margin-bottom: 5px;
            text-align: center;
        }
        
        .modal-content {
            margin: 10% auto;
            width: 95%;
            max-width: 95%;
        }
        
        .modal-header {
            padding: 20px 25px 15px 25px;
        }
        
        .modal-body {
            padding: 25px;
        }
        
        .modal-footer {
            padding: 20px 25px;
            flex-direction: column-reverse;
        }
        
        .btn, .btn-secondary {
            width: 100%;
            justify-content: center;
        }
        
        .stats-grid {
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
        }
        
        .stat-card {
            padding: 20px;
        }
        
        .stat-number {
            font-size: 2rem;
        }
    }
    
    @media (max-width: 480px) {
        .container {
            margin: 160px auto 20px auto;
            padding: 0 10px;
        }
        
        .page-header {
            padding: 20px;
        }
        
        .page-title {
            font-size: 1.8rem;
        }
        
        .department-card {
            padding: 20px;
        }
        
        .info-row {
            flex-direction: column;
            gap: 5px;
        }
        
        .info-label {
            width: 100%;
        }
        
        .modal-content {
            margin: 5% auto;
            border-radius: 15px;
        }
        
        .modal-header {
            padding: 18px 20px 12px 20px;
        }
        
        .modal-header h3 {
            font-size: 1.2rem;
        }
        
        .modal-body {
            padding: 20px;
        }
        
        .form-control {
            padding: 12px 15px;
        }
    }
</style>
</head>
<body>

<div class="message-container" id="messageContainer">
    <% if (message != null) { %>
        <div class="message-<%= "error".equals(messageType) ? "error" : "success" %>" id="message">
            <i class="fas <%= "error".equals(messageType) ? "fa-exclamation-triangle" : "fa-check-circle" %> message-icon"></i>
            <%= message %>
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
    <div class="page-header">
        <h1 class="page-title">Department Management</h1>
        <button class="btn btn-success" onclick="openAddModal()">
            <i class="fas fa-plus-circle"></i>Add New Department
        </button>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-building"></i></div>
            <div class="stat-number"><%= totalDepartments %></div>
            <div class="stat-label">Total Departments</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-user-friends"></i></div>
            <div class="stat-number"><%= totalEmployees %></div>
            <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-user-tie"></i></div>
            <div class="stat-number"><%= totalManagers %></div>
            <div class="stat-label">Managers Assigned</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-chart-line"></i></div>
            <div class="stat-number"><%= totalDepartments > 0 ? String.format("%.1f", (double) totalEmployees / totalDepartments) : 0 %></div>
            <div class="stat-label">Avg Employees/Dept</div>
        </div>
    </div>

    <div class="departments-grid">
        <% if (departments != null && !departments.isEmpty()) { 
            for (Department dept : departments) { 
        %>
            <div class="department-card">
                <div class="department-header">
                    <h3 class="department-name"><%= dept.getName() %></h3>
                    <span class="department-code"><%= dept.getCode() %></span>
                </div>
                
                <div class="department-info">
                    <div class="info-row">
                        <span class="info-label">Manager:</span>
                        <span class="info-value"><%= dept.getManager() != null ? dept.getManager() : "Not assigned" %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Employees:</span>
                        <span class="info-value">
                            <span class="employee-count"><%= dept.getEmployeeCount() %></span> 
                            employee<%= dept.getEmployeeCount() != 1 ? "s" : "" %>
                        </span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Location:</span>
                        <span class="info-value"><%= dept.getLocation() != null ? dept.getLocation() : "Main Office" %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Description:</span>
                        <span class="info-value"><%= dept.getDescription() != null ? dept.getDescription() : "No description provided" %></span>
                    </div>
                </div>
                
                <div class="department-actions">
                    <button class="btn btn-warning btn-sm" onclick="openEditModal(<%= dept.getId() %>, '<%= dept.getName().replace("'", "\\'") %>', '<%= dept.getCode().replace("'", "\\'") %>', '<%= dept.getManager() != null ? dept.getManager().replace("'", "\\'") : "" %>', '<%= dept.getLocation() != null ? dept.getLocation().replace("'", "\\'") : "" %>', '<%= dept.getDescription() != null ? dept.getDescription().replace("'", "\\'").replace("\"", "&quot;") : "" %>')">
                        <i class="fas fa-edit"></i>Edit
                    </button>
                    <button class="btn btn-danger btn-sm" onclick="confirmDelete(<%= dept.getId() %>, '<%= dept.getName().replace("'", "\\'") %>')">
                        <i class="fas fa-trash"></i>Delete
                    </button>
                </div>
            </div>
        <% } 
        } else { %>
        <div class="empty-state">
            <div class="empty-icon">🏢</div>
            <h3 class="empty-text">No Departments Found</h3>
            <p class="empty-subtext">Get started by creating your first department.</p>
            <button class="btn btn-success" onclick="openAddModal()">
                <i class="fas fa-plus-circle"></i>Create First Department
            </button>
        </div>
        <% } %>
    </div>
</div>

<div id="addModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Add New Department</h3>
            <button class="close" onclick="closeAddModal()">&times;</button>
        </div>
        <form id="addDepartmentForm" action="DepartmentServlet" method="POST">
            <input type="hidden" name="action" value="add">
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label" for="deptName">Department Name *</label>
                    <input type="text" class="form-control" id="deptName" name="name" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="deptCode">Department Code *</label>
                    <input type="text" class="form-control" id="deptCode" name="code" required maxlength="10">
                </div>
                <div class="form-group">
                    <label class="form-label" for="deptManager">Manager</label>
                    <input type="text" class="form-control" id="deptManager" name="manager">
                </div>
                <div class="form-group">
                    <label class="form-label" for="deptLocation">Location</label>
                    <input type="text" class="form-control" id="deptLocation" name="location">
                </div>
                <div class="form-group">
                    <label class="form-label" for="deptDescription">Description</label>
                    <textarea class="form-control" id="deptDescription" name="description" rows="3"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeAddModal()">Cancel</button>
                <button type="submit" class="btn btn-success">Add Department</button>
            </div>
        </form>
    </div>
</div>

<div id="editModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Edit Department</h3>
            <button class="close" onclick="closeEditModal()">&times;</button>
        </div>
        <form id="editDepartmentForm" action="DepartmentServlet" method="POST">
            <input type="hidden" name="action" value="update">
            <input type="hidden" id="editDeptId" name="id">
            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label" for="editDeptName">Department Name *</label>
                    <input type="text" class="form-control" id="editDeptName" name="name" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="editDeptCode">Department Code *</label>
                    <input type="text" class="form-control" id="editDeptCode" name="code" required maxlength="10">
                </div>
                <div class="form-group">
                    <label class="form-label" for="editDeptManager">Manager</label>
                    <input type="text" class="form-control" id="editDeptManager" name="manager">
                </div>
                <div class="form-group">
                    <label class="form-label" for="editDeptLocation">Location</label>
                    <input type="text" class="form-control" id="editDeptLocation" name="location">
                </div>
                <div class="form-group">
                    <label class="form-label" for="editDeptDescription">Description</label>
                    <textarea class="form-control" id="editDeptDescription" name="description" rows="3"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeEditModal()">Cancel</button>
                <button type="submit" class="btn btn-success">Update Department</button>
            </div>
        </form>
    </div>
</div>

<div id="deleteModal" class="modal delete-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Confirm Delete</h3>
            <button class="close" onclick="closeDeleteModal()">&times;</button>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to delete department: <strong id="deleteDeptName"></strong>?</p>
            <p style="color: #dc3545; font-weight: bold;">This action cannot be undone!</p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
            <button class="btn btn-danger" id="confirmDeleteBtn">
                <i class="fas fa-trash"></i>Delete Department
            </button>
        </div>
    </div>
</div>

<script>
    let departmentToDelete = '';

    function openAddModal() {
        document.getElementById('addModal').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }
    
    function closeAddModal() {
        document.getElementById('addModal').style.display = 'none';
        document.body.style.overflow = 'auto';
        document.getElementById('addDepartmentForm').reset();
    }
    
    function openEditModal(id, name, code, manager, location, description) {
        document.getElementById('editDeptId').value = id;
        document.getElementById('editDeptName').value = name;
        document.getElementById('editDeptCode').value = code;
        document.getElementById('editDeptManager').value = manager || '';
        document.getElementById('editDeptLocation').value = location || '';
        document.getElementById('editDeptDescription').value = description || '';
        document.getElementById('editModal').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }
    
    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
        document.body.style.overflow = 'auto';
    }
    
    function confirmDelete(id, name) {
        departmentToDelete = id;
        document.getElementById('deleteDeptName').textContent = name;
        document.getElementById('deleteModal').style.display = 'block';
        document.body.style.overflow = 'hidden';
    }
    
    function closeDeleteModal() {
        document.getElementById('deleteModal').style.display = 'none';
        document.body.style.overflow = 'auto';
        departmentToDelete = '';
    }
    
    document.getElementById('confirmDeleteBtn').onclick = function() {
        if (departmentToDelete) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'DepartmentServlet';
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';
            form.appendChild(actionInput);
            
            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = departmentToDelete;
            form.appendChild(idInput);
            
            document.body.appendChild(form);
            form.submit();
        }
    };
    
    window.onclick = function(event) {
        const addModal = document.getElementById('addModal');
        const editModal = document.getElementById('editModal');
        const deleteModal = document.getElementById('deleteModal');
        
        if (event.target === addModal) closeAddModal();
        if (event.target === editModal) closeEditModal();
        if (event.target === deleteModal) closeDeleteModal();
    }
    
    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            closeAddModal();
            closeEditModal();
            closeDeleteModal();
        }
    });
    
    document.getElementById('deptName').addEventListener('input', function() {
        const name = this.value;
        const codeInput = document.getElementById('deptCode');
        
        if (name && !codeInput.value) {
            const code = name.substring(0, 3).toUpperCase();
            codeInput.value = code;
        }
    });
    
    document.addEventListener('DOMContentLoaded', function() {
        const message = document.getElementById('message');
        const messageContainer = document.getElementById('messageContainer');
        
        function hideMessage() {
            if (message) {
                message.classList.add('message-hide');
                setTimeout(() => {
                    message.remove();
                    if (messageContainer && messageContainer.children.length === 0) {
                        messageContainer.remove();
                    }
                }, 300);
            }
        }
        
        if (message) {
            setTimeout(() => {
                hideMessage();
            }, 5000);
        }
        
        if (message) {
            message.addEventListener('click', function() {
                hideMessage();
            });
        }
    });
</script>

</body>
</html>