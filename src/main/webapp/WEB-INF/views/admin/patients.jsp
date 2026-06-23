<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Patient Management - HMS</title>
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
                        <h1>Patient Management</h1>
                        <p>Register and manage patient profiles</p>
                    </div>

                    <div class="form-card">
                        <h3>➕ Register New Patient</h3>
                        <form action="${pageContext.request.contextPath}/admin/patients/add" method="post">
                            <div class="form-row">
                                <div class="form-group"><label>Name</label><input type="text" name="name"
                                        placeholder="Full Name" required></div>
                                <div class="form-group"><label>Age</label><input type="number" name="age"
                                        placeholder="Age"></div>
                                <div class="form-group"><label>Gender</label>
                                    <select name="gender">
                                        <option value="">Select</option>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group"><label>Blood Group</label>
                                    <select name="bloodGroup">
                                        <option value="">Select</option>
                                        <option>A+</option>
                                        <option>A-</option>
                                        <option>B+</option>
                                        <option>B-</option>
                                        <option>AB+</option>
                                        <option>AB-</option>
                                        <option>O+</option>
                                        <option>O-</option>
                                    </select>
                                </div>
                                <div class="form-group"><label>Phone</label><input type="text" name="phone"
                                        placeholder="Phone"></div>
                                <div class="form-group"><label>Email</label><input type="email" name="email"
                                        placeholder="Email"></div>
                            </div>
                            <button type="submit" class="btn-primary" style="max-width:200px;">Register Patient</button>
                        </form>
                    </div>

                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>All Patients</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Age</th>
                                    <th>Gender</th>
                                    <th>Blood Group</th>
                                    <th>Phone</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${patients}" var="p">
                                    <tr>
                                        <td>P${p.id}</td>
                                        <td><strong>${p.name}</strong></td>
                                        <td>${p.age}</td>
                                        <td>${p.gender}</td>
                                        <td>${p.bloodGroup}</td>
                                        <td>${p.phone}</td>
                                        <td><span class="badge badge-active">${p.status}</span></td>
                                        <td class="actions">
                                            <a href="${pageContext.request.contextPath}/admin/patient-records/${p.id}"
                                                class="btn-sm btn-info">View Records</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty patients}">
                                    <tr>
                                        <td colspan="8" class="empty-state">
                                            <div class="empty-icon">🧑‍🤝‍🧑</div>
                                            <p>No patients registered yet</p>
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

