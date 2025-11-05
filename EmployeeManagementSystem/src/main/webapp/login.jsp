<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - EMS</title>
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
        .login-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 350px;
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
        .form-group input[type="email"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn-login {
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
        .btn-login:hover {
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
        .login-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }
        .forgot-password {
            text-align: center;
            margin: 10px 0;
        }
        .forgot-password a {
            color: #007bff;
            text-decoration: none;
        }
        .forgot-password a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Admin Login</h2>

        <%
            String successMsg = (String) session.getAttribute("successMsg");
            String errorMsg = (String) session.getAttribute("errorMsg");
        %>

        <% if (successMsg != null) { %>
            <div class="message-success">
                <%= successMsg %>
            </div>
            <% session.removeAttribute("successMsg"); %>
        <% } %>

        <% if (errorMsg != null) { %>
            <div class="message-error">
                <%= errorMsg %>
            </div>
            <% session.removeAttribute("errorMsg"); %>
        <% } %>

        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>
            <button type="submit" class="btn-login">Login</button>
        </form>
        
        <div class="forgot-password">
            <a href="forgot-password.jsp">Forgot Password?</a>
        </div>
        
        <div class="login-link">
           Don't have an account? <a href="registration.jsp">Register</a>
        </div>
    </div>

</body>
</html> --%>










<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WorkSphere Pro - Sign In</title>
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
            background: white;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            overflow: hidden;
        }
        
        .login-wrapper {
            display: flex;
            width: 100vw;
            height: 100vh;
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
        }
        
        .brand-section {
            flex: 1;
            background: rgba(0, 0, 0, 0.45);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
            padding: 40px;
            backdrop-filter: blur(15px);
            border-right: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .logo-container {
            display: flex;
            align-items: center;
            gap: 20px;
            text-decoration: none;
            margin-bottom: 40px;
        }
        
        .logo-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #3498db 0%, #2c3e50 100%);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            box-shadow: 0 8px 32px rgba(52, 152, 219, 0.4);
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
            font-size: 32px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));
            z-index: 1;
        }
        
        .logo-text {
            display: flex;
            flex-direction: column;
            line-height: 1;
            position: relative;
            text-align: left;
        }
        
        .logo-main {
            display: flex;
            align-items: baseline;
            gap: 6px;
            font-weight: 800;
            letter-spacing: -0.5px;
            position: relative;
        }
        
        .worksphere-text {
            font-size: 2.5rem;
            background: linear-gradient(135deg, #3498db 50%, #2c3e50 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 2px 10px rgba(52, 152, 219, 0.3);
            position: relative;
        }
        
        .worksphere-text::after {
            content: '';
            position: absolute;
            bottom: -3px;
            left: 0;
            width: 100%;
            height: 2px;
            background: linear-gradient(90deg, #3498db, transparent);
            opacity: 0.7;
        }
        
        .pro-text {
            font-size: 2rem;
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
            font-size: 0.8rem;
            font-weight: 700;
            color: #bdc3c7;
            letter-spacing: 3px;
            text-transform: uppercase;
            margin-top: 5px;
            position: relative;
            padding-left: 5px;
        }
        
        .logo-tagline::before {
            content: '✦';
            position: absolute;
            left: -12px;
            top: 50%;
            transform: translateY(-50%);
            color: #3498db;
            font-size: 0.6rem;
        }
        
        .brand-tagline {
            font-size: 1.1rem;
            color: #ecf0f1;
            line-height: 1.6;
            max-width: 300px;
            margin-top: 20px;
            opacity: 0.9;
        }
        
        .login-section {
            flex: 1.5;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background: rgba(255, 255, 255, 0.95);
            position: relative;
        }
        
        .login-content {
            width: 100%;
            max-width: 450px;
            padding: 0 40px;
        }
        
        .login-header {
            margin-bottom: 40px;
            text-align: center;
        }
        
        .login-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 10px;
        }
        
        .login-subtitle {
            color: #7f8c8d;
            font-size: 1.1rem;
        }
        
        .form-group {
            margin-bottom: 25px;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #2c3e50;
            font-size: 0.95rem;
        }
        
        .form-group input {
            width: 100%;
            padding: 15px 20px 15px 50px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            color: #2c3e50;
            font-family: 'Poppins', sans-serif;
            height: 55px;
        }
        
        .form-group input:-webkit-autofill,
        .form-group input:-webkit-autofill:hover,
        .form-group input:-webkit-autofill:focus,
        .form-group input:-webkit-autofill:active {
            -webkit-box-shadow: 0 0 0 30px white inset !important;
            -webkit-text-fill-color: #2c3e50 !important;
            background-color: white !important;
            color: #2c3e50 !important;
            border: 2px solid #3498db !important;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .input-icon {
            position: absolute;
            left: 18px;
            top: 50px;
            color: #7f8c8d;
            font-size: 1.1rem;
        }
        
        .btn-login {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            padding: 16px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            width: 100%;
            font-size: 1.1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-family: 'Poppins', sans-serif;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.3);
        }
        
        .login-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            font-size: 0.9rem;
        }
        
        .remember-me {
            display: flex;
            align-items: center;
        }
        
        .remember-me input {
            margin-right: 8px;
        }
        
        .forgot-password a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .forgot-password a:hover {
            text-decoration: underline;
        }
        
        .register-section {
            position: absolute;
            top: 30px;
            right: 30px;
            z-index: 10;
            text-align: right;
        }
        
        .back-section {
            position: absolute;
            top: 30px;
            left: 30px;
            z-index: 10;
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: white;
            text-decoration: none;
            font-weight: 600;
            padding: 10px 20px;
            background: rgba(0, 0, 0, 0.10);
            border-radius: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }
        
        .back-link:hover {
            background: white;
            color: #2c3e50;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            text-decoration: none;
            border-color: #3498db;
        }
        
        .register-text {
            color: #2c3e50;
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 8px;
            line-height: 1.4;
        }
        
        .register-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
            padding: 10px 20px;
            background: white;
            border-radius: 25px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            border: 2px solid #3498db;
        }
        
        .register-link:hover {
            background: #3498db;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            text-decoration: none;
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
    </style>
</head>
<body>

    <div class="login-wrapper">
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
        
        <div class="back-section">
            <a href="index.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i>
            </a>
        </div>
        
        <div class="register-section">
            <div class="register-text">
                New to WorkSphere Pro?
            </div>
            <a href="registration.jsp" class="register-link">
                <i class="fas fa-user-plus"></i>Sign Up
            </a>
        </div>
        
        <div class="brand-section">
            <div class="logo-container">
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
            </div>
            
            <p class="brand-tagline">Streamline Your Operations<br>Enterprise Management Suite</p>
        </div>
        
        <div class="login-section">
            <div class="login-content">
                <div class="login-header">
                    <h2 class="login-title">Welcome Back</h2>
                    <p class="login-subtitle">Sign in to your management account</p>
                </div>

                <form action="LoginServlet" method="post">
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" id="email" name="email" required placeholder="Enter your email">
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password</label>
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" required placeholder="Enter your password">
                    </div>
                    
                    <div class="login-options">
                        <div class="remember-me">
                            <input type="checkbox" id="remember" name="remember" required>
                            <label for="remember">Remember me</label>
                        </div>
                        <div class="forgot-password">
                            <a href="forgot-password.jsp">
                                <i class="fas fa-key"></i>Forgot Password?
                            </a>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-login">
                        <i class="fas fa-sign-in-alt"></i>Sign In
                    </button>
                </form>
            </div>
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
                        if (messageContainer.children.length === 0) {
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
        });
    </script>

</body>
</html>