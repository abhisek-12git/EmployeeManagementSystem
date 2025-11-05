<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Registration - EMS</title>
<style>
    body {
        background-color: #f4f4f4;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    
    .server-messages {
        max-width: 400px;
        margin: 20px auto 0 auto;
        padding: 0 30px;
    }
    
    .server-error {
        background: #ffebee;
        color: #d32f2f;
        padding: 12px 15px;
        border: 1px solid #f44336;
        border-radius: 4px;
        margin-bottom: 10px;
        text-align: center;
        transition: opacity 0.5s ease-in-out;
    }
    
    .server-success {
        background: #e8f5e8;
        color: #2e7d32;
        padding: 12px 15px;
        border: 1px solid #4caf50;
        border-radius: 4px;
        margin-bottom: 10px;
        text-align: center;
        transition: opacity 0.5s ease-in-out;
    }

    .client-messages {
        max-width: 400px;
        margin: 10px auto 0 auto;
        padding: 0 30px;
    }
    
    .client-error {
        background: #ffebee;
        color: #d32f2f;
        padding: 12px 15px;
        border: 1px solid #f44336;
        border-radius: 4px;
        margin-bottom: 10px;
        text-align: center;
        transition: opacity 0.5s ease-in-out;
    }
    
    .client-success {
        background: #e8f5e8;
        color: #2e7d32;
        padding: 12px 15px;
        border: 1px solid #4caf50;
        border-radius: 4px;
        margin-bottom: 10px;
        text-align: center;
        transition: opacity 0.5s ease-in-out;
    }

    .container {
        max-width: 400px;
        margin: 10px auto 50px auto;
        padding: 30px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .form-group {
        margin-bottom: 15px;
    }
    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333;
    }
    input[type="text"],
    input[type="email"],
    input[type="password"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 14px;
    }
    input:focus {
        outline: none;
        border-color: #007bff;
        box-shadow: 0 0 5px rgba(0,123,255,0.3);
    }
    .password-strength {
        height: 8px;
        margin-top: 5px;
        border-radius: 4px;
        background-color: #eee;
        transition: width 0.3s ease-in-out;
        display: none;
    }
    .strength-weak { background-color: red; width: 33%; }
    .strength-medium { background-color: orange; width: 66%; }
    .strength-strong { background-color: green; width: 100%; }
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
    small {
        color: #666;
        font-size: 0.8em;
    }
    button {
        background: #007bff;
        color: white;
        padding: 12px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        width: 100%;
        font-size: 16px;
        transition: background 0.3s;
    }
    button:hover {
        background: #0056b3;
    }
    h1 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }
    #strength-label {
        display: none;
        font-size: 0.9em;
        margin-top: 5px;
    }
    .login-link {
        text-align: center;
        margin-top: 20px;
        padding-top: 20px;
        border-top: 1px solid #eee;
    }
    .login-link a {
        color: #007bff;
        text-decoration: none;
        font-weight: bold;
    }
    .login-link a:hover {
        text-decoration: underline;
    }
    
    .availability-message {
        display: block;
        margin-top: 5px;
        font-size: 0.9em;
        padding: 5px;
        border-radius: 4px;
    }
    .availability-available {
        color: green;
        background-color: #e8f5e8;
        border: 1px solid #4caf50;
    }
    .availability-taken {
        color: #d32f2f;
        background-color: #ffebee;
        border: 1px solid #f44336;
    }
    .availability-checking {
        color: #ff9800;
        background-color: #fff3e0;
        border: 1px solid #ff9800;
    }
    
    .fade-out {
        opacity: 0;
        transition: opacity 0.5s ease-in-out;
    }
