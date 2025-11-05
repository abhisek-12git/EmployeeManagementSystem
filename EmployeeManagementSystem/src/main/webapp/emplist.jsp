<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.Employee" %>
<%@ page import="com.ems.model.Department" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.ems.service.StatsService" %>
<%@ page import="com.ems.dao.DepartmentDao" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Employee</title>
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
        max-width: 1400px;
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
    
    .btn-info {
        background: #17a2b8;
    }
    
    .btn-info:hover {
        background: #138496;
    }
    
    .btn-secondary {
        background: #6c757d;
    }
    
    .btn-secondary:hover {
        background: #545b62;
    }
    
    .search-section {
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 20px;
    }
    
    .search-form {
        display: flex;
        gap: 15px;
        align-items: center;
        flex-wrap: wrap;
    }
    
    .search-input {
        flex: 1;
        min-width: 250px;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
    }
    
    .filter-select {
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
        min-width: 150px;
    }
    
    .employees-table {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        overflow: hidden;
    }
    
    .table-header {
        background: #f8f9fa;
        padding: 15px 20px;
        border-bottom: 1px solid #dee2e6;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .table-title {
        margin: 0;
        color: #333;
        font-size: 18px;
    }
    
    .total-count {
        color: #666;
        font-size: 14px;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
    }
    
    th, td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #dee2e6;
    }
    
    th {
        background: #f8f9fa;
        font-weight: 600;
        color: #333;
        position: sticky;
        top: 0;
    }
    
    tr:hover {
        background: #f8f9fa;
    }
    
    .employee-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: #007bff;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 14px;
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
    
    .action-buttons {
        display: flex;
        gap: 5px;
        flex-wrap: wrap;
    }
    
    .action-btn {
        padding: 6px 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 12px;
        text-decoration: none;
        display: inline-block;
        text-align: center;
        transition: all 0.3s;
    }
    
    .no-data {
        text-align: center;
        padding: 40px;
        color: #666;
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
    
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
    }
    
    .modal-content {
        background-color: white;
        margin: 10% auto;
        border-radius: 8px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        max-width: 500px;
        width: 90%;
    }
    
    .modal-header {
        padding: 20px;
        background: #dc3545;
        color: white;
        border-radius: 8px 8px 0 0;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .modal-header h3 {
        margin: 0;
        font-size: 20px;
    }
    
    .close {
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
        line-height: 1;
    }
    
    .modal-body {
        padding: 30px 20px;
        border-bottom: 1px solid #dee2e6;
    }
    
    .modal-footer {
        padding: 20px;
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }
    
    .status-modal .modal-header {
        background: #007bff;
    }
    
    @media (max-width: 768px) {
        .page-header {
            flex-direction: column;
            gap: 15px;
            align-items: flex-start;
        }
        
        .search-form {
            flex-direction: column;
            align-items: stretch;
        }
        
        .search-input, .filter-select {
            min-width: auto;
        }
        
        .employees-table {
            overflow-x: auto;
        }
        
        table {
            min-width: 800px;
        }
        
        .action-buttons {
            flex-direction: column;
        }
        
        .action-btn {
            margin-bottom: 5px;
        }
        
        .modal-content {
            margin: 20% auto;
            width: 95%;
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
    
    List<Employee> employeeList = (List<Employee>) request.getAttribute("list");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    
    StatsService statsService = new StatsService();
    int totalEmployees = statsService.getTotalEmployeesCount();
    int activeEmployees = statsService.getActiveEmployeesCount();
    int newEmployeesThisMonth = statsService.getNewEmployeesThisMonth();
    int totalDepartments = statsService.getTotalDepartmentsCount();
    int inactiveEmployees = statsService.getInactiveEmployeesCount();
    
    DepartmentDao departmentDao = new DepartmentDao();
    List<Department> departments = departmentDao.getAllDepartments();
    
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
        <a href="EmpListServlet" style="background: rgba(255,255,255,0.2);">Employees</a>
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
        <h2 class="page-title">Employee Management</h2>
        <div>
            <a href="addemp.jsp" class="btn btn-success">Add New Employee</a>
        </div>
    </div>

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

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number"><%= totalEmployees %></div>
            <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= activeEmployees %></div>
            <div class="stat-label">Active Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= inactiveEmployees %></div>
            <div class="stat-label">Inactive Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= newEmployeesThisMonth %></div>
            <div class="stat-label">New This Month</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= totalDepartments %></div>
            <div class="stat-label">Departments</div>
        </div>
    </div>

    <div class="search-section">
        <form class="search-form" method="get" action="EmpListServlet">
            <input type="text" name="search" class="search-input" placeholder="Search by name, email, or employee ID..." 
                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <select name="department" class="filter-select">
                <option value="">All Departments</option>
                <% if (departments != null && !departments.isEmpty()) { 
                    for (Department dept : departments) { 
                %>
                    <option value="<%= dept.getName() %>" <%= dept.getName().equals(request.getParameter("department")) ? "selected" : "" %>>
                        <%= dept.getName() %>
                    </option>
                <% } 
                } else { %>
                    <option value="IT" <%= "IT".equals(request.getParameter("department")) ? "selected" : "" %>>IT</option>
                    <option value="HR" <%= "HR".equals(request.getParameter("department")) ? "selected" : "" %>>HR</option>
                    <option value="Finance" <%= "Finance".equals(request.getParameter("department")) ? "selected" : "" %>>Finance</option>
                    <option value="Marketing" <%= "Marketing".equals(request.getParameter("department")) ? "selected" : "" %>>Marketing</option>
                    <option value="Sales" <%= "Sales".equals(request.getParameter("department")) ? "selected" : "" %>>Sales</option>
                    <option value="Operations" <%= "Operations".equals(request.getParameter("department")) ? "selected" : "" %>>Operations</option>
                    <option value="R&D" <%= "R&D".equals(request.getParameter("department")) ? "selected" : "" %>>R&D</option>
                <% } %>
            </select>
            <select name="status" class="filter-select">
                <option value="">All Status</option>
                <option value="active" <%= "active".equals(request.getParameter("status")) ? "selected" : "" %>>Active</option>
                <option value="inactive" <%= "inactive".equals(request.getParameter("status")) ? "selected" : "" %>>Inactive</option>
            </select>
            <button type="submit" class="btn btn-info">Search</button>
            <button type="button" onclick="resetFilters()" class="btn">Reset</button>
        </form>
    </div>

    <div class="employees-table">
        <div class="table-header">
            <h3 class="table-title">Employee List</h3>
            <div class="total-count">
                Total Employees: <%= employeeList != null ? employeeList.size() : 0 %>
            </div>
        </div>

        <% if (employeeList != null && !employeeList.isEmpty()) { %>
            <table>
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>Employee</th>
                        <th>Department</th>
                        <th>Designation</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Join Date</th>
                        <th>Salary</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Employee emp : employeeList) { 
                        String initials = "";
                        if (emp.getEmp_name() != null && !emp.getEmp_name().trim().isEmpty()) {
                            String[] nameParts = emp.getEmp_name().split(" ");
                            if (nameParts.length >= 2) {
                                initials = nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1);
                            } else {
                                initials = emp.getEmp_name().substring(0, Math.min(2, emp.getEmp_name().length()));
                            }
                            initials = initials.toUpperCase();
                        } else {
                            initials = "NA";
                        }
                        
                        String statusClass = "status-active";
                        String statusText = "Active";
                        if ("inactive".equals(emp.getStatus())) {
                            statusClass = "status-inactive";
                            statusText = "Inactive";
                        }
                    %>
                    <tr>
                        <td><strong><%= emp.getEmp_id() != null ? emp.getEmp_id() : "N/A" %></strong></td>
                        <td>
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <div class="employee-avatar">
                                    <%= initials %>
                                </div>
                                <div>
                                    <div style="font-weight: 500;"><%= emp.getEmp_name() != null ? emp.getEmp_name() : "N/A" %></div>
                                    <div style="font-size: 12px; color: #666;"><%= emp.getGender() != null ? emp.getGender() : "N/A" %></div>
                                </div>
                            </div>
                        </td>
                        <td><%= emp.getDept() != null ? emp.getDept() : "N/A" %></td>
                        <td><%= emp.getDesg() != null ? emp.getDesg() : "N/A" %></td>
                        <td><%= emp.getEmp_email() != null ? emp.getEmp_email() : "N/A" %></td>
                        <td><%= emp.getEmp_phone() != null ? emp.getEmp_phone() : "N/A" %></td>
                        <td><%= emp.getJoindate() != null ? emp.getJoindate() : "N/A" %></td>
                        <td><%= emp.getTotal_salary() != null ? salaryFormat.format(emp.getTotal_salary()) : "N/A" %></td>
                        <td>
                            <span class="<%= statusClass %>"><%= statusText %></span>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a href="ViewEmpServlet?emp_id=<%= emp.getEmp_id() %>" class="action-btn btn-info">View</a>
                                <a href="EmpUpdateServlet?emp_id=<%= emp.getEmp_id() %>" class="action-btn btn-warning">Edit</a>
                                <% if ("active".equals(emp.getStatus())) { %>
                                    <button class="action-btn btn-secondary" onclick="showStatusModal('<%= emp.getEmp_id() %>', 'inactive', '<%= emp.getEmp_name() != null ? emp.getEmp_name() : "Employee" %>')">Deactivate</button>
                                <% } else { %>
                                    <button class="action-btn btn-success" onclick="showStatusModal('<%= emp.getEmp_id() %>', 'active', '<%= emp.getEmp_name() != null ? emp.getEmp_name() : "Employee" %>')">Activate</button>
                                <% } %>
                                <button class="action-btn btn-danger" onclick="showDeleteModal('<%= emp.getEmp_id() %>', '<%= emp.getEmp_name() != null ? emp.getEmp_name() : "Employee" %>')">Delete</button>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        <% } else { %>
            <div class="no-data">
                <h3>No Employees Found</h3>
                <p>There are no employees in the system yet.</p>
                <a href="addemp.jsp" class="btn btn-success">Add First Employee</a>
            </div>
        <% } %>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Confirm Delete</h3>
            <span class="close" onclick="closeDeleteModal()">&times;</span>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to delete employee: <strong id="deleteEmpName"></strong>?</p>
            <p style="color: #dc3545; font-weight: bold;">This action cannot be undone!</p>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="closeDeleteModal()">Cancel</button>
            <button class="btn btn-danger" id="confirmDeleteBtn">Delete Employee</button>
        </div>
    </div>
</div>

<!-- Status Change Confirmation Modal -->
<div id="statusModal" class="modal">
    <div class="modal-content">
        <div class="modal-header" style="background: #007bff;">
            <h3>Confirm Status Change</h3>
            <span class="close" onclick="closeStatusModal()">&times;</span>
        </div>
        <div class="modal-body">
            <p id="statusModalMessage"></p>
        </div>
        <div class="modal-footer">
            <button class="btn" onclick="closeStatusModal()">Cancel</button>
            <button class="btn btn-primary" id="confirmStatusBtn">Confirm</button>
        </div>
    </div>
</div>

<script>
    let employeeToDelete = '';
    let employeeToUpdate = '';
    let newStatus = '';

    function resetFilters() {
        window.location.href = 'EmpListServlet';
    }

    function showDeleteModal(empId, empName) {
        employeeToDelete = empId;
        document.getElementById('deleteEmpName').textContent = empName;
        document.getElementById('deleteModal').style.display = 'block';
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').style.display = 'none';
        employeeToDelete = '';
    }

    function showStatusModal(empId, status, empName) {
        employeeToUpdate = empId;
        newStatus = status;
        const action = status === 'active' ? 'activate' : 'deactivate';
        
        const messageElement = document.getElementById('statusModalMessage');
        messageElement.innerHTML = 'Are you sure you want to ' + action + ' employee: <strong>' + empName + '</strong>?';
        
        document.getElementById('statusModal').style.display = 'block';
    }

    function closeStatusModal() {
        document.getElementById('statusModal').style.display = 'none';
        employeeToUpdate = '';
        newStatus = '';
    }

    document.getElementById('confirmDeleteBtn').onclick = function() {
        if (employeeToDelete) {
            window.location.href = 'EmpDeleteServlet?emp_id=' + employeeToDelete;
        }
    };

    document.getElementById('confirmStatusBtn').onclick = function() {
        if (employeeToUpdate && newStatus) {
            window.location.href = 'EmpStatusServlet?emp_id=' + employeeToUpdate + '&status=' + newStatus;
        }
    };

    window.onclick = function(event) {
        const deleteModal = document.getElementById('deleteModal');
        const statusModal = document.getElementById('statusModal');
        if (event.target === deleteModal) {
            closeDeleteModal();
        }
        if (event.target === statusModal) {
            closeStatusModal();
        }
    };

    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            closeDeleteModal();
            closeStatusModal();
        }
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
<%@ page import="com.ems.service.StatsService" %>
<%@ page import="com.ems.dao.DepartmentDao" %>
<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    if (currentAdmin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    List<Employee> employeeList = (List<Employee>) request.getAttribute("list");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
    
    StatsService statsService = new StatsService();
    int totalEmployees = statsService.getTotalEmployeesCount();
    int activeEmployees = statsService.getActiveEmployeesCount();
    int newEmployeesThisMonth = statsService.getNewEmployeesThisMonth();
    int totalDepartments = statsService.getTotalDepartmentsCount();
    int inactiveEmployees = statsService.getInactiveEmployeesCount();
    
    DepartmentDao departmentDao = new DepartmentDao();
    List<Department> departments = departmentDao.getAllDepartments();
    
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
<title>WorkSphere Pro - Employee Management</title>
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
    
    .search-section {
        background: rgba(255, 255, 255, 0.95);
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        margin-bottom: 30px;
        animation: fadeInUp 0.8s ease-out 0.4s both;
        position: relative;
        overflow: hidden;
    }
    
    .search-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .search-section:hover::before {
        left: 100%;
    }
    
    .search-form {
        display: flex;
        gap: 15px;
        align-items: center;
        flex-wrap: wrap;
    }
    
    .search-input {
        flex: 1;
        min-width: 300px;
        padding: 14px 20px;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        font-size: 14px;
        font-family: 'Poppins', sans-serif;
        transition: all 0.3s ease;
        background: rgba(248, 249, 250, 0.7);
    }
    
    .search-input:focus {
        outline: none;
        border-color: #3498db;
        background: white;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    }
    
    .filter-select {
        padding: 14px 20px;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        font-size: 14px;
        font-family: 'Poppins', sans-serif;
        min-width: 180px;
        background: rgba(248, 249, 250, 0.7);
        transition: all 0.3s ease;
        cursor: pointer;
    }
    
    .filter-select:focus {
        outline: none;
        border-color: #3498db;
        background: white;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
    }
    
    .employees-table {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        overflow: hidden;
        animation: fadeInUp 0.8s ease-out 0.6s both;
        position: relative;
        width: 100%;
    }
    
    .employees-table::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .employees-table:hover::before {
        left: 100%;
    }
    
    .table-header {
        background: rgba(248, 249, 250, 0.9);
        padding: 25px 30px;
        border-bottom: 1px solid rgba(222, 226, 230, 0.5);
        display: flex;
        justify-content: space-between;
        align-items: center;
        backdrop-filter: blur(10px);
    }
    
    .table-title {
        margin: 0;
        color: #2c3e50;
        font-size: 1.5rem;
        font-weight: 700;
    }
    
    .total-count {
        color: #7f8c8d;
        font-size: 1rem;
        font-weight: 500;
    }
    
    .table-container {
        width: 100%;
        overflow-x: auto;
        max-height: 600px;
        overflow-y: auto;
    }
    
    table {
        width: 100%;
        border-collapse: collapse;
        min-width: 1200px;
    }
    
    th, td {
        padding: 18px 20px;
        text-align: left;
        border-bottom: 1px solid rgba(222, 226, 230, 0.5);
        white-space: nowrap;
    }
    
    th {
        background: rgba(248, 249, 250, 0.9);
        font-weight: 600;
        color: #2c3e50;
        position: sticky;
        top: 0;
        backdrop-filter: blur(10px);
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    
    tr {
        transition: all 0.3s ease;
    }
    
    tr:hover {
        background: rgba(52, 152, 219, 0.05);
    }
    
    .employee-avatar {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        font-size: 16px;
        box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        transition: all 0.3s ease;
    }
    
    tr:hover .employee-avatar {
        transform: scale(1.1) rotate(5deg);
    }
    
    .status-active {
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        color: #155724;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-block;
    }
    
    .status-inactive {
        background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
        color: #721c24;
        padding: 8px 16px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-block;
    }
    
    .action-buttons {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
    }
    
    .action-btn {
        padding: 8px 16px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 0.8rem;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 5px;
        text-align: center;
        transition: all 0.3s ease;
        font-weight: 600;
        min-width: 70px;
        justify-content: center;
    }
    
    .no-data {
        text-align: center;
        padding: 60px 40px;
        color: #7f8c8d;
    }
    
    .no-data h3 {
        font-size: 1.5rem;
        margin-bottom: 15px;
        color: #2c3e50;
    }
    
    .no-data p {
        font-size: 1rem;
        margin-bottom: 25px;
    }
    
    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(5px);
    }
    
    .modal-content {
        background-color: white;
        margin: 10% auto;
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        max-width: 500px;
        width: 90%;
        overflow: hidden;
        animation: modalSlideIn 0.3s ease-out;
    }
    
    @keyframes modalSlideIn {
        from {
            opacity: 0;
            transform: translateY(-50px) scale(0.9);
        }
        to {
            opacity: 1;
            transform: translateY(0) scale(1);
        }
    }
    
    .modal-header {
        padding: 25px 30px;
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .modal-header h3 {
        margin: 0;
        font-size: 1.3rem;
        font-weight: 700;
    }
    
    .close {
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
        line-height: 1;
        transition: transform 0.3s ease;
    }
    
    .close:hover {
        transform: scale(1.2);
    }
    
    .modal-body {
        padding: 30px;
        border-bottom: 1px solid rgba(222, 226, 230, 0.5);
        font-size: 1rem;
        line-height: 1.6;
    }
    
    .modal-footer {
        padding: 25px 30px;
        display: flex;
        justify-content: flex-end;
        gap: 15px;
    }
    
    .status-modal .modal-header {
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
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
    
    @media (max-width: 1200px) {
        table {
            min-width: 1100px;
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
        
        .search-form {
            flex-direction: column;
            align-items: stretch;
        }
        
        .search-input, .filter-select {
            min-width: auto;
        }
        
        .employees-table {
            overflow-x: auto;
        }
        
        table {
            min-width: 1000px;
        }
        
        .action-buttons {
            flex-direction: column;
        }
        
        .action-btn {
            margin-bottom: 5px;
            min-width: 100px;
        }
        
        .modal-content {
            margin: 20% auto;
            width: 95%;
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
        
        .search-section {
            padding: 20px;
        }
        
        .table-header {
            padding: 20px;
        }
        
        .table-title {
            font-size: 1.3rem;
        }
        
        th, td {
            padding: 12px 15px;
        }
        
        .action-btn {
            padding: 6px 12px;
            font-size: 0.7rem;
        }
        
        .employee-avatar {
            width: 40px;
            height: 40px;
            font-size: 14px;
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
        <h1 class="page-title">Employee Management</h1>
        <a href="addemp.jsp" class="btn btn-success">
            <i class="fas fa-user-plus"></i>Add New Employee
        </a>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-user-friends"></i></div>
            <div class="stat-number"><%= totalEmployees %></div>
            <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-user-check"></i></div>
            <div class="stat-number"><%= activeEmployees %></div>
            <div class="stat-label">Active Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-user-clock"></i></div>
            <div class="stat-number"><%= inactiveEmployees %></div>
            <div class="stat-label">Inactive Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-user-plus"></i></div>
            <div class="stat-number"><%= newEmployeesThisMonth %></div>
            <div class="stat-label">New This Month</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-building"></i></div>
            <div class="stat-number"><%= totalDepartments %></div>
            <div class="stat-label">Departments</div>
        </div>
    </div>

    <div class="search-section">
        <form class="search-form" method="get" action="EmpListServlet">
            <input type="text" name="search" class="search-input" placeholder="Search by name, email, or employee ID..." 
                   value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
            <select name="department" class="filter-select">
                <option value="">All Departments</option>
                <% if (departments != null && !departments.isEmpty()) { 
                    for (Department dept : departments) { 
                %>
                    <option value="<%= dept.getName() %>" <%= dept.getName().equals(request.getParameter("department")) ? "selected" : "" %>>
                        <%= dept.getName() %>
                    </option>
                <% } 
                } else { %>
                    <option value="IT" <%= "IT".equals(request.getParameter("department")) ? "selected" : "" %>>IT</option>
                    <option value="HR" <%= "HR".equals(request.getParameter("department")) ? "selected" : "" %>>HR</option>
                    <option value="Finance" <%= "Finance".equals(request.getParameter("department")) ? "selected" : "" %>>Finance</option>
                    <option value="Marketing" <%= "Marketing".equals(request.getParameter("department")) ? "selected" : "" %>>Marketing</option>
                    <option value="Sales" <%= "Sales".equals(request.getParameter("department")) ? "selected" : "" %>>Sales</option>
                    <option value="Operations" <%= "Operations".equals(request.getParameter("department")) ? "selected" : "" %>>Operations</option>
                    <option value="R&D" <%= "R&D".equals(request.getParameter("department")) ? "selected" : "" %>>R&D</option>
                <% } %>
            </select>
            <select name="status" class="filter-select">
                <option value="">All Status</option>
                <option value="active" <%= "active".equals(request.getParameter("status")) ? "selected" : "" %>>Active</option>
                <option value="inactive" <%= "inactive".equals(request.getParameter("status")) ? "selected" : "" %>>Inactive</option>
            </select>
            <button type="submit" class="btn btn-info">
                <i class="fas fa-search"></i>Search
            </button>
            <button type="button" onclick="resetFilters()" class="btn btn-secondary">
                <i class="fas fa-refresh"></i>Reset
            </button>
        </form>
    </div>

    <div class="employees-table">
        <div class="table-header">
            <h3 class="table-title">Employee List</h3>
            <div class="total-count">
                Total Employees: <%= employeeList != null ? employeeList.size() : 0 %>
            </div>
        </div>

        <% if (employeeList != null && !employeeList.isEmpty()) { %>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Employee ID</th>
                            <th>Employee</th>
                            <th>Department</th>
                            <th>Designation</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Join Date</th>
                            <th>Salary</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Employee emp : employeeList) { 
                            String initials = "";
                            if (emp.getEmp_name() != null && !emp.getEmp_name().trim().isEmpty()) {
                                String[] nameParts = emp.getEmp_name().split(" ");
                                if (nameParts.length >= 2) {
                                    initials = nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1);
                                } else {
                                    initials = emp.getEmp_name().substring(0, Math.min(2, emp.getEmp_name().length()));
                                }
                                initials = initials.toUpperCase();
                            } else {
                                initials = "NA";
                            }
                            
                            String statusClass = "status-active";
                            String statusText = "Active";
                            if ("inactive".equals(emp.getStatus())) {
                                statusClass = "status-inactive";
                                statusText = "Inactive";
                            }
                        %>
                        <tr>
                            <td><strong><%= emp.getEmp_id() != null ? emp.getEmp_id() : "N/A" %></strong></td>
                            <td>
                                <div style="display: flex; align-items: center; gap: 15px;">
                                    <div class="employee-avatar">
                                        <%= initials %>
                                    </div>
                                    <div>
                                        <div style="font-weight: 600; color: #2c3e50;"><%= emp.getEmp_name() != null ? emp.getEmp_name() : "N/A" %></div>
                                        <div style="font-size: 0.85rem; color: #7f8c8d;"><%= emp.getGender() != null ? emp.getGender() : "N/A" %></div>
                                    </div>
                                </div>
                            </td>
                            <td><%= emp.getDept() != null ? emp.getDept() : "N/A" %></td>
                            <td><%= emp.getDesg() != null ? emp.getDesg() : "N/A" %></td>
                            <td><%= emp.getEmp_email() != null ? emp.getEmp_email() : "N/A" %></td>
                            <td><%= emp.getEmp_phone() != null ? emp.getEmp_phone() : "N/A" %></td>
                            <td><%= emp.getJoindate() != null ? emp.getJoindate() : "N/A" %></td>
                            <td style="font-weight: 600; color: #27ae60;"><%= emp.getTotal_salary() != null ? salaryFormat.format(emp.getTotal_salary()) : "N/A" %></td>
                            <td>
                                <span class="<%= statusClass %>"><%= statusText %></span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="ViewEmpServlet?emp_id=<%= emp.getEmp_id() %>" class="action-btn btn-info">
                                        <i class="fas fa-eye"></i>View
                                    </a>
                                    <a href="EmpUpdateServlet?emp_id=<%= emp.getEmp_id() %>" class="action-btn btn-warning">
                                        <i class="fas fa-edit"></i>Edit
                                    </a>
                                    <% if ("active".equals(emp.getStatus())) { %>
                                        <button class="action-btn btn-secondary" onclick="showStatusModal('<%= emp.getEmp_id() %>', 'inactive', '<%= emp.getEmp_name() != null ? emp.getEmp_name() : "Employee" %>')">
                                            <i class="fas fa-pause"></i>Deactivate
                                        </button>
                                    <% } else { %>
                                        <button class="action-btn btn-success" onclick="showStatusModal('<%= emp.getEmp_id() %>', 'active', '<%= emp.getEmp_name() != null ? emp.getEmp_name() : "Employee" %>')">
                                            <i class="fas fa-play"></i>Activate
                                        </button>
                                    <% } %>
                                    <button class="action-btn btn-danger" onclick="showDeleteModal('<%= emp.getEmp_id() %>', '<%= emp.getEmp_name() != null ? emp.getEmp_name() : "Employee" %>')">
                                        <i class="fas fa-trash"></i>Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <div class="no-data">
                <h3>No Employees Found</h3>
                <p>There are no employees in the system yet.</p>
                <a href="addemp.jsp" class="btn btn-success">
                    <i class="fas fa-user-plus"></i>Add First Employee
                </a>
            </div>
        <% } %>
    </div>
</div>

<div id="deleteModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Confirm Delete</h3>
            <span class="close" onclick="closeDeleteModal()">&times;</span>
        </div>
        <div class="modal-body">
            <p>Are you sure you want to delete employee: <strong id="deleteEmpName"></strong>?</p>
            <p style="color: #dc3545; font-weight: bold;">This action cannot be undone!</p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeDeleteModal()">Cancel</button>
            <button class="btn btn-danger" id="confirmDeleteBtn">
                <i class="fas fa-trash"></i>Delete Employee
            </button>
        </div>
    </div>
</div>

<div id="statusModal" class="modal status-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Confirm Status Change</h3>
            <span class="close" onclick="closeStatusModal()">&times;</span>
        </div>
        <div class="modal-body">
            <p id="statusModalMessage"></p>
        </div>
        <div class="modal-footer">
            <button class="btn btn-secondary" onclick="closeStatusModal()">Cancel</button>
            <button class="btn btn-primary" id="confirmStatusBtn">
                <i class="fas fa-check"></i>Confirm
            </button>
        </div>
    </div>
</div>

<script>
    let employeeToDelete = '';
    let employeeToUpdate = '';
    let newStatus = '';

    function resetFilters() {
        window.location.href = 'EmpListServlet';
    }

    function showDeleteModal(empId, empName) {
        employeeToDelete = empId;
        document.getElementById('deleteEmpName').textContent = empName;
        document.getElementById('deleteModal').style.display = 'block';
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').style.display = 'none';
        employeeToDelete = '';
    }

    function showStatusModal(empId, status, empName) {
        employeeToUpdate = empId;
        newStatus = status;
        const action = status === 'active' ? 'activate' : 'deactivate';
        
        const messageElement = document.getElementById('statusModalMessage');
        messageElement.innerHTML = 'Are you sure you want to ' + action + ' employee: <strong>' + empName + '</strong>?';
        
        document.getElementById('statusModal').style.display = 'block';
    }

    function closeStatusModal() {
        document.getElementById('statusModal').style.display = 'none';
        employeeToUpdate = '';
        newStatus = '';
    }

    document.getElementById('confirmDeleteBtn').onclick = function() {
        if (employeeToDelete) {
            window.location.href = 'EmpDeleteServlet?emp_id=' + employeeToDelete;
        }
    };

    document.getElementById('confirmStatusBtn').onclick = function() {
        if (employeeToUpdate && newStatus) {
            window.location.href = 'EmpStatusServlet?emp_id=' + employeeToUpdate + '&status=' + newStatus;
        }
    };

    window.onclick = function(event) {
        const deleteModal = document.getElementById('deleteModal');
        const statusModal = document.getElementById('statusModal');
        if (event.target === deleteModal) {
            closeDeleteModal();
        }
        if (event.target === statusModal) {
            closeStatusModal();
        }
    };

    document.addEventListener('keydown', function(event) {
        if (event.key === 'Escape') {
            closeDeleteModal();
            closeStatusModal();
        }
    });

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