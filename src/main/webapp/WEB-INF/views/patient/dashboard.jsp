<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Patient Dashboard - SmartMedix</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                /* ===== Dashboard Authentic Backdrop ===== */
                .main-content {
                    background: var(--body-bg);
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
                    opacity: 0.12;
                    z-index: 0;
                    pointer-events: none;
                    filter: saturate(0.8) contrast(1.1);
                }

                .main-content::after {
                    content: '';
                    position: fixed;
                    top: 0;
                    right: 0;
                    bottom: 0;
                    left: 260px;
                    background: linear-gradient(135deg, rgba(241, 245, 249, 0.96) 0%, rgba(241, 245, 249, 0.9) 50%, rgba(219, 234, 254, 0.94) 100%);
                    z-index: 0;
                    pointer-events: none;
                }

                .main-content>* {
                    position: relative;
                    z-index: 1;
                }

                /* ----- Welcome Hero Banner ----- */
                .dashboard-hero {
                    background: linear-gradient(135deg, #0F172A 0%, #1E3A5F 50%, #0F6FFF 100%);
                    border-radius: 20px;
                    padding: 40px 44px;
                    margin-bottom: 32px;
                    position: relative;
                    overflow: hidden;
                    box-shadow: 0 10px 40px rgba(15, 111, 255, 0.2);
                }

                .dashboard-hero::before {
                    content: '';
                    position: absolute;
                    top: -30%;
                    right: -5%;
                    width: 350px;
                    height: 350px;
                    background: radial-gradient(circle, rgba(96, 165, 250, 0.2) 0%, transparent 70%);
                    border-radius: 50%;
                    animation: hero-pulse 4s ease-in-out infinite;
                }

                .dashboard-hero::after {
                    content: '';
                    position: absolute;
                    bottom: -40%;
                    left: 10%;
                    width: 250px;
                    height: 250px;
                    background: radial-gradient(circle, rgba(108, 99, 255, 0.15) 0%, transparent 70%);
                    border-radius: 50%;
                    animation: hero-pulse 5s ease-in-out infinite reverse;
                }

                @keyframes hero-pulse {

                    0%,
                    100% {
                        transform: scale(1);
                        opacity: 0.6;
                    }

                    50% {
                        transform: scale(1.15);
                        opacity: 1;
                    }
                }

                .dashboard-hero h1 {
                    font-size: 30px;
                    font-weight: 800;
                    color: #fff;
                    margin-bottom: 8px;
                    position: relative;
                    z-index: 1;
                }

                .dashboard-hero h1 span {
                    background: linear-gradient(135deg, #60A5FA, #818CF8);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }

                .dashboard-hero p {
                    color: rgba(255, 255, 255, 0.7);
                    font-size: 15px;
                    position: relative;
                    z-index: 1;
                }

                .dashboard-hero .hero-badge {
                    display: inline-block;
                    padding: 6px 16px;
                    background: rgba(16, 185, 129, 0.2);
                    border: 1px solid rgba(16, 185, 129, 0.3);
                    border-radius: 20px;
                    color: #6EE7B7;
                    font-size: 12px;
                    font-weight: 600;
                    margin-top: 14px;
                    position: relative;
                    z-index: 1;
                }

                /* ----- Animated Stat Cards ----- */
                .stat-card {
                    backdrop-filter: blur(8px);
                    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                }

                .stat-card:hover {
                    transform: translateY(-6px) scale(1.02);
                    box-shadow: 0 16px 40px rgba(15, 111, 255, 0.15);
                }

                .stat-card .stat-icon {
                    transition: transform 0.3s ease;
                }

                .stat-card:hover .stat-icon {
                    transform: scale(1.2) rotate(-5deg);
                }

                /* ----- Health Score Styles ----- */
                .health-score-container {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 24px;
                    margin-bottom: 32px;
                }

                .score-main-card {
                    background: #fff;
                    border-radius: 20px;
                    padding: 30px;
                    text-align: center;
                    border: 1px solid #e2e8f0;
                    position: relative;
                    overflow: hidden;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
                }

                .score-circle-wrapper {
                    position: relative;
                    width: 140px;
                    height: 140px;
                    margin: 0 auto 20px;
                }

                .score-value {
                    position: absolute;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    font-size: 36px;
                    font-weight: 800;
                    color: #1e293b;
                }

                .score-breakdown {
                    margin-top: 20px;
                    text-align: left;
                }

                .breakdown-item {
                    margin-bottom: 12px;
                }

                .breakdown-label {
                    display: flex;
                    justify-content: space-between;
                    font-size: 13px;
                    color: #64748b;
                    margin-bottom: 4px;
                }

                .progress-bar {
                    height: 8px;
                    background: #f1f5f9;
                    border-radius: 4px;
                    overflow: hidden;
                }

                .progress-fill {
                    height: 100%;
                    border-radius: 4px;
                    transition: width 1s ease-out;
                }

                .insight-card {
                    background: #fff;
                    border-radius: 20px;
                    padding: 30px;
                    border: 1px solid #e2e8f0;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
                }

                .tips-list {
                    list-style: none;
                    padding: 0;
                    margin: 20px 0 0;
                }

                .tip-item {
                    display: flex;
                    align-items: start;
                    gap: 12px;
                    padding: 12px;
                    background: #f8fafc;
                    border-radius: 12px;
                    margin-bottom: 10px;
                    font-size: 14px;
                    color: #475569;
                    border-left: 4px solid #0f6fff;
                }

                .diet-plan-grid {
                    display: grid;
                    grid-template-columns: 1.5fr 1fr;
                }

                @media (max-width: 992px) {
                    .health-score-container, .diet-plan-grid {
                        grid-template-columns: 1fr;
                    }
                    .diet-plan-grid > div > div > div {
                        grid-template-columns: 1fr !important;
                    }
                }
                
                @media (max-width: 768px) {
                    .quick-action-grid {
                        grid-template-columns: 1fr 1fr !important;
                        padding: 16px !important;
                    }
                    .availability-grid {
                        grid-template-columns: 1fr !important;
                    }
                }
                
                @media (max-width: 480px) {
                    .quick-action-grid {
                        grid-template-columns: 1fr !important;
                    }
                }

                .quick-action-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                    gap: 20px;
                    padding: 28px;
                }

                .quick-action-card {
                    background: var(--card-bg);
                    border-radius: 16px;
                    padding: 28px 20px;
                    text-align: center;
                    text-decoration: none;
                    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                    border: 2px solid transparent;
                    position: relative;
                    overflow: hidden;
                }

                .quick-action-card::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    height: 4px;
                    transform: scaleX(0);
                    transform-origin: left;
                    transition: transform 0.4s ease;
                }

                .quick-action-card:hover::before {
                    transform: scaleX(1);
                }

                .quick-action-card.blue::before {
                    background: linear-gradient(90deg, #0F6FFF, #6C63FF);
                }

                .quick-action-card.green::before {
                    background: linear-gradient(90deg, #10B981, #34D399);
                }

                .quick-action-card.orange::before {
                    background: linear-gradient(90deg, #F59E0B, #FBBF24);
                }

                .quick-action-card.purple::before {
                    background: linear-gradient(90deg, #8B5CF6, #A78BFA);
                }

                .quick-action-card:hover {
                    transform: translateY(-6px);
                    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.08);
                    border-color: rgba(15, 111, 255, 0.12);
                }

                .quick-action-card .qa-icon {
                    font-size: 40px;
                    display: block;
                    margin-bottom: 14px;
                    transition: transform 0.3s ease;
                }

                .quick-action-card:hover .qa-icon {
                    transform: scale(1.15) translateY(-4px);
                }

                .quick-action-card .qa-label {
                    font-size: 14px;
                    font-weight: 600;
                    color: var(--text-primary);
                }

                /* ----- Complaint Card Enhancement ----- */
                .form-card {
                    border: 1px solid rgba(15, 111, 255, 0.06);
                    transition: all 0.3s ease;
                }

                .form-card:hover {
                    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.06);
                }

                /* ----- Sidebar SmartMedix Branding ----- */
                .sidebar-header h3 {
                    letter-spacing: -0.3px;
                }

                @media (max-width: 768px) {

                    .main-content::before,
                    .main-content::after {
                        left: 0;
                    }

                    .dashboard-hero {
                        padding: 28px 24px;
                    }

                    .dashboard-hero h1 {
                        font-size: 24px;
                    }
                }

                /* ----- Doctor Availability Tracker Styling ----- */
                .availability-wrapper {
                    background: var(--card-bg);
                    border-radius: 20px;
                    padding: 32px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
                    border: 1px solid rgba(15, 111, 255, 0.06);
                    margin-bottom: 32px;
                }

                .availability-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                    gap: 20px;
                    margin-top: 24px;
                }

                .doctor-status-card {
                    background: #f8fafc;
                    border-radius: 16px;
                    padding: 24px;
                    border: 1px solid rgba(15, 111, 255, 0.08);
                    transition: all 0.3s ease;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-between;
                }

                .doctor-status-card:hover {
                    transform: translateY(-5px);
                    background: #fff;
                    box-shadow: 0 12px 30px rgba(15, 111, 255, 0.1);
                    border-color: rgba(15, 111, 255, 0.2);
                }

                .status-indicator {
                    display: inline-flex;
                    align-items: center;
                    gap: 8px;
                    padding: 6px 14px;
                    border-radius: 30px;
                    font-size: 12px;
                    font-weight: 800;
                    margin-bottom: 16px;
                    width: fit-content;
                }

                .status-indicator.available {
                    background: #DCFCE7;
                    color: #166534;
                }

                .status-indicator.busy {
                    background: #FEE2E2;
                    color: #991B1B;
                }

                .status-indicator.offline {
                    background: #F1F5F9;
                    color: #475569;
                }

                .doc-info h4 {
                    font-size: 18px;
                    font-weight: 700;
                    color: #1e293b;
                    margin-bottom: 4px;
                }

                .doc-info span {
                    font-size: 13px;
                    color: #64748b;
                    display: block;
                    margin-bottom: 20px;
                }

                .btn-instant {
                    background: linear-gradient(135deg, #0F6FFF 0%, #6C63FF 100%);
                    color: #fff;
                    border: none;
                    border-radius: 12px;
                    padding: 12px;
                    font-weight: 700;
                    text-decoration: none;
                    text-align: center;
                    font-size: 14px;
                    transition: all 0.3s ease;
                }

                .btn-instant:hover {
                    box-shadow: 0 8px 20px rgba(15, 111, 255, 0.3);
                    transform: translateY(-2px);
                }

                .btn-instant.disabled {
                    background: #e2e8f0;
                    color: #94a3b8;
                    cursor: not-allowed;
                    pointer-events: none;
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
                        <li><a href="${pageContext.request.contextPath}/patient/dashboard" class="active"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/book-appointment"><span
                                    class="nav-icon">📅</span> Book Appointment</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/bills"><span class="nav-icon">💳</span>
                                My Bills</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/my-appointments"><span
                                    class="nav-icon">📋</span> My Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/medical-records"><span
                                    class="nav-icon">📁</span> Medical Records</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/reminders"><span
                                    class="nav-icon">⏰</span> Reminders</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/insurance"><span
                                    class="nav-icon">🛡️</span> My Insurance</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/profile"><span
                                    class="nav-icon">👤</span> My Profile</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">

                    <!-- ===== Welcome Hero Banner ===== -->
                    <div class="dashboard-hero">
                        <h1>Welcome back, <span>${sessionScope.user.fullName}!</span></h1>
                        <p>Here's your health summary for today. Stay on top of your appointments and medications.</p>
                        <div class="hero-badge">✅ All Systems Healthy</div>
                    </div>

                    <% if ("submitted".equals(request.getParameter("complaint"))) { %>
                        <div class="alert alert-success">Complaint submitted successfully!</div>
                        <% } %>

                            <!-- ===== Stat Cards ===== -->
                            <div class="stats-grid">
                                <div class="stat-card blue">
                                    <div class="stat-icon">📅</div>
                                    <div class="stat-value">${upcomingAppointments}</div>
                                    <div class="stat-label">Upcoming Appointments</div>
                                </div>
                                <div class="stat-card green">
                                    <div class="stat-icon">🧪</div>
                                    <div class="stat-value">${labReportsCount}</div>
                                    <div class="stat-label">Lab Reports Available</div>
                                </div>
                                <div class="stat-card purple">
                                    <div class="stat-icon">💊</div>
                                    <div class="stat-value">${prescriptionsCount}</div>
                                    <div class="stat-label">Prescriptions</div>
                                </div>
                            </div>

                            <!-- ===== Health Score & Analytics ===== -->
                            <div class="health-score-container">
                                <div class="score-main-card">
                                    <h3 style="margin-bottom: 20px;">🎯 Your Health Score</h3>
                                    <div class="score-circle-wrapper">
                                        <svg viewBox="0 0 36 36" class="circular-chart"
                                            style="display: block; margin: 10px auto; max-width: 100%; max-height: 250px;">
                                            <path class="circle-bg"
                                                d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
                                                style="fill: none; stroke: #f1f5f9; stroke-width: 2.8;" />
                                            <path class="circle" stroke-dasharray="${healthScore.overallScore}, 100"
                                                d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
                                                style="fill: none; stroke: #0f6fff; stroke-width: 2.8; stroke-linecap: round; transition: stroke-dasharray 1s ease;" />
                                        </svg>
                                        <div class="score-value">${healthScore.overallScore}</div>
                                    </div>
                                    <div class="score-breakdown">
                                        <div class="breakdown-item">
                                            <div class="breakdown-label">
                                                <span>🍎 Diet</span>
                                                <span>${healthScore.dietScore}%</span>
                                            </div>
                                            <div class="progress-bar">
                                                <div class="progress-fill"
                                                    style="width: ${healthScore.dietScore}%; background: #22c55e;">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="breakdown-item">
                                            <div class="breakdown-label">
                                                <span>🏃 Exercise</span>
                                                <span>${healthScore.exerciseScore}%</span>
                                            </div>
                                            <div class="progress-bar">
                                                <div class="progress-fill"
                                                    style="width: ${healthScore.exerciseScore}%; background: #3b82f6;">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="breakdown-item">
                                            <div class="breakdown-label">
                                                <span>💊 Medication</span>
                                                <span>${healthScore.medicationScore}%</span>
                                            </div>
                                            <div class="progress-bar">
                                                <div class="progress-fill"
                                                    style="width: ${healthScore.medicationScore}%; background: #f59e0b;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="insight-card">
                                    <h3 style="margin-bottom: 20px;">📈 Health Progress</h3>
                                    <div style="height: 200px; margin-bottom: 24px;">
                                        <canvas id="healthHistoryChart"></canvas>
                                    </div>
                                    <h3>💡 Personal Insights</h3>
                                    <div class="tips-list" style="margin-top: 15px;">
                                        <c:forEach items="${healthTips}" var="tip">
                                            <div class="tip-item">
                                                <span>✨</span>
                                                <span>${tip}</span>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>

                            <!-- ===== Doctor's Prescribed Diet & Health Plan (NEW) ===== -->
                            <c:if test="${not empty latestDietPlan}">
                                <div class="data-table-wrapper"
                                    style="margin-bottom: 24px; border-radius: 20px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.05); overflow: hidden; background: #fff;">
                                    <div
                                        style="background: linear-gradient(135deg, #10b981, #059669); padding: 20px 24px; color: #fff; display: flex; justify-content: space-between; align-items: center;">
                                        <div>
                                            <h3 style="margin: 0; font-size: 18px; font-weight: 700; color: #fff;">🥗 My
                                                Prescribed Diet & Health Plan</h3>
                                            <p style="margin: 4px 0 0; font-size: 12px; opacity: 0.9;">Recommended by
                                                Dr. ${latestDietPlan.doctor.name} on ${latestDietPlan.formattedDate}</p>
                                            <p
                                                style="margin: 4px 0 0; font-size: 13px; color: #fff; font-weight: 600; background: rgba(255,255,255,0.1); display: inline-block; padding: 2px 8px; border-radius: 4px;">
                                                ⏱ Follow this diet for: ${latestDietPlan.durationDays} Days</p>
                                        </div>
                                        <div
                                            style="background: rgba(255,255,255,0.2); padding: 8px 16px; border-radius: 10px; font-size: 13px; font-weight: 600;">
                                            Status: Active ✅
                                        </div>
                                    </div>
                                    <div class="diet-plan-grid"
                                        style="padding: 24px; gap: 32px;">
                                        <!-- Nutrition Part -->
                                        <div>
                                            <h4
                                                style="margin: 0 0 16px; color: #1e293b; font-size: 15px; border-left: 4px solid #10b981; padding-left: 10px;">
                                                Daily Nutrition Goals</h4>
                                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                                                <div
                                                    style="background: #f8fafc; padding: 16px; border-radius: 15px; border: 1px solid #e2e8f0;">
                                                    <div
                                                        style="font-size: 11px; color: #64748b; margin-bottom: 4px; font-weight: 700; text-transform: uppercase;">
                                                        Breakfast</div>
                                                    <div style="font-size: 14px; color: #1e293b; font-weight: 700;">
                                                        ${latestDietPlan.breakfast}</div>
                                                </div>
                                                <div
                                                    style="background: #f8fafc; padding: 16px; border-radius: 15px; border: 1px solid #e2e8f0;">
                                                    <div
                                                        style="font-size: 11px; color: #64748b; margin-bottom: 4px; font-weight: 700; text-transform: uppercase;">
                                                        Lunch</div>
                                                    <div style="font-size: 14px; color: #1e293b; font-weight: 700;">
                                                        ${latestDietPlan.lunch}</div>
                                                </div>
                                                <div
                                                    style="background: #f8fafc; padding: 16px; border-radius: 15px; border: 1px solid #e2e8f0;">
                                                    <div
                                                        style="font-size: 11px; color: #64748b; margin-bottom: 4px; font-weight: 700; text-transform: uppercase;">
                                                        Dinner</div>
                                                    <div style="font-size: 14px; color: #1e293b; font-weight: 700;">
                                                        ${latestDietPlan.dinner}</div>
                                                </div>
                                                <div
                                                    style="background: #f8fafc; padding: 16px; border-radius: 15px; border: 1px solid #e2e8f0;">
                                                    <div
                                                        style="font-size: 11px; color: #64748b; margin-bottom: 4px; font-weight: 700; text-transform: uppercase;">
                                                        Healthy Drinks</div>
                                                    <div style="font-size: 14px; color: #1e293b; font-weight: 700;">
                                                        ${latestDietPlan.healthyDrinks}</div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Activity Part -->
                                        <div>
                                            <h4
                                                style="margin: 0 0 16px; color: #1e293b; font-size: 15px; border-left: 4px solid #3b82f6; padding-left: 10px;">
                                                Daily Activity Goals</h4>
                                            <div style="display: flex; flex-direction: column; gap: 12px;">
                                                <div
                                                    style="display: flex; align-items: center; justify-content: space-between; background: #eff6ff; padding: 16px; border-radius: 15px;">
                                                    <div style="display: flex; align-items: center; gap: 12px;">
                                                        <span style="font-size: 24px;">👟</span>
                                                        <div>
                                                            <div
                                                                style="font-size: 11px; color: #1e40af; font-weight: 700;">
                                                                Daily Steps</div>
                                                            <div
                                                                style="font-size: 16px; color: #1e3a8a; font-weight: 800;">
                                                                ${latestDietPlan.stepsTarget} Steps</div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div
                                                    style="display: flex; align-items: center; justify-content: space-between; background: #f0fdf4; padding: 16px; border-radius: 15px;">
                                                    <div style="display: flex; align-items: center; gap: 12px;">
                                                        <span style="font-size: 24px;">⏱️</span>
                                                        <div>
                                                            <div
                                                                style="font-size: 11px; color: #166534; font-weight: 700;">
                                                                Exercise</div>
                                                            <div
                                                                style="font-size: 16px; color: #14532d; font-weight: 800;">
                                                                ${latestDietPlan.exerciseMinutes} Min Workout</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Analysis Scores -->
                                            <div
                                                style="margin-top: 16px; background: #fff7ed; padding: 16px; border-radius: 15px; border: 1px solid #ffedd5;">
                                                <div
                                                    style="font-size: 11px; color: #9a3412; font-weight: 800; margin-bottom: 8px; text-transform: uppercase;">
                                                    Doctor's Analysis Score</div>
                                                <div
                                                    style="display: flex; gap: 16px; align-items: center; font-size: 14px; font-weight: 700; color: #7c2d12;">
                                                    <span>🍎 Diet Adherence: ${latestDietPlan.dietScore}%</span>
                                                    <span>🏃 Exercise Intensity: ${latestDietPlan.exerciseScore}%</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <!-- ===== Active Reminders ===== -->
                            <c:if test="${not empty reminders}">
                                <div class="form-card" style="margin-bottom:24px;">
                                    <h3>⏰ Active Medicine Reminders</h3>
                                    <c:forEach items="${reminders}" var="r">
                                        <div class="alert alert-info" style="margin-bottom:8px;">
                                            💊 <strong>${r.medicineName}</strong> - ${r.dosage} at
                                            <strong>${r.reminderTime}</strong>
                                            <c:if test="${r.notes != null}"> | ${r.notes}</c:if>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>

                            <!-- ===== Doctor Availability Tracker ===== -->
                            <div class="availability-wrapper">
                                <div class="table-header" style="margin-bottom: 10px;">
                                    <h3>🚀 Doctor Availability Tracker</h3>
                                    <p style="font-size: 14px; color: #64748b;">Find an available specialist and book
                                        your appointment instantly.</p>
                                </div>

                                <div class="availability-grid">
                                    <c:forEach items="${doctors}" var="doc">
                                        <div class="doctor-status-card">
                                            <div>
                                                <div class="status-indicator <c:choose><c:when test="
                                                    ${doc.availabilityStatus=='AVAILABLE' }">available</c:when>
                                                    <c:when test="${doc.availabilityStatus == 'BUSY'}">busy</c:when>
                                                    <c:otherwise>offline</c:otherwise>
                                                    </c:choose>">
                                                    <span>
                                                        <c:choose>
                                                            <c:when test="${doc.availabilityStatus == 'AVAILABLE'}">🟢
                                                            </c:when>
                                                            <c:when test="${doc.availabilityStatus == 'BUSY'}">🔴
                                                            </c:when>
                                                            <c:otherwise>⚪</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                    <c:choose>
                                                        <c:when test="${doc.availabilityStatus == 'AVAILABLE'}">
                                                            Available now</c:when>
                                                        <c:when test="${doc.availabilityStatus == 'BUSY'}">Busy</c:when>
                                                        <c:otherwise>Offline</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="doc-info">
                                                    <h4>Dr. ${doc.name}</h4>
                                                    <span>🩺 ${doc.specialization} | ${doc.department}</span>
                                                </div>
                                            </div>

                                            <a href="${pageContext.request.contextPath}/patient/book-appointment?doctorId=${doc.id}"
                                                class="btn-instant ${doc.availabilityStatus == 'AVAILABLE' ? '' : 'disabled'}">
                                                ⚡ <c:choose>
                                                    <c:when test="${doc.availabilityStatus == 'AVAILABLE'}">Instant Book
                                                    </c:when>
                                                    <c:when test="${doc.availabilityStatus == 'BUSY'}">Currently Busy
                                                    </c:when>
                                                    <c:otherwise>Doctor Offline</c:otherwise>
                                                </c:choose>
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- ===== Pending Lab Requests ===== -->
                            <c:if test="${not empty pendingLabRequests}">
                                <div class="data-table-wrapper" style="margin-bottom: 24px;">
                                    <div class="table-header">
                                        <h3 style="color: #F59E0B;">⚠️ Pending Lab Requests</h3>
                                        <p style="font-size: 14px; color: #64748b;">Your doctor has requested the
                                            following laboratory tests. Please accept and pay to proceed.</p>
                                    </div>
                                    <div class="availability-grid" style="padding: 0 24px 24px 24px; margin-top: 10px;">
                                        <c:forEach items="${pendingLabRequests}" var="req">
                                            <div class="doctor-status-card" style="border-left: 4px solid #F59E0B;">
                                                <div>
                                                    <div class="status-indicator"
                                                        style="background: #FEF3C7; color: #B45309;">
                                                        <span>🧪</span> Requested by Dr. ${req.doctor.name}
                                                    </div>
                                                    <div class="doc-info">
                                                        <h4>${req.testName}</h4>
                                                        <c:if test="${not empty req.description}">
                                                            <span style="margin-bottom: 15px;">📝
                                                                ${req.description}</span>
                                                        </c:if>
                                                        <span style="color: #EF4444; font-weight: 600;">Urgency:
                                                            ${req.urgency}</span>
                                                    </div>
                                                </div>
                                                <div style="display: flex; gap: 10px; margin-top: 10px;">
                                                    <form
                                                        action="${pageContext.request.contextPath}/patient/lab-request/accept"
                                                        method="post" style="flex: 1;">
                                                        <input type="hidden" name="requestId" value="${req.id}">
                                                        <button type="submit" class="btn-instant"
                                                            style="width: 100%; height: 100%; border-radius: 8px;">
                                                            Pay Online (UPI/Wallet) 💳
                                                        </button>
                                                    </form>
                                                    <c:if test="${req.status == 'Pending'}">
                                                        <form
                                                            action="${pageContext.request.contextPath}/patient/lab-request/reject"
                                                            method="post" style="flex: 1;">
                                                            <input type="hidden" name="requestId" value="${req.id}">
                                                            <button type="submit" class="btn-instant"
                                                                style="background: #fee2e2; color: #991b1b; width: 100%; border-radius: 8px;">
                                                                Reject ❌
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>

                            <!-- ===== Quick Actions ===== -->
                            <div class="data-table-wrapper" style="margin-bottom:24px;">
                                <div class="table-header">
                                    <h3>⚡ Quick Actions</h3>
                                </div>
                                <div class="quick-action-grid">
                                    <a href="${pageContext.request.contextPath}/patient/book-appointment"
                                        class="quick-action-card blue">
                                        <span class="qa-icon">📅</span>
                                        <span class="qa-label">Book Appointment</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/patient/medical-records"
                                        class="quick-action-card green">
                                        <span class="qa-icon">📁</span>
                                        <span class="qa-label">View Records</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/patient/lab-reports"
                                        class="quick-action-card orange">
                                        <span class="qa-icon">🧪</span>
                                        <span class="qa-label">Lab Reports</span>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/patient/profile"
                                        class="quick-action-card purple">
                                        <span class="qa-icon">👤</span>
                                        <span class="qa-label">My Profile</span>
                                    </a>
                                </div>
                            </div>

                            <!-- ===== Community Health Trends ===== -->
                            <div class="form-card" style="position: relative; overflow: hidden;">
                                <div
                                    style="position: absolute; top: 0; right: 0; width: 140px; height: 140px; background: linear-gradient(135deg, rgba(239,68,68,0.06), rgba(249,115,22,0.06)); border-radius: 0 0 0 100%; pointer-events: none;">
                                </div>
                                <h3 style="margin-bottom: 4px;">🦠 Community Health Trends</h3>
                                <p style="color: #64748b; font-size: 13px; margin-bottom: 20px;">Aggregated disease data
                                    from your region (no personal info shown)</p>

                                <!-- Alert Cards -->
                                <div id="patientAlerts"
                                    style="display: flex; flex-wrap: wrap; gap: 12px; margin-bottom: 24px;"></div>

                                <!-- Chart -->
                                <div
                                    style="background: #f8fafc; border-radius: 16px; padding: 20px; border: 1px solid #e2e8f0;">
                                    <canvas id="patientDiseaseChart" height="220"></canvas>
                                </div>

                                <p style="color: #94a3b8; font-size: 11px; margin-top: 12px; text-align: center;">📊
                                    Data aggregated from anonymized health reports • Last 30 days</p>
                            </div>

                            <!-- ===== Hospital Bed Finder ===== -->
                            <div class="form-card" style="position: relative; overflow: hidden;">
                                <div
                                    style="position: absolute; top: 0; right: 0; width: 140px; height: 140px; background: linear-gradient(135deg, rgba(34,197,94,0.06), rgba(59,130,246,0.06)); border-radius: 0 0 0 100%; pointer-events: none;">
                                </div>
                                <h3 style="margin-bottom: 4px;">🛏️ Find Hospital Beds</h3>
                                <p style="color: #64748b; font-size: 13px; margin-bottom: 16px;">Search real-time bed
                                    availability across hospitals. Find ICU, Oxygen, and General beds instantly during
                                    emergencies.</p>

                                <div style="display: flex; gap: 12px; margin-bottom: 20px;">
                                    <input type="text" id="bedSearchCity"
                                        placeholder="Search by city (e.g. Mumbai, Delhi)..."
                                        style="flex:1; padding: 12px 16px; border: 2px solid #e2e8f0; border-radius: 12px; font-size: 14px; outline: none; transition: border 0.3s;"
                                        onfocus="this.style.borderColor='#0f6fff'"
                                        onblur="this.style.borderColor='#e2e8f0'">
                                    <button onclick="searchBeds()"
                                        style="padding: 12px 24px; background: linear-gradient(135deg, #22c55e, #16a34a); color: #fff; border: none; border-radius: 12px; font-weight: 700; cursor: pointer; font-size: 14px; white-space: nowrap;">🔍
                                        Search</button>
                                </div>

                                <div id="bedResults" style="display: none;">
                                    <div id="bedResultsCount"
                                        style="font-size: 13px; color: #64748b; margin-bottom: 16px; font-weight: 600;">
                                    </div>
                                    <div id="bedResultsList"></div>
                                </div>
                                <div id="bedLoading"
                                    style="display: none; text-align: center; padding: 20px; color: #64748b;">⏳
                                    Searching hospitals...</div>
                                <div id="bedEmpty"
                                    style="display: none; text-align: center; padding: 20px; color: #94a3b8;">No
                                    hospitals found. Try a different city.</div>
                            </div>

                            <!-- ===== Share Records via QR Code ===== -->
                            <div class="form-card" style="position: relative; overflow: hidden;">
                                <div
                                    style="position: absolute; top: 0; right: 0; width: 120px; height: 120px; background: linear-gradient(135deg, rgba(15,111,255,0.08), rgba(108,99,255,0.08)); border-radius: 0 0 0 100%; pointer-events: none;">
                                </div>
                                <h3>🔐 Secure Health Record Sharing</h3>
                                <p style="color: #64748b; font-size: 14px; margin-bottom: 20px;">Generate a temporary QR
                                    code to securely share your medical records with your doctor during consultation.
                                    The code expires in 10 minutes and is single-use.</p>
                                <button onclick="generateQrCode()" class="btn-primary" id="generateQrBtn"
                                    style="max-width: 280px; background: linear-gradient(135deg, #0f6fff 0%, #6c63ff 100%); border: none; cursor: pointer;">
                                    🔑 Generate QR Code
                                </button>
                            </div>

                            <!-- ===== Submit Complaint ===== -->
                            <div class="form-card">
                                <h3>📝 Submit a Complaint</h3>
                                <form action="${pageContext.request.contextPath}/patient/complaint" method="post">
                                    <div class="form-group"><label>Your Complaint</label><textarea name="complaintText"
                                            rows="3" placeholder="Describe your complaint..." required></textarea></div>
                                    <button type="submit" class="btn-primary" style="max-width:200px;">Submit
                                        Complaint</button>
                                </form>
                            </div>
                </main>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
            <script>
                // ===== Disease Trends =====
                fetch('${pageContext.request.contextPath}/patient/disease-trends')
                    .then(function (r) { return r.json(); })
                    .then(function (data) {
                        if (data.error) return;
                        var alertsDiv = document.getElementById('patientAlerts');
                        var trendConfig = { RISING: ['#fef2f2', '#dc2626', '\u{1F53A}'], FALLING: ['#f0fdf4', '#16a34a', '\u{1F53D}'], STABLE: ['#f8fafc', '#64748b', '➡️'] };
                        (data.alerts || []).forEach(function (a) {
                            var cfg = trendConfig[a.trend] || trendConfig.STABLE;
                            alertsDiv.innerHTML += '<div style="flex:1;min-width:140px;padding:14px 16px;border-radius:14px;background:' + cfg[0] + ';border:1px solid ' + cfg[1] + '20">'
                                + '<div style="font-size:13px;font-weight:700;color:' + cfg[1] + ';margin-bottom:4px">' + cfg[2] + ' ' + a.disease + '</div>'
                                + '<div style="font-size:12px;color:#64748b">' + a.recentCases + ' cases \u2022 ' + a.trend + '</div></div>';
                        });
                        var diseases = data.diseases || [];
                        var colors = ['#ef4444', '#f97316', '#eab308', '#22c55e', '#3b82f6', '#8b5cf6', '#ec4899'];
                        new Chart(document.getElementById('patientDiseaseChart'), {
                            type: 'bar',
                            data: {
                                labels: diseases.map(function (d) { return d.name; }),
                                datasets: [{
                                    label: 'Reported Cases (30 days)',
                                    data: diseases.map(function (d) { return d.count; }),
                                    backgroundColor: diseases.map(function (_, i) { return colors[i % colors.length] + '22'; }),
                                    borderColor: diseases.map(function (_, i) { return colors[i % colors.length]; }),
                                    borderWidth: 2, borderRadius: 8
                                }]
                            },
                            options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, grid: { color: '#f1f5f9' } }, x: { grid: { display: false } } } }
                        });

                        // ===== Health History Chart =====
                        fetch('${pageContext.request.contextPath}/patient/health-history')
                            .then(function (r) { return r.json(); })
                            .then(function (data) {
                                if (!data || data.length === 0) return;
                                new Chart(document.getElementById('healthHistoryChart'), {
                                    type: 'line',
                                    data: {
                                        labels: data.map(function (s) { return s.date; }),
                                        datasets: [{
                                            label: 'Overall Health Score',
                                            data: data.map(function (s) { return s.overallScore; }),
                                            borderColor: '#0f6fff',
                                            backgroundColor: 'rgba(15, 111, 255, 0.1)',
                                            fill: true,
                                            tension: 0.4,
                                            borderWidth: 3,
                                            pointRadius: 4,
                                            pointBackgroundColor: '#fff',
                                            pointBorderColor: '#0f6fff',
                                            pointBorderWidth: 2
                                        }]
                                    },
                                    options: {
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        plugins: { legend: { display: false } },
                                        scales: {
                                            y: { min: 0, max: 100, grid: { color: '#f1f5f9' } },
                                            x: { grid: { display: false } }
                                        }
                                    }
                                });
                            }).catch(function () { });
                    }).catch(function () { });
            </script>
            <script>
                // ===== Hospital Bed Search =====
                function searchBeds() {
                    var city = document.getElementById('bedSearchCity').value;
                    var loading = document.getElementById('bedLoading');
                    var results = document.getElementById('bedResults');
                    var empty = document.getElementById('bedEmpty');
                    var list = document.getElementById('bedResultsList');
                    var count = document.getElementById('bedResultsCount');

                    loading.style.display = 'block';
                    results.style.display = 'none';
                    empty.style.display = 'none';

                    fetch('${pageContext.request.contextPath}/patient/hospitals/search?city=' + encodeURIComponent(city))
                        .then(function (r) { return r.json(); })
                        .then(function (data) {
                            loading.style.display = 'none';
                            if (!data || data.length === 0) {
                                empty.style.display = 'block';
                                return;
                            }
                            results.style.display = 'block';
                            count.innerText = data.length + ' hospital(s) found';
                            list.innerHTML = '';
                            data.forEach(function (h) {
                                var bedColor = function (avail, total) {
                                    var pct = total > 0 ? (avail / total) * 100 : 0;
                                    if (pct <= 10) return '#ef4444';
                                    if (pct <= 30) return '#f97316';
                                    return '#22c55e';
                                };
                                list.innerHTML += '<div style="background:#f8fafc;border-radius:16px;padding:20px;margin-bottom:16px;border:1px solid #e2e8f0">'
                                    + '<div style="display:flex;justify-content:space-between;align-items:start;flex-wrap:wrap;gap:12px">'
                                    + '<div><h4 style="margin:0 0 4px;font-size:16px;color:#1e293b">\u{1F3E5} ' + h.name + '</h4>'
                                    + '<div style="font-size:12px;color:#64748b">\u{1F4CD} ' + h.area + ', ' + h.city + '</div>'
                                    + '<div style="font-size:12px;color:#94a3b8;margin-top:2px">' + h.address + '</div></div>'
                                    + '<div style="text-align:right"><div style="font-size:24px;font-weight:800;color:' + bedColor(h.totalAvailable, h.totalBeds) + '">' + h.totalAvailable + '</div>'
                                    + '<div style="font-size:11px;color:#64748b">beds available</div></div></div>'
                                    + '<div style="display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin:16px 0">'
                                    + '<div style="text-align:center;padding:12px;background:#fff;border-radius:10px;border:1px solid #fee2e2">'
                                    + '<div style="font-size:10px;font-weight:700;color:#ef4444;text-transform:uppercase">\u{1F534} ICU</div>'
                                    + '<div style="font-size:20px;font-weight:800;color:#ef4444">' + h.icuAvailable + '</div>'
                                    + '<div style="font-size:10px;color:#94a3b8">of ' + h.icuTotal + '</div></div>'
                                    + '<div style="text-align:center;padding:12px;background:#fff;border-radius:10px;border:1px solid #dbeafe">'
                                    + '<div style="font-size:10px;font-weight:700;color:#3b82f6;text-transform:uppercase">\u{1F535} Oxygen</div>'
                                    + '<div style="font-size:20px;font-weight:800;color:#3b82f6">' + h.oxygenAvailable + '</div>'
                                    + '<div style="font-size:10px;color:#94a3b8">of ' + h.oxygenTotal + '</div></div>'
                                    + '<div style="text-align:center;padding:12px;background:#fff;border-radius:10px;border:1px solid #dcfce7">'
                                    + '<div style="font-size:10px;font-weight:700;color:#22c55e;text-transform:uppercase">\u{1F7E2} General</div>'
                                    + '<div style="font-size:20px;font-weight:800;color:#22c55e">' + h.generalAvailable + '</div>'
                                    + '<div style="font-size:10px;color:#94a3b8">of ' + h.generalTotal + '</div></div></div>'
                                    + '<a href="https://wa.me/919353994683?text=Hello Admin, I am ' + encodeURIComponent('${patient.name}') + '. I need help regarding bed availability at ' + encodeURIComponent(h.name) + ' in ' + encodeURIComponent(h.city) + '." target="_blank" style="width:100%;text-align:center;padding:12px;background:linear-gradient(135deg,#25D366,#128C7E);color:#fff;border-radius:12px;font-weight:700;font-size:14px;text-decoration:none;display:flex;align-items:center;justify-content:center;gap:8px;box-shadow:0 4px 12px rgba(37,211,102,0.2)">\uD83D\uDCAC Real-Time Admin Chat</a></div></div>';
                            });
                        }).catch(function () {
                            loading.style.display = 'none';
                            empty.style.display = 'block';
                        });
                }
                // Auto-load all hospitals on page load
                document.addEventListener('DOMContentLoaded', function () { searchBeds(); });
            </script>
            <script src="https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js"></script>
            <style>
                @keyframes modalSlideIn {
                    from {
                        opacity: 0;
                        transform: translateY(-30px) scale(0.95);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0) scale(1);
                    }
                }
            </style>
            <script>
                let countdownInterval;

                function generateQrCode() {
                    const btn = document.getElementById('generateQrBtn');
                    btn.disabled = true;
                    btn.innerHTML = '⏳ Generating...';

                    fetch('${pageContext.request.contextPath}/patient/qr/generate', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/json' }
                    })
                        .then(res => res.json())
                        .then(data => {
                            btn.disabled = false;
                            btn.innerHTML = '🔑 Generate QR Code';

                            if (data.error) {
                                alert('Error: ' + data.error);
                                return;
                            }

                            // Show modal
                            const modal = document.getElementById('qrModal');
                            modal.style.display = 'flex';

                            // Clear previous QR
                            const container = document.getElementById('qrCodeContainer');
                            container.innerHTML = '';

                            // Generate QR code
                            new QRCode(container, {
                                text: data.token,
                                width: 200,
                                height: 200,
                                colorDark: '#0f172a',
                                colorLight: '#ffffff',
                                correctLevel: QRCode.CorrectLevel.H
                            });

                            // Display token
                            document.getElementById('qrTokenDisplay').innerText = 'Token: ' + data.token;

                            // Start countdown
                            startCountdown(data.expiresAt);
                        })
                        .catch(err => {
                            btn.disabled = false;
                            btn.innerHTML = '🔑 Generate QR Code';
                            alert('Failed to generate QR code. Please try again.');
                        });
                }

                function startCountdown(expiresAtStr) {
                    if (countdownInterval) clearInterval(countdownInterval);
                    const expiresAt = new Date(expiresAtStr);
                    countdownInterval = setInterval(() => {
                        const now = new Date();
                        const diff = expiresAt - now;
                        if (diff <= 0) {
                            clearInterval(countdownInterval);
                            document.getElementById('qrCountdown').innerText = 'EXPIRED';
                            document.getElementById('qrExpiry').style.background = 'linear-gradient(135deg, #fecaca, #fca5a5)';
                            document.getElementById('qrExpiry').style.color = '#991b1b';
                            return;
                        }
                        const mins = Math.floor(diff / 60000);
                        const secs = Math.floor((diff % 60000) / 1000);
                        document.getElementById('qrCountdown').innerText = mins + ':' + (secs < 10 ? '0' : '') + secs;
                    }, 1000);
                }

                function closeQrModal() {
                    document.getElementById('qrModal').style.display = 'none';
                    if (countdownInterval) clearInterval(countdownInterval);
                }

                // Close modal on background click
                document.getElementById('qrModal').addEventListener('click', function (e) {
                    if (e.target === this) closeQrModal();
                });
            </script>

            <!-- QR Code Modal (placed at body level for proper overlay) -->
            <div id="qrModal"
                style="display:none; position:fixed; top:0; left:0; right:0; bottom:0; background:rgba(0,0,0,0.6); z-index:9999; align-items:center; justify-content:center;">
                <div
                    style="background: #fff; border-radius: 24px; padding: 40px; max-width: 420px; width: 90%; text-align: center; box-shadow: 0 25px 60px rgba(0,0,0,0.3); position: relative; animation: modalSlideIn 0.3s ease;">
                    <button onclick="closeQrModal()"
                        style="position:absolute; top:16px; right:16px; background:none; border:none; font-size:24px; cursor:pointer; color:#94a3b8;">✕</button>
                    <div
                        style="width: 60px; height: 60px; background: linear-gradient(135deg, #0f6fff, #6c63ff); border-radius: 16px; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; font-size: 28px;">
                        🔐</div>
                    <h3 style="margin-bottom: 6px; color: #1e293b;">Your Secure QR Code</h3>
                    <p style="color: #64748b; font-size: 13px; margin-bottom: 20px;">Show this to your doctor to share
                        your medical records</p>
                    <div id="qrCodeContainer"
                        style="display: flex; justify-content: center; margin-bottom: 20px; padding: 20px; background: #f8fafc; border-radius: 16px; border: 2px dashed #e2e8f0;">
                    </div>
                    <div id="qrTokenDisplay"
                        style="font-family: 'Courier New', Courier, monospace; font-size: 14px; font-weight: 700; color: #1e293b; letter-spacing: 0.5px; word-break: break-all; margin-bottom: 16px; padding: 12px; background: #eef2ff; border: 1px solid #c7d2fe; border-radius: 10px; box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);">
                    </div>
                    <div id="qrExpiry"
                        style="display: flex; align-items: center; justify-content: center; gap: 8px; padding: 10px 20px; background: linear-gradient(135deg, #fef3c7, #fde68a); border-radius: 12px; color: #92400e; font-weight: 600; font-size: 14px;">
                        ⏱️ <span id="qrCountdown">10:00</span> remaining
                    </div>
                </div>
            </div>

            <a href="https://wa.me/919353994683?text=Hello Admin, I am ${patient.name} and I need help with hospital bed availability."
                target="_blank"
                style="position:fixed; bottom:30px; right:30px; width:60px; height:60px; background:linear-gradient(135deg,#25D366,#128C7E); border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:30px; color:#fff; box-shadow: 0 10px 25px rgba(37,211,102,0.3); z-index:9999; transition:all 0.3s ease; text-decoration:none;"
                onmouseover="this.style.transform='scale(1.1) rotate(5deg)';"
                onmouseout="this.style.transform='scale(1) rotate(0deg)';" title="Chat with Admin for Bed Availability">
                💬
            </a>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

