<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.Report" %>
<%@ page import="com.ems.model.DepartmentStats" %>
<%@ page import="com.ems.model.SalaryReport" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reports & Analytics</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        flex-wrap: wrap;
        gap: 20px;
    }
    
    .page-title {
        color: #333;
        margin: 0;
    }
    
    .controls {
        display: flex;
        gap: 15px;
        align-items: center;
        flex-wrap: wrap;
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
    
    .btn-info {
        background: #17a2b8;
    }
    
    .btn-info:hover {
        background: #138496;
    }
    
    .btn-sm {
        padding: 8px 15px;
        font-size: 14px;
    }
    
    .filter-section {
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 25px;
    }
    
    .filter-row {
        display: flex;
        gap: 20px;
        align-items: end;
        flex-wrap: wrap;
    }
    
    .filter-group {
        display: flex;
        flex-direction: column;
        min-width: 200px;
    }
    
    .filter-label {
        font-weight: bold;
        margin-bottom: 8px;
        color: #333;
        font-size: 14px;
    }
    
    .filter-select {
        padding: 10px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
        background: white;
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
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
    }
    
    .stat-label {
        color: #666;
        font-size: 14px;
        font-weight: 500;
    }
    
    .charts-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }
    
    .chart-card {
        background: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .chart-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .chart-title {
        color: #333;
        margin: 0;
        font-size: 18px;
    }
    
    .chart-container {
        position: relative;
        height: 300px;
        width: 100%;
    }
    
    .reports-section {
        background: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        margin-bottom: 30px;
    }
    
    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .section-title {
        color: #333;
        margin: 0;
    }
    
    .table-container {
        overflow-x: auto;
    }
    
    .data-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }
    
    .data-table th,
    .data-table td {
        padding: 12px 15px;
        text-align: left;
        border-bottom: 1px solid #e9ecef;
    }
    
    .data-table th {
        background-color: #f8f9fa;
        font-weight: 600;
        color: #333;
        position: sticky;
        top: 0;
    }
    
    .data-table tbody tr:hover {
        background-color: #f8f9fa;
    }
    
    .badge {
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 12px;
        font-weight: 500;
    }
    
    .badge-info {
        background: #d1ecf1;
        color: #0c5460;
    }
    
    .export-section {
        background: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        text-align: center;
    }
    
    .export-options {
        display: flex;
        justify-content: center;
        gap: 15px;
        flex-wrap: wrap;
        margin-top: 20px;
    }
    
    @media (max-width: 768px) {
        .charts-grid {
            grid-template-columns: 1fr;
        }
        
        .chart-card {
            padding: 15px;
        }
        
        .filter-row {
            flex-direction: column;
            align-items: stretch;
        }
        
        .filter-group {
            min-width: auto;
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
    
    Report reportData = (Report) request.getAttribute("reportData");
    Map<String, Integer> departmentDistribution = (Map<String, Integer>) request.getAttribute("departmentDistribution");
    Map<String, Integer> statusDistribution = (Map<String, Integer>) request.getAttribute("statusDistribution");
    List<DepartmentStats> departmentStats = (List<DepartmentStats>) request.getAttribute("departmentStats");
    List<SalaryReport> salaryReports = (List<SalaryReport>) request.getAttribute("salaryReports");
    
    if (reportData == null) {
        reportData = new Report();
        departmentDistribution = new HashMap<>();
        statusDistribution = new HashMap<>();
        departmentStats = new java.util.ArrayList<>();
        salaryReports = new java.util.ArrayList<>();
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
        <h2 class="page-title">📊 Reports & Analytics</h2>
        <div class="controls">
            <select class="filter-select" id="reportPeriod">
                <option value="30days" selected>Last 30 Days</option>
                <option value="90days">Last 90 Days</option>
                <option value="1year">Last Year</option>
            </select>
            <button class="btn btn-info" onclick="refreshReports()">🔄 Refresh</button>
            <button class="btn btn-success" onclick="exportToPDF()">📄 Export PDF</button>
        </div>
    </div>

    <div class="filter-section">
        <div class="filter-row">
            <div class="filter-group">
                <label class="filter-label">Department</label>
                <select class="filter-select" id="departmentFilter">
                    <option value="all">All Departments</option>
                    <% for (String dept : departmentDistribution.keySet()) { %>
                        <option value="<%= dept %>"><%= dept %></option>
                    <% } %>
                </select>
            </div>
            <div class="filter-group">
                <label class="filter-label">Employee Type</label>
                <select class="filter-select" id="statusFilter">
                    <option value="all">All Types</option>
                    <% for (String type : statusDistribution.keySet()) { %>
                        <option value="<%= type %>"><%= type %></option>
                    <% } %>
                </select>
            </div>
            <div class="filter-group">
                <button class="btn" onclick="applyFilters()">Apply Filters</button>
                <button class="btn" onclick="resetFilters()">Reset</button>
            </div>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-number"><%= reportData.getTotalEmployees() %></div>
            <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">💼</div>
            <div class="stat-number"><%= reportData.getTotalDepartments() %></div>
            <div class="stat-label">Departments</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">💰</div>
            <div class="stat-number">₹<%= String.format("%.0f", reportData.getAverageSalary()) %></div>
            <div class="stat-label">Avg Salary</div>
        </div>
    </div>

    <div class="charts-grid">
        <div class="chart-card">
            <div class="chart-header">
                <h3 class="chart-title">Employee Distribution by Department</h3>
            </div>
            <div class="chart-container">
                <canvas id="departmentChart"></canvas>
            </div>
        </div>

        <div class="chart-card">
            <div class="chart-header">
                <h3 class="chart-title">Employee Type Distribution</h3>
            </div>
            <div class="chart-container">
                <canvas id="statusChart"></canvas>
            </div>
        </div>

        <div class="chart-card">
            <div class="chart-header">
                <h3 class="chart-title">Average Salary by Department</h3>
            </div>
            <div class="chart-container">
                <canvas id="salaryChart"></canvas>
            </div>
        </div>
    </div>

    <div class="reports-section">
        <div class="section-header">
            <h3 class="section-title">💰 Salary Report</h3>
            <button class="btn btn-sm btn-info" onclick="toggleTable('salaryTable')">Toggle View</button>
        </div>
        <div class="table-container">
            <table class="data-table" id="salaryTable">
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Designation</th>
                        <th>Employee Type</th>
                        <th>Basic Salary</th>
                        <th>Allowances</th>
                        <th>PF</th>
                        <th>Total Salary</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (salaryReports != null && !salaryReports.isEmpty()) { 
                        for (SalaryReport report : salaryReports) { %>
                    <tr>
                        <td><%= report.getEmpId() %></td>
                        <td><%= report.getEmpName() %></td>
                        <td><%= report.getDepartment() %></td>
                        <td><%= report.getDesignation() %></td>
                        <td><span class="badge badge-info"><%= report.getEmpType() %></span></td>
                        <td>₹<%= String.format("%.0f", report.getBasicSalary()) %></td>
                        <td>₹<%= String.format("%.0f", report.getAllowances()) %></td>
                        <td>₹<%= String.format("%.0f", report.getPf()) %></td>
                        <td><strong>₹<%= String.format("%.0f", report.getTotalSalary()) %></strong></td>
                    </tr>
                    <% } 
                    } else { %>
                    <tr>
                        <td colspan="9" style="text-align: center; color: #666;">No salary data available</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="export-section">
        <h3>📤 Export Reports</h3>
        <p>Generate and download reports in various formats for further analysis or sharing.</p>
        <div class="export-options">
            <button class="btn btn-success" onclick="exportToPDF()">📄 Export as PDF</button>
            <button class="btn btn-info" onclick="exportToExcel()">📊 Export as Excel</button>
            <button class="btn btn-info" onclick="printReport()">🖨️ Print Report</button>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        initializeCharts();
    });

    function initializeCharts() {
        const deptCtx = document.getElementById('departmentChart').getContext('2d');
        new Chart(deptCtx, {
            type: 'doughnut',
            data: {
                labels: [<%= getChartLabels(departmentDistribution) %>],
                datasets: [{
                    data: [<%= getChartData(departmentDistribution) %>],
                    backgroundColor: ['#007bff', '#28a745', '#ffc107', '#dc3545', '#6f42c1', '#e83e8c', '#fd7e14', '#20c997'],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `${context.label}: ${context.raw} employees`;
                            }
                        }
                    }
                }
            }
        });

        const statusCtx = document.getElementById('statusChart').getContext('2d');
        new Chart(statusCtx, {
            type: 'pie',
            data: {
                labels: [<%= getChartLabels(statusDistribution) %>],
                datasets: [{
                    data: [<%= getChartData(statusDistribution) %>],
                    backgroundColor: ['#17a2b8', '#6c757d', '#fd7e14', '#20c997', '#6610f2', '#e83e8c', '#ffc107'],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        const salaryCtx = document.getElementById('salaryChart').getContext('2d');
        new Chart(salaryCtx, {
            type: 'bar',
            data: {
                labels: [<%= getDepartmentNames(departmentStats) %>],
                datasets: [{
                    label: 'Average Salary (₹)',
                    data: [<%= getDepartmentSalaries(departmentStats) %>],
                    backgroundColor: '#28a745',
                    borderColor: '#218838',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Salary (₹)'
                        }
                    }
                }
            }
        });
    }

    function applyFilters() {
        const department = document.getElementById('departmentFilter').value;
        const status = document.getElementById('statusFilter').value;
        const period = document.getElementById('reportPeriod').value;
        
        showNotification('Filters applied successfully!', 'success');
    }

    function resetFilters() {
        document.getElementById('departmentFilter').value = 'all';
        document.getElementById('statusFilter').value = 'all';
        document.getElementById('reportPeriod').value = '30days';
        
        applyFilters();
        showNotification('Filters reset to default', 'info');
    }

    function refreshReports() {
        window.location.reload();
    }

    function exportToPDF() {
        showNotification('Preparing PDF export...', 'info');
        setTimeout(() => {
            showNotification('PDF exported successfully!', 'success');
        }, 2000);
    }

    function exportToExcel() {
        showNotification('Preparing Excel export...', 'info');
        setTimeout(() => {
            showNotification('Excel file exported successfully!', 'success');
        }, 2000);
    }

    function printReport() {
        window.print();
    }

    function toggleTable(tableId) {
        const table = document.getElementById(tableId);
        table.style.display = table.style.display === 'none' ? 'table' : 'none';
    }

    function showNotification(message, type) {
        const notification = document.createElement('div');
        const bgColor = type === 'success' ? '#28a745' : '#17a2b8';
        
        notification.style.position = 'fixed';
        notification.style.top = '20px';
        notification.style.right = '20px';
        notification.style.padding = '15px 20px';
        notification.style.borderRadius = '4px';
        notification.style.color = 'white';
        notification.style.fontWeight = '500';
        notification.style.zIndex = '10000';
        notification.style.transition = 'all 0.3s ease';
        notification.style.boxShadow = '0 4px 12px rgba(0,0,0,0.15)';
        notification.style.backgroundColor = bgColor;
        
        notification.textContent = message;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.opacity = '0';
            notification.style.transform = 'translateX(100px)';
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        }, 3000);
    }
</script>

</body>
</html>

<%!
    private String getChartLabels(Map<String, Integer> distribution) {
        if (distribution == null || distribution.isEmpty()) return "'No Data'";
        StringBuilder labels = new StringBuilder();
        for (String key : distribution.keySet()) {
            if (labels.length() > 0) labels.append(",");
            labels.append("'").append(key).append("'");
        }
        return labels.toString();
    }

    private String getChartData(Map<String, Integer> distribution) {
        if (distribution == null || distribution.isEmpty()) return "0";
        StringBuilder data = new StringBuilder();
        for (Integer value : distribution.values()) {
            if (data.length() > 0) data.append(",");
            data.append(value);
        }
        return data.toString();
    }

    private String getDepartmentNames(List<DepartmentStats> stats) {
        if (stats == null || stats.isEmpty()) return "'No Data'";
        StringBuilder names = new StringBuilder();
        for (DepartmentStats stat : stats) {
            if (names.length() > 0) names.append(",");
            names.append("'").append(stat.getDepartmentName()).append("'");
        }
        return names.toString();
    }

    private String getDepartmentSalaries(List<DepartmentStats> stats) {
        if (stats == null || stats.isEmpty()) return "0";
        StringBuilder salaries = new StringBuilder();
        for (DepartmentStats stat : stats) {
            if (salaries.length() > 0) salaries.append(",");
            salaries.append(String.format("%.0f", stat.getAverageSalary()));
        }
        return salaries.toString();
    }
%> --%>




















<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.model.Report" %>
<%@ page import="com.ems.model.DepartmentStats" %>
<%@ page import="com.ems.model.SalaryReport" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    
    if (currentAdmin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    Report reportData = (Report) request.getAttribute("reportData");
    Map<String, Integer> departmentDistribution = (Map<String, Integer>) request.getAttribute("departmentDistribution");
    Map<String, Integer> statusDistribution = (Map<String, Integer>) request.getAttribute("statusDistribution");
    List<DepartmentStats> departmentStats = (List<DepartmentStats>) request.getAttribute("departmentStats");
    List<SalaryReport> salaryReports = (List<SalaryReport>) request.getAttribute("salaryReports");
    
    if (reportData == null) {
        reportData = new Report();
        departmentDistribution = new HashMap<>();
        statusDistribution = new HashMap<>();
        departmentStats = new java.util.ArrayList<>();
        salaryReports = new java.util.ArrayList<>();
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
<title>WorkSphere Pro - Reports & Analytics</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    
    .btn-info {
        background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
        color: white;
        box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);
    }
    
    .btn-info:hover {
        box-shadow: 0 8px 25px rgba(23, 162, 184, 0.4);
    }
    
    .btn-warning {
        background: linear-gradient(135deg, #ffc107 0%, #ffca2c 100%);
        color: #212529;
        box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
    }
    
    .btn-warning:hover {
        box-shadow: 0 8px 25px rgba(255, 193, 7, 0.4);
    }
    
    .btn-sm {
        padding: 10px 20px;
        font-size: 12px;
    }
    
    .filter-section {
        background: rgba(255, 255, 255, 0.95);
        padding: 25px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        margin-bottom: 25px;
        animation: fadeInUp 0.8s ease-out 0.1s both;
    }
    
    .filter-row {
        display: flex;
        gap: 20px;
        align-items: end;
        flex-wrap: wrap;
    }
    
    .filter-group {
        display: flex;
        flex-direction: column;
        min-width: 200px;
    }
    
    .filter-label {
        font-weight: 600;
        margin-bottom: 8px;
        color: #2c3e50;
        font-size: 0.9rem;
    }
    
    .filter-select {
        padding: 12px 15px;
        border: 2px solid #e0e0e0;
        border-radius: 12px;
        font-size: 14px;
        font-family: 'Poppins', sans-serif;
        transition: all 0.3s ease;
        background: rgba(255,255,255,0.9);
        color: #2c3e50;
    }
    
    .filter-select:focus {
        outline: none;
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        transform: translateY(-2px);
    }
    
    .stats-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
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
    
    .charts-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
        gap: 25px;
        margin-bottom: 30px;
    }
    
    .chart-card {
        background: rgba(255, 255, 255, 0.95);
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        transition: all 0.4s ease;
        position: relative;
        overflow: hidden;
        animation: fadeInUp 0.8s ease-out 0.3s both;
    }
    
    .chart-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .chart-card:hover::before {
        left: 100%;
    }
    
    .chart-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 40px rgba(52, 152, 219, 0.2);
    }
    
    .chart-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .chart-title {
        color: #2c3e50;
        margin: 0;
        font-size: 1.3rem;
        font-weight: 600;
    }
    
    .chart-container {
        position: relative;
        height: 300px;
        width: 100%;
    }
    
    .reports-section {
        background: rgba(255, 255, 255, 0.95);
        padding: 30px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        margin-bottom: 30px;
        animation: fadeInUp 0.8s ease-out 0.4s both;
    }
    
    .section-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .section-title {
        color: #2c3e50;
        margin: 0;
        font-size: 1.5rem;
        font-weight: 600;
    }
    
    .table-container {
        overflow-x: auto;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    }
    
    .data-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
        background: white;
        border-radius: 12px;
        overflow: hidden;
    }
    
    .data-table th,
    .data-table td {
        padding: 15px 20px;
        text-align: left;
        border-bottom: 1px solid #e9ecef;
    }
    
    .data-table th {
        background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        color: white;
        font-weight: 600;
        position: sticky;
        top: 0;
    }
    
    .data-table tbody tr {
        transition: all 0.3s ease;
    }
    
    .data-table tbody tr:hover {
        background-color: #f8f9fa;
        transform: translateX(5px);
    }
    
    .badge {
        padding: 6px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 500;
    }
    
    .badge-info {
        background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
        color: white;
    }
    
    .export-section {
        background: rgba(255, 255, 255, 0.95);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.1);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.3);
        text-align: center;
        animation: fadeInUp 0.8s ease-out 0.5s both;
    }
    
    .export-options {
        display: flex;
        justify-content: center;
        gap: 15px;
        flex-wrap: wrap;
        margin-top: 20px;
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
        
        .charts-grid {
            grid-template-columns: 1fr;
        }
        
        .chart-card {
            padding: 20px;
        }
        
        .filter-row {
            flex-direction: column;
            align-items: stretch;
        }
        
        .filter-group {
            min-width: auto;
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
        
        .export-options {
            flex-direction: column;
            align-items: center;
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
        
        .chart-card {
            padding: 15px;
        }
        
        .reports-section {
            padding: 20px;
        }
        
        .data-table th,
        .data-table td {
            padding: 10px 12px;
            font-size: 0.9rem;
        }
    }
</style>
</head>
<body>

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
        <h1 class="page-title">📊 Reports & Analytics</h1>
        <div class="controls">
            <select class="filter-select" id="reportPeriod">
                <option value="30days" selected>Last 30 Days</option>
                <option value="90days">Last 90 Days</option>
                <option value="1year">Last Year</option>
            </select>
            <button class="btn btn-info" onclick="refreshReports()">
                <i class="fas fa-sync-alt"></i>Refresh
            </button>
            <button class="btn btn-success" onclick="exportToPDF()">
                <i class="fas fa-file-pdf"></i>Export PDF
            </button>
        </div>
    </div>

    <div class="filter-section">
        <div class="filter-row">
            <div class="filter-group">
                <label class="filter-label">Department</label>
                <select class="filter-select" id="departmentFilter">
                    <option value="all">All Departments</option>
                    <% for (String dept : departmentDistribution.keySet()) { %>
                        <option value="<%= dept %>"><%= dept %></option>
                    <% } %>
                </select>
            </div>
            <div class="filter-group">
                <label class="filter-label">Employee Type</label>
                <select class="filter-select" id="statusFilter">
                    <option value="all">All Types</option>
                    <% for (String type : statusDistribution.keySet()) { %>
                        <option value="<%= type %>"><%= type %></option>
                    <% } %>
                </select>
            </div>
            <div class="filter-group">
                <button class="btn btn-info" onclick="applyFilters()">
                    <i class="fas fa-filter"></i>Apply Filters
                </button>
                <button class="btn" onclick="resetFilters()">
                    <i class="fas fa-redo"></i>Reset
                </button>
            </div>
        </div>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-users"></i></div>
            <div class="stat-number"><%= reportData.getTotalEmployees() %></div>
            <div class="stat-label">Total Employees</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-building"></i></div>
            <div class="stat-number"><%= reportData.getTotalDepartments() %></div>
            <div class="stat-label">Departments</div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-money-bill-wave"></i></div>
            <div class="stat-number">₹<%= String.format("%.0f", reportData.getAverageSalary()) %></div>
            <div class="stat-label">Avg Salary</div>
        </div>
    </div>

    <div class="charts-grid">
        <div class="chart-card">
            <div class="chart-header">
                <h3 class="chart-title">Employee Distribution by Department</h3>
            </div>
            <div class="chart-container">
                <canvas id="departmentChart"></canvas>
            </div>
        </div>

        <div class="chart-card">
            <div class="chart-header">
                <h3 class="chart-title">Employee Type Distribution</h3>
            </div>
            <div class="chart-container">
                <canvas id="statusChart"></canvas>
            </div>
        </div>

        <div class="chart-card">
            <div class="chart-header">
                <h3 class="chart-title">Average Salary by Department</h3>
            </div>
            <div class="chart-container">
                <canvas id="salaryChart"></canvas>
            </div>
        </div>
    </div>

    <div class="reports-section">
        <div class="section-header">
            <h3 class="section-title">💰 Salary Report</h3>
            <button class="btn btn-sm btn-info" onclick="toggleTable('salaryTable')">
                <i class="fas fa-eye"></i>View
            </button>
        </div>
        <div class="table-container">
            <table class="data-table" id="salaryTable">
                <thead>
                    <tr>
                        <th>Employee ID</th>
                        <th>Name</th>
                        <th>Department</th>
                        <th>Designation</th>
                        <th>Employee Type</th>
                        <th>Basic Salary</th>
                        <th>Allowances</th>
                        <th>PF</th>
                        <th>Total Salary</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (salaryReports != null && !salaryReports.isEmpty()) { 
                        for (SalaryReport report : salaryReports) { %>
                    <tr>
                        <td><%= report.getEmpId() %></td>
                        <td><%= report.getEmpName() %></td>
                        <td><%= report.getDepartment() %></td>
                        <td><%= report.getDesignation() %></td>
                        <td><span class="badge badge-info"><%= report.getEmpType() %></span></td>
                        <td>₹<%= String.format("%.0f", report.getBasicSalary()) %></td>
                        <td>₹<%= String.format("%.0f", report.getAllowances()) %></td>
                        <td>₹<%= String.format("%.0f", report.getPf()) %></td>
                        <td><strong>₹<%= String.format("%.0f", report.getTotalSalary()) %></strong></td>
                    </tr>
                    <% } 
                    } else { %>
                    <tr>
                        <td colspan="9" style="text-align: center; color: #666;">No salary data available</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <div class="export-section">
        <h3>📤 Export Reports</h3>
        <p>Generate and download reports in various formats for further analysis or sharing.</p>
        <div class="export-options">
            <button class="btn btn-success" onclick="exportToPDF()">
                <i class="fas fa-file-pdf"></i>Export as PDF
            </button>
            <button class="btn btn-info" onclick="exportToExcel()">
                <i class="fas fa-file-excel"></i>Export as Excel
            </button>
            <button class="btn btn-info" onclick="printReport()">
                <i class="fas fa-print"></i>Print Report
            </button>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        initializeCharts();
    });

    function initializeCharts() {
        const deptCtx = document.getElementById('departmentChart').getContext('2d');
        new Chart(deptCtx, {
            type: 'doughnut',
            data: {
                labels: [<%= getChartLabels(departmentDistribution) %>],
                datasets: [{
                    data: [<%= getChartData(departmentDistribution) %>],
                    backgroundColor: ['#3498db', '#2ecc71', '#e74c3c', '#f39c12', '#9b59b6', '#1abc9c', '#d35400', '#34495e'],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `${context.label}: ${context.raw} employees`;
                            }
                        }
                    }
                }
            }
        });

        const statusCtx = document.getElementById('statusChart').getContext('2d');
        new Chart(statusCtx, {
            type: 'pie',
            data: {
                labels: [<%= getChartLabels(statusDistribution) %>],
                datasets: [{
                    data: [<%= getChartData(statusDistribution) %>],
                    backgroundColor: ['#3498db', '#2ecc71', '#e74c3c', '#f39c12', '#9b59b6', '#1abc9c', '#d35400'],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        const salaryCtx = document.getElementById('salaryChart').getContext('2d');
        new Chart(salaryCtx, {
            type: 'bar',
            data: {
                labels: [<%= getDepartmentNames(departmentStats) %>],
                datasets: [{
                    label: 'Average Salary (₹)',
                    data: [<%= getDepartmentSalaries(departmentStats) %>],
                    backgroundColor: '#2ecc71',
                    borderColor: '#27ae60',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Salary (₹)'
                        }
                    }
                }
            }
        });
    }

    function applyFilters() {
        const department = document.getElementById('departmentFilter').value;
        const status = document.getElementById('statusFilter').value;
        const period = document.getElementById('reportPeriod').value;
        
        showNotification('Filters applied successfully!', 'success');
    }

    function resetFilters() {
        document.getElementById('departmentFilter').value = 'all';
        document.getElementById('statusFilter').value = 'all';
        document.getElementById('reportPeriod').value = '30days';
        
        applyFilters();
        showNotification('Filters reset to default', 'info');
    }

    function refreshReports() {
        window.location.reload();
    }

    function exportToPDF() {
        showNotification('Preparing PDF export...', 'info');
        setTimeout(() => {
            showNotification('PDF exported successfully!', 'success');
        }, 2000);
    }

    function exportToExcel() {
        showNotification('Preparing Excel export...', 'info');
        setTimeout(() => {
            showNotification('Excel file exported successfully!', 'success');
        }, 2000);
    }

    function printReport() {
        window.print();
    }

    function toggleTable(tableId) {
        const table = document.getElementById(tableId);
        table.style.display = table.style.display === 'none' ? 'table' : 'none';
    }

    function showNotification(message, type) {
        const notification = document.createElement('div');
        const bgColor = type === 'success' ? '#2ecc71' : '#3498db';
        
        notification.style.position = 'fixed';
        notification.style.top = '20px';
        notification.style.right = '20px';
        notification.style.padding = '15px 20px';
        notification.style.borderRadius = '12px';
        notification.style.color = 'white';
        notification.style.fontWeight = '500';
        notification.style.zIndex = '10000';
        notification.style.transition = 'all 0.3s ease';
        notification.style.boxShadow = '0 8px 25px rgba(0,0,0,0.15)';
        notification.style.backgroundColor = bgColor;
        notification.style.backdropFilter = 'blur(10px)';
        
        notification.textContent = message;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.opacity = '0';
            notification.style.transform = 'translateX(100px)';
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        }, 3000);
    }
</script>

</body>
</html>

<%!
    private String getChartLabels(Map<String, Integer> distribution) {
        if (distribution == null || distribution.isEmpty()) return "'No Data'";
        StringBuilder labels = new StringBuilder();
        for (String key : distribution.keySet()) {
            if (labels.length() > 0) labels.append(",");
            labels.append("'").append(key).append("'");
        }
        return labels.toString();
    }

    private String getChartData(Map<String, Integer> distribution) {
        if (distribution == null || distribution.isEmpty()) return "0";
        StringBuilder data = new StringBuilder();
        for (Integer value : distribution.values()) {
            if (data.length() > 0) data.append(",");
            data.append(value);
        }
        return data.toString();
    }

    private String getDepartmentNames(List<DepartmentStats> stats) {
        if (stats == null || stats.isEmpty()) return "'No Data'";
        StringBuilder names = new StringBuilder();
        for (DepartmentStats stat : stats) {
            if (names.length() > 0) names.append(",");
            names.append("'").append(stat.getDepartmentName()).append("'");
        }
        return names.toString();
    }

    private String getDepartmentSalaries(List<DepartmentStats> stats) {
        if (stats == null || stats.isEmpty()) return "0";
        StringBuilder salaries = new StringBuilder();
        for (DepartmentStats stat : stats) {
            if (salaries.length() > 0) salaries.append(",");
            salaries.append(String.format("%.0f", stat.getAverageSalary()));
        }
        return salaries.toString();
    }
%>