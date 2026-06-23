<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Patient Records - HMS</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🏥 HMS</h3>
                        <div class="role-badge">Admin Panel</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/doctors"><span
                                    class="nav-icon">👨‍⚕️</span> Doctors</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/patients" class="active"><span
                                    class="nav-icon">🧑‍🤝‍🧑</span> Patients</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/appointments"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/analytics"><span
                                    class="nav-icon">📈</span> Analytics</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/complaints"><span
                                    class="nav-icon">📝</span> Complaints</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Patient Records: ${patient.name}</h1>
                        <p>View complete medical records</p>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card blue">
                            <div class="stat-icon">🧑</div>
                            <div class="stat-value">${patient.name}</div>
                            <div class="stat-label">Patient Name</div>
                        </div>
                        <div class="stat-card green">
                            <div class="stat-icon">🩸</div>
                            <div class="stat-value">${patient.bloodGroup != null ? patient.bloodGroup : 'N/A'}</div>
                            <div class="stat-label">Blood Group</div>
                        </div>
                        <div class="stat-card orange">
                            <div class="stat-icon">📅</div>
                            <div class="stat-value">${patient.age != null ? patient.age : 'N/A'}</div>
                            <div class="stat-label">Age</div>
                        </div>
                    </div>

                    <div class="data-table-wrapper" style="margin-bottom:24px;">
                        <div class="table-header">
                            <h3>📅 Appointments</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Doctor</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${appointments}" var="a">
                                    <tr>
                                        <td>A${a.id}</td>
                                        <td>${a.doctor.name}</td>
                                        <td>${a.appointmentDate}</td>
                                        <td><span
                                                class="badge badge-${a.status == 'Completed' ? 'completed' : a.status == 'Pending' ? 'pending' : 'approved'}">${a.status}</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty appointments}">
                                    <tr>
                                        <td colspan="4" style="text-align:center;padding:20px;">No appointments found
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table></div>
                    </div>

                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>🧪 Lab Reports</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Test</th>
                                    <th>Result</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${labReports}" var="r">
                                    <tr>
                                        <td>L${r.id}</td>
                                        <td>${r.testName}</td>
                                        <td>${r.result}</td>
                                        <td>${r.reportDate}</td>
                                        <td><span
                                                class="badge badge-${r.status == 'Uploaded' ? 'uploaded' : 'pending'}">${r.status}</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty labReports}">
                                    <tr>
                                        <td colspan="5" style="text-align:center;padding:20px;">No lab reports found
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

