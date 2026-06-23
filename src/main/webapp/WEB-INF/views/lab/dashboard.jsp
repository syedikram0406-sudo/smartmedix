<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Lab Dashboard - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/lab/dashboard" class="active"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/test-requests"><span
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
                        <h1>Lab Dashboard</h1>
                        <p>Welcome, ${sessionScope.user.fullName}! Here's your daily workload.</p>
                    </div>
                    <div class="stats-grid">
                        <div class="stat-card blue">
                            <div class="stat-icon">📋</div>
                            <div class="stat-value">${totalRequests}</div>
                            <div class="stat-label">Total Test Requests</div>
                        </div>
                        <div class="stat-card green">
                            <div class="stat-icon">✅</div>
                            <div class="stat-value">${completedReports}</div>
                            <div class="stat-label">Completed Reports</div>
                        </div>
                        <div class="stat-card orange">
                            <div class="stat-icon">⏳</div>
                            <div class="stat-value">${pendingReports}</div>
                            <div class="stat-label">Pending Reports</div>
                        </div>
                        <div class="stat-card red">
                            <div class="stat-icon">🔔</div>
                            <div class="stat-value">${pendingRequests}</div>
                            <div class="stat-label">Pending Requests</div>
                        </div>
                    </div>

                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>Quick Actions</h3>
                        </div>
                        <div
                            style="padding: 24px; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px;">
                            <a href="${pageContext.request.contextPath}/lab/test-requests"
                                style="text-decoration:none;">
                                <div class="stat-card blue" style="cursor:pointer; text-align:center;">
                                    <div class="stat-icon">📋</div>
                                    <div class="stat-label">View Requests</div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/lab/upload-report"
                                style="text-decoration:none;">
                                <div class="stat-card green" style="cursor:pointer; text-align:center;">
                                    <div class="stat-icon">📤</div>
                                    <div class="stat-label">Upload Report</div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/lab/report-status"
                                style="text-decoration:none;">
                                <div class="stat-card orange" style="cursor:pointer; text-align:center;">
                                    <div class="stat-icon">📊</div>
                                    <div class="stat-label">Manage Status</div>
                                </div>
                            </a>
                        </div>
                    </div>

                    <!-- Lab Service Billing Status -->
                    <div class="data-table-wrapper" style="margin-top: 32px;">
                        <div class="table-header" style="background: #fff; padding: 24px;">
                            <div>
                                <h3
                                    style="font-size: 20px; font-weight: 700; color: #1e293b; display: flex; align-items: center; gap: 8px;">
                                    💳 Lab Service Billing
                                </h3>
                                <p style="font-size: 14px; color: #64748b; margin-top: 4px;">Track payment status and
                                    service details for patients.</p>
                            </div>
                        </div>
                        <div class="table-container">
                            <div class="table-responsive"><table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Patient</th>
                                        <th>Service Type</th>
                                        <th>Amount</th>
                                        <th>Payment Status</th>
                                        <th>Transaction Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${bills}" var="bill">
                                        <tr>
                                            <td>
                                                <div style="display: flex; align-items: center; gap: 12px;">
                                                    <div
                                                        style="width: 36px; height: 36px; background: #e0f2fe; color: #0369a1; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 14px; border: 2px solid #fff; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
                                                        ${bill.patient.name.substring(0,1).toUpperCase()}
                                                    </div>
                                                    <strong
                                                        style="color: #1e293b; font-size: 15px;">${bill.patient.name}</strong>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge"
                                                    style="background: ${bill.serviceType == 'CONSULTATION' ? '#dcfce7' : '#e0f2fe'}; color: ${bill.serviceType == 'CONSULTATION' ? '#166534' : '#0369a1'};">
                                                    ${bill.serviceType}
                                                </span>
                                            </td>
                                            <td style="font-weight: 700; font-size: 15px;">₹${bill.amount}</td>
                                            <td>
                                                <span
                                                    class="badge ${bill.status == 'PAID' ? 'status-green' : 'status-red'}">
                                                    ${bill.status}
                                                </span>
                                            </td>
                                            <td style="color: #1e293b; font-size: 13px; font-weight: 500;">
                                                ${bill.formattedDate}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table></div>
                        </div>
                    </div>

                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

