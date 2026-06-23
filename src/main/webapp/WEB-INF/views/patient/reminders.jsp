<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Medicine Reminders - SmartMedix</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                /* ===== Medicine Reminders Backdrop ===== */
                .main-content {
                    position: relative;
                    overflow: hidden;
                }

                .main-content::before {
                    content: '';
                    position: fixed;
                    top: 0;
                    right: 0;
                    bottom: 0;
                    left: 260px;
                    background: url('${pageContext.request.contextPath}/images/medical-backdrop.png') center/cover no-repeat;
                    opacity: 0.05;
                    z-index: 0;
                    pointer-events: none;
                }

                .main-content::after {
                    content: '';
                    position: fixed;
                    top: 0;
                    right: 0;
                    bottom: 0;
                    left: 260px;
                    background: linear-gradient(135deg, rgba(241, 245, 249, 0.96) 0%, rgba(241, 245, 249, 0.92) 50%, rgba(219, 234, 254, 0.95) 100%);
                    z-index: 0;
                    pointer-events: none;
                }

                .main-content>* {
                    position: relative;
                    z-index: 1;
                }

                .form-card {
                    border: 1px solid rgba(15, 111, 255, 0.08);
                    transition: all 0.3s ease;
                }

                .form-card:hover {
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
                }

                /* Custom styling for select dropdowns */
                .form-group select {
                    appearance: none;
                    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748b'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
                    background-repeat: no-repeat;
                    background-position: right 12px center;
                    background-size: 16px;
                    padding-right: 40px;
                }

                @media (max-width: 768px) {

                    .main-content::before,
                    .main-content::after {
                        left: 0;
                    }
                }
            </style>
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🩺 SmartMedix</h3>
                        <div class="role-badge">Patient Panel</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/patient/dashboard"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/book-appointment"><span
                                    class="nav-icon">📅</span> Book Appointment</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/my-appointments"><span
                                    class="nav-icon">📋</span> My Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/medical-records"><span
                                    class="nav-icon">📁</span> Medical Records</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/reminders" class="active"><span
                                    class="nav-icon">⏰</span> Reminders</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/profile"><span
                                    class="nav-icon">👤</span> My Profile</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Medicine Reminders</h1>
                        <p>Set and manage your medicine reminders with SmartMedix</p>
                    </div>

                    <div class="form-card">
                        <h3>⏰ Add New Reminder</h3>
                        <form action="${pageContext.request.contextPath}/patient/reminders/add" method="post">
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Medicine Name</label>
                                    <select name="medicineName" required>
                                        <option value="">-- Select Tablet --</option>
                                        <option value="Paracetamol (Fever and Pain relief)">Paracetamol (Fever and Pain
                                            relief)</option>
                                        <option value="Ibuprofen (Anti-inflammatory/Pain)">Ibuprofen
                                            (Anti-inflammatory/Pain)</option>
                                        <option value="Amoxicillin (Bacterial Infections)">Amoxicillin (Bacterial
                                            Infections)</option>
                                        <option value="Cetirizine (Allergies/Hay fever)">Cetirizine (Allergies/Hay
                                            fever)</option>
                                        <option value="Metformin (Type 2 Diabetes)">Metformin (Type 2 Diabetes)</option>
                                        <option value="Amlodipine (High Blood Pressure)">Amlodipine (High Blood
                                            Pressure)</option>
                                        <option value="Omeprazole (Acid Reflux/Heartburn)">Omeprazole (Acid
                                            Reflux/Heartburn)</option>
                                        <option value="Azithromycin (Respiratory Infections)">Azithromycin (Respiratory
                                            Infections)</option>
                                        <option value="Atorvastatin (High Cholesterol)">Atorvastatin (High Cholesterol)
                                        </option>
                                        <option value="Salbutamol (Asthma/Wheezing)">Salbutamol (Asthma/Wheezing)
                                        </option>
                                        <option value="Metoprolol (Heart rate/Blood Pressure)">Metoprolol (Heart
                                            rate/Blood Pressure)</option>
                                        <option value="Loratadine (Seasonal Allergies)">Loratadine (Seasonal Allergies)
                                        </option>
                                        <option value="Ciprofloxacin (Urinary/Gut Infections)">Ciprofloxacin
                                            (Urinary/Gut Infections)</option>
                                        <option value="Pantoprazole (Gastric Ulcers/Acidity)">Pantoprazole (Gastric
                                            Ulcers/Acidity)</option>
                                        <option value="Diazepam (Anxiety/Muscle spasms)">Diazepam (Anxiety/Muscle
                                            spasms)</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Dosage</label>
                                    <select name="dosage">
                                        <option value="">-- Select MG --</option>
                                        <c:forEach var="mg" items="10,25,50,75,100,150,200,250,300,350,400,450,500">
                                            <option value="${mg}mg">${mg}mg</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Reminder Time</label>
                                    <input type="time" name="reminderTime" required>
                                </div>
                            </div>
                            <div class="form-group"><label>Notes</label><textarea name="notes" rows="2"
                                    placeholder="Additional notes"></textarea></div>
                            <button type="submit" class="btn-primary" style="max-width:200px;">Add Reminder</button>
                        </form>
                    </div>

                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>Your Reminders</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Medicine</th>
                                    <th>Dosage</th>
                                    <th>Time</th>
                                    <th>Notes</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${reminders}" var="r">
                                    <tr>
                                        <td><strong>${r.medicineName}</strong></td>
                                        <td>${r.dosage}</td>
                                        <td>${r.reminderTime}</td>
                                        <td>${r.notes}</td>
                                        <td><span
                                                class="badge ${r.active ? 'badge-active' : 'badge-inactive'}">${r.active
                                                ? 'Active' : 'Inactive'}</span></td>
                                        <td><a href="${pageContext.request.contextPath}/patient/reminders/delete/${r.id}"
                                                class="btn-sm btn-danger"
                                                onclick="return confirm('Remove this reminder?')">Remove</a></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty reminders}">
                                    <tr>
                                        <td colspan="6" class="empty-state">
                                            <div class="empty-icon">⏰</div>
                                            <p>No reminders set</p>
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

