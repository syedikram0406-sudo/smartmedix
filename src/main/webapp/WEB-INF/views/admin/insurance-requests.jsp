<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Insurance Claims - Admin Panel</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                .actions {
                    display: flex;
                    gap: 8px;
                }

                .btn-verify {
                    background: #dcfce7;
                    color: #166534;
                    padding: 6px 12px;
                    border-radius: 6px;
                    border: none;
                    cursor: pointer;
                    font-weight: 600;
                }

                .btn-reject {
                    background: #fee2e2;
                    color: #991b1b;
                    padding: 6px 12px;
                    border-radius: 6px;
                    border: none;
                    cursor: pointer;
                    font-weight: 600;
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
                        <li><a href="${pageContext.request.contextPath}/admin/insurance-requests" class="active"><span
                                    class="nav-icon">🛡️</span> Insurance Claims</a></li>
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
                        <h1>Insurance Claims & Verifications</h1>
                        <p>Review and verify patient insurance coverage details.</p>
                    </div>

                    <div class="data-table-wrapper">
                        <div class="table-responsive"><table class="data-table">
                            <c:set var="hasPending" value="false" />
                            <c:forEach items="${insurances}" var="insCheck">
                                <c:if test="${insCheck.status == 'Pending'}">
                                    <c:set var="hasPending" value="true" />
                                </c:if>
                            </c:forEach>
                            <thead>
                                <tr>
                                    <th>Patient</th>
                                    <th>Provider</th>
                                    <th>Policy Number</th>
                                    <th>Coverage (₹)</th>
                                    <th>Expiry</th>
                                    <th>Card</th>
                                    <th>Status</th>
                                    <c:if test="${hasPending}">
                                        <th>Action</th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${insurances}" var="ins">
                                    <tr>
                                        <td>${ins.patient.name}</td>
                                        <td>${ins.provider}</td>
                                        <td>${ins.policyNumber}</td>
                                        <td style="font-weight: 600;">₹${ins.coverageAmount}</td>
                                        <td>${ins.expiryDate}</td>
                                        <td>
                                            <c:if test="${not empty ins.cardImageUrl}">
                                                <a href="${pageContext.request.contextPath}${ins.cardImageUrl}"
                                                    target="_blank" style="color: #0f6fff; font-size: 13px;">View
                                                    Card</a>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span
                                                class="badge badge-${ins.status == 'Verified' ? 'completed' : ins.status == 'Rejected' ? 'cancelled' : 'pending'}">${ins.status}</span>
                                        </td>
                                        <c:if test="${hasPending}">
                                            <td>
                                                <c:if test="${ins.status == 'Pending'}">
                                                    <div class="actions">
                                                        <form method="post"
                                                            action="${pageContext.request.contextPath}/admin/insurance/status"
                                                            style="display:inline;">
                                                            <input type="hidden" name="id" value="${ins.id}">
                                                            <input type="hidden" name="status" value="Verified">
                                                            <button type="submit" class="btn-verify">Verify</button>
                                                        </form>
                                                        <form method="post"
                                                            action="${pageContext.request.contextPath}/admin/insurance/status"
                                                            style="display:inline;">
                                                            <input type="hidden" name="id" value="${ins.id}">
                                                            <input type="hidden" name="status" value="Rejected">
                                                            <button type="submit" class="btn-reject">Reject</button>
                                                        </form>
                                                    </div>
                                                </c:if>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table></div>
                    </div>
                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

