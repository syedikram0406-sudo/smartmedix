<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>My Insurance - SmartMedix</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                .insurance-form-card {
                    background: #fff;
                    border-radius: 20px;
                    padding: 32px;
                    box-shadow: 0 4px 25px rgba(0, 0, 0, 0.04);
                    border: 1px solid rgba(15, 111, 255, 0.08);
                    margin-bottom: 32px;
                }

                .insurance-list {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                    gap: 24px;
                }

                .insurance-card {
                    background: linear-gradient(145deg, #ffffff, #f8fafc);
                    border-radius: 16px;
                    padding: 24px;
                    border: 1px solid #e2e8f0;
                    box-shadow: 0 10px 25px rgba(0,0,0,0.03);
                    transition: transform 0.3s ease;
                    position: relative;
                }

                .insurance-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 15px 35px rgba(15, 111, 255, 0.1);
                    border-color: rgba(15, 111, 255, 0.2);
                }

                .insurance-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                    margin-bottom: 20px;
                }

                .provider-name {
                    font-size: 20px;
                    font-weight: 800;
                    color: #1e293b;
                    margin: 0;
                }

                .policy-no {
                    font-size: 13px;
                    color: #64748b;
                    margin-top: 4px;
                }

                .status-badge {
                    padding: 6px 14px;
                    border-radius: 20px;
                    font-size: 12px;
                    font-weight: 700;
                }

                .status-badge.pending {
                    background: #fef3c7;
                    color: #d97706;
                }

                .status-badge.verified {
                    background: #dcfce7;
                    color: #16a34a;
                }

                .status-badge.rejected {
                    background: #fee2e2;
                    color: #dc2626;
                }

                .coverage-amt {
                    font-size: 28px;
                    font-weight: 800;
                    color: #0f6fff;
                    margin-bottom: 12px;
                }

                .expiry {
                    font-size: 13px;
                    color: #64748b;
                    display: flex;
                    align-items: center;
                    gap: 6px;
                }

                .btn-view-card {
                    margin-top: 16px;
                    display: inline-block;
                    padding: 8px 16px;
                    background: #f1f5f9;
                    color: #334155;
                    border-radius: 8px;
                    text-decoration: none;
                    font-size: 13px;
                    font-weight: 600;
                    transition: 0.2s;
                    border: 1px solid #e2e8f0;
                }

                .btn-view-card:hover {
                    background: #e2e8f0;
                    color: #0f6fff;
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
                        <li><a href="${pageContext.request.contextPath}/patient/dashboard"><span class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/book-appointment"><span class="nav-icon">📅</span> Book Appointment</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/bills"><span class="nav-icon">💳</span> My Bills</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/my-appointments"><span class="nav-icon">📋</span> My Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/medical-records"><span class="nav-icon">📁</span> Medical Records</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/lab-reports"><span class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/patient/insurance" class="active"><span class="nav-icon">🛡️</span> My Insurance</a></li>
                    </ul>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Insurance Management</h1>
                        <p>Track and manage your medical insurance coverages</p>
                    </div>

                    <c:if test="${param.success == 'true'}">
                        <div class="alert alert-success">✅ Insurance request submitted successfully! It is now pending admin verification.</div>
                    </c:if>

                    <div class="insurance-form-card">
                        <h3>➕ Add New Insurance</h3>
                        <p style="color: #64748b; margin-bottom: 24px;">Enter your provider details to apply coverage for upcoming bills.</p>
                        
                        <form action="${pageContext.request.contextPath}/patient/insurance/add" method="post" enctype="multipart/form-data">
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Insurance Provider Name</label>
                                    <select name="provider" required style="width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px; font-size: 14px; color: #1e293b; background-color: #f8fafc;">
                                        <option value="" disabled selected>Select an Insurance Provider</option>
                                        <option value="Star Health Insurance">Star Health Insurance</option>
                                        <option value="Life Insurance Corporation (LIC)">Life Insurance Corporation (LIC)</option>
                                        <option value="Aetna Health">Aetna Health</option>
                                        <option value="Other">Other</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Policy Number</label>
                                    <input type="text" name="policyNumber" placeholder="Enter policy ID" required>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Total Coverage Amount (₹)</label>
                                    <input type="number" name="coverageAmount" placeholder="e.g. 500000" required>
                                </div>
                                <div class="form-group">
                                    <label>Expiry Date</label>
                                    <input type="date" name="expiryDate" required>
                                </div>
                            </div>

                            <div class="form-group" style="margin-bottom: 24px;">
                                <label>Upload Insurance Card (Image)</label>
                                <input type="file" name="cardImage" accept="image/*" required style="padding: 10px; background: #f8fafc; border-radius: 8px; border: 1px dashed #cbd5e1; width: 100%;">
                            </div>

                            <button type="submit" class="btn-primary" style="max-width: 250px;">Submit for Verification</button>
                        </form>
                    </div>

                    <h3 style="margin-bottom: 20px;">🛡️ Your Active Policies</h3>
                    <div class="insurance-list">
                        <c:forEach items="${insurances}" var="ins">
                            <div class="insurance-card">
                                <div class="insurance-header">
                                    <div>
                                        <h4 class="provider-name">${ins.provider}</h4>
                                        <p class="policy-no">Policy: ${ins.policyNumber}</p>
                                    </div>
                                    <span class="status-badge ${ins.status == 'Pending' ? 'pending' : ins.status == 'Verified' ? 'verified' : 'rejected'}">${ins.status}</span>
                                </div>
                                
                                <div class="coverage-amt">₹${ins.coverageAmount}</div>
                                <div class="expiry">📅 Valid till: ${ins.expiryDate}</div>

                                <c:if test="${not empty ins.cardImageUrl}">
                                    <a href="${pageContext.request.contextPath}${ins.cardImageUrl}" target="_blank" class="btn-view-card">👁️ View Insurance Card</a>
                                </c:if>
                            </div>
                        </c:forEach>

                        <c:if test="${empty insurances}">
                            <div class="empty-state" style="grid-column: 1 / -1; padding: 40px; text-align: center; border: 1px dashed #cbd5e1; border-radius: 16px;">
                                <span style="font-size: 40px; display: block; margin-bottom: 12px;">📄</span>
                                <h4>No insurance records found</h4>
                                <p style="color: #64748b;">Add your insurance details above to start claiming coverage.</p>
                            </div>
                        </c:if>
                    </div>

                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>
        </html>


