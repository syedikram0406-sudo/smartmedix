<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - SmartMedix</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <div class="auth-wrapper">
            <div class="auth-card">
                <div class="logo-icon">🩺</div>
                <h2>Create Account</h2>
                <p class="subtitle">Join SmartMedix – Smart Medical Data Management</p>

                <% if (request.getAttribute("error") !=null) { %>
                    <div class="alert alert-danger">${error}</div>
                    <% } %>

                        <form action="${pageContext.request.contextPath}/auth/register" method="post">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" name="fullName" placeholder="Enter your full name" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" name="email" placeholder="Enter your email" required>
                            </div>
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" name="username" placeholder="Choose a username" required>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" placeholder="Choose a password" required>
                            </div>
                            <div class="form-group">
                                <label>Role</label>
                                <select name="role" required>
                                    <option value="">Select your role</option>
                                    <option value="ADMIN">Admin</option>
                                    <option value="DOCTOR">Doctor</option>
                                    <option value="PATIENT">Patient</option>
                                    <option value="LAB_TECHNICIAN">Lab Technician</option>
                                </select>
                            </div>
                            <button type="submit" class="btn-primary">Register</button>
                        </form>

                        <div class="auth-link">
                            Already have an account? <a href="${pageContext.request.contextPath}/auth/login">Login
                                here</a>
                        </div>
            </div>
        </div>
    </body>

    </html>