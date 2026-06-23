<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Doctor Dashboard - SmartMedix</title>
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

                /* ----- Welcome Hero Banner ----- */
                .dashboard-hero {
                    background: linear-gradient(135deg, #0F172A 0%, #1E3A5F 50%, #06B6D4 100%);
                    border-radius: 20px;
                    padding: 40px 44px;
                    margin-bottom: 32px;
                    position: relative;
                    overflow: hidden;
                    box-shadow: 0 10px 40px rgba(6, 182, 212, 0.15);
                }

                .dashboard-hero::before {
                    content: '';
                    position: absolute;
                    top: -30%;
                    right: -5%;
                    width: 350px;
                    height: 350px;
                    background: radial-gradient(circle, rgba(6, 182, 212, 0.2) 0%, transparent 70%);
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
                    background: radial-gradient(circle, rgba(15, 111, 255, 0.1) 0%, transparent 70%);
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
                    background: linear-gradient(135deg, #22D3EE, #60A5FA);
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
                    background: rgba(15, 111, 255, 0.2);
                    border: 1px solid rgba(15, 111, 255, 0.3);
                    border-radius: 20px;
                    color: #93C5FD;
                    font-size: 12px;
                    font-weight: 600;
                    margin-top: 14px;
                    position: relative;
                    z-index: 1;
                }

                /* ----- Stat Cards ----- */
                .stat-card {
                    backdrop-filter: blur(8px);
                    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                }

                .stat-card:hover {
                    transform: translateY(-6px) scale(1.02);
                    box-shadow: 0 16px 40px rgba(15, 111, 255, 0.15);
                }

                /* ----- Quick Action Cards ----- */
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
                    background: linear-gradient(90deg, #0F6FFF, #06B6D4);
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
                        <div class="role-badge">Doctor Panel</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/doctor/dashboard" class="active"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/appointments"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/prescription"><span
                                    class="nav-icon">💊</span> Prescriptions</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/lab-request"><span
                                    class="nav-icon">🧪</span> Lab Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/consultation-notes"><span
                                    class="nav-icon">📋</span> Consultation Notes</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/qr/scan"><span class="nav-icon">📱</span>
                                Scan QR</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>

                <main class="main-content">
                    <div style="padding: 32px; max-width: 1400px; margin: 0 auto;">

                        <!-- ===== Welcome Hero Banner ===== -->
                        <div class="dashboard-hero">
                            <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                                <div>
                                    <h1>Welcome back, <span>Dr. ${sessionScope.user.fullName}!</span></h1>
                                    <p>Your daily healthcare summary is ready. You have ${todayAppointments}
                                        appointments scheduled for today.</p>
                                    <div class="hero-badge">🧑‍⚕️ Clinical Mode Active</div>
                                </div>

                                <!-- ===== Availability Toggle ===== -->
                                <div class="availability-toggle-container"
                                    style="background: rgba(255,255,255,0.1); padding: 20px; border-radius: 16px; border: 1px solid rgba(255,255,255,0.2); backdrop-filter: blur(10px); text-align: center; min-width: 180px;">
                                    <div
                                        style="color: #fff; font-size: 13px; font-weight: 600; margin-bottom: 10px; opacity: 0.9;">
                                        MY AVAILABILITY</div>
                                    <div
                                        style="display: flex; align-items: center; justify-content: center; gap: 10px; margin-bottom: 12px;">
                                        <span style="font-size: 20px;">
                                            <c:choose>
                                                <c:when test="${doctor.availabilityStatus == 'AVAILABLE'}">🟢</c:when>
                                                <c:when test="${doctor.availabilityStatus == 'BUSY'}">🔴</c:when>
                                                <c:when test="${doctor.availabilityStatus == 'IN_CONSULTATION'}">🟡
                                                </c:when>
                                                <c:when test="${doctor.availabilityStatus == 'OFFLINE'}">⚫</c:when>
                                                <c:otherwise>⚫</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span
                                            style="color: #fff; font-weight: 700; font-size: 16px; letter-spacing: 0.5px;">
                                            <c:choose>
                                                <c:when test="${doctor.availabilityStatus == 'IN_CONSULTATION'}">IN
                                                    CONSULTATION</c:when>
                                                <c:when test="${empty doctor.availabilityStatus}">OFFLINE</c:when>
                                                <c:otherwise>${doctor.availabilityStatus}</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <form action="${pageContext.request.contextPath}/doctor/update-availability"
                                        method="post">
                                        <c:set var="nextStatus" value="" />
                                        <c:set var="nextStatusText" value="" />
                                        <c:set var="nextColor" value="" />
                                        <c:choose>
                                            <c:when test="${doctor.availabilityStatus == 'AVAILABLE'}">
                                                <c:set var="nextStatus" value="BUSY" />
                                                <c:set var="nextStatusText" value="BUSY 🔴" />
                                                <c:set var="nextColor" value="#EF4444" />
                                            </c:when>
                                            <c:when test="${doctor.availabilityStatus == 'BUSY'}">
                                                <c:set var="nextStatus" value="IN_CONSULTATION" />
                                                <c:set var="nextStatusText" value="IN CONSULTATION 🟡" />
                                                <c:set var="nextColor" value="#F59E0B" />
                                            </c:when>
                                            <c:when test="${doctor.availabilityStatus == 'IN_CONSULTATION'}">
                                                <c:set var="nextStatus" value="OFFLINE" />
                                                <c:set var="nextStatusText" value="OFFLINE ⚫" />
                                                <c:set var="nextColor" value="#334155" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="nextStatus" value="AVAILABLE" />
                                                <c:set var="nextStatusText" value="AVAILABLE 🟢" />
                                                <c:set var="nextColor" value="#10B981" />
                                            </c:otherwise>
                                        </c:choose>
                                        <input type="hidden" name="status" value="${nextStatus}">
                                        <button type="submit"
                                            style="background: ${nextColor}; color: #fff; border: none; padding: 10px 16px; width: 100%; border-radius: 12px; font-weight: 700; cursor: pointer; transition: all 0.3s ease;">
                                            SET AS ${nextStatusText}
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="stats-grid">
                            <div class="stat-card blue">
                                <div class="stat-icon">📅</div>
                                <div class="stat-value">${todayAppointments}</div>
                                <div class="stat-label">Today's Appointments</div>
                            </div>
                            <div class="stat-card green">
                                <div class="stat-icon">✅</div>
                                <div class="stat-value">${completedConsultations}</div>
                                <div class="stat-label">Completed Consultations</div>
                            </div>
                            <div class="stat-card orange">
                                <div class="stat-icon">⏳</div>
                                <div class="stat-value">${pendingAppointments}</div>
                                <div class="stat-label">Pending Appointments</div>
                            </div>
                            <div class="stat-card purple">
                                <div class="stat-icon">🧑‍🤝‍🧑</div>
                                <div class="stat-value">${totalPatients}</div>
                                <div class="stat-label">Total Patients</div>
                            </div>
                        </div>

                        <div class="data-table-wrapper" style="margin-bottom: 32px;">
                            <div class="table-header">
                                <h3>⚡ Quick Actions</h3>
                            </div>
                            <div class="quick-action-grid">
                                <a href="${pageContext.request.contextPath}/doctor/appointments"
                                    class="quick-action-card blue"><span class="qa-icon">📅</span><span
                                        class="qa-label">View Appointments</span></a>
                                <a href="${pageContext.request.contextPath}/doctor/prescription"
                                    class="quick-action-card green"><span class="qa-icon">💊</span><span
                                        class="qa-label">Write Prescription</span></a>
                                <a href="${pageContext.request.contextPath}/doctor/lab-request"
                                    class="quick-action-card orange"><span class="qa-icon">🧪</span><span
                                        class="qa-label">Request Lab Test</span></a>
                                <a href="${pageContext.request.contextPath}/doctor/consultation-notes"
                                    class="quick-action-card purple"><span class="qa-icon">📋</span><span
                                        class="qa-label">Add Notes</span></a>
                                <a href="${pageContext.request.contextPath}/doctor/qr/scan"
                                    class="quick-action-card blue"
                                    style="border: 2px solid rgba(15,111,255,0.15); background: linear-gradient(135deg, rgba(15,111,255,0.03), rgba(108,99,255,0.03));">
                                    <span class="qa-icon">📱</span><span class="qa-label">Scan Patient QR</span>
                                </a>
                            </div>
                        </div>

                        <c:if test="${not empty message}">
                            <div
                                style="margin-bottom: 20px; padding: 16px; background: #ecfdf5; border: 1px solid #10b981; border-radius: 12px; color: #065f46; font-weight: 600; display: flex; align-items: center; gap: 10px;">
                                <span>✔</span> ${message}
                            </div>
                        </c:if>

                        <!-- 1. Patient Diet & Health Plan Section (NEW CARD) -->
                        <div class="data-table-wrapper"
                            style="margin-bottom: 32px; border-radius: 20px; border: none; box-shadow: 0 10px 30px rgba(0,0,0,0.08); overflow: hidden; background: #fff;">
                            <div
                                style="background: linear-gradient(135deg, #10b981, #059669); padding: 16px 24px; color: #fff; display: flex; justify-content: space-between; align-items: center;">
                                <h3 style="margin: 0; font-size: 18px; font-weight: 700; color: #fff;">🥗 Patient Health
                                    & Diet Prescription</h3>
                                <span
                                    style="background: rgba(255,255,255,0.2); padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 600;">Prescribe
                                    nutrition & exercise goals</span>
                            </div>
                            <div style="padding: 24px;">
                                <form action="${pageContext.request.contextPath}/doctor/prescribe-diet" method="POST">
                                    <input type="hidden" name="redirectSource" value="dashboard">
                                    <div
                                        style="display: grid; grid-template-columns: 1.2fr 2fr 2fr; gap: 20px; margin-bottom: 20px;">
                                        <!-- Select Patient -->
                                        <div>
                                            <label
                                                style="display: block; font-size: 12px; font-weight: 700; color: #64748b; margin-bottom: 8px;">1.
                                                Select Patient</label>
                                            <select name="patientId" required
                                                style="width: 100%; padding: 12px; border-radius: 12px; border: 1px solid #e2e8f0; font-size: 14px; outline: none; background: #f8fafc;">
                                                <option value="" disabled selected>Choose a patient...</option>
                                                <c:forEach items="${patients}" var="p">
                                                    <option value="${p.id}">${p.name} (ID: ${p.id})</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <!-- Nutrition Goals -->
                                        <div
                                            style="background: #f0fdf4; padding: 16px; border-radius: 16px; border: 1px solid #dcfce7;">
                                            <label
                                                style="display: block; font-size: 12px; font-weight: 700; color: #166534; margin-bottom: 12px; text-transform: uppercase;">2.
                                                Nutrition Plan</label>
                                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                                                <div style="position: relative;">
                                                    <label
                                                        style="font-size: 10px; color: #166534; font-weight: 600; position: absolute; top: -6px; left: 8px; background: #f0fdf4; padding: 0 4px;">Breakfast</label>
                                                    <select name="breakfast" required
                                                        style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #bdfdc9; font-size: 13px; background: #fff; outline: none;">
                                                        <option value="Oats with Fruits">Oats with Fruits</option>
                                                        <option value="Greek Yogurt & Nuts">Greek Yogurt & Nuts</option>
                                                        <option value="Berry Smoothie Bowl">Berry Smoothie Bowl</option>
                                                        <option value="Avocado Toast & Egg">Avocado Toast & Egg</option>
                                                        <option value="Spinach Omelette">Spinach Omelette</option>
                                                    </select>
                                                </div>
                                                <div style="position: relative;">
                                                    <label
                                                        style="font-size: 10px; color: #166534; font-weight: 600; position: absolute; top: -6px; left: 8px; background: #f0fdf4; padding: 0 4px;">Lunch</label>
                                                    <select name="lunch" required
                                                        style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #bdfdc9; font-size: 13px; background: #fff; outline: none;">
                                                        <option value="Grilled Chicken Salad">Grilled Chicken Salad
                                                        </option>
                                                        <option value="Quinoa & Veggie Bowl">Quinoa & Veggie Bowl
                                                        </option>
                                                        <option value="Lentil Soup & Salad">Lentil Soup & Salad</option>
                                                        <option value="Brown Rice & Steamed Fish">Brown Rice & Steamed
                                                            Fish</option>
                                                        <option value="Chickpea Wrap">Chickpea Wrap</option>
                                                    </select>
                                                </div>
                                                <div style="position: relative;">
                                                    <label
                                                        style="font-size: 10px; color: #166534; font-weight: 600; position: absolute; top: -6px; left: 8px; background: #f0fdf4; padding: 0 4px;">Dinner</label>
                                                    <select name="dinner" required
                                                        style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #bdfdc9; font-size: 13px; background: #fff; outline: none;">
                                                        <option value="Baked Tofu & Broccoli">Baked Tofu & Broccoli
                                                        </option>
                                                        <option value="Roasted Salmon & Asparagus">Roasted Salmon &
                                                            Asparagus</option>
                                                        <option value="Turkey & Veggie Chili">Turkey & Veggie Chili
                                                        </option>
                                                        <option value="Zucchini Noodles with Pesto">Zucchini Noodles
                                                            with Pesto</option>
                                                        <option value="Steamed Veggies & Paneer">Steamed Veggies &
                                                            Paneer</option>
                                                    </select>
                                                </div>
                                                <div style="position: relative;">
                                                    <label
                                                        style="font-size: 10px; color: #166534; font-weight: 600; position: absolute; top: -6px; left: 8px; background: #f0fdf4; padding: 0 4px;">Healthy
                                                        Drinks</label>
                                                    <select name="drinks" required
                                                        style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #bdfdc9; font-size: 13px; background: #fff; outline: none;">
                                                        <option value="Green Tea">Green Tea</option>
                                                        <option value="Lemon & Chia Water">Lemon & Chia Water</option>
                                                        <option value="Fresh Coconut Water">Fresh Coconut Water</option>
                                                        <option value="Herbal Infusion">Herbal Infusion</option>
                                                        <option value="Fresh Pomegranate Juice">Fresh Pomegranate Juice
                                                        </option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Activity Goals -->
                                        <div
                                            style="background: #eff6ff; padding: 16px; border-radius: 16px; border: 1px solid #dbeafe;">
                                            <label
                                                style="display: block; font-size: 12px; font-weight: 700; color: #1e40af; margin-bottom: 12px; text-transform: uppercase;">3.
                                                Activity & Analysis</label>
                                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                                                <div style="position: relative;">
                                                    <label
                                                        style="font-size: 10px; color: #1e40af; font-weight: 600; position: absolute; top: -6px; left: 8px; background: #eff6ff; padding: 0 4px;">Daily
                                                        Steps Target</label>
                                                    <input type="number" name="steps" value="8000" min="1000" step="500"
                                                        style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #bfdbfe; font-size: 13px; outline: none;">
                                                </div>
                                                <div style="position: relative;">
                                                    <label
                                                        style="font-size: 10px; color: #1e40af; font-weight: 600; position: absolute; top: -6px; left: 8px; background: #eff6ff; padding: 0 4px;">Daily
                                                        Workout (Min)</label>
                                                    <input type="number" name="exercise" value="20" min="5" step="5"
                                                        style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #bfdbfe; font-size: 13px; outline: none;">
                                                </div>
                                                <div style="position: relative;">
                                                    <label
                                                        style="font-size: 10px; color: #1e40af; font-weight: 600; position: absolute; top: -6px; left: 8px; background: #eff6ff; padding: 0 4px;">Diet
                                                        Adherence (%)</label>
                                                    <input type="number" name="dietScore" value="75" min="0" max="100"
                                                        style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #bfdbfe; font-size: 13px; outline: none;">
                                                </div>
                                                <div style="position: relative;">
                                                    <label
                                                        style="font-size: 10px; color: #1e40af; font-weight: 600; position: absolute; top: -6px; left: 8px; background: #eff6ff; padding: 0 4px;">Exercise
                                                        Intensity (%)</label>
                                                    <input type="number" name="exerciseScore" value="75" min="0"
                                                        max="100"
                                                        style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #bfdbfe; font-size: 13px; outline: none;">
                                                </div>
                                                <div style="position: relative;">
                                                    <label
                                                        style="font-size: 10px; color: #1e40af; font-weight: 600; position: absolute; top: -6px; left: 8px; background: #eff6ff; padding: 0 4px;">Diet
                                                        Duration (Days)</label>
                                                    <input type="number" name="duration" value="7" min="1" max="100"
                                                        style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #bfdbfe; font-size: 13px; outline: none;">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div style="display: flex; justify-content: flex-end;">
                                        <button type="submit"
                                            style="padding: 12px 32px; background: linear-gradient(135deg, #10b981, #059669); color: #fff; border: none; border-radius: 12px; font-weight: 700; font-size: 14px; cursor: pointer; transition: all 0.3s ease; box-shadow: 0 4px 12px rgba(16,185,129,0.2);">🚀
                                            Prescribe Diet & Health Plan</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- 2. Disease Outbreak Monitor Section -->
                        <div class="data-table-wrapper"
                            style="position: relative; overflow: hidden; margin-bottom: 32px;">
                            <div
                                style="position: absolute; top: 0; right: 0; width: 160px; height: 160px; background: linear-gradient(135deg, rgba(239,68,68,0.05), rgba(249,115,22,0.05)); border-radius: 0 0 0 100%; pointer-events: none;">
                            </div>
                            <div class="table-header">
                                <h3>🦠 Disease Outbreak Monitor</h3>
                            </div>
                            <div style="padding: 24px;">
                                <p style="color: #64748b; font-size: 13px; margin-bottom: 20px;">Real-time aggregated
                                    disease surveillance data. No personal patient information is displayed.</p>

                                <!-- Manual Reporting Form -->
                                <div
                                    style="background: linear-gradient(135deg, rgba(15,111,255,0.05), rgba(6,182,212,0.05)); border-radius: 16px; padding: 20px; border: 1px solid rgba(15,111,255,0.1); margin-bottom: 24px; display: flex; align-items: center; gap: 16px; flex-wrap: wrap;">
                                    <div style="flex: 1; min-width: 200px;">
                                        <label
                                            style="display: block; font-size: 11px; font-weight: 700; color: #64748b; text-transform: uppercase; margin-bottom: 6px;">Report
                                            Disease Case</label>
                                        <div style="display: flex; gap: 10px;">
                                            <input type="text" id="manualDisease" placeholder="Disease (e.g. Flu)"
                                                style="flex: 1; padding: 10px; border-radius: 10px; border: 1px solid #e2e8f0; font-size: 13px;">
                                            <select id="manualCity"
                                                style="flex: 1.5; padding: 10px; border-radius: 10px; border: 1px solid #e2e8f0; font-size: 13px;">
                                                <option value="" disabled selected>Select State / Region</option>
                                                <option value="Maharashtra">Maharashtra</option>
                                                <option value="Delhi">Delhi</option>
                                                <option value="Karnataka">Karnataka</option>
                                                <option value="Telangana">Telangana</option>
                                                <option value="Tamil Nadu">Tamil Nadu</option>
                                                <option value="West Bengal">West Bengal</option>
                                                <option value="Gujarat">Gujarat</option>
                                                <option value="Uttar Pradesh">Uttar Pradesh</option>
                                                <option value="Rajasthan">Rajasthan</option>
                                                <option value="Kerala">Kerala</option>
                                                <option value="Punjab">Punjab</option>
                                                <option value="Haryana">Haryana</option>
                                                <option value="Madhya Pradesh">Madhya Pradesh</option>
                                                <option value="Bihar">Bihar</option>
                                                <option value="Odisha">Odisha</option>
                                                <option value="Andhra Pradesh">Andhra Pradesh</option>
                                                <option value="Assam">Assam</option>
                                                <option value="Chhattisgarh">Chhattisgarh</option>
                                                <option value="Jharkhand">Jharkhand</option>
                                                <option value="Uttarakhand">Uttarakhand</option>
                                                <option value="Himachal Pradesh">Himachal Pradesh</option>
                                                <option value="Goa">Goa</option>
                                            </select>
                                            <input type="number" id="manualCount" value="1" min="1"
                                                style="width: 70px; padding: 10px; border-radius: 10px; border: 1px solid #e2e8f0; font-size: 13px; text-align: center;">
                                        </div>
                                    </div>
                                    <button id="manualReportBtn" onclick="reportManualDisease()"
                                        style="padding: 12px 24px; background: linear-gradient(135deg, #0F6FFF, #06B6D4); color: #fff; border: none; border-radius: 10px; font-weight: 700; font-size: 13px; cursor: pointer; transition: all 0.3s ease; align-self: flex-end;">🚀
                                        Report Case</button>
                                </div>

                                <!-- Alerts Row -->
                                <div id="doctorAlerts"
                                    style="display: flex; flex-wrap: wrap; gap: 12px; margin-bottom: 24px;"></div>

                                <!-- Charts Row -->
                                <div
                                    style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 24px;">
                                    <div
                                        style="background: #f8fafc; border-radius: 16px; padding: 20px; border: 1px solid #e2e8f0;">
                                        <h4 style="margin-bottom: 12px; font-size: 14px; color: #475569;">📊 Cases by
                                            Disease</h4>
                                        <canvas id="doctorDiseaseChart" height="200"></canvas>
                                    </div>
                                    <div
                                        style="background: #f8fafc; border-radius: 16px; padding: 20px; border: 1px solid #e2e8f0;">
                                        <h4 style="margin-bottom: 12px; font-size: 14px; color: #475569;">🗺️ Cases by
                                            State</h4>
                                        <canvas id="doctorCityChart" height="200"></canvas>
                                    </div>
                                </div>

                                <!-- Table Breakdown -->
                                <h4 style="margin-bottom: 12px; font-size: 14px; color: #475569;">📋 Detailed Breakdown
                                    (Top 10)</h4>
                                <div class="table-responsive"><table class="data-table" id="breakdownTable">
                                    <thead>
                                        <tr>
                                            <th>Disease</th>
                                            <th>State</th>
                                            <th>Cases</th>
                                        </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table></div>
                                <p style="color: #94a3b8; font-size: 11px; margin-top: 12px; text-align: center;">📊
                                    Aggregated anonymous data • Last 30 days • Updated in real-time</p>
                            </div>
                        </div>

                    </div>
                </main>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
            <script>
                var diseaseChart, cityChart;

                function loadDiseaseTrends() {
                    fetch('${pageContext.request.contextPath}/doctor/disease-trends')
                        .then(r => r.json())
                        .then(data => { if (!data.error) updateDiseaseUI(data); })
                        .catch(() => { });
                }

                function updateDiseaseUI(data) {
                    var alertsDiv = document.getElementById('doctorAlerts');
                    alertsDiv.innerHTML = '';
                    var cfgMap = { RISING: ['#fef2f2', '#dc2626', '🔺'], FALLING: ['#f0fdf4', '#16a34a', '🔻'], STABLE: ['#f8fafc', '#64748b', '➡️'] };
                    (data.alerts || []).forEach(a => {
                        var cfg = cfgMap[a.trend] || cfgMap.STABLE;
                        alertsDiv.innerHTML += `<div style="flex:1; min-width:140px; padding:12px; border-radius:12px; background:\${cfg[0]}; border:1px solid \${cfg[1]}22">`
                            + `<div style="font-size:13px; font-weight:700; color:\${cfg[1]}">\${cfg[2]} \${a.disease}</div>`
                            + `<div style="font-size:11px; color:#64748b">\${a.recentCases} cases • \${a.trend}</div></div>`;
                    });

                    var dLabels = (data.diseases || []).map(d => d.name);
                    var dValues = (data.diseases || []).map(d => d.count);
                    var colors = ['#ef4444', '#f97316', '#eab308', '#22c55e', '#3b82f6', '#8b5cf6'];

                    if (diseaseChart) diseaseChart.destroy();
                    diseaseChart = new Chart(document.getElementById('doctorDiseaseChart'), {
                        type: 'bar',
                        data: { labels: dLabels, datasets: [{ label: 'Cases', data: dValues, backgroundColor: colors.map(c => c + '22'), borderColor: colors, borderWidth: 2, borderRadius: 6 }] },
                        options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true } } }
                    });

                    var cLabels = (data.cities || []).map(c => c.name);
                    var cValues = (data.cities || []).map(c => c.count);
                    if (cityChart) cityChart.destroy();
                    cityChart = new Chart(document.getElementById('doctorCityChart'), {
                        type: 'doughnut',
                        data: { labels: cLabels, datasets: [{ data: cValues, backgroundColor: colors, borderWidth: 2, borderColor: '#fff' }] },
                        options: { responsive: true, plugins: { legend: { position: 'bottom', labels: { boxWidth: 10, font: { size: 10 } } } } }
                    });

                    var tbody = document.querySelector('#breakdownTable tbody');
                    tbody.innerHTML = '';
                    (data.breakdown || []).slice(0, 10).forEach(row => {
                        tbody.innerHTML += `<tr><td>\${row.disease}</td><td>\${row.city}</td><td style="font-weight:600">\${row.count}</td></tr>`;
                    });
                }

                function reportManualDisease() {
                    var disease = document.getElementById('manualDisease').value;
                    var city = document.getElementById('manualCity').value;
                    var count = document.getElementById('manualCount').value;
                    if (!disease || !city) { alert('Please enter disease and select region'); return; }

                    var btn = document.getElementById('manualReportBtn');
                    var orig = btn.innerHTML;
                    btn.disabled = true; btn.innerHTML = 'Reporting...';

                    var params = new URLSearchParams();
                    params.append('disease', disease); params.append('city', city); params.append('count', count);

                    fetch('${pageContext.request.contextPath}/doctor/report-disease', { method: 'POST', body: params })
                        .then(r => r.json())
                        .then(data => {
                            btn.disabled = false; btn.innerHTML = orig;
                            if (data.error) { alert(data.error); return; }
                            document.getElementById('manualDisease').value = '';
                            updateDiseaseUI(data);
                            showToast('Report successful!');
                        }).catch(() => { btn.disabled = false; btn.innerHTML = orig; });
                }

                function showToast(msg) {
                    var t = document.createElement('div');
                    t.style = 'position:fixed;bottom:20px;right:20px;background:#10b981;color:#fff;padding:12px 24px;border-radius:12px;z-index:9999;box-shadow:0 10px 20px rgba(0,0,0,0.1);font-weight:700;';
                    t.innerHTML = '✅ ' + msg;
                    document.body.appendChild(t);
                    setTimeout(() => t.remove(), 3000);
                }

                document.addEventListener('DOMContentLoaded', loadDiseaseTrends);
            </script>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

