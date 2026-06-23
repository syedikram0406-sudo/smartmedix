<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Book Appointment - SmartMedix</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                /* ===== Book Appointment Backdrop ===== */
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
                    opacity: 0.06;
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
                    background: linear-gradient(135deg, rgba(241, 245, 249, 0.95) 0%, rgba(241, 245, 249, 0.88) 50%, rgba(219, 234, 254, 0.92) 100%);
                    z-index: 0;
                    pointer-events: none;
                }

                .main-content>* {
                    position: relative;
                    z-index: 1;
                }

                .form-card {
                    border: 1px solid rgba(15, 111, 255, 0.06);
                    transition: all 0.3s ease;
                }

                .form-card:hover {
                    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
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
                        <li><a href="${pageContext.request.contextPath}/patient/book-appointment" class="active"><span
                                    class="nav-icon">📅</span> Book Appointment</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/my-appointments"><span
                                    class="nav-icon">📋</span> My Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/medical-records"><span
                                    class="nav-icon">📁</span> Medical Records</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/reminders"><span
                                    class="nav-icon">⏰</span> Reminders</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/profile"><span
                                    class="nav-icon">👤</span> My Profile</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Book Appointment</h1>
                        <p>Schedule an appointment with a doctor</p>
                    </div>
                    <div class="form-card">
                        <h3>📅 Appointment Form</h3>
                        <form action="${pageContext.request.contextPath}/patient/book-appointment" method="post">
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Doctor</label>
                                    <select name="doctorId" required>
                                        <option value="">Select Doctor</option>
                                        <c:forEach items="${doctors}" var="d">
                                            <option value="${d.id}" ${preSelectedDoctorId==d.id ? 'selected' : '' }>
                                                ${d.name} - ${d.department}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group"><label>Date</label><input type="date" name="appointmentDate"
                                        required></div>
                                <div class="form-group"><label>Time</label><input type="time" name="appointmentTime">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Reason for Visit</label>
                                <select name="reason" required>
                                    <option value="">-- Select Reason for Visit --</option>
                                    <option value="General Checkup / Routine Examination">General Checkup / Routine
                                        Examination</option>
                                    <option value="Fever, Cold or Flu Symptoms">Fever, Cold or Flu Symptoms</option>
                                    <option value="Chronic Disease Follow-up">Chronic Disease Follow-up (Diabetes,
                                        Hypertension, etc.)</option>
                                    <option value="Chest Pain or Heart-Related Concerns">Chest Pain or Heart-Related
                                        Concerns</option>
                                    <option value="Skin Rash, Allergy or Dermatology Issue">Skin Rash, Allergy or
                                        Dermatology Issue</option>
                                    <option value="Stomach Pain or Digestive Problems">Stomach Pain or Digestive
                                        Problems</option>
                                    <option value="Joint Pain, Back Pain or Orthopedic Issue">Joint Pain, Back Pain or
                                        Orthopedic Issue</option>
                                    <option value="Eye-Related Problem or Vision Check">Eye-Related Problem or Vision
                                        Check</option>
                                    <option value="ENT Issue (Ear, Nose, Throat)">ENT Issue (Ear, Nose, Throat)</option>
                                    <option value="Mental Health or Counseling">Mental Health or Counseling</option>
                                    <option value="Dental Checkup or Oral Problem">Dental Checkup or Oral Problem
                                    </option>
                                    <option value="Lab Test or Diagnostic Report Review">Lab Test or Diagnostic Report
                                        Review</option>
                                    <option value="Vaccination or Immunization">Vaccination or Immunization</option>
                                    <option value="Post-Surgery or Post-Treatment Follow-up">Post-Surgery or
                                        Post-Treatment Follow-up</option>
                                    <option value="Prescription Renewal or Medication Review">Prescription Renewal or
                                        Medication Review</option>
                                </select>
                            </div>
                            <div class="form-group" style="margin-bottom: 24px;">
                                <label style="display: block; margin-bottom: 10px; font-weight: 600; color: #1e293b;">Current Pain Level (Optional)</label>
                                <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                                    <label style="display: flex; align-items: center; gap: 8px; padding: 10px 16px; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 8px; cursor: pointer; transition: all 0.2s ease;">
                                        <input type="radio" name="painLevel" value="No Pain" style="margin: 0;">
                                        <span style="font-weight: 500;">🟢 No Pain</span>
                                    </label>
                                    <label style="display: flex; align-items: center; gap: 8px; padding: 10px 16px; background: #FEF3C7; border: 1px solid #FDE68A; border-radius: 8px; cursor: pointer; transition: all 0.2s ease;">
                                        <input type="radio" name="painLevel" value="Mild Pain" style="margin: 0;">
                                        <span style="font-weight: 500;">🟡 Mild Pain</span>
                                    </label>
                                    <label style="display: flex; align-items: center; gap: 8px; padding: 10px 16px; background: #FEE2E2; border: 1px solid #FECACA; border-radius: 8px; cursor: pointer; transition: all 0.2s ease;">
                                        <input type="radio" name="painLevel" value="Severe Pain" style="margin: 0;">
                                        <span style="font-weight: 500;">🔴 Severe Pain</span>
                                    </label>
                                </div>
                            </div>
                            <button type="submit" class="btn-primary" style="max-width:250px;">Book Appointment</button>
                        </form>
                    </div>
                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

