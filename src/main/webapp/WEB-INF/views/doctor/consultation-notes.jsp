<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Consultation Notes - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/doctor/appointments"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/prescription"><span
                                    class="nav-icon">💊</span> Prescriptions</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/lab-request"><span
                                    class="nav-icon">🧪</span> Lab Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/consultation-notes" class="active"><span
                                    class="nav-icon">📋</span> Consultation Notes</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Consultation Notes</h1>
                        <p>Add and view patient consultation notes</p>
                    </div>

                    <% if (request.getParameter("success") !=null) { %>
                        <div class="alert alert-success">Note added successfully!</div>
                        <% } %>

                            <div class="form-card">
                                <h3>📋 Add Consultation Note</h3>
                                <form action="${pageContext.request.contextPath}/doctor/consultation-notes/add"
                                    method="post">
                                    <div class="form-group">
                                        <label>Patient</label>
                                        <select name="patientId" required>
                                            <option value="">Select Patient</option>
                                            <c:forEach items="${patients}" var="p">
                                                <option value="${p.id}" ${patient !=null && patient.id==p.id
                                                    ? 'selected' : '' }>${p.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="form-group"><label>Note</label><textarea name="noteText" rows="4"
                                            placeholder="e.g. Patient should reduce sugar intake." required></textarea>
                                    </div>
                                    <button type="submit" class="btn-primary" style="max-width:200px;">Save
                                        Note</button>
                                </form>
                            </div>

                            <c:if test="${not empty notes}">
                                <div class="data-table-wrapper">
                                    <div class="table-header">
                                        <h3>Notes for ${patient.name}</h3>
                                    </div>
                                    <div class="table-responsive"><table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>Note</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${notes}" var="n">
                                                <tr>
                                                    <td>${n.noteText}</td>
                                                    <td>${n.noteDate}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table></div>
                                </div>
                            </c:if>
                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

