<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Hospital Bed Management - Admin Panel</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                .bed-grid {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr);
                    gap: 12px;
                    margin: 16px 0;
                }

                .bed-card {
                    background: #f8fafc;
                    border-radius: 12px;
                    padding: 14px;
                    text-align: center;
                    border: 1px solid #e2e8f0;
                }

                .bed-card.icu {
                    border-left: 4px solid #ef4444;
                }

                .bed-card.oxygen {
                    border-left: 4px solid #3b82f6;
                }

                .bed-card.general {
                    border-left: 4px solid #22c55e;
                }

                .bed-card .bed-type {
                    font-size: 11px;
                    font-weight: 700;
                    text-transform: uppercase;
                    color: #64748b;
                    letter-spacing: 0.5px;
                }

                .bed-card .bed-count {
                    font-size: 24px;
                    font-weight: 800;
                    margin: 4px 0;
                }

                .bed-card .bed-total {
                    font-size: 11px;
                    color: #94a3b8;
                }

                .bed-card.icu .bed-count {
                    color: #ef4444;
                }

                .bed-card.oxygen .bed-count {
                    color: #3b82f6;
                }

                .bed-card.general .bed-count {
                    color: #22c55e;
                }

                .hospital-card {
                    background: #fff;
                    border-radius: 16px;
                    padding: 24px;
                    margin-bottom: 20px;
                    border: 1px solid #e2e8f0;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
                }

                .hospital-card h4 {
                    font-size: 18px;
                    margin-bottom: 4px;
                    color: #1e293b;
                }

                .hospital-meta {
                    font-size: 13px;
                    color: #64748b;
                    margin-bottom: 12px;
                }

                .update-form {
                    display: grid;
                    grid-template-columns: repeat(3, 1fr) auto;
                    gap: 12px;
                    align-items: end;
                    margin-top: 16px;
                    padding-top: 16px;
                    border-top: 1px solid #f1f5f9;
                }

                .update-form label {
                    font-size: 11px;
                    font-weight: 700;
                    color: #64748b;
                    text-transform: uppercase;
                    display: block;
                    margin-bottom: 4px;
                }

                .update-form input {
                    width: 100%;
                    padding: 8px 12px;
                    border: 2px solid #e2e8f0;
                    border-radius: 8px;
                    font-size: 14px;
                    box-sizing: border-box;
                }

                .update-form input:focus {
                    border-color: #0f6fff;
                    outline: none;
                }

                .btn-update {
                    padding: 10px 20px;
                    background: linear-gradient(135deg, #0f6fff, #6c63ff);
                    color: #fff;
                    border: none;
                    border-radius: 8px;
                    font-weight: 700;
                    cursor: pointer;
                    font-size: 13px;
                }

                .btn-update:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 4px 12px rgba(15, 111, 255, 0.3);
                }

                .last-updated {
                    font-size: 11px;
                    color: #94a3b8;
                    margin-top: 8px;
                }
            </style>
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🏥 HMS Admin</h3>
                        <div class="role-badge">Admin Panel</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/doctors"><span
                                    class="nav-icon">👨‍⚕️</span> Doctors</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/patients"><span
                                    class="nav-icon">🧑‍🤝‍🧑</span> Patients</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/appointments"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/transactions"><span
                                    class="nav-icon">💸</span> Transactions</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/insurance-requests"><span
                                    class="nav-icon">🛡️</span> Insurance Claims</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/analytics"><span
                                    class="nav-icon">📈</span> Analytics</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/complaints"><span
                                    class="nav-icon">📝</span> Complaints</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/hospitals" class="active"><span
                                    class="nav-icon">🛏️</span> Bed Availability</a></li>
                    </ul>
                    <div class="sidebar-footer">
                        <a href="${pageContext.request.contextPath}/auth/logout"><span class="nav-icon">🚪</span>
                            Logout</a>
                    </div>
                </aside>

                <main class="main-content">
                    <div class="page-header">
                        <h1>🛏️ Hospital Bed Availability Management</h1>
                        <p>Update real-time bed availability for all hospitals in the network.</p>
                    </div>

                    <c:forEach items="${hospitals}" var="h">
                        <div class="hospital-card">
                            <h4>🏥 ${h.name}</h4>
                            <div class="hospital-meta">📍 ${h.area}, ${h.city} &nbsp;|&nbsp; 📞 ${h.phone} &nbsp;|&nbsp;
                                ✉️ ${h.email}</div>

                            <div class="bed-grid">
                                <div class="bed-card icu">
                                    <div class="bed-type">🔴 ICU Beds</div>
                                    <div class="bed-count">${h.icuBedsAvailable}</div>
                                    <div class="bed-total">of ${h.icuBedsTotal} total</div>
                                </div>
                                <div class="bed-card oxygen">
                                    <div class="bed-type">🔵 Oxygen Beds</div>
                                    <div class="bed-count">${h.oxygenBedsAvailable}</div>
                                    <div class="bed-total">of ${h.oxygenBedsTotal} total</div>
                                </div>
                                <div class="bed-card general">
                                    <div class="bed-type">🟢 General Beds</div>
                                    <div class="bed-count">${h.generalBedsAvailable}</div>
                                    <div class="bed-total">of ${h.generalBedsTotal} total</div>
                                </div>
                            </div>

                            <form action="${pageContext.request.contextPath}/admin/hospitals/update-beds" method="post"
                                class="update-form">
                                <input type="hidden" name="id" value="${h.id}">
                                <div>
                                    <label>ICU Available</label>
                                    <input type="number" name="icuBedsAvailable" value="${h.icuBedsAvailable}" min="0"
                                        max="${h.icuBedsTotal}">
                                </div>
                                <div>
                                    <label>Oxygen Available</label>
                                    <input type="number" name="oxygenBedsAvailable" value="${h.oxygenBedsAvailable}"
                                        min="0" max="${h.oxygenBedsTotal}">
                                </div>
                                <div>
                                    <label>General Available</label>
                                    <input type="number" name="generalBedsAvailable" value="${h.generalBedsAvailable}"
                                        min="0" max="${h.generalBedsTotal}">
                                </div>
                                <button type="submit" class="btn-update">Update 🔄</button>
                            </form>
                            <div class="last-updated">Last updated: ${h.lastUpdated}</div>
                        </div>
                    </c:forEach>
                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

