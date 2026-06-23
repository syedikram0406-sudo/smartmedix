<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Report History - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/lab/test-requests"><span
                                    class="nav-icon">📋</span> Test Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/upload-report"><span
                                    class="nav-icon">📤</span> Upload Report</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/report-status"><span
                                    class="nav-icon">📊</span> Report Status</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/report-history" class="active"><span
                                    class="nav-icon">📜</span> Report History</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Report History</h1>
                        <p>View all previously uploaded reports</p>
                    </div>
                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>All Reports History</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Date</th>
                                    <th>Patient</th>
                                    <th>Test</th>
                                    <th>Result</th>
                                    <th>Remarks</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${reports}" var="r">
                                    <tr>
                                        <td>L${r.id}</td>
                                        <td>${r.reportDate}</td>
                                        <td>${r.patient.name}</td>
                                        <td>${r.testName}</td>
                                        <td>${r.result}</td>
                                        <td>${r.remarks}</td>
                                        <td><span
                                                class="badge badge-${r.status == 'Completed' || r.status == 'Uploaded' ? 'completed' : 'pending'}">${r.status}</span>
                                        </td>
                                        <td><a href="${pageContext.request.contextPath}/lab/patient-reports/${r.patient.id}"
                                                class="btn-sm btn-info">Patient History</a></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty reports}">
                                    <tr>
                                        <td colspan="8" class="empty-state">
                                            <div class="empty-icon">📜</div>
                                            <p>No report history</p>
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

