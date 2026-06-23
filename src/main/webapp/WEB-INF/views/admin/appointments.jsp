<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Appointment Management - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/admin/appointments" class="active"><span
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
                        <h1>Appointment Management</h1>
                        <p>Approve, reschedule, and manage appointments</p>
                    </div>

                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>All Appointments</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Doctor</th>
                                    <th>Patient</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Reason</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${appointments}" var="a">
                                    <tr>
                                        <td>A${a.id}</td>
                                        <td>${a.doctor.name}</td>
                                        <td>${a.patient.name}</td>
                                        <td>${a.appointmentDate}</td>
                                        <td>${a.appointmentTime}</td>
                                        <td>${a.reason}</td>
                                        <td><span
                                                class="badge badge-${a.status == 'Completed' ? 'completed' : a.status == 'Approved' ? 'approved' : a.status == 'Cancelled' ? 'cancelled' : 'pending'}">${a.status}</span>
                                        </td>
                                        <td class="actions">
                                            <form action="${pageContext.request.contextPath}/admin/appointments/status"
                                                method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="${a.id}">
                                                <select name="status" onchange="this.form.submit()"
                                                    style="padding:4px 8px;border-radius:6px;border:1px solid #ddd;font-size:12px;">
                                                    <option value="">Change</option>
                                                    <option value="Approved">Approve</option>
                                                    <option value="Completed">Complete</option>
                                                    <option value="Cancelled">Cancel</option>
                                                    <option value="Rescheduled">Reschedule</option>
                                                </select>
                                            </form>
                                            <a href="${pageContext.request.contextPath}/admin/appointments/delete/${a.id}"
                                                class="btn-sm btn-danger" onclick="return confirm('Delete?')">🗑</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty appointments}">
                                    <tr>
                                        <td colspan="8" class="empty-state">
                                            <div class="empty-icon">📅</div>
                                            <p>No appointments found</p>
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

