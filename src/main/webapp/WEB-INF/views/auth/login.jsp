<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - SmartMedix</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>

    <body>
        <div class="auth-wrapper">
            <div class="auth-card">
                <div class="logo-icon">🩺</div>
                <h2>Welcome Back</h2>
                <p class="subtitle">SmartMedix – Smart Medical Data Management</p>

                <% if (request.getAttribute("error") !=null) { %>
                    <div class="alert alert-danger">${error}</div>
                    <% } %>
                        <% if (request.getAttribute("success") !=null) { %>
                            <div class="alert alert-success">${success}</div>
                            <% } %>

                                <form action="${pageContext.request.contextPath}/auth/login" method="post">
                                    <div class="form-group">
                                        <label>Username</label>
                                        <input type="text" name="username" placeholder="Enter your username" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Password</label>
                                        <input type="password" name="password" placeholder="Enter your password"
                                            required>
                                    </div>
                                    <button type="submit" class="btn-primary">Sign In</button>
                                </form>

                                <div class="auth-link">
                                    Don't have an account? <a
                                        href="${pageContext.request.contextPath}/auth/register">Register here</a>
                                </div>
            </div>
        </div>
    </body>

    </html>