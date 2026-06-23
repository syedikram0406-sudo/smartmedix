<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Financial Oversight - SmartMedix Admin</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <style>
                .stats-container {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                    gap: 24px;
                    margin-bottom: 32px;
                }

                .stat-card {
                    background: #fff;
                    border-radius: 16px;
                    padding: 24px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
                    border: 1px solid rgba(0, 0, 0, 0.05);
                    transition: transform 0.3s ease;
                }

                .stat-card:hover {
                    transform: translateY(-5px);
                }

                .stat-card.revenue {
                    border-left: 6px solid #0F6FFF;
                }

                .stat-card.consultation {
                    border-left: 6px solid #10B981;
                }

                .stat-card.technician {
                    border-left: 6px solid #F59E0B;
                }

                .stat-title {
                    font-size: 14px;
                    color: #64748b;
                    margin-bottom: 8px;
                    font-weight: 600;
                    text-transform: uppercase;
                }

                .stat-value {
                    font-size: 28px;
                    font-weight: 800;
                    color: #1e293b;
                }

                .analytics-section {
                    display: grid;
                    grid-template-columns: 1fr 2fr;
                    gap: 24px;
                    margin-bottom: 40px;
                    align-items: start;
                }

                .chart-card {
                    background: #fff;
                    border-radius: 20px;
                    padding: 32px;
                    box-shadow: 0 4px 25px rgba(0, 0, 0, 0.04);
                    text-align: center;
                }

                .chart-card h3 {
                    margin-bottom: 24px;
                    font-size: 18px;
                    color: #1e293b;
                }

                .table-wrapper {
                    background: #fff;
                    border-radius: 20px;
                    padding: 24px;
                    box-shadow: 0 4px 25px rgba(0, 0, 0, 0.04);
                }

                .main-content {
                    padding: 40px;
                }
            </style>
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🩺 SmartMedix</h3>
                        <div class="role-badge">Admin Panel</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/doctors"><span class="nav-icon">🩺</span>
                                Doctors</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/patients"><span class="nav-icon">👤</span>
                                Patients</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/appointments"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/transactions" class="active"><span
                                    class="nav-icon">💸</span> Transactions</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>

                <main class="main-content">
                    <div class="page-header" style="margin-bottom: 32px;">
                        <h1 style="font-size: 32px; font-weight: 800; color: #1e293b;">Financial Oversight</h1>
                        <p style="color: #64748b; font-size: 16px;">Monitor all system-wide billing and revenue
                            distribution</p>
                    </div>

                    <div class="stats-container">
                        <div class="stat-card revenue">
                            <div class="stat-title">Total Revenue</div>
                            <div class="stat-value">₹${totalRevenue}</div>
                        </div>
                        <div class="stat-card consultation">
                            <div class="stat-title">Consultation Fees</div>
                            <div class="stat-value">₹${consultationRevenue}</div>
                        </div>
                        <div class="stat-card technician">
                            <div class="stat-title">Technician Fees</div>
                            <div class="stat-value">₹${technicianRevenue}</div>
                        </div>
                    </div>

                    <div class="analytics-section">
                        <div class="chart-card">
                            <h3>Revenue Breakdown</h3>
                            <div style="max-width: 300px; margin: 0 auto;">
                                <canvas id="revenueChart"></canvas>
                            </div>
                        </div>

                        <div class="table-wrapper">
                            <div class="table-header"
                                style="padding-bottom: 20px; border-bottom: 1px solid #f1f5f9; margin-bottom: 20px;">
                                <h3 style="font-size: 18px; color: #1e293b;">Recent Transactions</h3>
                            </div>
                            <div class="table-container">
                                <div class="table-responsive"><table class="data-table">
                                    <thead>
                                        <tr>
                                            <th>Txn ID</th>
                                            <th>Patient</th>
                                            <th>Service</th>
                                            <th>Amount</th>
                                            <th>Method</th>
                                            <th>Date</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${transactions}" var="t">
                                            <tr>
                                                <td><code
                                                        style="background: #f1f5f9; padding: 4px 8px; border-radius: 6px; font-size: 12px; font-weight: 600;">${t.transactionId}</code>
                                                </td>
                                                <td><strong>${t.bill.patient.name}</strong></td>
                                                <td>
                                                    <span class="badge"
                                                        style="background: ${t.bill.serviceType == 'CONSULTATION' ? '#dcfce7' : '#e0f2fe'}; color: ${t.bill.serviceType == 'CONSULTATION' ? '#166534' : '#0369a1'};">
                                                        ${t.bill.serviceType}
                                                    </span>
                                                </td>
                                                <td style="color: #1e293b; font-weight: 700;">₹${t.amountPaid}</td>
                                                <td><span
                                                        style="font-size: 13px; color: #64748b; font-weight: 600;">${t.paymentMethod}</span>
                                                </td>
                                                <td style="font-size: 13px; color: #1e293b; font-weight: 500;">
                                                    ${t.formattedDate}</td>
                                                <td><span class="badge status-green">SUCCESS</span></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table></div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>

            <script>
                const ctx = document.getElementById('revenueChart').getContext('2d');
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Consultation', 'Technician'],
                        datasets: [{
                            data: [${ consultationRevenue }, ${ technicianRevenue }],
                            backgroundColor: ['#10B981', '#0F6FFF'],
                            borderWidth: 0,
                            hoverOffset: 10
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    padding: 20,
                                    usePointStyle: true,
                                    font: { family: 'Inter, sans-serif', size: 12, weight: '600' }
                                }
                            }
                        },
                        cutout: '70%'
                    }
                });
            </script>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

