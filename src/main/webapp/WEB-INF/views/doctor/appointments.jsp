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
                        <div class="role-badge">Doctor Panel</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/doctor/dashboard"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/appointments" class="active"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/prescription"><span
                                    class="nav-icon">💊</span> Prescriptions</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/lab-request"><span
                                    class="nav-icon">🧪</span> Lab Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/consultation-notes"><span
                                    class="nav-icon">📋</span> Consultation Notes</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>My Appointments</h1>
                        <p>View and manage your appointments</p>
                    </div>
                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>Appointment List</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Patient</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Reason</th>
                                    <th>Pain Level</th>
                                    <th>Payment Status</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${appointments}" var="a">
                                    <tr>
                                        <td>A${a.id}</td>
                                        <td><strong>${a.patient.name}</strong></td>
                                        <td>${a.appointmentDate}</td>
                                        <td>${a.appointmentTime}</td>
                                        <td>${a.reason}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${a.painLevel == 'Severe Pain'}"><span style="background: #FEE2E2; color: #DC2626; padding: 4px 8px; border-radius: 6px; font-size: 12px; font-weight: 600;">🔴 Severe</span></c:when>
                                                <c:when test="${a.painLevel == 'Mild Pain'}"><span style="background: #FEF3C7; color: #D97706; padding: 4px 8px; border-radius: 6px; font-size: 12px; font-weight: 600;">🟡 Mild</span></c:when>
                                                <c:when test="${a.painLevel == 'No Pain'}"><span style="background: #DCFCE7; color: #16A34A; padding: 4px 8px; border-radius: 6px; font-size: 12px; font-weight: 600;">🟢 None</span></c:when>
                                                <c:otherwise><span style="color: #94a3b8; font-size: 13px;">Not specified</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${paymentStatusMap[a.id] == 'PAID'}">
                                                    <span style="background: #dcfce7; color: #166534; padding: 4px 8px; border-radius: 6px; font-size: 12px; font-weight: 700;">PAID</span>
                                                </c:when>
                                                <c:when test="${paymentStatusMap[a.id] == 'UNPAID'}">
                                                    <span style="background: #fee2e2; color: #991b1b; padding: 4px 8px; border-radius: 6px; font-size: 12px; font-weight: 700;">UNPAID</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #94a3b8; font-size: 12px;">--</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><span
                                                class="badge badge-${a.status == 'Completed' ? 'completed' : a.status == 'Approved' ? 'approved' : a.status == 'Cancelled' ? 'cancelled' : 'pending'}">${a.status}</span>
                                        </td>
                                        <td class="actions">
                                            <form action="${pageContext.request.contextPath}/doctor/appointments/status"
                                                method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="${a.id}">
                                                <select name="status" onchange="this.form.submit()"
                                                    style="padding:4px 8px;border-radius:6px;border:1px solid #ddd;font-size:12px;">
                                                    <option value="">Action</option>
                                                    <option value="Approved">Accept</option>
                                                    <option value="Completed">Complete</option>
                                                    <option value="Cancelled">Cancel</option>
                                                </select>
                                            </form>
                                            <a href="${pageContext.request.contextPath}/doctor/patient-records/${a.patient.id}"
                                                class="btn-sm btn-info">Records</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty appointments}">
                                    <tr>
                                        <td colspan="8" class="empty-state">
                                            <div class="empty-icon">📅</div>
                                            <p>No appointments</p>
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

