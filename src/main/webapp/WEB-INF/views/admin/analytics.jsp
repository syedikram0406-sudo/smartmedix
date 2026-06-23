<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Analytics - HMS</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🏥 HMS</h3>
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
                        <li><a href="${pageContext.request.contextPath}/admin/lab-reports"><span
                                    class="nav-icon">🧪</span> Lab Reports</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/analytics" class="active"><span
                                    class="nav-icon">📈</span> Analytics</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/complaints"><span
                                    class="nav-icon">📝</span> Complaints</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Hospital Analytics</h1>
                        <p>Data insights and department statistics</p>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card blue">
                            <div class="stat-icon">🧑‍🤝‍🧑</div>
                            <div class="stat-value">${totalPatients}</div>
                            <div class="stat-label">Total Patients</div>
                        </div>
                        <div class="stat-card green">
                            <div class="stat-icon">👨‍⚕️</div>
                            <div class="stat-value">${totalDoctors}</div>
                            <div class="stat-label">Total Doctors</div>
                        </div>
                        <div class="stat-card orange">
                            <div class="stat-icon">📅</div>
                            <div class="stat-value">${totalAppointments}</div>
                            <div class="stat-label">Total Appointments</div>
                        </div>
                    </div>

                    <div class="revenue-charts-section"
                        style="margin-top: 30px; display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        <div class="chart-container"
                            style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.05);">
                            <h3 style="margin-bottom: 20px; color: #2d3436; font-size: 1.1rem;">📊 Monthly Revenue
                                Breakdown</h3>
                            <div style="position: relative; height: 300px;">
                                <canvas id="monthlyRevenueChart"></canvas>
                            </div>
                        </div>
                        <div class="chart-container"
                            style="background: white; padding: 25px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.05);">
                            <h3 style="margin-bottom: 20px; color: #2d3436; font-size: 1.1rem;">📈 Yearly Revenue
                                Breakdown</h3>
                            <div style="position: relative; height: 300px;">
                                <canvas id="yearlyRevenueChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <div class="data-table-wrapper">
                        <div class="table-header">
                            <h3>📊 Department-wise Statistics</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Department</th>
                                    <th>Doctors</th>
                                    <th>Visual</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${departmentStats}" var="entry">
                                    <tr>
                                        <td><strong>${entry.key}</strong></td>
                                        <td>${entry.value}</td>
                                        <td>
                                            <div
                                                style="background: linear-gradient(90deg, var(--primary), var(--secondary)); height: 24px; border-radius: 12px; width: ${entry.value * 60}px; max-width: 300px; display: flex; align-items: center; justify-content: center; color: white; font-size: 12px; font-weight: 600;">
                                                ${entry.value}</div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty departmentStats}">
                                    <tr>
                                        <td colspan="3" style="text-align:center;padding:20px;">No department data
                                            available</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table></div>
                    </div>
                </main>
            </div>

            <script>
                const commonOptions = {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                usePointStyle: true,
                                padding: 20,
                                font: {
                                    family: "'Inter', sans-serif",
                                    size: 12
                                }
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(255, 255, 255, 0.9)',
                            titleColor: '#2d3436',
                            bodyColor: '#636e72',
                            borderColor: '#dfe6e9',
                            borderWidth: 1,
                            padding: 10,
                            displayColors: true,
                            callbacks: {
                                label: function (context) {
                                    let label = context.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    if (context.parsed !== null) {
                                        label += new Intl.NumberFormat('en-IN', { style: 'currency', currency: 'INR' }).format(context.parsed);
                                    }
                                    return label;
                                }
                            }
                        }
                    }
                };

                // Monthly Revenue Chart
                const monthlyCtx = document.getElementById('monthlyRevenueChart').getContext('2d');
                new Chart(monthlyCtx, {
                    type: 'pie',
                    data: {
                        labels: [
                            <c:forEach items="${monthlyRevenue}" var="entry" varStatus="status">
                                '${entry.key}'${!status.last ? ',' : ''}
                            </c:forEach>
                        ],
                        datasets: [{
                            label: 'Revenue',
                            data: [
                                <c:forEach items="${monthlyRevenue}" var="entry" varStatus="status">
                                    ${entry.value}${!status.last ? ',' : ''}
                                </c:forEach>
                            ],
                            backgroundColor: ['#6c5ce7', '#a29bfe', '#00cec9', '#fab1a0', '#fdcb6e', '#e17055'],
                            borderWidth: 2,
                            borderColor: '#fff',
                            hoverOffset: 15
                        }]
                    },
                    options: commonOptions
                });

                // Yearly Revenue Chart
                const yearlyCtx = document.getElementById('yearlyRevenueChart').getContext('2d');
                new Chart(yearlyCtx, {
                    type: 'doughnut',
                    data: {
                        labels: [
                            <c:forEach items="${yearlyRevenue}" var="entry" varStatus="status">
                                '${entry.key}'${!status.last ? ',' : ''}
                            </c:forEach>
                        ],
                        datasets: [{
                            data: [
                                <c:forEach items="${yearlyRevenue}" var="entry" varStatus="status">
                                    ${entry.value}${!status.last ? ',' : ''}
                                </c:forEach>
                            ],
                            backgroundColor: ['#0984e3', '#74b9ff', '#55efc4', '#ffeaa7'],
                            borderWidth: 0,
                            hoverOffset: 15
                        }]
                    },
                    options: commonOptions
                });
            </script>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

