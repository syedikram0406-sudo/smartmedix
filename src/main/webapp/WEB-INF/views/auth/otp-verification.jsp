<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - SmartMedix</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .otp-input-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin: 20px 0;
        }
        .otp-input {
            width: 45px;
            height: 45px;
            text-align: center;
            font-size: 20px;
            font-weight: 600;
            border: 2px solid rgba(15, 23, 42, 0.1);
            border-radius: 8px;
            background: #fff;
            color: var(--primary-navy);
            transition: all 0.3s ease;
        }
        .otp-input:focus {
            border-color: var(--medical-blue);
            box-shadow: 0 0 10px rgba(30, 136, 229, 0.2);
            outline: none;
        }
    </style>
</head>
<body>
    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="logo-icon">📧</div>
            <h2>Verify Your Email</h2>
            <p class="subtitle">Please enter the 6-digit OTP sent to your registered email.</p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">${error}</div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">${success}</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/auth/verify-otp" method="post">
                <input type="hidden" name="email" value="${verificationEmail != null ? verificationEmail : unverifiedEmail}">
                
                <div class="form-group">
                    <label>Enter 6-Digit OTP</label>
                    <input type="text" name="otp" placeholder="123456" 
                           maxlength="6" required 
                           style="text-align: center; letter-spacing: 15px; font-size: 24px; font-weight: 700;">
                </div>

                <button type="submit" class="btn-primary">Verify OTP</button>
            </form>

            <div class="auth-link">
                Didn't receive the code? <a href="#" onclick="alert('OTP has been resent!')">Resend OTP</a>
            </div>
            <div class="auth-link" style="margin-top: 10px;">
                <a href="${pageContext.request.contextPath}/auth/login">Back to Login</a>
            </div>
        </div>
    </div>
</body>
</html>
