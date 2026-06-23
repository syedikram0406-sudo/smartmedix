<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Profile - HMS</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🏥 HMS</h3>
                        <div class="role-badge">Patient Panel</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/patient/dashboard"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/book-appointment"><span
                                    class="nav-icon">📅</span> Book Appointment</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/my-appointments"><span
                                    class="nav-icon">📋</span> My Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/medical-records"><span
                                    class="nav-icon">📁</span> Medical Records</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/reminders"><span
                                    class="nav-icon">⏰</span> Reminders</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/profile" class="active"><span
                                    class="nav-icon">👤</span> My Profile</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Health Profile</h1>
                        <p>View and update your health profile</p>
                    </div>

                    <% if (request.getParameter("success") !=null) { %>
                        <div class="alert alert-success">Profile updated successfully!</div>
                        <% } %>

                            <div class="form-card">
                                <h3>👤 Your Profile</h3>
                                <form action="${pageContext.request.contextPath}/patient/profile/update" method="post">
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label>Name</label>
                                            <input type="text" value="${patient.name}" disabled>
                                        </div>
                                        <div class="form-group"><label>Age</label><input type="number" name="age"
                                                value="${patient.age}" placeholder="Age"></div>
                                        <div class="form-group"><label>Gender</label>
                                            <select name="gender">
                                                <option value="">Select</option>
                                                <option value="Male" ${patient.gender=='Male' ? 'selected' : '' }>Male
                                                </option>
                                                <option value="Female" ${patient.gender=='Female' ? 'selected' : '' }>
                                                    Female</option>
                                                <option value="Other" ${patient.gender=='Other' ? 'selected' : '' }>
                                                    Other</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group"><label>Blood Group</label>
                                            <select name="bloodGroup">
                                                <option value="">Select</option>
                                                <option ${patient.bloodGroup=='A+' ? 'selected' : '' }>A+</option>
                                                <option ${patient.bloodGroup=='A-' ? 'selected' : '' }>A-</option>
                                                <option ${patient.bloodGroup=='B+' ? 'selected' : '' }>B+</option>
                                                <option ${patient.bloodGroup=='B-' ? 'selected' : '' }>B-</option>
                                                <option ${patient.bloodGroup=='AB+' ? 'selected' : '' }>AB+</option>
                                                <option ${patient.bloodGroup=='AB-' ? 'selected' : '' }>AB-</option>
                                                <option ${patient.bloodGroup=='O+' ? 'selected' : '' }>O+</option>
                                                <option ${patient.bloodGroup=='O-' ? 'selected' : '' }>O-</option>
                                            </select>
                                        </div>
                                        <div class="form-group"><label>Phone</label><input type="text" name="phone"
                                                value="${patient.phone}" placeholder="Phone"></div>
                                        <div class="form-group"><label>Emergency Contact</label><input type="text"
                                                name="emergencyContact" value="${patient.emergencyContact}"
                                                placeholder="Emergency Contact"></div>
                                    </div>
                                    <div class="form-group"><label>Allergies</label><textarea name="allergies" rows="2"
                                            placeholder="List any allergies">${patient.allergies}</textarea></div>
                                    <div class="form-group"><label>Address</label><textarea name="address" rows="2"
                                            placeholder="Your address">${patient.address}</textarea></div>
                                    <button type="submit" class="btn-primary" style="max-width:200px;">Update
                                        Profile</button>
                                </form>
                            </div>
                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

