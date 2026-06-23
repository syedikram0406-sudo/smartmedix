<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Complaints - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/admin/patients"><span
                                    class="nav-icon">🧑‍🤝‍🧑</span> Patients</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/appointments"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/analytics"><span
                                    class="nav-icon">📈</span> Analytics</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/complaints" class="active"><span
                                    class="nav-icon">📝</span> Complaints</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Complaint Management</h1>
                        <p>Review and resolve patient complaints</p>
                    </div>
                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>All Complaints</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Patient</th>
                                    <th>Complaint</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Resolution</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${complaints}" var="c">
                                    <tr>
                                        <td>${c.id}</td>
                                        <td>${c.patient.name}</td>
                                        <td>${c.complaintText}</td>
                                        <td>${c.submittedDate}</td>
                                        <td><span
                                                class="badge badge-${c.status == 'Resolved' ? 'completed' : 'pending'}">${c.status}</span>
                                        </td>
                                        <td>${c.resolution}</td>
                                        <td>
                                            <c:if test="${c.status != 'Resolved'}">
                                                <form
                                                    action="${pageContext.request.contextPath}/admin/complaints/resolve"
                                                    method="post" style="display:flex;gap:6px;">
                                                    <input type="hidden" name="id" value="${c.id}">
                                                    <input type="text" name="resolution" placeholder="Resolution"
                                                        style="padding:4px 8px;border:1px solid #ddd;border-radius:6px;font-size:12px;width:150px;"
                                                        required>
                                                    <button type="submit" class="btn-sm btn-success">Resolve</button>
                                                </form>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty complaints}">
                                    <tr>
                                        <td colspan="7" class="empty-state">
                                            <div class="empty-icon">📝</div>
                                            <p>No complaints found</p>
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

