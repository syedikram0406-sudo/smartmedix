<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Medical Records - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/patient/medical-records" class="active"><span
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
                        <h1>Medical Records</h1>
                        <p>View your prescriptions and lab reports</p>
                    </div>

                    <div class="data-table-wrapper" style="margin-bottom:24px;">
                        <div class="table-header">
                            <h3>💊 Prescriptions</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Medicine</th>
                                    <th>Dosage</th>
                                    <th>Duration</th>
                                    <th>Instructions</th>
                                    <th>Doctor</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${prescriptions}" var="p">
                                    <tr>
                                        <td><strong>${p.medicineName}</strong></td>
                                        <td>${p.dosage}</td>
                                        <td>${p.duration}</td>
                                        <td>${p.instructions}</td>
                                        <td>${p.doctor.name}</td>
                                        <td>${p.prescriptionDate}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty prescriptions}">
                                    <tr>
                                        <td colspan="6" style="text-align:center;padding:20px;">No prescriptions yet
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
                                    <th>Test</th>
                                    <th>Result</th>
                                    <th>Normal Range</th>
                                    <th>Remarks</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${labReports}" var="r">
                                    <tr>
                                        <td><strong>${r.testName}</strong></td>
                                        <td>${r.result}</td>
                                        <td>${r.normalRange}</td>
                                        <td>${r.remarks}</td>
                                        <td>${r.reportDate}</td>
                                        <td><span
                                                class="badge badge-${r.status == 'Uploaded' || r.status == 'Completed' ? 'uploaded' : 'pending'}">${r.status}</span>
                                        </td>
                                        <td>
                                            <c:if test="${r.status == 'Uploaded' || r.status == 'Completed'}">
                                                <a href="${pageContext.request.contextPath}/patient/lab-report/download/${r.id}" 
                                                   class="btn btn-sm btn-primary" title="Download Report">
                                                   <span>📥</span> Download
                                                </a>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty labReports}">
                                    <tr>
                                        <td colspan="6" style="text-align:center;padding:20px;">No lab reports yet</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table></div>
                    </div>
                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

