<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Doctor Management - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/admin/doctors" class="active"><span
                                    class="nav-icon">👨‍⚕️</span> Doctors</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/patients"><span
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
                    <div class="sidebar-footer">
                        <a href="${pageContext.request.contextPath}/auth/logout"><span class="nav-icon">🚪</span>
                            Logout</a>
                    </div>
                </aside>

                <main class="main-content">
                    <div class="page-header">
                        <h1>Doctor Management</h1>
                        <p>Add, update, and manage doctor profiles</p>
                    </div>

                    <!-- Add Doctor Form -->
                    <div class="form-card">
                        <h3>➕ Add New Doctor</h3>
                        <form action="${pageContext.request.contextPath}/admin/doctors/add" method="post">
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Name</label>
                                    <input type="text" name="name" placeholder="Dr. Full Name" required>
                                </div>
                                <div class="form-group">
                                    <label>Department</label>
                                    <select name="department" required>
                                        <option value="General">General</option>
                                        <option value="Cardiology">Cardiology</option>
                                        <option value="Neurology">Neurology</option>
                                        <option value="Orthopedics">Orthopedics</option>
                                        <option value="Pediatrics">Pediatrics</option>
                                        <option value="Dermatology">Dermatology</option>
                                        <option value="ENT">ENT</option>
                                        <option value="Ophthalmology">Ophthalmology</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Specialization</label>
                                    <select name="specialization">
                                        <option value="">Select Specialization</option>
                                        <option value="General Physician">General Physician</option>
                                        <option value="Cardiologist">Cardiologist</option>
                                        <option value="Neurologist">Neurologist</option>
                                        <option value="Orthopedic Surgeon">Orthopedic Surgeon</option>
                                        <option value="Pediatrician">Pediatrician</option>
                                        <option value="Dermatologist">Dermatologist</option>
                                        <option value="ENT Specialist">ENT Specialist</option>
                                        <option value="Ophthalmologist">Ophthalmologist</option>
                                        <option value="Psychiatrist">Psychiatrist</option>
                                        <option value="Gynecologist">Gynecologist</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Phone</label>
                                    <input type="text" name="phone" placeholder="Phone number">
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" name="email" placeholder="Email address">
                                </div>
                                <div class="form-group" style="display:flex;align-items:flex-end;">
                                    <button type="submit" class="btn-primary" style="width:100%;">Add Doctor</button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Doctor Table -->
                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>All Doctors</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Department</th>
                                    <th>Specialization</th>
                                    <th>Phone</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${doctors}" var="doc">
                                    <tr>
                                        <td>D${doc.id}</td>
                                        <td><strong>${doc.name}</strong></td>
                                        <td>${doc.department}</td>
                                        <td>${doc.specialization}</td>
                                        <td>${doc.phone}</td>
                                        <td><span
                                                class="badge ${doc.status == 'Active' ? 'badge-active' : 'badge-inactive'}">${doc.status}</span>
                                        </td>
                                        <td class="actions">
                                            <button class="btn-sm btn-info"
                                                onclick="editDoctor(${doc.id}, '${doc.name}', '${doc.department}', '${doc.specialization}', '${doc.phone}', '${doc.email}', '${doc.status}')">Edit</button>
                                            <a href="${pageContext.request.contextPath}/admin/doctors/delete/${doc.id}"
                                                class="btn-sm btn-danger"
                                                onclick="return confirm('Delete this doctor?')">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty doctors}">
                                    <tr>
                                        <td colspan="7" class="empty-state">
                                            <div class="empty-icon">👨‍⚕️</div>
                                            <p>No doctors registered yet</p>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table></div>
                    </div>

                    <!-- Edit Modal -->
                    <div class="modal-overlay" id="editModal">
                        <div class="modal-content">
                            <h3>Edit Doctor</h3>
                            <form action="${pageContext.request.contextPath}/admin/doctors/update" method="post">
                                <input type="hidden" name="id" id="editId">
                                <div class="form-group">
                                    <label>Name</label>
                                    <input type="text" name="name" id="editName" required>
                                </div>
                                <div class="form-group">
                                    <label>Department</label>
                                    <select name="department" id="editDept">
                                        <option value="General">General</option>
                                        <option value="Cardiology">Cardiology</option>
                                        <option value="Neurology">Neurology</option>
                                        <option value="Orthopedics">Orthopedics</option>
                                        <option value="Pediatrics">Pediatrics</option>
                                        <option value="Dermatology">Dermatology</option>
                                        <option value="ENT">ENT</option>
                                        <option value="Ophthalmology">Ophthalmology</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Specialization</label>
                                    <select name="specialization" id="editSpec">
                                        <option value="">Select Specialization</option>
                                        <option value="General Physician">General Physician</option>
                                        <option value="Cardiologist">Cardiologist</option>
                                        <option value="Neurologist">Neurologist</option>
                                        <option value="Orthopedic Surgeon">Orthopedic Surgeon</option>
                                        <option value="Pediatrician">Pediatrician</option>
                                        <option value="Dermatologist">Dermatologist</option>
                                        <option value="ENT Specialist">ENT Specialist</option>
                                        <option value="Ophthalmologist">Ophthalmologist</option>
                                        <option value="Psychiatrist">Psychiatrist</option>
                                        <option value="Gynecologist">Gynecologist</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Phone</label>
                                    <input type="text" name="phone" id="editPhone">
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" name="email" id="editEmail">
                                </div>
                                <div class="form-group">
                                    <label>Status</label>
                                    <select name="status" id="editStatus">
                                        <option value="Active">Active</option>
                                        <option value="Inactive">Inactive</option>
                                    </select>
                                </div>
                                <div style="display:flex;gap:12px;">
                                    <button type="submit" class="btn-primary">Update</button>
                                    <button type="button" class="btn-primary" style="background:#64748B;"
                                        onclick="closeModal()">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>
            </div>

            <script>
                function editDoctor(id, name, dept, spec, phone, email, status) {
                    document.getElementById('editId').value = id;
                    document.getElementById('editName').value = name;
                    document.getElementById('editDept').value = dept;
                    document.getElementById('editSpec').value = spec || '';
                    document.getElementById('editPhone').value = phone || '';
                    document.getElementById('editEmail').value = email || '';
                    document.getElementById('editStatus').value = status;
                    document.getElementById('editModal').classList.add('show');
                }
                function closeModal() {
                    document.getElementById('editModal').classList.remove('show');
                }
            </script>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

