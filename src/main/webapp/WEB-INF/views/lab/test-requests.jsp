<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Test Requests - HMS</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🏥 HMS</h3>
                        <div class="role-badge">Lab Technician</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/lab/dashboard"><span class="nav-icon">📊</span>
                                Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/test-requests" class="active"><span
                                    class="nav-icon">📋</span> Test Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/upload-report"><span
                                    class="nav-icon">📤</span> Upload Report</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/report-status"><span
                                    class="nav-icon">📊</span> Report Status</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/report-history"><span
                                    class="nav-icon">📜</span> Report History</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Test Requests</h1>
                        <p>View lab test requests from doctors</p>
                    </div>
                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>All Test Requests</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Patient</th>
                                    <th>Test</th>
                                    <th>Doctor</th>
                                    <th>Urgency</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requests}" var="r">
                                    <tr>
                                        <td>R${r.id}</td>
                                        <td>${r.patient.name}</td>
                                        <td>${r.testName}</td>
                                        <td>${r.doctor.name}</td>
                                        <td><span
                                                class="badge ${r.urgency == 'Urgent' ? 'badge-urgent' : 'badge-approved'}">${r.urgency}</span>
                                        </td>
                                        <td>${r.requestDate}</td>
                                        <td><span
                                                class="badge badge-${r.status == 'Completed' ? 'completed' : 'pending'}">${r.status}</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty requests}">
                                    <tr>
                                        <td colspan="7" class="empty-state">
                                            <div class="empty-icon">📋</div>
                                            <p>No test requests</p>
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