</style>
</head>
<body>

    <div class="server-messages" id="serverMessages">
        <% 
            String error = (String) session.getAttribute("error");
            if (error != null) {
                out.println("<div class='server-error' id='server-error'>" + error + "</div>");
                session.removeAttribute("error");
            }
        %>
    </div>

    <div class="client-messages" id="clientMessages"></div>

    <div class="container">
        <h1>Admin Registration</h1>

        <form action="RegisterServlet" method="post" id="registrationForm">
            
            <div class="form-group">
                <label for="fullname">Full Name:</label>
                <input type="text" id="fullname" name="fullname" required>
            </div>

            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required 
                       oninput="validateUsername()">
                <span id="username-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
                <span id="email-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number:</label>
                <input type="text" id="phone" name="phone" required 
                       placeholder="Enter 10-digit phone number" 
                       maxlength="10"
                       oninput="validatePhone()">
                <span id="phone-error" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required onkeyup="checkPasswordStrength()">
                <div id="strength-meter" class="password-strength"></div>
                <small id="strength-label"></small>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required onkeyup="checkPasswordMatch()">
                <span id="match-error" class="error-message"></span>
            </div>
            
            <button type="submit" id="submit-btn">Register</button>
        </form>

        <div class="login-link">
            <p>Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>
    
    <script>
        function autoHideMessages() {
            const serverError = document.getElementById('server-error');
            const clientMessages = document.getElementById('clientMessages');
            
            if (serverError) {
                setTimeout(() => {
                    serverError.classList.add('fade-out');
                    setTimeout(() => {
                        serverError.remove();
                    }, 500);
                }, 5000);
            }
            
            if (clientMessages && clientMessages.children.length > 0) {
                setTimeout(() => {
                    Array.from(clientMessages.children).forEach(child => {
                        child.classList.add('fade-out');
                        setTimeout(() => {
                            child.remove();
                        }, 500);
                    });
                }, 5000);
            }
        }

        function clearFormFields() {
            document.getElementById('fullname').value = '';
            document.getElementById('username').value = '';
            document.getElementById('email').value = '';
            document.getElementById('phone').value = '';
            document.getElementById('password').value = '';
            document.getElementById('confirmPassword').value = '';
            
            document.getElementById('username-error').textContent = '';
            document.getElementById('email-error').textContent = '';
            document.getElementById('phone-error').textContent = '';
            document.getElementById('match-error').textContent = '';
            
            const usernameAvailability = document.getElementById('username-availability');
            const emailAvailability = document.getElementById('email-availability');
            if (usernameAvailability) usernameAvailability.textContent = '';
            if (emailAvailability) emailAvailability.textContent = '';
            
            document.getElementById('strength-meter').style.display = 'none';
            document.getElementById('strength-label').style.display = 'none';
        }

        document.addEventListener('DOMContentLoaded', function() {
            const usernameGroup = document.querySelector('#username').closest('.form-group');
            if (!document.getElementById('username-availability')) {
                const usernameAvailability = document.createElement('span');
                usernameAvailability.id = 'username-availability';
                usernameAvailability.className = 'availability-message';
                usernameGroup.appendChild(usernameAvailability);
            }
            
            const emailGroup = document.querySelector('#email').closest('.form-group');
            if (!document.getElementById('email-availability')) {
                const emailAvailability = document.createElement('span');
                emailAvailability.id = 'email-availability';
                emailAvailability.className = 'availability-message';
                emailGroup.appendChild(emailAvailability);
            }
            
            validateUsername();
            validatePhone();
            checkPasswordMatch();
            
            autoHideMessages();
        });

        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthMeter = document.getElementById('strength-meter');
            const strengthLabel = document.getElementById('strength-label');
            let score = 0;

            if (password.length > 0) {
                strengthMeter.style.display = 'block';
                strengthLabel.style.display = 'block';
            } else {
                strengthMeter.style.display = 'none';
                strengthLabel.style.display = 'none';
                return;
            }

            if (password.length >= 8) score += 20;
            if (password.length >= 12) score += 20;
            if (/[a-z]/.test(password)) score += 15;
            if (/[A-Z]/.test(password)) score += 15;
            if (/\d/.test(password)) score += 15;
            if (/[^a-zA-Z0-9\s]/.test(password)) score += 15;

            strengthMeter.className = 'password-strength';
            strengthLabel.style.color = 'black';

            if (score < 40) {
                strengthMeter.classList.add('strength-weak');
                strengthLabel.textContent = 'Weak';
                strengthLabel.style.color = 'red';
            } else if (score < 80) {
                strengthMeter.classList.add('strength-medium');
                strengthLabel.textContent = 'Medium';
                strengthLabel.style.color = 'orange';
            } else {
                strengthMeter.classList.add('strength-strong');
                strengthLabel.textContent = 'Strong';
                strengthLabel.style.color = 'green';
            }
            checkPasswordMatch();
        }

        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchError = document.getElementById('match-error');

            if (confirmPassword.length === 0) {
                matchError.textContent = '';
                return false;
            } else if (password === confirmPassword) {
                matchError.textContent = 'Password match!';
                matchError.style.color = 'green';
                matchError.className = 'success-message';
                return true;
            } else {
                matchError.textContent = 'Password do not match!';
                matchError.style.color = 'red';
                matchError.className = 'error-message';
                return false;
            }
        }

        function validateUsername() {
            const usernameInput = document.getElementById('username');
            const errorElement = document.getElementById('username-error');
            const username = usernameInput.value;
            
            const hasAlpha = /[A-Za-z]/.test(username);
            const hasDigit = /\d/.test(username);
            const hasSpecial = /[^A-Za-z0-9\s]/.test(username);

            if (username.length === 0) {
                errorElement.textContent = "";
                return false;
            } else if (!hasAlpha || !hasDigit || !hasSpecial) {
                errorElement.textContent = "Username must contain alphabetics, digits, AND special characters.";
                errorElement.style.color = 'red';
                errorElement.className = 'error-message';
                return false;
            } else {
                errorElement.textContent = "Valid Username!";
                errorElement.style.color = 'green';
                errorElement.className = 'success-message';
                return true;
            }
        }

        function validatePhone() {
            const phoneInput = document.getElementById('phone');
            const errorElement = document.getElementById('phone-error');
            const phone = phoneInput.value.replace(/\D/g, '');
            
            phoneInput.value = phone;
            
            const phoneRegex = /^[6-9]\d{9}$/;

            if (phone.length === 0) {
                errorElement.textContent = "";
                return false;
            } else if (!phoneRegex.test(phone)) {
                errorElement.textContent = "Please enter a valid 10-digit phone number starting with 6-9.";
                errorElement.style.color = 'red';
                errorElement.className = 'error-message';
                return false;
            } else {
                errorElement.textContent = "Valid phone number!";
                errorElement.style.color = 'green';
                errorElement.className = 'success-message';
                return true;
            }
        }

        document.getElementById('registrationForm').addEventListener('submit', function(event) {
            event.preventDefault();
            
            const isUsernameValid = validateUsername();
            const isPasswordMatch = checkPasswordMatch();
            const isPhoneValid = validatePhone();
            
            const fullname = document.getElementById('fullname').value.trim();
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const password = document.getElementById('password').value;
            
            if (!fullname) {
                showFieldError('fullname', 'Please enter your full name.');
                return false;
            } else {
                clearFieldError('fullname');
            }
            
            if (!isUsernameValid) {
                showFieldError('username', 'Please correct the username error.');
                return false;
            } else {
                clearFieldError('username');
            }
            
            if (!email) {
                showFieldError('email', 'Please enter your email address.');
                return false;
            } else {
                clearFieldError('email');
            }
            
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                showFieldError('email', 'Please enter a valid email address.');
                return false;
            } else {
                clearFieldError('email');
            }
            
            if (!isPhoneValid) {
                showFieldError('phone', 'Please enter a valid 10-digit phone number.');
                return false;
            } else {
                clearFieldError('phone');
            }
            
            if (!isPasswordMatch) {
                showFieldError('confirmPassword', 'Passwords must match.');
                return false;
            } else {
                clearFieldError('confirmPassword');
            }

            checkAvailabilityAndSubmit(username, email);
        });

        function showFieldError(fieldId, message) {
            const field = document.getElementById(fieldId);
            let errorElement = document.getElementById(`${fieldId}-error`);
            
            if (!errorElement) {
                errorElement = document.createElement('span');
                errorElement.id = `${fieldId}-error`;
                errorElement.className = 'error-message';
                field.parentNode.appendChild(errorElement);
            }
            
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }

        function clearFieldError(fieldId) {
            const errorElement = document.getElementById(`${fieldId}-error`);
            if (errorElement) {
                errorElement.textContent = '';
                errorElement.style.display = 'none';
            }
        }

        function checkAvailabilityAndSubmit(username, email) {
            const submitBtn = document.getElementById('submit-btn');
            submitBtn.disabled = true;
            submitBtn.textContent = 'Checking...';
            
            showAvailabilityMessage('username', 'Checking username availability...', 'checking');
            showAvailabilityMessage('email', 'Checking email availability...', 'checking');
            clearClientMessages();
            
            const usernameCheck = checkUsernameAvailability(username);
            const emailCheck = checkEmailAvailability(email);
            
            Promise.all([usernameCheck, emailCheck])
                .then(([usernameResult, emailResult]) => {
                    const isUsernameAvailable = usernameResult.available;
                    const isEmailAvailable = emailResult.available;
                    
                    let errorMessages = [];
                    
                    if (isUsernameAvailable) {
                        showAvailabilityMessage('username', '✓ Username is available!', 'available');
                    } else {
                        showAvailabilityMessage('username', '✗ Username is already registered!', 'taken');
                        errorMessages.push('Username is already registered');
                    }
                    
                    if (isEmailAvailable) {
                        showAvailabilityMessage('email', '✓ Email is available!', 'available');
                    } else {
                        showAvailabilityMessage('email', '✗ Email is already registered!', 'taken');
                        errorMessages.push('Email is already registered');
                    }
                    
                    if (errorMessages.length > 0) {
                        if (errorMessages.length === 2) {
                            showClientError('Username and email are already registered! Please use different credentials.');
                            clearFormFields();
                        } else if (errorMessages.length === 1) {
                            showClientError(errorMessages[0] + '! Please choose a different one.');
                            if (errorMessages[0].includes('Username')) {
                                document.getElementById('username').value = '';
                            } else if (errorMessages[0].includes('Email')) {
                                document.getElementById('email').value = '';
                            }
                        }
                        submitBtn.disabled = false;
                        submitBtn.textContent = 'Register';
                        autoHideMessages();
                    } else {
                        showClientSuccess('All credentials are available! Registering...');
                        setTimeout(() => {
                            document.getElementById('registrationForm').submit();
                        }, 1000);
                    }
                })
                .catch(error => {
                    console.error('Availability check error:', error);
                    showClientError('Error checking availability. Please try again.');
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Register';
                    autoHideMessages();
                });
        }

        function showAvailabilityMessage(type, message, status) {
            const element = document.getElementById(`${type}-availability`);
            if (element) {
                element.textContent = message;
                element.className = `availability-message availability-${status}`;
                element.style.display = 'block';
            }
        }

        function showClientError(message) {
            const clientMessages = document.getElementById('clientMessages');
            clientMessages.innerHTML = '';
            
            const errorElement = document.createElement('div');
            errorElement.className = 'client-error';
            errorElement.textContent = message;
            clientMessages.appendChild(errorElement);
        }

        function showClientSuccess(message) {
            const clientMessages = document.getElementById('clientMessages');
            clientMessages.innerHTML = '';
            
            const successElement = document.createElement('div');
            successElement.className = 'client-success';
            successElement.textContent = message;
            clientMessages.appendChild(successElement);
        }

        function clearClientMessages() {
            const clientMessages = document.getElementById('clientMessages');
            clientMessages.innerHTML = '';
        }

        function checkUsernameAvailability(username) {
            return new Promise((resolve, reject) => {
                if (username.length === 0) {
                    resolve({ available: false });
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
                                resolve(response);
                            } catch (e) {
                                console.error('Error parsing username response:', e);
                                resolve({ available: false });
                            }
                        } else {
                            reject(new Error('Request failed'));
                        }
                    }
                };
                
                xhr.onerror = function() {
                    reject(new Error('Request error'));
                };
                
                xhr.send('type=username&value=' + encodeURIComponent(username));
            });
        }

        function checkEmailAvailability(email) {
            return new Promise((resolve, reject) => {
                if (email.length === 0) {
                    resolve({ available: false });
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
                                resolve(response);
                            } catch (e) {
                                console.error('Error parsing email response:', e);
                                resolve({ available: false });
                            }
                        } else {
                            reject(new Error('Request failed'));
                        }
                    }
                };
                
                xhr.onerror = function() {
                    reject(new Error('Request error'));
                };
                
                xhr.send('type=email&value=' + encodeURIComponent(email));
            });
        }
    </script>

