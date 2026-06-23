<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Patient Reports - HMS</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🏥 HMS</h3>
                        <div class="role-badge">Lab Technician</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/lab/dashboard"><span class="nav-icon">📊</span>
                                Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/test-requests"><span
                                    class="nav-icon">📋</span> Test Requests</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/upload-report"><span
                                    class="nav-icon">📤</span> Upload Report</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/report-status"><span
                                    class="nav-icon">📊</span> Report Status</a></li>
                        <li><a href="${pageContext.request.contextPath}/lab/report-history"><span
                                    class="nav-icon">📜</span> Report History</a></li>
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Patient Test History: ${patient.name}</h1>
                        <p>View all test reports for this patient</p>
                    </div>

                    <!-- Patient Selector -->
                    <div class="form-card" style="margin-bottom:24px;">
                        <form style="display:flex;gap:12px;align-items:flex-end;">
                            <div class="form-group" style="flex:1;">
                                <label>Select Patient</label>
                                <select
                                    onchange="if(this.value) window.location.href='${pageContext.request.contextPath}/lab/patient-reports/'+this.value">
                                    <option value="">Select Patient</option>
                                    <c:forEach items="${patients}" var="p">
                                        <option value="${p.id}" ${patient !=null && patient.id==p.id ? 'selected' : ''
                                            }>${p.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>
                    </div>

                    <c:if test="${patient != null}">
                        <div class="data-table-wrapper">
                            <div class="table-header">
                                <h3>Test Reports for ${patient.name}</h3>
                            </div>
                            <div class="table-responsive"><table class="data-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Test</th>
                                        <th>Result</th>
                                        <th>Normal Range</th>
                                        <th>Remarks</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${reports}" var="r">
                                        <tr>
                                            <td>L${r.id}</td>
                                            <td>${r.testName}</td>
                                            <td>${r.result}</td>
                                            <td>${r.normalRange}</td>
                                            <td>${r.remarks}</td>
                                            <td>${r.reportDate}</td>
                                            <td><span
                                                    class="badge badge-${r.status == 'Completed' || r.status == 'Uploaded' ? 'completed' : 'pending'}">${r.status}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty reports}">
                                        <tr>
                                            <td colspan="7" style="text-align:center;padding:20px;">No reports for this
                                                patient</td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table></div>
                        </div>
                    </c:if>
                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

