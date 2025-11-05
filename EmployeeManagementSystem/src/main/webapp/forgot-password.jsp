<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - EMS</title>
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
        .forgot-container {
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
        .form-group input[type="email"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn-submit {
            background-color: #007bff;
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
            background-color: #0056b3;
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
        .info-text {
            text-align: center;
            margin-bottom: 20px;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <div class="forgot-container">
        <h2>Forgot Password</h2>
        
        <div class="info-text">
            Enter your email address and we'll send you a link to reset your password.
        </div>

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

        <form action="ForgotPasswordServlet" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required placeholder="Enter your registered email">
            </div>
            <button type="submit" class="btn-submit">Send Reset Link</button>
        </form>
        
        <div class="back-link">
            <a href="login.jsp">← Back to Login</a>
        </div>
    </div>

</body>
</html> --%>











<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WorkSphere Pro - Forgot Password</title>
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
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        .forgot-container {
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
        
        .forgot-container::before {
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
        
        .form-group input {
            width: 100%;
            padding: 12px 15px 12px 45px;
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
        
        @media (max-width: 480px) {
            .forgot-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>

    <div class="forgot-container">
        <div class="logo">
            <i class="fas fa-lock"></i>
        </div>
        
        <h2>Forgot Password</h2>
        
        <div class="subtitle">
            Enter your email address and we'll send you an OTP to reset your password.
        </div>

        <%
            String successMsg = (String) session.getAttribute("successMsg");
            String errorMsg = (String) session.getAttribute("errorMsg");
        %>

        <form id="forgotForm" action="ForgotPasswordServlet" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <div class="input-with-icon">
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" required placeholder="Enter your registered email">
                </div>
            </div>
            <button type="submit" class="btn-submit" id="submitBtn">
                <i class="fas fa-paper-plane"></i> Send OTP
            </button>
        </form>
        
        <div class="back-link">
            <a href="login.jsp">
                <i class="fas fa-arrow-left"></i> Back to Login
            </a>
        </div>
    </div>

    <div class="message-container" id="messageContainer">
        <% if (successMsg != null) { %>
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

        document.getElementById('forgotForm').addEventListener('submit', function(e) {
            const submitBtn = document.getElementById('submitBtn');
            
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Sending...';
            
            setTimeout(function() {
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Send OTP';
            }, 2000);
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