</body>
</html>--%>










<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WorkSphere Pro - Sign Up</title>
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
        background: linear-gradient(135deg, #0c0c0c 0%, #1a1a2e 50%, #16213e 100%);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        overflow-x: hidden;
        color: #ffffff;
    }

    .top-left-back {
        position: fixed;
        top: 20px;
        left: 20px;
        z-index: 1001;
    }

    .back-link {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 50px;
        height: 50px;
        color: #ffffff;
        text-decoration: none;
        font-weight: 600;
        background: rgba(255, 255, 255, 0.0);
        border-radius: 50%;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
        border: 1px solid rgba(255, 255, 255, 0.2);
        backdrop-filter: blur(10px);
    }
    
    .back-link:hover {
        background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(242, 171, 78, 0.4);
        text-decoration: none;
        border-color: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
    }

    .top-right-login {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 1001;
    }

    .top-login-link {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        color: #4a6bff;
        text-decoration: none;
        font-weight: 600;
        padding: 10px 20px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 20px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
        border: 1px solid rgba(74, 107, 255, 0.3);
        backdrop-filter: blur(10px);
    }
    
    .top-login-link:hover {
        background: linear-gradient(135deg, #FF6B35 0%, #FF8E53 100%);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(242, 171, 78, 0.4);
        text-decoration: none;
    }

    .register-wrapper {
        display: flex;
        width: 95vw;
        max-width: 1200px;
        height: 90vh;
        background: rgba(18, 18, 30, 0.95);
        border-radius: 20px;
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.3);
        overflow: hidden;
        animation: slideUp 0.8s ease-out;
        backdrop-filter: blur(15px);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .brand-section {
        flex: 1;
        background: linear-gradient(135deg, #0f3460 0%, #1a1a2e 100%);
        color: white;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        padding: 40px;
        position: relative;
        overflow: hidden;
    }
    
    .brand-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="15" height="15" patternUnits="userSpaceOnUse"><path d="M 15 0 L 0 0 0 15" fill="none" stroke="rgba(255,255,255,0.05)" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
        animation: float 8s ease-in-out infinite;
    }
    
    @keyframes float {
        0%, 100% { transform: translateY(0px) rotate(0deg); }
        50% { transform: translateY(-10px) rotate(1deg); }
    }

    .logo-container {
        display: flex;
        align-items: center;
        gap: 15px;
        text-decoration: none;
        margin-bottom: 25px;
    }
    
    .logo-icon {
        width: 70px;
        height: 70px;
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
        font-size: 28px;
        filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));
        z-index: 1;
    }
    
    .logo-text {
        display: flex;
        flex-direction: column;
        line-height: 1;
        position: relative;
        align-items: flex-start;
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
        font-size: 2.2rem;
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
        font-size: 1.8rem;
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
        font-size: 0.75rem;
        font-weight: 700;
        color: #b0b0b0;
        letter-spacing: 2px;
        text-transform: uppercase;
        margin-top: 5px;
        position: relative;
        padding-left: 12px;
        align-self: flex-start;
    }
    
    .logo-tagline::before {
        content: '✦';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        color: #3498db;
        font-size: 0.5rem;
    }

    .brand-tagline {
        font-size: 1rem;
        opacity: 0.8;
        line-height: 1.5;
        max-width: 280px;
        font-weight: 300;
        margin-top: 10px;
    }

    .register-section {
        flex: 1.2;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;
        padding: 40px;
        position: relative;
        overflow-y: auto;
        background: rgba(13, 13, 23, 0.95);
    }

    .register-content {
        width: 100%;
        max-width: 500px;
        margin: 0 auto;
        animation: fadeIn 0.8s ease-out 0.3s both;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateX(20px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    .register-header {
        margin-bottom: 30px;
        text-align: center;
    }
    
    .main-heading {
        font-size: 2.5rem;
        font-weight: 800;
        color: #ffffff;
        margin-bottom: 10px;
        background: linear-gradient(135deg, #4a6bff, #9254ff);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }
    
    .register-subtitle {
        color: #b0b0b0;
        font-size: 1.1rem;
        font-weight: 400;
        line-height: 1.5;
    }

    .form-container {
        display: flex;
        flex-direction: column;
        gap: 20px;
        margin-bottom: 25px;
    }

    .form-group {
        position: relative;
        animation: slideIn 0.6s ease-out;
    }
    
    @keyframes slideIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #e0e0e0;
        font-size: 0.9rem;
        transition: all 0.3s ease;
    }
    
    .input-with-icon {
        position: relative;
    }
    
    .form-group input {
        width: 100%;
        padding: 15px 50px 15px 50px;
        border: 2px solid #2a2a3a;
        border-radius: 12px;
        font-size: 1rem;
        transition: all 0.3s ease;
        background: rgba(30, 30, 45, 0.8);
        color: #ffffff;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }
    
    .form-group input:-webkit-autofill,
    .form-group input:-webkit-autofill:hover,
    .form-group input:-webkit-autofill:focus,
    .form-group input:-webkit-autofill:active {
        -webkit-box-shadow: 0 0 0 30px rgba(30, 30, 45, 0.9) inset !important;
        -webkit-text-fill-color: #ffffff !important;
        background-color: rgba(30, 30, 45, 0.9) !important;
        color: #ffffff !important;
        border: 2px solid #4a6bff !important;
    }
    
    .form-group input::placeholder {
        color: #888;
    }
    
    .form-group input:focus {
        outline: none;
        border-color: #4a6bff;
        box-shadow: 0 0 0 4px rgba(74, 107, 255, 0.2);
        transform: translateY(-2px);
        background: rgba(35, 35, 55, 0.9);
    }
    
    .form-group input:hover {
        border-color: #4a6bff;
        transform: translateY(-1px);
    }

    .input-icon {
        position: absolute;
        left: 18px;
        top: 50%;
        transform: translateY(-50%);
        color: #888;
        font-size: 1rem;
        z-index: 2;
        transition: all 0.3s ease;
    }
    
    .form-group input:focus + .input-icon {
        color: #4a6bff;
    }

    .password-toggle {
        position: absolute;
        right: 18px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: #888;
        cursor: pointer;
        font-size: 1rem;
        transition: all 0.3s ease;
        z-index: 2;
        padding: 5px;
        border-radius: 4px;
    }
    
    .password-toggle:hover {
        color: #4a6bff;
    }

    .password-strength {
        height: 6px;
        margin-top: 8px;
        border-radius: 3px;
        background-color: #2a2a3a;
        transition: all 0.4s ease;
        display: none;
        box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.2);
    }
    
    .strength-weak { 
        background: linear-gradient(90deg, #ff4757, #ff3838);
        width: 33%; 
    }
    
    .strength-medium { 
        background: linear-gradient(90deg, #ff9f1a, #ffaf40);
        width: 66%; 
    }
    
    .strength-strong { 
        background: linear-gradient(90deg, #2ed573, #1e90ff);
        width: 100%; 
    }
    
    #strength-label {
        display: none;
        font-size: 0.8rem;
        margin-top: 6px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-register {
        background: linear-gradient(135deg, #4a6bff 0%, #9254ff 100%);
        color: white;
        padding: 16px 30px;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        width: 100%;
        font-size: 1.1rem;
        font-weight: 700;
        transition: all 0.4s ease;
        margin: 10px 0;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        box-shadow: 0 8px 25px rgba(74, 107, 255, 0.3);
        position: relative;
        overflow: hidden;
    }
    
    .btn-register::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: left 0.6s;
    }
    
    .btn-register:hover::before {
        left: 100%;
    }
    
    .btn-register:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 35px rgba(74, 107, 255, 0.5);
        background: linear-gradient(135deg, #9254ff 0%, #4a6bff 100%);
    }
    
    .btn-register:active {
        transform: translateY(-1px);
    }

    .btn-register:disabled {
        background: #4a5568;
        cursor: not-allowed;
        transform: none;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
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
    
    .server-messages, .client-messages {
        width: 100%;
    }
    
    .server-error, .server-success,
    .client-error, .client-success {
        padding: 16px 20px 16px 55px;
        border-radius: 12px;
        text-align: left;
        font-weight: 500;
        margin-bottom: 12px;
        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
        animation: slideDown 0.5s ease-out;
        position: relative;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    
    .server-success, .client-success {
        background: linear-gradient(135deg, rgba(34, 197, 94, 0.2), rgba(21, 128, 61, 0.2));
        color: #4ade80;
        border-left: 4px solid #22c55e;
    }
    
    .server-error, .client-error {
        background: linear-gradient(135deg, rgba(239, 68, 68, 0.2), rgba(185, 28, 28, 0.2));
        color: #f87171;
        border-left: 4px solid #ef4444;
    }
    
    .message-icon {
        position: absolute;
        left: 20px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 1.2rem;
    }
    
    .server-success .message-icon,
    .client-success .message-icon {
        color: #22c55e;
    }
    
    .server-error .message-icon,
    .client-error .message-icon {
        color: #ef4444;
    }

    .error-message {
        color: #f87171;
        font-size: 0.8rem;
        margin-top: 6px;
        display: block;
        font-weight: 600;
        animation: shake 0.5s ease-in-out;
    }
    
    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-5px); }
        75% { transform: translateX(5px); }
    }
    
    .success-message {
        color: #4ade80;
        font-size: 0.8rem;
        margin-top: 6px;
        display: block;
        font-weight: 600;
        animation: bounce 0.5s ease-in-out;
    }
    
    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-2px); }
    }

    .availability-message {
        display: none;
        margin-top: 6px;
        font-size: 0.8rem;
        padding: 6px 10px;
        border-radius: 6px;
        font-weight: 600;
        animation: fadeIn 0.5s ease-out;
        border-left: 3px solid;
    }
    
    .availability-available {
        color: #4ade80;
        background: rgba(34, 197, 94, 0.1);
        border-left-color: #22c55e;
    }
    
    .availability-taken {
        color: #f87171;
        background: rgba(239, 68, 68, 0.1);
        border-left-color: #ef4444;
    }
    
    .availability-checking {
        color: #fbbf24;
        background: rgba(245, 158, 11, 0.1);
        border-left-color: #f59e0b;
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
    
    .fade-out {
        opacity: 0;
        transform: translateY(-20px);
        transition: all 0.5s ease-in-out;
    }

    .register-section::-webkit-scrollbar {
        width: 6px;
    }
    
    .register-section::-webkit-scrollbar-track {
        background: rgba(30, 30, 45, 0.5);
        border-radius: 3px;
    }
    
    .register-section::-webkit-scrollbar-thumb {
        background: linear-gradient(135deg, #4a6bff, #9254ff);
        border-radius: 3px;
    }
    
    .register-section::-webkit-scrollbar-thumb:hover {
        background: linear-gradient(135deg, #9254ff, #4a6bff);
    }

    @media (max-width: 768px) {
        .register-wrapper {
            flex-direction: column;
            height: auto;
            margin: 20px;
            max-width: 500px;
        }
        
        .brand-section {
            padding: 30px 25px;
        }
        
        .register-section {
            padding: 30px 25px;
        }
        
        .main-heading {
            font-size: 2rem;
        }
        
        .worksphere-text {
            font-size: 1.8rem;
        }
        
        .pro-text {
            font-size: 1.4rem;
        }
        
        .logo-icon {
            width: 60px;
            height: 60px;
        }
        
        .logo-icon i {
            font-size: 24px;
        }

        .top-left-back {
            top: 15px;
            left: 15px;
        }
        
        .back-link {
            width: 45px;
            height: 45px;
        }

        .top-right-login {
            top: 15px;
            right: 15px;
        }
        
        .top-login-link {
            padding: 8px 16px;
            font-size: 0.9rem;
        }
    }

    @media (max-width: 480px) {
        .register-wrapper {
            margin: 10px;
            border-radius: 16px;
        }
        
        .brand-section,
        .register-section {
            padding: 25px 20px;
        }
        
        .form-group input {
            padding: 14px 45px 14px 45px;
        }

        .top-left-back {
            top: 10px;
            left: 10px;
        }
        
        .back-link {
            width: 40px;
            height: 40px;
        }

        .top-right-login {
            top: 10px;
            right: 10px;
        }
        
        .top-login-link {
            padding: 6px 12px;
            font-size: 0.85rem;
        }
        
        .worksphere-text {
            font-size: 1.6rem;
        }
        
        .pro-text {
            font-size: 1.2rem;
        }
        
        .logo-icon {
            width: 50px;
            height: 50px;
        }
        
        .logo-icon i {
            font-size: 20px;
        }
    }
</style>
</head>
<body>

    <div class="top-left-back">
        <a href="index.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i>
        </a>
    </div>

    <div class="top-right-login">
        <a href="login.jsp" class="top-login-link">
            <i class="fas fa-sign-in-alt"></i>Sign In
        </a>
    </div>

    <div class="message-container" id="messageContainer">
        <div class="server-messages" id="serverMessages">
            <% 
                String error = (String) session.getAttribute("error");
                if (error != null) {
            %>
                <div class="server-error" id="server-error">
                    <i class="fas fa-exclamation-triangle message-icon"></i>
                    <%= error %>
                </div>
                <% session.removeAttribute("error"); %>
            <% } %>
        </div>
        <div class="client-messages" id="clientMessages"></div>
    </div>

    <div class="register-wrapper">
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
                    <div class="logo-tagline">ENTERPRISE SUITE</div>
                </div>
            </div>
            <p class="brand-tagline">Enterprise Management Suite<br>Join Our Professional Network</p>
        </div>
        
        <div class="register-section">
            <div class="register-content">
                <div class="register-header">
                    <h1 class="main-heading">Create Management Account</h1>
                    <p class="register-subtitle">Join our enterprise platform and manage your organization efficiently with powerful tools and features.</p>
                </div>

                <form action="RegisterServlet" method="post" id="registrationForm">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="fullname">Full Name</label>
                            <div class="input-with-icon">
                                <input type="text" id="fullname" name="fullname" required placeholder="Enter your full name">
                                <i class="fas fa-user input-icon"></i>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone Number</label>
                            <div class="input-with-icon">
                                <input type="text" id="phone" name="phone" required 
                                       placeholder="Enter your phone number" 
                                       maxlength="10"
                                       oninput="validatePhone()">
                                <i class="fas fa-phone input-icon"></i>
                            </div>
                            <span id="phone-error" class="error-message"></span>
                        </div>

                        <div class="form-group">
                            <label for="username">Username</label>
                            <div class="input-with-icon">
                                <input type="text" id="username" name="username" required 
                                       placeholder="Enter username"
                                       oninput="validateUsername()">
                                <i class="fas fa-user-circle input-icon"></i>
                            </div>
                            <span id="username-error" class="error-message"></span>
                        </div>

                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <div class="input-with-icon">
                                <input type="email" id="email" name="email" required placeholder="Enter your email">
                                <i class="fas fa-envelope input-icon"></i>
                            </div>
                            <span id="email-error" class="error-message"></span>
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <div class="input-with-icon">
                                <input type="password" id="password" name="password" required 
                                       placeholder="Create password" 
                                       onkeyup="checkPasswordStrength()">
                                <i class="fas fa-lock input-icon"></i>
                                <button type="button" class="password-toggle" onclick="togglePassword('password')">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div id="strength-meter" class="password-strength"></div>
                            <small id="strength-label"></small>
                        </div>
                        
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password</label>
                            <div class="input-with-icon">
                                <input type="password" id="confirmPassword" name="confirmPassword" required 
                                       placeholder="Confirm password" 
                                       onkeyup="checkPasswordMatch()">
                                <i class="fas fa-lock input-icon"></i>
                                <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <span id="match-error" class="error-message"></span>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-register" id="submit-btn">
                        <i class="fas fa-user-plus"></i>Sign Up
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const toggle = field.parentNode.querySelector('.password-toggle i');
            
            if (field.type === 'password') {
                field.type = 'text';
                toggle.classList.remove('fa-eye');
                toggle.classList.add('fa-eye-slash');
            } else {
                field.type = 'password';
                toggle.classList.remove('fa-eye-slash');
                toggle.classList.add('fa-eye');
            }
        }

        function autoHideMessages() {
            const serverError = document.getElementById('server-error');
            const clientMessages = document.getElementById('clientMessages');
            
            if (serverError) {
                setTimeout(() => {
                    serverError.classList.add('fade-out');
                    setTimeout(() => {
                        serverError.remove();
                    }, 500);
                }, 5000);
            }
            
            if (clientMessages && clientMessages.children.length > 0) {
                setTimeout(() => {
                    Array.from(clientMessages.children).forEach(child => {
                        child.classList.add('fade-out');
                        setTimeout(() => {
                            child.remove();
                        }, 500);
                    });
                }, 5000);
            }
        }

        function clearFormFields() {
            document.getElementById('fullname').value = '';
            document.getElementById('username').value = '';
            document.getElementById('email').value = '';
            document.getElementById('phone').value = '';
            document.getElementById('password').value = '';
            document.getElementById('confirmPassword').value = '';
            
            document.getElementById('username-error').textContent = '';
            document.getElementById('email-error').textContent = '';
            document.getElementById('phone-error').textContent = '';
            document.getElementById('match-error').textContent = '';
            
            const usernameAvailability = document.getElementById('username-availability');
            const emailAvailability = document.getElementById('email-availability');
            if (usernameAvailability) usernameAvailability.textContent = '';
            if (emailAvailability) emailAvailability.textContent = '';
            
            document.getElementById('strength-meter').style.display = 'none';
            document.getElementById('strength-label').style.display = 'none';
        }

        document.addEventListener('DOMContentLoaded', function() {
            const usernameGroup = document.querySelector('#username').closest('.form-group');
            if (!document.getElementById('username-availability')) {
                const usernameAvailability = document.createElement('span');
                usernameAvailability.id = 'username-availability';
                usernameAvailability.className = 'availability-message';
                usernameGroup.appendChild(usernameAvailability);
            }
            
            const emailGroup = document.querySelector('#email').closest('.form-group');
            if (!document.getElementById('email-availability')) {
                const emailAvailability = document.createElement('span');
                emailAvailability.id = 'email-availability';
                emailAvailability.className = 'availability-message';
                emailGroup.appendChild(emailAvailability);
            }
            
            validateUsername();
            validatePhone();
            checkPasswordMatch();
            
            autoHideMessages();
        });

        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthMeter = document.getElementById('strength-meter');
            const strengthLabel = document.getElementById('strength-label');
            let score = 0;

            if (password.length > 0) {
                strengthMeter.style.display = 'block';
                strengthLabel.style.display = 'block';
            } else {
                strengthMeter.style.display = 'none';
                strengthLabel.style.display = 'none';
                return;
            }

            if (password.length >= 8) score += 20;
            if (password.length >= 12) score += 20;
            if (/[a-z]/.test(password)) score += 15;
            if (/[A-Z]/.test(password)) score += 15;
            if (/\d/.test(password)) score += 15;
            if (/[^a-zA-Z0-9\s]/.test(password)) score += 15;

            strengthMeter.className = 'password-strength';
            strengthLabel.style.color = '#ffffff';

            if (score < 40) {
                strengthMeter.classList.add('strength-weak');
                strengthLabel.textContent = 'Weak Password';
                strengthLabel.style.color = '#f87171';
            } else if (score < 80) {
                strengthMeter.classList.add('strength-medium');
                strengthLabel.textContent = 'Medium Password';
                strengthLabel.style.color = '#fbbf24';
            } else {
                strengthMeter.classList.add('strength-strong');
                strengthLabel.textContent = 'Strong Password';
                strengthLabel.style.color = '#4ade80';
            }
            checkPasswordMatch();
        }

        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchError = document.getElementById('match-error');

            if (confirmPassword.length === 0) {
                matchError.textContent = '';
                return false;
            } else if (password === confirmPassword) {
                matchError.textContent = 'Password match!';
                matchError.style.color = '#4ade80';
                matchError.className = 'success-message';
                return true;
            } else {
                matchError.textContent = 'Password do not match!';
                matchError.style.color = '#f87171';
                matchError.className = 'error-message';
                return false;
            }
        }

        function validateUsername() {
            const usernameInput = document.getElementById('username');
            const errorElement = document.getElementById('username-error');
            const username = usernameInput.value;
            
            const hasAlpha = /[A-Za-z]/.test(username);
            const hasDigit = /\d/.test(username);
            const hasSpecial = /[^A-Za-z0-9\s]/.test(username);

            if (username.length === 0) {
                errorElement.textContent = "";
                return false;
            } else if (!hasAlpha || !hasDigit || !hasSpecial) {
                errorElement.textContent = "Username must contain alphabetics, digits, AND special characters.";
                errorElement.style.color = '#f87171';
                errorElement.className = 'error-message';
                return false;
            } else {
                errorElement.textContent = "Valid Username!";
                errorElement.style.color = '#4ade80';
                errorElement.className = 'success-message';
                return true;
            }
        }

        function validatePhone() {
            const phoneInput = document.getElementById('phone');
            const errorElement = document.getElementById('phone-error');
            const phone = phoneInput.value.replace(/\D/g, '');
            
            phoneInput.value = phone;
            
            const phoneRegex = /^[6-9]\d{9}$/;

            if (phone.length === 0) {
                errorElement.textContent = "";
                return false;
            } else if (!phoneRegex.test(phone)) {
                errorElement.textContent = "Please enter a valid 10-digit phone number starting with 6-9.";
                errorElement.style.color = '#f87171';
                errorElement.className = 'error-message';
                return false;
            } else {
                errorElement.textContent = "Valid phone number!";
                errorElement.style.color = '#4ade80';
                errorElement.className = 'success-message';
                return true;
            }
        }

        document.getElementById('registrationForm').addEventListener('submit', function(event) {
            event.preventDefault();
            
            const isUsernameValid = validateUsername();
            const isPasswordMatch = checkPasswordMatch();
            const isPhoneValid = validatePhone();
            
            const fullname = document.getElementById('fullname').value.trim();
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const password = document.getElementById('password').value;
            
            if (!fullname) {
                showFieldError('fullname', 'Please enter your full name.');
                return false;
            } else {
                clearFieldError('fullname');
            }
            
            if (!isUsernameValid) {
                showFieldError('username', 'Please correct the username error.');
                return false;
            } else {
                clearFieldError('username');
            }
            
            if (!email) {
                showFieldError('email', 'Please enter your email address.');
                return false;
            } else {
                clearFieldError('email');
            }
            
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                showFieldError('email', 'Please enter a valid email address.');
                return false;
            } else {
                clearFieldError('email');
            }
            
            if (!isPhoneValid) {
                showFieldError('phone', 'Please enter a valid 10-digit phone number.');
                return false;
            } else {
                clearFieldError('phone');
            }
            
            if (!isPasswordMatch) {
                showFieldError('confirmPassword', 'Passwords must match.');
                return false;
            } else {
                clearFieldError('confirmPassword');
            }

            checkAvailabilityAndSubmit(username, email);
        });

        function showFieldError(fieldId, message) {
            const field = document.getElementById(fieldId);
            let errorElement = document.getElementById(`${fieldId}-error`);
            
            if (!errorElement) {
                errorElement = document.createElement('span');
                errorElement.id = `${fieldId}-error`;
                errorElement.className = 'error-message';
                field.parentNode.appendChild(errorElement);
            }
            
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }

        function clearFieldError(fieldId) {
            const errorElement = document.getElementById(`${fieldId}-error`);
            if (errorElement) {
                errorElement.textContent = '';
                errorElement.style.display = 'none';
            }
        }

        function checkAvailabilityAndSubmit(username, email) {
            const submitBtn = document.getElementById('submit-btn');
            submitBtn.disabled = true;
            submitBtn.textContent = 'Checking...';
            
            showAvailabilityMessage('username', 'Checking username availability...', 'checking');
            showAvailabilityMessage('email', 'Checking email availability...', 'checking');
            clearClientMessages();
            
            const usernameCheck = checkUsernameAvailability(username);
            const emailCheck = checkEmailAvailability(email);
            
            Promise.all([usernameCheck, emailCheck])
                .then(([usernameResult, emailResult]) => {
                    const isUsernameAvailable = usernameResult.available;
                    const isEmailAvailable = emailResult.available;
                    
                    let errorMessages = [];
                    
                    if (isUsernameAvailable) {
                        showAvailabilityMessage('username', 'Username is available!', 'available');
                    } else {
                        showAvailabilityMessage('username', 'Username is already registered!', 'taken');
                        errorMessages.push('Username is already registered');
                    }
                    
                    if (isEmailAvailable) {
                        showAvailabilityMessage('email', 'Email is available!', 'available');
                    } else {
                        showAvailabilityMessage('email', 'Email is already registered!', 'taken');
                        errorMessages.push('Email is already registered');
                    }
                    
                    if (errorMessages.length > 0) {
                        if (errorMessages.length === 2) {
                            showClientError('Username and email are already registered! Please use different credentials.');
                            clearFormFields();
                        } else if (errorMessages.length === 1) {
                            showClientError(errorMessages[0] + '! Please choose a different one.');
                            if (errorMessages[0].includes('Username')) {
                                document.getElementById('username').value = '';
                            } else if (errorMessages[0].includes('Email')) {
                                document.getElementById('email').value = '';
                            }
                        }
                        submitBtn.disabled = false;
                        submitBtn.textContent = 'Create Account';
                        autoHideMessages();
                    } else {
                        showClientSuccess('All credentials are available! Registering...');
                        setTimeout(() => {
                            document.getElementById('registrationForm').submit();
                        }, 1000);
                    }
                })
                .catch(error => {
                    console.error('Availability check error:', error);
                    showClientError('Error checking availability. Please try again.');
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'Create Account';
                    autoHideMessages();
                });
        }

        function showAvailabilityMessage(type, message, status) {
            const element = document.getElementById(`${type}-availability`);
            if (element) {
                const cleanMessage = message.replace(/[\(\)]/g, '');
                element.textContent = cleanMessage;
                element.className = `availability-message availability-${status}`;
                element.style.display = 'block';
            }
        }

        function showClientError(message) {
            const clientMessages = document.getElementById('clientMessages');
            clientMessages.innerHTML = '';
            
            const errorElement = document.createElement('div');
            errorElement.className = 'client-error';
            errorElement.innerHTML = '<i class="fas fa-exclamation-triangle message-icon"></i>' + message;
            clientMessages.appendChild(errorElement);
        }

        function showClientSuccess(message) {
            const clientMessages = document.getElementById('clientMessages');
            clientMessages.innerHTML = '';
            
            const successElement = document.createElement('div');
            successElement.className = 'client-success';
            successElement.innerHTML = '<i class="fas fa-check-circle message-icon"></i>' + message;
            clientMessages.appendChild(successElement);
        }

        function clearClientMessages() {
            const clientMessages = document.getElementById('clientMessages');
            clientMessages.innerHTML = '';
        }

        function checkUsernameAvailability(username) {
            return new Promise((resolve, reject) => {
                if (username.length === 0) {
                    resolve({ available: false });
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
                                resolve(response);
                            } catch (e) {
                                console.error('Error parsing username response:', e);
                                resolve({ available: false });
                            }
                        } else {
                            reject(new Error('Request failed'));
                        }
                    }
                };
                
                xhr.onerror = function() {
                    reject(new Error('Request error'));
                };
                
                xhr.send('type=username&value=' + encodeURIComponent(username));
            });
        }

        function checkEmailAvailability(email) {
            return new Promise((resolve, reject) => {
                if (email.length === 0) {
                    resolve({ available: false });
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
                                resolve(response);
                            } catch (e) {
                                console.error('Error parsing email response:', e);
                                resolve({ available: false });
                            }
                        } else {
                            reject(new Error('Request failed'));
                        }
                    }
                };
                
                xhr.onerror = function() {
                    reject(new Error('Request error'));
                };
                
                xhr.send('type=email&value=' + encodeURIComponent(email));
            });
        }
    </script>

</body>
</html>



