<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.util.ColorUtils" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>
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
    
    .container {
        max-width: 800px;
        margin: 100px auto 30px auto;
        padding: 0 20px;
        z-index: 1;
    }
    
    .profile-form {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    
    .form-group {
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
    .form-group input[type="file"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
    }
    
    .avatar-preview {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        margin: 0 auto 20px;
        overflow: hidden;
        border: 3px solid #007bff;
    }
    
    .avatar-preview img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .random-avatar {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 50px;
        color: white;
        text-transform: uppercase;
        font-weight: bold;
    }
    
    .btn-update {
        background: #007bff;
        color: white;
        padding: 12px 30px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
        transition: background 0.3s;
    }
    
    .btn-update:hover {
        background: #0056b3;
    }
    
    .remove-picture {
        display: block;
        text-align: center;
        margin: 10px 0 20px 0;
    }
    
    .remove-picture label {
        display: inline-flex;
        align-items: center;
        cursor: pointer;
        color: #666;
    }
    
    .remove-picture input {
        margin-right: 8px;
    }
    
    .message {
        padding: 10px;
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
    
    .error-message { 
        color: red; 
        font-size: 0.9em;
        display: block;
        margin-top: 5px;
    }
    
    .success-message {
        color: green;
        font-size: 0.9em;
        display: block;
        margin-top: 5px;
    }
    
    .checking-message {
        color: #007bff;
        font-size: 0.9em;
        display: block;
        margin-top: 5px;
    }
    
    small {
        color: #666;
        font-size: 0.8em;
    }
    
    input:focus {
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0,123,255,0.3);
    }
</style>
</head>
<body>

<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    
    if (currentAdmin == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String fullname = currentAdmin.getFullname();
    String initials = currentAdmin.getInitials();
    String profilePicture = currentAdmin.getProfilePicture();
    
    String successMsg = (String) session.getAttribute("successMsg");
    String errorMsg = (String) session.getAttribute("errorMsg");
    
    String colorSeed = String.valueOf(currentAdmin.getId()) + currentAdmin.getUsername();
    String randomColor = ColorUtils.generateRandomColor(colorSeed);
    
    String profilePictureUrl = null;
    if (profilePicture != null && !profilePicture.isEmpty()) {
        profilePictureUrl = request.getContextPath() + "/uploads/profiles/" + profilePicture + "?v=" + System.currentTimeMillis();
    }
%>

<div class="header">
    <h1>Employee Management System</h1>
    <div class="nav-links">
        <a href="AdminHomeServlet">Home</a>
        <a href="EmpListServlet">Employees</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<div class="container">
    <div class="profile-form">
        <h2>My Profile</h2>
        
        <% if (successMsg != null) { %>
            <div class="message message-success">
                <%= successMsg %>
            </div>
            <% session.removeAttribute("successMsg"); %>
        <% } %>
        
        <% if (errorMsg != null) { %>
            <div class="message message-error">
                <%= errorMsg %>
            </div>
            <% session.removeAttribute("errorMsg"); %>
        <% } %>
        
        <div class="avatar-preview">
            <% if (profilePictureUrl != null) { %>
                <img src="<%= profilePictureUrl %>" 
                     alt="Profile Picture" 
                     id="avatarPreview"
                     onerror="this.style.display='none'; document.getElementById('randomAvatar').style.display='flex';">
                <div id="randomAvatar" class="random-avatar" style="display: none; background-color: <%= randomColor %>;">
                    <%= initials %>
                </div>
            <% } else { %>
                <div id="randomAvatar" class="random-avatar" style="background-color: <%= randomColor %>;">
                    <%= initials %>
                </div>
            <% } %>
        </div>

        <form action="ProfileUpdateServlet" method="post" enctype="multipart/form-data" id="profileForm">
            <div class="form-group">
                <label for="profilePicture">Profile Picture</label>
                <input type="file" id="profilePicture" name="profilePicture" accept="image/*" onchange="previewImage(this)">
                <small>Supported formats: JPG, PNG, GIF. Max size: 10MB</small>
            </div>
            
            <% if (profilePicture != null && !profilePicture.isEmpty()) { %>
            <div class="remove-picture">
                <label>
                    <input type="checkbox" id="removePicture" name="removePicture" value="true">
                    Remove current profile picture
                </label>
            </div>
            <% } %>
            
            <div class="form-group">
                <label for="fullname">Full Name</label>
                <input type="text" id="fullname" name="fullname" value="<%= currentAdmin.getFullname() != null ? currentAdmin.getFullname() : "" %>" required>
            </div>
            
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" value="<%= currentAdmin.getUsername() != null ? currentAdmin.getUsername() : "" %>" required
                       oninput="validateProfileUsername()">
                <span id="username-error" class="error-message"></span>
                <span id="username-availability" class="checking-message"></span>
                <small>Username must contain alphabets, digits, AND special characters</small>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= currentAdmin.getEmail() != null ? currentAdmin.getEmail() : "" %>" required
                       oninput="validateProfileEmail()">
                <span id="email-error" class="error-message"></span>
                <span id="email-availability" class="checking-message"></span>
            </div>
            
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="text" id="phone" name="phone" value="<%= currentAdmin.getPhone() != null ? currentAdmin.getPhone() : "" %>"
                       maxlength="10" placeholder="Enter 10-digit phone number"
                       oninput="validateProfilePhone()">
                <span id="phone-error" class="error-message"></span>
                <small>Phone number must be 10 digits starting with 6-9</small>
            </div>
            
            <button type="submit" class="btn-update" id="update-btn">Update Profile</button>
        </form>
    </div>
</div>

<script>
    const originalUsername = '<%= currentAdmin.getUsername() %>';
    const originalEmail = '<%= currentAdmin.getEmail() %>';
    let isUsernameAvailable = true;
    let isEmailAvailable = true;
    let usernameTimeout;
    let emailTimeout;

    function validateProfileUsername() {
        const usernameInput = document.getElementById('username');
        const errorElement = document.getElementById('username-error');
        const availabilityElement = document.getElementById('username-availability');
        const username = usernameInput.value;
        
        const hasAlpha = /[A-Za-z]/.test(username);
        const hasDigit = /\d/.test(username);
        const hasSpecial = /[^A-Za-z0-9\s]/.test(username);

        clearTimeout(usernameTimeout);

        if (username.length === 0) {
            errorElement.textContent = "";
            availabilityElement.textContent = "";
            isUsernameAvailable = false;
            return false;
        } else if (!hasAlpha || !hasDigit || !hasSpecial) {
            errorElement.textContent = "Username must contain alphabets, digits, AND special characters.";
            errorElement.style.color = 'red';
            availabilityElement.textContent = "";
            isUsernameAvailable = false;
            return false;
        } else {
            errorElement.textContent = "Username format is valid!";
            errorElement.style.color = 'green';
            
            if (username !== originalUsername) {
                availabilityElement.textContent = "Checking availability...";
                availabilityElement.style.color = '#007bff';
                
                usernameTimeout = setTimeout(() => {
                    checkUsernameAvailability(username)
                        .then(available => {
                            isUsernameAvailable = available;
                            if (available) {
                                availabilityElement.textContent = "✓ Username is available!";
                                availabilityElement.style.color = 'green';
                            } else {
                                availabilityElement.textContent = "✗ Username is already taken!";
                                availabilityElement.style.color = 'red';
                            }
                        })
                        .catch(error => {
                            console.error('Error checking username availability:', error);
                            availabilityElement.textContent = "⚠ Error checking availability";
                            availabilityElement.style.color = 'orange';
                        });
                }, 500);
            } else {
                isUsernameAvailable = true;
                availabilityElement.textContent = "";
            }
            return true;
        }
    }

    function validateProfileEmail() {
        const emailInput = document.getElementById('email');
        const errorElement = document.getElementById('email-error');
        const availabilityElement = document.getElementById('email-availability');
        const email = emailInput.value;
        
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        clearTimeout(emailTimeout);

        if (email.length === 0) {
            errorElement.textContent = "";
            availabilityElement.textContent = "";
            isEmailAvailable = false;
            return false;
        } else if (!emailRegex.test(email)) {
            errorElement.textContent = "Please enter a valid email address.";
            errorElement.style.color = 'red';
            availabilityElement.textContent = "";
            isEmailAvailable = false;
            return false;
        } else {
            errorElement.textContent = "✓ Valid email format!";
            errorElement.style.color = 'green';
            
            if (email !== originalEmail) {
                availabilityElement.textContent = "Checking availability...";
                availabilityElement.style.color = '#007bff';
                
                emailTimeout = setTimeout(() => {
                    checkEmailAvailability(email)
                        .then(available => {
                            isEmailAvailable = available;
                            if (available) {
                                availabilityElement.textContent = "✓ Email is available!";
                                availabilityElement.style.color = 'green';
                            } else {
                                availabilityElement.textContent = "✗ Email is already registered!";
                                availabilityElement.style.color = 'red';
                            }
                        })
                        .catch(error => {
                            console.error('Error checking email availability:', error);
                            availabilityElement.textContent = "⚠ Error checking availability";
                            availabilityElement.style.color = 'orange';
                        });
                }, 500); 
            } else {
                isEmailAvailable = true;
                availabilityElement.textContent = "";
            }
            return true;
        }
    }

    function validateProfilePhone() {
        const phoneInput = document.getElementById('phone');
        const errorElement = document.getElementById('phone-error');
        const phone = phoneInput.value.replace(/\D/g, '');
        
        phoneInput.value = phone;
        
        const phoneRegex = /^[6-9]\d{9}$/;

        if (phone.length === 0) {
            errorElement.textContent = "";
            return true;
        } else if (!phoneRegex.test(phone)) {
            errorElement.textContent = "Please enter a valid 10-digit phone number starting with 6-9.";
            errorElement.style.color = 'red';
            return false;
        } else {
            errorElement.textContent = "✓ Valid phone number!";
            errorElement.style.color = 'green';
            return true;
        }
    }

    function checkUsernameAvailability(username) {
        return new Promise((resolve, reject) => {
            if (username.length === 0) {
                resolve(false);
                return;
            }
            
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'CheckAvailabilityServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        try {
                            const response = JSON.parse(xhr.responseText);
                            resolve(response.available);
                        } catch (e) {
                            reject(new Error('Invalid JSON response'));
                        }
                    } else {
                        reject(new Error('Request failed with status: ' + xhr.status));
                    }
                }
            };
            
            xhr.onerror = function() {
                reject(new Error('Request error'));
            };
            
            xhr.timeout = 10000;
            xhr.ontimeout = function() {
                reject(new Error('Request timeout'));
            };
            
            xhr.send('type=username&value=' + encodeURIComponent(username));
        });
    }

    function checkEmailAvailability(email) {
        return new Promise((resolve, reject) => {
            if (email.length === 0) {
                resolve(false);
                return;
            }
            
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'CheckAvailabilityServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        try {
                            const response = JSON.parse(xhr.responseText);
                            resolve(response.available);
                        } catch (e) {
                            reject(new Error('Invalid JSON response'));
                        }
                    } else {
                        reject(new Error('Request failed with status: ' + xhr.status));
                    }
                }
            };
            
            xhr.onerror = function() {
                reject(new Error('Request error'));
            };
            
            xhr.timeout = 10000;
            xhr.ontimeout = function() {
                reject(new Error('Request timeout'));
            };
            
            xhr.send('type=email&value=' + encodeURIComponent(email));
        });
    }

    document.getElementById('profileForm').addEventListener('submit', function(event) {
        event.preventDefault();
        
        const isUsernameValid = validateProfileUsername();
        const isEmailValid = validateProfileEmail();
        const isPhoneValid = validateProfilePhone();
        
        const fullname = document.getElementById('fullname').value.trim();
        const username = document.getElementById('username').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();
        
        if (!fullname) {
            alert("Please enter your full name.");
            return false;
        }
        
        if (!isUsernameValid) {
            alert("Please correct the username format. It must contain alphabets, digits, AND special characters.");
            return false;
        }
        
        if (!isEmailValid) {
            alert("Please enter a valid email address.");
            return false;
        }
        
        if (phone && !isPhoneValid) {
            alert("Please enter a valid 10-digit phone number starting with 6-9.");
            return false;
        }

        if (!validateFile()) {
            return false;
        }

        const updateBtn = document.getElementById('update-btn');
        updateBtn.disabled = true;
        updateBtn.textContent = 'Checking...';

        Promise.all([
            username !== originalUsername ? checkUsernameAvailability(username) : Promise.resolve(true),
            email !== originalEmail ? checkEmailAvailability(email) : Promise.resolve(true)
        ])
        .then(([usernameAvailable, emailAvailable]) => {
            isUsernameAvailable = usernameAvailable;
            isEmailAvailable = emailAvailable;

            if (!isUsernameAvailable || !isEmailAvailable) {
                if (!isUsernameAvailable && !isEmailAvailable) {
                    alert("Username and email are already registered! Please use different credentials.");
                } else if (!isUsernameAvailable) {
                    alert("Username is already registered! Please choose a different username.");
                } else if (!isEmailAvailable) {
                    alert("Email is already registered! Please use a different email address.");
                }
                updateBtn.disabled = false;
                updateBtn.textContent = 'Update Profile';
                return;
            }

            updateBtn.textContent = 'Updating...';
            this.submit();
        })
        .catch(error => {
            console.error('Error during final availability check:', error);
            alert("Error checking availability. Please try again.");
            updateBtn.disabled = false;
            updateBtn.textContent = 'Update Profile';
        });
    });

    function validateFile() {
        const fileInput = document.getElementById('profilePicture');
        const file = fileInput.files[0];
        const removePictureCheckbox = document.getElementById('removePicture');
        
        if (removePictureCheckbox && removePictureCheckbox.checked) {
            return true;
        }
        
        if (file) {
            const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
            const maxSize = 10 * 1024 * 1024;
            
            if (!validTypes.includes(file.type)) {
                alert('Please select a valid image file (JPG, PNG, GIF).');
                return false;
            }
            
            if (file.size > maxSize) {
                alert('File size must be less than 10MB.');
                return false;
            }
        }
        
        return true;
    }

    function previewImage(input) {
        const preview = document.getElementById('avatarPreview');
        const randomAvatar = document.getElementById('randomAvatar');
        const removePictureCheckbox = document.getElementById('removePicture');
        
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                if (removePictureCheckbox) {
                    removePictureCheckbox.checked = false;
                }
                
                if (randomAvatar) {
                    randomAvatar.style.display = 'none';
                }
                if (!preview) {
                    const avatarPreview = document.createElement('img');
                    avatarPreview.id = 'avatarPreview';
                    avatarPreview.alt = 'Profile Picture';
                    avatarPreview.style.width = '100%';
                    avatarPreview.style.height = '100%';
                    avatarPreview.style.objectFit = 'cover';
                    document.querySelector('.avatar-preview').appendChild(avatarPreview);
                    document.getElementById('avatarPreview').src = e.target.result;
                } else {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                }
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        const removePictureCheckbox = document.getElementById('removePicture');
        const fileInput = document.getElementById('profilePicture');
        const randomAvatar = document.getElementById('randomAvatar');
        const preview = document.getElementById('avatarPreview');
        
        validateProfileUsername();
        validateProfileEmail();
        validateProfilePhone();
        
        if (removePictureCheckbox) {
            removePictureCheckbox.addEventListener('change', function() {
                if (this.checked) {
                    if (fileInput) {
                        fileInput.value = '';
                    }
                    if (preview) {
                        preview.style.display = 'none';
                    }
                    if (randomAvatar) {
                        randomAvatar.style.display = 'flex';
                    }
                }
            });
        }
    });
