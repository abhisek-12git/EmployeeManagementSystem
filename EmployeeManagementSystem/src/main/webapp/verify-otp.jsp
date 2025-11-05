<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("forgot-password.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WorkSphere Pro - Verify OTP</title>
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
        
        .otp-container {
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
        
        .otp-container::before {
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
        
        .email-info {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #e9ecef;
        }
        
        .email-info i {
            color: var(--primary);
            margin-right: 8px;
        }
        
        .timer-container {
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
            color: var(--dark);
        }
        
        .timer {
            font-weight: bold;
            color: var(--danger);
            font-size: 16px;
        }
        
        .timer-expired {
            color: var(--danger);
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
            font-size: 16px;
            text-align: center;
            letter-spacing: 8px;
            font-weight: bold;
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
        
        .btn-submit i {
            margin-right: 8px;
        }
        
        .resend-otp {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
        
        .resend-otp a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .resend-otp a:hover {
            text-decoration: underline;
        }
        
        .resend-otp a.disabled {
            color: var(--gray);
            cursor: not-allowed;
            text-decoration: none;
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
        
        @media (max-width: 480px) {
            .otp-container {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>

    <div class="otp-container">
        <div class="logo">
            <i class="fas fa-shield-alt"></i>
        </div>
        
        <h2>Verify OTP</h2>
        
        <div class="subtitle">
            Enter the 6-digit OTP sent to your email
        </div>

        <div class="email-info">
            <i class="fas fa-envelope"></i>
            <strong><%= email %></strong>
        </div>

        <div class="timer-container">
            <div id="timerText">OTP expires in: <span class="timer" id="countdown">10:00</span></div>
        </div>

        <form id="otpForm" action="VerifyOTPServlet" method="post">
            <div class="form-group">
                <label for="otp">Enter OTP</label>
                <div class="input-with-icon">
                    <i class="fas fa-key"></i>
                    <input type="text" id="otp" name="otp" required 
                           placeholder="000000" maxlength="6" pattern="[0-9]{6}"
                           oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                </div>
            </div>
            
            <button type="submit" class="btn-submit" id="submitBtn">
                <i class="fas fa-check-circle"></i> Verify OTP
            </button>
        </form>
        
        <div class="resend-otp">
            Didn't receive OTP? 
            <a href="forgot-password.jsp" id="resendLink">Request a new one</a>
            <span id="resendTimer" style="display: none;"> (Available in <span id="resendCountdown">60</span>s)</span>
        </div>
        
        <div class="back-link">
            <a href="forgot-password.jsp">
                <i class="fas fa-arrow-left"></i> Back to Forgot Password
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
        let timer;
        let totalSeconds = 600;
        let resendTimer;
        let resendSeconds = 60;

        function startTimer() {
            timer = setInterval(function() {
                totalSeconds--;
                const minutes = Math.floor(totalSeconds / 60);
                const seconds = totalSeconds % 60;
                
                document.getElementById('countdown').textContent = 
                    minutes.toString().padStart(2, '0') + ':' + seconds.toString().padStart(2, '0');
                
                if (totalSeconds <= 0) {
                    clearInterval(timer);
                    document.getElementById('countdown').textContent = '00:00';
                    document.getElementById('countdown').classList.add('timer-expired');
                    document.getElementById('timerText').innerHTML = 'OTP has expired. Please request a new one.';
                    document.getElementById('submitBtn').disabled = true;
                }
            }, 1000);
        }

        function showMessage(message, type) {
            const messageContainer = document.getElementById('messageContainer');
            const messageDiv = document.createElement('div');
            messageDiv.className = type === 'success' ? 'message-success' : 'message-error';
            
            const iconClass = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle';
            messageDiv.innerHTML = '<i class="fas ' + iconClass + ' message-icon"></i>' + message;
            
            messageContainer.appendChild(messageDiv);
            
            setTimeout(() => {
                messageDiv.classList.add('message-hide');
                setTimeout(() => {
                    messageDiv.remove();
                }, 300);
            }, 5000);
            
            messageDiv.addEventListener('click', function() {
                messageDiv.classList.add('message-hide');
                setTimeout(() => {
                    messageDiv.remove();
                }, 300);
            });
        }

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
            
            startTimer();
        });

        document.getElementById('otpForm').addEventListener('submit', function(e) {
            const otp = document.getElementById('otp').value;
            const submitBtn = document.getElementById('submitBtn');
            
            if (otp.length !== 6) {
                e.preventDefault();
                showMessage('Please enter a valid 6-digit OTP.', 'error');
                return;
            }
            
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Verifying...';
        });

        document.getElementById('otp').focus();
    </script>

</body>
</html>