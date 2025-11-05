<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String token = request.getParameter("token");
    if (token == null || token.trim().isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password - EMS</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .reset-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn-submit {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-bottom: 15px;
        }
        .btn-submit:hover {
            background-color: #218838;
        }
        .message-success, .message-error {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
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
        .back-link {
            text-align: center;
            margin-top: 15px;
        }
        .back-link a {
            color: #007bff;
            text-decoration: none;
        }
        .back-link a:hover {
            text-decoration: underline;
        }
        .password-requirements {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>

    <div class="reset-container">
        <h2>Reset Your Password</h2>

        <%
            String successMsg = (String) session.getAttribute("successMsg");
            String errorMsg = (String) session.getAttribute("errorMsg");
        %>

        <% if (successMsg != null) { %>
            <div class="message-success">
                <%= successMsg %>
            </div>
            <%
                session.removeAttribute("successMsg");
            %>
        <% } %>

        <% if (errorMsg != null) { %>
            <div class="message-error">
                <%= errorMsg %>
            </div>
            <%
                session.removeAttribute("errorMsg");
            %>
        <% } %>

        <form action="ResetPasswordServlet" method="post">
            <input type="hidden" name="token" value="<%= token %>">
            
            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" required 
                       placeholder="Enter new password" minlength="8">
                <div class="password-requirements">Password must be at least 8 characters long</div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required 
                       placeholder="Confirm new password">
            </div>
            
            <button type="submit" class="btn-submit">Reset Password</button>
        </form>
        
        <div class="back-link">
            <a href="login.jsp">← Back to Login</a>
        </div>
    </div>

</body>
</html>  --%>












<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
    String otpVerified = (String) session.getAttribute("otpVerified");
    
    if (email == null || !"true".equals(otpVerified)) {
        session.setAttribute("errorMsg", "Please verify OTP first.");
        response.sendRedirect("forgot-password.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WorkSphere Pro - Reset Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #3498db;
            --primary-dark: #2980b9;
            --secondary: #2c3e50;
            --accent: #34495e;
            --success: #27ae60;
            --danger: #e74c3c;
            --light: #f8f9fa;
            --dark: #2c3e50;
            --gray: #7f8c8d;
            --shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: #fafbfc;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .reset-container {
            background-color: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            width: 100%;
            max-width: 450px;
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.5s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .reset-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
        }
        
        .logo {
            text-align: center;
            margin-bottom: 10px;
        }
        
        .logo i {
            font-size: 40px;
            color: var(--primary);
            margin-bottom: 10px;
        }
        
        h2 {
            text-align: center;
            color: var(--dark);
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .subtitle {
            text-align: center;
            color: var(--gray);
            margin-bottom: 30px;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 20px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
            transition: var(--transition);
        }
        
        .input-with-icon {
            position: relative;
        }
        
        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
            transition: var(--transition);
        }
        
        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
            cursor: pointer;
            transition: var(--transition);
            background: none;
            border: none;
            font-size: 16px;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .toggle-password:hover {
            color: var(--primary);
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 45px 12px 45px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 14px;
            transition: var(--transition);
            background-color: white;
            color: var(--dark);
        }
        
        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
        }
        
        .form-group input:focus + .input-with-icon i {
            color: var(--primary);
        }
        
        .form-group input.error {
            border-color: var(--danger);
            box-shadow: 0 0 0 3px rgba(231, 76, 60, 0.2);
        }
        
        .form-group input.success {
            border-color: var(--success);
            box-shadow: 0 0 0 3px rgba(39, 174, 96, 0.2);
        }
        
        .form-group input:-webkit-autofill,
        .form-group input:-webkit-autofill:hover,
        .form-group input:-webkit-autofill:focus,
        .form-group input:-webkit-autofill:active {
            -webkit-box-shadow: 0 0 0 30px white inset !important;
            -webkit-text-fill-color: var(--dark) !important;
            background-color: white !important;
            color: var(--dark) !important;
            border: 2px solid #e9ecef;
        }
        
        .btn-submit {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            font-weight: 500;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            z-index: 1;
        }
        
        .btn-submit::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background: linear-gradient(135deg, var(--secondary), var(--accent));
            transition: var(--transition);
            z-index: -1;
        }
        
        .btn-submit:hover::before {
            width: 100%;
        }
        
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }
        
        .btn-submit:active {
            transform: translateY(0);
        }
        
        .btn-submit i {
            margin-right: 8px;
        }
        
        .message-container {
            position: fixed;
            top: 20px;
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
        
        .back-link {
            text-align: center;
            margin-top: 25px;
        }
        
        .back-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            transition: var(--transition);
        }
        
        .back-link a:hover {
            color: var(--secondary);
            transform: translateX(-3px);
        }
        
        .back-link a i {
            margin-right: 8px;
            transition: var(--transition);
        }
        
        .back-link a:hover i {
            transform: translateX(-3px);
        }
        
        .password-strength {
            margin-top: 8px;
            height: 4px;
            background: #e9ecef;
            border-radius: 2px;
            overflow: hidden;
            display: none;
        }
        
        .strength-bar {
            height: 100%;
            width: 0%;
            transition: var(--transition);
            border-radius: 2px;
        }
        
        .strength-weak {
            background: var(--danger);
            width: 33%;
        }
        
        .strength-medium {
            background: #f39c12;
            width: 66%;
        }
        
        .strength-strong {
            background: var(--success);
            width: 100%;
        }
        
        .strength-label {
            font-size: 12px;
            margin-top: 5px;
            display: none;
        }
        
        .strength-weak-label {
            color: var(--danger);
            display: block;
        }
        
        .strength-medium-label {
            color: #f39c12;
            display: block;
        }
        
        .strength-strong-label {
            color: var(--success);
            display: block;
        }
        
        .validation-message {
            font-size: 12px;
            margin-top: 5px;
            padding: 5px 10px;
            border-radius: 4px;
            display: none;
        }
        
        .validation-error {
            background-color: rgba(231, 76, 60, 0.1);
            color: var(--danger);
            border-left: 3px solid var(--danger);
            display: block;
        }
        
        .validation-success {
            background-color: rgba(39, 174, 96, 0.1);
            color: var(--success);
            border-left: 3px solid var(--success);
            display: block;
        }
        
        @media (max-width: 480px) {
            .reset-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>

    <div class="reset-container">
        <div class="logo">
            <i class="fas fa-key"></i>
        </div>
        
        <h2>Reset Your Password</h2>
        
        <div class="subtitle">
            Create a new strong password for your account
        </div>

        <form id="resetForm" action="ResetPasswordServlet" method="post">            
            <div class="form-group">
                <label for="newPassword">New Password</label>
                <div class="input-with-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="newPassword" name="newPassword" required 
                           placeholder="Enter new password" minlength="8">
                    <button type="button" class="toggle-password" onclick="togglePassword('newPassword')">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <div class="password-strength" id="passwordStrengthContainer">
                    <div class="strength-bar" id="passwordStrength"></div>
                </div>
                <div class="strength-label" id="passwordStrengthLabel"></div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <div class="input-with-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="confirmPassword" name="confirmPassword" required 
                           placeholder="Confirm new password">
                    <button type="button" class="toggle-password" onclick="togglePassword('confirmPassword')">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <div id="confirmPasswordMessage" class="validation-message"></div>
            </div>
            
            <button type="submit" class="btn-submit" id="submitBtn">
                <i class="fas fa-sync-alt"></i> Reset Password
            </button>
        </form>
        
        <div class="back-link">
            <a href="login.jsp">
                <i class="fas fa-arrow-left"></i> Back to Login
            </a>
        </div>
    </div>

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
                        if (messageContainer.children.length === 0) {
                            messageContainer.remove();
                        }
                    }, 300);
                }
            }
            
            if (successMessage) {
                setTimeout(() => {
                    hideMessage(successMessage);
                }, 5000);
            }
            
            if (errorMessage) {
                setTimeout(() => {
                    hideMessage(errorMessage);
                }, 5000);
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
        });

        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const icon = field.parentElement.querySelector('.toggle-password i');
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.className = 'fas fa-eye-slash';
            } else {
                field.type = 'password';
                icon.className = 'fas fa-eye';
            }
        }

        function checkPasswordStrength(password) {
            let strength = 0;
            const requirements = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /[0-9]/.test(password),
                special: /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)
            };

            Object.values(requirements).forEach(req => {
                if (req) strength++;
            });

            const strengthBar = document.getElementById('passwordStrength');
            const strengthContainer = document.getElementById('passwordStrengthContainer');
            const strengthLabel = document.getElementById('passwordStrengthLabel');
            
            strengthBar.className = 'strength-bar';
            strengthLabel.className = 'strength-label';
            strengthContainer.style.display = 'block';

            if (strength === 0) {
                return 'weak';
            } else if (strength <= 2) {
                strengthBar.classList.add('strength-weak');
                strengthLabel.classList.add('strength-weak-label');
                strengthLabel.textContent = 'Weak password';
                return 'weak';
            } else if (strength === 3) {
                strengthBar.classList.add('strength-medium');
                strengthLabel.classList.add('strength-medium-label');
                strengthLabel.textContent = 'Medium password';
                return 'medium';
            } else {
                strengthBar.classList.add('strength-strong');
                strengthLabel.classList.add('strength-strong-label');
                strengthLabel.textContent = 'Strong password';
                return 'strong';
            }
        }

        function checkPasswordMatch() {
            const password = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const confirmField = document.getElementById('confirmPassword');
            const confirmMessage = document.getElementById('confirmPasswordMessage');
            
            confirmField.classList.remove('error', 'success');
            confirmMessage.className = 'validation-message';
            
            if (confirmPassword.length > 0) {
                if (password === confirmPassword) {
                    confirmField.classList.add('success');
                    confirmMessage.textContent = '✓ Passwords match';
                    confirmMessage.classList.add('validation-success');
                } else {
                    confirmField.classList.add('error');
                    confirmMessage.textContent = '✗ Passwords do not match';
                    confirmMessage.classList.add('validation-error');
                }
            }
        }

        document.getElementById('newPassword').addEventListener('input', function() {
            const password = this.value;
            if (password.length > 0) {
                checkPasswordStrength(password);
            } else {
                document.getElementById('passwordStrengthContainer').style.display = 'none';
                document.getElementById('passwordStrengthLabel').className = 'strength-label';
            }
            checkPasswordMatch();
        });

        document.getElementById('confirmPassword').addEventListener('input', checkPasswordMatch);

        document.getElementById('resetForm').addEventListener('submit', function(e) {
            const password = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const submitBtn = document.getElementById('submitBtn');
            
            if (password !== confirmPassword) {
                e.preventDefault();
                document.getElementById('confirmPassword').classList.add('error');
                document.getElementById('confirmPasswordMessage').textContent = '✗ Passwords do not match';
                document.getElementById('confirmPasswordMessage').className = 'validation-message validation-error';
                return;
            }
            
            if (password.length < 8) {
                e.preventDefault();
                alert('Password must be at least 8 characters long');
                return;
            }
            
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Resetting...';
        });

        const inputs = document.querySelectorAll('input');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.parentElement.querySelector('label').style.color = 'var(--primary)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.parentElement.querySelector('label').style.color = 'var(--dark)';
            });
        });
    </script>

</body>
</html>