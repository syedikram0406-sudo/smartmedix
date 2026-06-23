<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Scan Patient QR - SmartMedix</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                .qr-scan-wrapper {
                    max-width: 560px;
                    margin: 0 auto;
                }

                .qr-scan-card {
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(12px);
                    border-radius: 24px;
                    padding: 48px 40px;
                    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.06);
                    border: 1px solid rgba(15, 111, 255, 0.08);
                    text-align: center;
                    position: relative;
                    overflow: hidden;
                }

                .qr-scan-card::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    height: 5px;
                    background: linear-gradient(90deg, #0f6fff, #6c63ff, #06b6d4);
                }

                .scan-icon-wrapper {
                    width: 80px;
                    height: 80px;
                    background: linear-gradient(135deg, #0f6fff, #6c63ff);
                    border-radius: 20px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin: 0 auto 24px;
                    font-size: 36px;
                    box-shadow: 0 8px 24px rgba(15, 111, 255, 0.25);
                }

                .scan-title {
                    font-size: 24px;
                    font-weight: 800;
                    color: #1e293b;
                    margin-bottom: 8px;
                }

                .scan-subtitle {
                    color: #64748b;
                    font-size: 14px;
                    margin-bottom: 32px;
                    line-height: 1.5;
                }

                .token-input {
                    width: 100%;
                    padding: 16px 20px;
                    border: 2px solid #e2e8f0;
                    border-radius: 14px;
                    font-size: 16px;
                    font-family: monospace;
                    text-align: center;
                    letter-spacing: 1px;
                    transition: all 0.3s ease;
                    outline: none;
                    box-sizing: border-box;
                }

                .token-input:focus {
                    border-color: #0f6fff;
                    box-shadow: 0 0 0 4px rgba(15, 111, 255, 0.1);
                }

                .btn-verify-token {
                    width: 100%;
                    padding: 16px;
                    background: linear-gradient(135deg, #0f6fff 0%, #6c63ff 100%);
                    color: #fff;
                    border: none;
                    border-radius: 14px;
                    font-size: 16px;
                    font-weight: 700;
                    cursor: pointer;
                    margin-top: 20px;
                    transition: all 0.3s ease;
                }

                .btn-verify-token:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(15, 111, 255, 0.3);
                }

                .error-alert {
                    background: linear-gradient(135deg, #fee2e2, #fecaca);
                    color: #991b1b;
                    padding: 14px 20px;
                    border-radius: 12px;
                    font-weight: 600;
                    font-size: 14px;
                    margin-bottom: 24px;
                    display: flex;
                    align-items: center;
                    gap: 10px;
                }

                .security-badges {
                    display: flex;
                    justify-content: center;
                    gap: 16px;
                    margin-top: 28px;
                    flex-wrap: wrap;
                }

                .security-badge {
                    display: flex;
                    align-items: center;
                    gap: 6px;
                    padding: 6px 14px;
                    background: #f1f5f9;
                    border-radius: 20px;
                    font-size: 11px;
                    font-weight: 600;
                    color: #64748b;
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
                        <li><a href="${pageContext.request.contextPath}/doctor/dashboard"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/appointments"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/prescription"><span
                                    class="nav-icon">💊</span> Prescriptions</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/lab-request"><span
                                    class="nav-icon">🧪</span> Lab Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/consultation-notes"><span
                                    class="nav-icon">📋</span> Consultation Notes</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/qr/scan" class="active"><span
                                    class="nav-icon">📱</span> Scan QR</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>

                <main class="main-content">
                    <div class="page-header">
                        <h1>📱 Scan Patient QR Code</h1>
                        <p>Enter the patient's secure QR token to access their medical records</p>
                    </div>

                    <div class="qr-scan-wrapper">
                        <div class="qr-scan-card">
                            <div class="scan-icon-wrapper">📱</div>
                            <h2 class="scan-title">Verify Patient Token</h2>
                            <p class="scan-subtitle">Ask the patient to generate a QR code from their dashboard, then
                                enter the token shown below the QR code here.</p>

                            <c:if test="${not empty qrError}">
                                <div class="error-alert">
                                    ⚠️ ${qrError}
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/doctor/qr/verify" method="post">
                                <input type="text" name="token" class="token-input"
                                    placeholder="Paste patient token here..." required autocomplete="off">
                                <button type="submit" class="btn-verify-token">🔓 Verify & Access Records</button>
                            </form>

                            <div class="security-badges">
                                <div class="security-badge">🔒 Encrypted</div>
                                <div class="security-badge">⏱️ Time-Limited</div>
                                <div class="security-badge">🔑 Single-Use</div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

