<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Lab Requests - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/doctor/lab-request" class="active"><span
                                    class="nav-icon">🧪</span> Lab Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/consultation-notes"><span
                                    class="nav-icon">📋</span> Consultation Notes</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Lab Test Requests</h1>
                        <p>Request lab tests for patients</p>
                    </div>

                    <% if (request.getParameter("success") !=null) { %>
                        <div class="alert alert-success">Lab test request submitted!</div>
                        <% } %>

                            <div class="form-card">
                                <h3>🧪 New Lab Test Request</h3>
                                <form action="${pageContext.request.contextPath}/doctor/lab-request/add" method="post">
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label>Patient</label>
                                            <select name="patientId" required>
                                                <option value="">Select Patient</option>
                                                <c:forEach items="${patients}" var="p">
                                                    <option value="${p.id}">${p.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Test Name</label>
                                            <select name="testName" required>
                                                <option value="">Select Test</option>
                                                <option value="Blood Test">Blood Test</option>
                                                <option value="X-Ray">X-Ray</option>
                                                <option value="MRI">MRI</option>
                                                <option value="CT Scan">CT Scan</option>
                                                <option value="Urine Test">Urine Test</option>
                                                <option value="Blood Sugar">Blood Sugar</option>
                                                <option value="ECG">ECG</option>
                                                <option value="Ultrasound">Ultrasound</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Urgency</label>
                                            <select name="urgency">
                                                <option value="Normal">Normal</option>
                                                <option value="Urgent">Urgent</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group"><label>Description</label><textarea name="description"
                                            rows="2" placeholder="Additional notes"></textarea></div>
                                    <button type="submit" class="btn-primary" style="max-width:250px;">Submit
                                        Request</button>
                                </form>
                            </div>

                            <c:if test="${not empty requests}">
                                <div class="data-table-wrapper">
                                    <div class="table-header">
                                        <h3>My Requests</h3>
                                    </div>
                                    <div class="table-responsive"><table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Patient</th>
                                                <th>Test</th>
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
                                                    <td><span
                                                            class="badge ${r.urgency == 'Urgent' ? 'badge-urgent' : 'badge-approved'}">${r.urgency}</span>
                                                    </td>
                                                    <td>${r.requestDate}</td>
                                                    <td><span
                                                            class="badge badge-${r.status == 'Completed' ? 'completed' : 'pending'}">${r.status}</span>
                                                    </td>
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

