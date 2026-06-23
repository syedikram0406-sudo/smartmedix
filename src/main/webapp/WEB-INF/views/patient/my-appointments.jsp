<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Appointments - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/patient/my-appointments" class="active"><span
                                    class="nav-icon">📋</span> My Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/medical-records"><span
                                    class="nav-icon">📁</span> Medical Records</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/reminders"><span
                                    class="nav-icon">⏰</span> Reminders</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/profile"><span
                                    class="nav-icon">👤</span> My Profile</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>My Appointments</h1>
                        <p>Track your appointments</p>
                    </div>
                    <% if (request.getParameter("success") !=null) { %>
                        <div class="alert alert-success">Appointment booked successfully!</div>
                        <% } %>
                            <div class="data-table-wrapper">
                                <div class="table-header">
                                    <h3>Appointments</h3>
                                </div>
                                <div class="table-responsive"><table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Doctor</th>
                                            <th>Department</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${appointments}" var="a">
                                            <tr>
                                                <td>A${a.id}</td>
                                                <td>${a.doctor.name}</td>
                                                <td>${a.doctor.department}</td>
                                                <td>${a.appointmentDate}</td>
                                                <td>${a.appointmentTime}</td>
                                                <td><span
                                                        class="badge badge-${a.status == 'Completed' ? 'completed' : a.status == 'Approved' ? 'approved' : a.status == 'Cancelled' ? 'cancelled' : 'pending'}">${a.status}</span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty appointments}">
                                            <tr>
                                                <td colspan="6" class="empty-state">
                                                    <div class="empty-icon">📅</div>
                                                    <p>No appointments yet. <a
                                                            href="${pageContext.request.contextPath}/patient/book-appointment">Book
                                                            one now!</a></p>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table></div>
                            </div>
                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

