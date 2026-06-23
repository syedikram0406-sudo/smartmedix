<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.functions" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>My Bills - SmartMedix</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
                <style>
                    .billing-wrapper {
                        background: rgba(255, 255, 255, 0.9);
                        backdrop-filter: blur(10px);
                        border-radius: 20px;
                        padding: 32px;
                        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
                        border: 1px solid rgba(15, 111, 255, 0.1);
                        margin-top: 24px;
                    }

                    .bill-table {
                        width: 100%;
                        border-collapse: separate;
                        border-spacing: 0 12px;
                    }

                    .bill-table th {
                        text-align: left;
                        padding: 12px 20px;
                        color: #64748b;
                        font-weight: 600;
                        text-transform: uppercase;
                        font-size: 12px;
                        letter-spacing: 0.05em;
                    }

                    .bill-row {
                        background: #fff;
                        transition: all 0.3s ease;
                        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.02);
                    }

                    .bill-row:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                    }

                    .bill-row td {
                        padding: 20px;
                        border-top: 1px solid #f1f5f9;
                        border-bottom: 1px solid #f1f5f9;
                    }

                    .bill-row td:first-child {
                        border-left: 1px solid #f1f5f9;
                        border-top-left-radius: 12px;
                        border-bottom-left-radius: 12px;
                    }

                    .bill-row td:last-child {
                        border-right: 1px solid #f1f5f9;
                        border-top-right-radius: 12px;
                        border-bottom-right-radius: 12px;
                    }

                    .status-pill {
                        padding: 6px 12px;
                        border-radius: 20px;
                        font-size: 11px;
                        font-weight: 700;
                        text-transform: uppercase;
                    }

                    .status-pill.unpaid {
                        background: #fee2e2;
                        color: #991b1b;
                    }

                    .status-pill.paid {
                        background: #dcfce7;
                        color: #166534;
                    }

                    .btn-pay {
                        background: linear-gradient(135deg, #0f6fff 0%, #6c63ff 100%);
                        color: #fff;
                        padding: 8px 16px;
                        border-radius: 8px;
                        text-decoration: none;
                        font-size: 13px;
                        font-weight: 600;
                        transition: 0.3s;
                    }

                    .btn-pay:hover {
                        opacity: 0.9;
                        transform: scale(1.05);
                    }

                    .btn-receipt {
                        color: #0f6fff;
                        text-decoration: none;
                        font-size: 13px;
                        font-weight: 600;
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
                            <li><a href="${pageContext.request.contextPath}/patient/bills" class="active"><span
                                        class="nav-icon">💳</span> My Bills</a></li>
                            <li><a href="${pageContext.request.contextPath}/patient/medical-records"><span
                                        class="nav-icon">📁</span> Medical Records</a></li>
                        </ul>
                    </aside>

                    <main class="main-content">
                        <div class="page-header">
                            <h1>Billing & Payments</h1>
                            <p>Manage your consultation and lab test invoices</p>
                        </div>

                        <c:if test="${param.payment == 'success'}">
                            <div class="alert alert-success" style="margin-bottom: 24px;">
                                ✨ Payment successful! Transaction ID: <strong>${param.txnId}</strong>
                            </div>
                        </c:if>

                        <div class="billing-wrapper">
                            <h3>📑 Active Invoices</h3>
                            <div class="table-responsive"><table class="bill-table">
                                <thead>
                                    <tr>
                                        <th>Bill ID</th>
                                        <th>Service</th>
                                        <th>Amount</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${bills}" var="bill">
                                        <tr class="bill-row">
                                            <td>#BILL-${bill.id}</td>
                                            <td>
                                                <div style="font-weight: 600; color: #1e293b;">${bill.serviceType}</div>
                                                <div style="font-size: 11px; color: #64748b;">Ref ID: ${bill.serviceId}
                                                </div>
                                            </td>
                                            <td style="font-weight: 700; color: #0f6fff;">₹${bill.amount}</td>
                                            <td style="font-size: 13px; color: #1e293b; font-weight: 500;">
                                                ${bill.formattedDate}</td>
                                            <td>
                                                <span
                                                    class="status-pill ${bill.status == 'PAID' ? 'paid' : 'unpaid'}">${bill.status}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${bill.status == 'UNPAID'}">
                                                        <a href="${pageContext.request.contextPath}/patient/pay/${bill.id}"
                                                            class="btn-pay">💳 Pay Now</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="${pageContext.request.contextPath}/patient/receipt/download/${bill.id}"
                                                            class="btn-receipt">📄 Receipt</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table></div>
                        </div>
                    </main>
                </div>
            <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

            </html>