</script>

</body>
</html> --%>














<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ems.model.Admin" %>
<%@ page import="com.ems.util.ColorUtils" %>
<%
    Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
    
    if (currentAdmin == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    String fullname = currentAdmin.getFullname();
    String initials = currentAdmin.getInitials();
    String profilePicture = currentAdmin.getProfilePicture();
    
    String successMsg = (String) session.getAttribute("successMsg");
    String errorMsg = (String) session.getAttribute("errorMsg");
    
    String colorSeed = String.valueOf(currentAdmin.getId()) + currentAdmin.getUsername();
    String randomColor = ColorUtils.generateRandomColor(colorSeed);
    
    String profilePictureUrl = null;
    if (profilePicture != null && !profilePicture.isEmpty()) {
        profilePictureUrl = request.getContextPath() + "/uploads/profiles/" + profilePicture + "?v=" + System.currentTimeMillis();
    }
    
    String gradientColor1 = "#3498db";
    String gradientColor2 = "#2980b9";
    
    String[][] gradientColors = {
        {"#FF6B6B", "#FF8E8E"}, {"#4ECDC4", "#44A08D"}, {"#45B7D1", "#96C93D"}, {"#FDC830", "#F37335"},
        {"#834D9B", "#D04ED6"}, {"#00B4DB", "#0083B0"}, {"#FF9A9E", "#FAD0C4"}, {"#A1C4FD", "#C2E9FB"},
        {"#FFECD2", "#FCB69F"}, {"#667EEA", "#764BA2"}, {"#F093FB", "#F5576C"}, {"#4FACFE", "#00F2FE"},
        {"#43E97B", "#38F9D7"}, {"#FA709A", "#FEE140"}, {"#30CFD0", "#330867"}, {"#FF9D6C", "#BB4E75"},
        {"#A3B1F6", "#6964DE"}, {"#F6D365", "#FDA085"}, {"#5EE7DF", "#B490CA"}, {"#D299C2", "#FEF9D7"},
        {"#FF5858", "#F09819"}, {"#00CDAC", "#02AAB0"}, {"#C471F5", "#FA71CD"}, {"#48C6EF", "#6F86D6"},
        {"#F77062", "#FE5196"}
    };
    
    if (currentAdmin != null) {
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
<title>WorkSphere Pro - My Profile</title>
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
        max-width: 900px;
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
    
    .profile-container {
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
    
    .profile-container::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(52, 152, 219, 0.1), transparent);
        transition: left 0.5s;
    }
    
    .profile-container:hover::before {
        left: 100%;
    }
    
    .profile-header {
        text-align: center;
        margin-bottom: 40px;
    }
    
    .profile-title {
        color: #2c3e50;
        margin-bottom: 10px;
        font-size: 2.2rem;
        font-weight: 700;
        background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        position: relative;
        padding-bottom: 15px;
    }
    
    .profile-title::after {
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
    
    .avatar-section {
        text-align: center;
        margin-bottom: 40px;
    }
    
    .avatar-preview {
        width: 180px;
        height: 180px;
        border-radius: 50%;
        margin: 0 auto 25px;
        overflow: hidden;
        border: 4px solid #3498db;
        box-shadow: 0 8px 25px rgba(52, 152, 219, 0.3);
        transition: all 0.4s ease;
        position: relative;
    }
    
    .avatar-preview:hover {
        transform: scale(1.05);
        box-shadow: 0 12px 35px rgba(52, 152, 219, 0.4);
    }
    
    .avatar-preview img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .avatar-initials {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 4rem;
        color: white;
        text-transform: uppercase;
        font-weight: bold;
        background: linear-gradient(135deg, <%= gradientColor1 %> 0%, <%= gradientColor2 %> 100%);
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
    
    .form-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
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
    .form-group input[type="file"] {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #e0e0e0;
        border-radius: 12px;
        box-sizing: border-box;
        font-size: 15px;
        font-family: 'Poppins', sans-serif;
        transition: all 0.3s ease;
        background: rgba(255,255,255,0.9);
        color: #2c3e50 !important;
    }
    
    .form-group input:focus {
        outline: none;
        border-color: #3498db;
        box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        transform: translateY(-2px);
    }
    
    .form-group input:-webkit-autofill,
    .form-group input:-webkit-autofill:hover, 
    .form-group input:-webkit-autofill:focus,
    .form-group input:-webkit-autofill:active {
        -webkit-text-fill-color: #2c3e50 !important;
        -webkit-box-shadow: 0 0 0px 1000px rgba(255,255,255,0.9) inset !important;
        transition: background-color 5000s ease-in-out 0s;
        border: 2px solid #e0e0e0;
        font-size: 15px;
        font-family: 'Poppins', sans-serif;
    }
    
    .file-upload-container {
        border: 3px dashed #3498db;
        border-radius: 16px;
        padding: 25px;
        text-align: center;
        background: rgba(248, 249, 250, 0.7);
        transition: all 0.4s ease;
        position: relative;
        cursor: pointer;
        margin-top: 10px;
    }
    
    .file-upload-container:hover {
        border-color: #2980b9;
        background: rgba(227, 242, 253, 0.7);
    }
    
    .file-upload-icon {
        font-size: 2.5rem;
        color: #3498db;
        margin-bottom: 15px;
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
    
    .remove-picture {
        text-align: center;
        margin: 20px 0;
    }
    
    .remove-picture label {
        display: inline-flex;
        align-items: center;
        cursor: pointer;
        color: #e74c3c;
        font-weight: 500;
        padding: 10px 20px;
        border: 2px solid #e74c3c;
        border-radius: 8px;
        transition: all 0.3s ease;
    }
    
    .remove-picture label:hover {
        background: #e74c3c;
        color: white;
    }
    
    .remove-picture input {
        margin-right: 8px;
    }
    
    .btn-update {
        background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        color: white;
        padding: 16px 40px;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 600;
        transition: all 0.4s ease;
        display: block;
        margin: 30px auto 0;
        min-width: 200px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        position: relative;
        overflow: hidden;
    }
    
    .btn-update::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
        transition: left 0.5s;
    }
    
    .btn-update:hover::before {
        left: 100%;
    }
    
    .btn-update:hover {
        background: linear-gradient(135deg, #218838 0%, #1e9e8a 100%);
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
    }
    
    .message-container {
        margin-bottom: 30px;
    }
    
    .message {
        padding: 20px;
        border-radius: 12px;
        text-align: center;
        font-weight: 500;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        animation: slideDown 0.3s ease-out;
        position: relative;
        border-left: 4px solid;
    }
    
    .message-success {
        background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
        color: #155724;
        border-left-color: #28a745;
    }
    
    .message-error {
        background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
        color: #721c24;
        border-left-color: #dc3545;
    }
    
    .form-hint {
        font-size: 0.85rem;
        color: #7f8c8d;
        margin-top: 8px;
        font-style: italic;
    }
    
    .validation-message {
        font-size: 0.85rem;
        margin-top: 5px;
        display: none;
        font-weight: 500;
        min-height: 20px;
    }
    
    .error-message { 
        color: #e74c3c; 
    }
    
    .success-message {
        color: #27ae60;
    }
    
    .checking-message {
        color: #3498db;
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
        
        .profile-container {
            padding: 25px;
        }
        
        .form-row {
            grid-template-columns: 1fr;
        }
        
        .avatar-preview {
            width: 150px;
            height: 150px;
        }
        
        .avatar-initials {
            font-size: 3rem;
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
                     onerror="this.style.display='none'; document.getElementById('navProfileInitials').style.display='flex';">
                <div id="navProfileInitials" class="profile-initials" style="display: none; background: linear-gradient(135deg, <%= gradientColor1 %> 0%, <%= gradientColor2 %> 100%);">
                    <%= currentAdmin.getInitials() %>
                </div>
            <% } else { %>
                <div class="profile-initials" style="background: linear-gradient(135deg, <%= gradientColor1 %> 0%, <%= gradientColor2 %> 100%);">
                    <%= currentAdmin.getInitials() %>
                </div>
            <% } %>
            
            <div class="profile-info">
                <div class="profile-name"><%= currentAdmin.getFullname() != null ? currentAdmin.getFullname() : currentAdmin.getUsername() %></div>
                <div class="profile-role">Administrator</div>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="profile-container">
        <div class="profile-header">
            <h1 class="profile-title">My Profile</h1>
        </div>
        
        <div class="message-container" id="successMessageContainer" style="display: none;">
            <div class="message message-success" id="successMessage">
                <i class="fas fa-check-circle"></i> Profile updated successfully!
            </div>
        </div>
        
        <div class="message-container">
            <% if (successMsg != null) { %>
                <div class="message message-success">
                    <i class="fas fa-check-circle"></i> <%= successMsg %>
                </div>
                <% session.removeAttribute("successMsg"); %>
            <% } %>
            
            <% if (errorMsg != null) { %>
                <div class="message message-error">
                    <i class="fas fa-exclamation-triangle"></i> <%= errorMsg %>
                </div>
                <% session.removeAttribute("errorMsg"); %>
            <% } %>
        </div>
        
        <div class="avatar-section">
            <div class="avatar-preview">
                <% if (profilePictureUrl != null) { %>
                    <img src="<%= profilePictureUrl %>" 
                         alt="Profile Picture" 
                         id="avatarPreview"
                         onerror="this.style.display='none'; document.getElementById('avatarInitials').style.display='flex';">
                    <div id="avatarInitials" class="avatar-initials" style="display: none;">
                        <%= initials %>
                    </div>
                <% } else { %>
                    <div id="avatarInitials" class="avatar-initials">
                        <%= initials %>
                    </div>
                <% } %>
            </div>
        </div>

        <form action="ProfileUpdateServlet" method="post" enctype="multipart/form-data" id="profileForm">
            <div class="form-section">
                <h3 class="section-title"><i class="fas fa-image"></i>Profile Picture</h3>
                
                <div class="file-upload-container" onclick="document.getElementById('profilePicture').click()">
                    <div class="file-upload-icon"><i class="fas fa-cloud-upload-alt"></i></div>
                    <h4>Upload Profile Picture</h4>
                    <p>Supported formats: JPG, PNG, GIF</p>
                    <p>Max file size: 10MB</p>
                    <input type="file" id="profilePicture" name="profilePicture" accept="image/*" class="file-input" onchange="previewImage(this)">
                    <button type="button" class="file-upload-btn">Choose File</button>
                </div>
                
                <% if (profilePicture != null && !profilePicture.isEmpty()) { %>
                <div class="remove-picture">
                    <label>
                        <input type="checkbox" id="removePicture" name="removePicture" value="true">
                        <i class="fas fa-trash-alt"></i> Remove current profile picture
                    </label>
                </div>
                <% } %>
            </div>

            <div class="form-section">
                <h3 class="section-title"><i class="fas fa-user-edit"></i>Personal Information</h3>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="fullname" class="required">Full Name</label>
                        <input type="text" id="fullname" name="fullname" value="<%= currentAdmin.getFullname() != null ? currentAdmin.getFullname() : "" %>" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="username" class="required">Username</label>
                        <input type="text" id="username" name="username" value="<%= currentAdmin.getUsername() != null ? currentAdmin.getUsername() : "" %>" required
                               oninput="validateProfileUsername()">
                        <span id="username-error" class="validation-message error-message"></span>
                        <span id="username-availability" class="validation-message checking-message"></span>
                        <div class="form-hint">Username must contain alphabets, digits, AND special characters</div>
                    </div>
                    
                    <div class="form-group">
                        <label for="email" class="required">Email</label>
                        <input type="email" id="email" name="email" value="<%= currentAdmin.getEmail() != null ? currentAdmin.getEmail() : "" %>" required
                               oninput="validateProfileEmail()">
                        <span id="email-error" class="validation-message error-message"></span>
                        <span id="email-availability" class="validation-message checking-message"></span>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="text" id="phone" name="phone" value="<%= currentAdmin.getPhone() != null ? currentAdmin.getPhone() : "" %>"
                               maxlength="10" placeholder="Enter 10-digit phone number"
                               oninput="validateProfilePhone()">
                        <span id="phone-error" class="validation-message error-message"></span>
                        <div class="form-hint">Phone number must be 10 digits starting with 6-9</div>
                    </div>
                </div>
            </div>
            
            <button type="submit" class="btn-update" id="update-btn">
                <i class="fas fa-save"></i> Update Profile
            </button>
        </form>
    </div>
</div>

<script>
    const originalUsername = '<%= currentAdmin.getUsername() %>';
    const originalEmail = '<%= currentAdmin.getEmail() %>';
    let isUsernameAvailable = true;
    let isEmailAvailable = true;
    let usernameTimeout;
    let emailTimeout;

    function validateProfileUsername() {
        const usernameInput = document.getElementById('username');
        const errorElement = document.getElementById('username-error');
        const availabilityElement = document.getElementById('username-availability');
        const username = usernameInput.value;
        
        const hasAlpha = /[A-Za-z]/.test(username);
        const hasDigit = /\d/.test(username);
        const hasSpecial = /[^A-Za-z0-9\s]/.test(username);

        clearTimeout(usernameTimeout);

        if (username.length === 0) {
            errorElement.style.display = 'none';
            availabilityElement.style.display = 'none';
            isUsernameAvailable = false;
            return false;
        } else if (!hasAlpha || !hasDigit || !hasSpecial) {
            errorElement.textContent = "Username must contain alphabets, digits, AND special characters.";
            errorElement.className = "validation-message error-message";
            errorElement.style.display = 'block';
            availabilityElement.style.display = 'none';
            isUsernameAvailable = false;
            return false;
        } else {
            errorElement.textContent = "✓ Valid username!";
            errorElement.className = "validation-message success-message";
            errorElement.style.display = 'block';
            
            if (username !== originalUsername) {
                availabilityElement.textContent = "Checking availability...";
                availabilityElement.className = "validation-message checking-message";
                availabilityElement.style.display = 'block';
                
                usernameTimeout = setTimeout(() => {
                    checkUsernameAvailability(username)
                        .then(available => {
                            isUsernameAvailable = available;
                            if (available) {
                                availabilityElement.textContent = "✓ Username is available!";
                                availabilityElement.className = "validation-message success-message";
                            } else {
                                availabilityElement.textContent = "✗ Username is already taken!";
                                availabilityElement.className = "validation-message error-message";
                            }
                        })
                        .catch(error => {
                            console.error('Error checking username availability:', error);
                            availabilityElement.textContent = "⚠ Error checking availability";
                            availabilityElement.className = "validation-message checking-message";
                        });
                }, 500);
            } else {
                isUsernameAvailable = true;
                availabilityElement.style.display = 'none';
            }
            return true;
        }
    }

    function validateProfileEmail() {
        const emailInput = document.getElementById('email');
        const errorElement = document.getElementById('email-error');
        const availabilityElement = document.getElementById('email-availability');
        const email = emailInput.value;
        
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        clearTimeout(emailTimeout);

        if (email.length === 0) {
            errorElement.style.display = 'none';
            availabilityElement.style.display = 'none';
            isEmailAvailable = false;
            return false;
        } else if (!emailRegex.test(email)) {
            errorElement.textContent = "Please enter a valid email address.";
            errorElement.className = "validation-message error-message";
            errorElement.style.display = 'block';
            availabilityElement.style.display = 'none';
            isEmailAvailable = false;
            return false;
        } else {
            errorElement.textContent = "✓ Valid email address!";
            errorElement.className = "validation-message success-message";
            errorElement.style.display = 'block';
            
            if (email !== originalEmail) {
                availabilityElement.textContent = "Checking availability...";
                availabilityElement.className = "validation-message checking-message";
                availabilityElement.style.display = 'block';
                
                emailTimeout = setTimeout(() => {
                    checkEmailAvailability(email)
                        .then(available => {
                            isEmailAvailable = available;
                            if (available) {
                                availabilityElement.textContent = "✓ Email is available!";
                                availabilityElement.className = "validation-message success-message";
                            } else {
                                availabilityElement.textContent = "✗ Email is already registered!";
                                availabilityElement.className = "validation-message error-message";
                            }
                        })
                        .catch(error => {
                            console.error('Error checking email availability:', error);
                            availabilityElement.textContent = "⚠ Error checking availability";
                            availabilityElement.className = "validation-message checking-message";
                        });
                }, 500);
            } else {
                isEmailAvailable = true;
                availabilityElement.style.display = 'none';
            }
            return true;
        }
    }

    function validateProfilePhone() {
        const phoneInput = document.getElementById('phone');
        const errorElement = document.getElementById('phone-error');
        const phone = phoneInput.value.replace(/\D/g, '');
        
        phoneInput.value = phone;
        
        const phoneRegex = /^[6-9]\d{9}$/;

        if (phone.length === 0) {
            errorElement.style.display = 'none';
            return true;
        } else if (!phoneRegex.test(phone)) {
            errorElement.textContent = "Please enter a valid 10-digit phone number starting with 6-9.";
            errorElement.className = "validation-message error-message";
            errorElement.style.display = 'block';
            return false;
        } else {
            errorElement.textContent = "✓ Valid phone number!";
            errorElement.className = "validation-message success-message";
            errorElement.style.display = 'block';
            return true;
        }
    }

    function checkUsernameAvailability(username) {
        return new Promise((resolve, reject) => {
            if (username.length === 0) {
                resolve(false);
                return;
            }
            
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'CheckAvailabilityServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        try {
                            const response = JSON.parse(xhr.responseText);
                            resolve(response.available);
                        } catch (e) {
                            reject(new Error('Invalid JSON response'));
                        }
                    } else {
                        reject(new Error('Request failed with status: ' + xhr.status));
                    }
                }
            };
            
            xhr.onerror = function() {
                reject(new Error('Request error'));
            };
            
            xhr.timeout = 10000;
            xhr.ontimeout = function() {
                reject(new Error('Request timeout'));
            };
            
            xhr.send('type=username&value=' + encodeURIComponent(username));
        });
    }

    function checkEmailAvailability(email) {
        return new Promise((resolve, reject) => {
            if (email.length === 0) {
                resolve(false);
                return;
            }
            
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'CheckAvailabilityServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        try {
                            const response = JSON.parse(xhr.responseText);
                            resolve(response.available);
                        } catch (e) {
                            reject(new Error('Invalid JSON response'));
                        }
                    } else {
                        reject(new Error('Request failed with status: ' + xhr.status));
                    }
                }
            };
            
            xhr.onerror = function() {
                reject(new Error('Request error'));
            };
            
            xhr.timeout = 10000;
            xhr.ontimeout = function() {
                reject(new Error('Request timeout'));
            };
            
            xhr.send('type=email&value=' + encodeURIComponent(email));
        });
    }

    document.getElementById('profileForm').addEventListener('submit', function(event) {
        event.preventDefault();
        
        const isUsernameValid = validateProfileUsername();
        const isEmailValid = validateProfileEmail();
        const isPhoneValid = validateProfilePhone();
        
        const fullname = document.getElementById('fullname').value.trim();
        const username = document.getElementById('username').value.trim();
        const email = document.getElementById('email').value.trim();
        const phone = document.getElementById('phone').value.trim();
        
        if (!fullname) {
            alert("Please enter your full name.");
            return false;
        }
        
        if (!isUsernameValid) {
            alert("Please correct the username format. It must contain alphabets, digits, AND special characters.");
            return false;
        }
        
        if (!isEmailValid) {
            alert("Please enter a valid email address.");
            return false;
        }
        
        if (phone && !isPhoneValid) {
            alert("Please enter a valid 10-digit phone number starting with 6-9.");
            return false;
        }

        if (!validateFile()) {
            return false;
        }

        const updateBtn = document.getElementById('update-btn');
        updateBtn.disabled = true;
        updateBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Checking...';

        Promise.all([
            username !== originalUsername ? checkUsernameAvailability(username) : Promise.resolve(true),
            email !== originalEmail ? checkEmailAvailability(email) : Promise.resolve(true)
        ])
        .then(([usernameAvailable, emailAvailable]) => {
            isUsernameAvailable = usernameAvailable;
            isEmailAvailable = emailAvailable;

            if (!isUsernameAvailable || !isEmailAvailable) {
                if (!isUsernameAvailable && !isEmailAvailable) {
                    alert("Username and email are already registered! Please use different credentials.");
                } else if (!isUsernameAvailable) {
                    alert("Username is already registered! Please choose a different username.");
                } else if (!isEmailAvailable) {
                    alert("Email is already registered! Please use a different email address.");
                }
                updateBtn.disabled = false;
                updateBtn.innerHTML = '<i class="fas fa-save"></i> Update Profile';
                return;
            }

            updateBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Updating...';
            
            const successMessageContainer = document.getElementById('successMessageContainer');
            successMessageContainer.style.display = 'block';
            
            setTimeout(() => {
                this.submit();
            }, 1000);
        })
        .catch(error => {
            console.error('Error during final availability check:', error);
            alert("Error checking availability. Please try again.");
            updateBtn.disabled = false;
            updateBtn.innerHTML = '<i class="fas fa-save"></i> Update Profile';
        });
    });

    function validateFile() {
        const fileInput = document.getElementById('profilePicture');
        const file = fileInput.files[0];
        const removePictureCheckbox = document.getElementById('removePicture');
        
        if (removePictureCheckbox && removePictureCheckbox.checked) {
            return true;
        }
        
        if (file) {
            const validTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
            const maxSize = 10 * 1024 * 1024;
            
            if (!validTypes.includes(file.type)) {
                alert('Please select a valid image file (JPG, PNG, GIF).');
                return false;
            }
            
            if (file.size > maxSize) {
                alert('File size must be less than 10MB.');
                return false;
            }
        }
        
        return true;
    }

    function previewImage(input) {
        const preview = document.getElementById('avatarPreview');
        const avatarInitials = document.getElementById('avatarInitials');
        const removePictureCheckbox = document.getElementById('removePicture');
        
        if (input.files && input.files[0]) {
            const reader = new FileReader();
            
            reader.onload = function(e) {
                if (removePictureCheckbox) {
                    removePictureCheckbox.checked = false;
                }
                
                if (avatarInitials) {
                    avatarInitials.style.display = 'none';
                }
                if (!preview) {
                    const avatarPreview = document.createElement('img');
                    avatarPreview.id = 'avatarPreview';
                    avatarPreview.alt = 'Profile Picture';
                    avatarPreview.style.width = '100%';
                    avatarPreview.style.height = '100%';
                    avatarPreview.style.objectFit = 'cover';
                    document.querySelector('.avatar-preview').appendChild(avatarPreview);
                    document.getElementById('avatarPreview').src = e.target.result;
                } else {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                }
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        const removePictureCheckbox = document.getElementById('removePicture');
        const fileInput = document.getElementById('profilePicture');
        const avatarInitials = document.getElementById('avatarInitials');
        const preview = document.getElementById('avatarPreview');
        
        if (removePictureCheckbox) {
            removePictureCheckbox.addEventListener('change', function() {
                if (this.checked) {
                    if (fileInput) {
                        fileInput.value = '';
                    }
                    if (preview) {
                        preview.style.display = 'none';
                    }
                    if (avatarInitials) {
                        avatarInitials.style.display = 'flex';
                    }
                }
            });
        }
    });
</script>

</body>
</html>