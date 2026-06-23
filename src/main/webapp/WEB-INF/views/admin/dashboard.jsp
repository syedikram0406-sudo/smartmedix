<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard - HMS</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div><!-- Mobile Top Bar --><div class=mobile-top-bar><span class=mobile-logo>&#129658; SmartMedix</span><button class=hamburger-btn id=hamburgerBtn aria-label=Toggle menu><span></span><span></span><span></span></button></div><div class=sidebar-overlay id=sidebarOverlay></div>
            <div class="layout">
                <!-- Sidebar -->
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🏥 HMS</h3>
                        <div class="role-badge">Admin Panel</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="active"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/doctors"><span
                                    class="nav-icon">👨‍⚕️</span> Doctors</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/patients"><span
                                    class="nav-icon">🧑‍🤝‍🧑</span> Patients</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/appointments"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/transactions"><span
                                    class="nav-icon">💸</span> Transactions</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/insurance-requests"><span
                                    class="nav-icon">🛡️</span> Insurance Claims</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/analytics"><span
                                    class="nav-icon">📈</span> Analytics</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/complaints"><span
                                    class="nav-icon">📝</span> Complaints</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/hospitals"><span
                                    class="nav-icon">🛏️</span> Bed Availability</a></li>
                    </ul>
                    <div class="sidebar-footer">
                        <a href="${pageContext.request.contextPath}/auth/logout"><span class="nav-icon">🚪</span>
                            Logout</a>
                    </div>
                </aside>

                <!-- Main Content -->
                <main class="main-content">
                    <div class="page-header">
                        <h1>Dashboard Overview</h1>
                        <p>Welcome back, ${sessionScope.user.fullName}! Here's your hospital summary.</p>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card blue">
                            <div class="stat-icon">🧑‍🤝‍🧑</div>
                            <div class="stat-value">${totalPatients}</div>
                            <div class="stat-label">Total Patients</div>
                        </div>
                        <div class="stat-card green">
                            <div class="stat-icon">👨‍⚕️</div>
                            <div class="stat-value">${totalDoctors}</div>
                            <div class="stat-label">Total Doctors</div>
                        </div>
                        <div class="stat-card orange">
                            <div class="stat-icon">📅</div>
                            <div class="stat-value">${totalAppointments}</div>
                            <div class="stat-label">Total Appointments</div>
                        </div>
                        <div class="stat-card purple">
                            <div class="stat-icon">🧪</div>
                            <div class="stat-value">${totalLabReports}</div>
                            <div class="stat-label">Lab Reports Generated</div>
                        </div>
                        <div class="stat-card red">
                            <div class="stat-icon">📝</div>
                            <div class="stat-value">${pendingComplaints}</div>
                            <div class="stat-label">Pending Complaints</div>
                        </div>
                    </div>

                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>Quick Actions</h3>
                        </div>
                        <div
                            style="padding: 24px; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px;">
                            <a href="${pageContext.request.contextPath}/admin/doctors" style="text-decoration:none;">
                                <div class="stat-card blue" style="cursor:pointer; text-align:center;">
                                    <div class="stat-icon">➕</div>
                                    <div class="stat-label">Manage Doctors</div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/patients" style="text-decoration:none;">
                                <div class="stat-card green" style="cursor:pointer; text-align:center;">
                                    <div class="stat-icon">➕</div>
                                    <div class="stat-label">Manage Patients</div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/appointments"
                                style="text-decoration:none;">
                                <div class="stat-card orange" style="cursor:pointer; text-align:center;">
                                    <div class="stat-icon">📋</div>
                                    <div class="stat-label">View Appointments</div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/complaints" style="text-decoration:none;">
                                <div class="stat-card red" style="cursor:pointer; text-align:center;">
                                    <div class="stat-icon">⚠️</div>
                                    <div class="stat-label">Resolve Complaints</div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/hospitals" style="text-decoration:none;">
                                <div class="stat-card purple" style="cursor:pointer; text-align:center;">
                                    <div class="stat-icon">🛏️</div>
                                    <div class="stat-label">Manage Beds</div>
                                </div>
                            </a>
                        </div>
                    </div>
                </main>
            </div>
        <script src=/js/responsive.js></script><script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>


