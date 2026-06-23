<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Patient Records - HMS</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3>🏥 HMS</h3>
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
                    </ul>
                    <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/auth/logout"><span
                                class="nav-icon">🚪</span> Logout</a></div>
                </aside>
                <main class="main-content">
                    <div class="page-header">
                        <h1>Patient Records: ${patient.name}</h1>
                        <p>Complete medical history, prescriptions, and lab reports</p>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card blue">
                            <div class="stat-icon">🧑</div>
                            <div class="stat-value">${patient.name}</div>
                            <div class="stat-label">Name | Age: ${patient.age != null ? patient.age : 'N/A'}</div>
                        </div>
                        <div class="stat-card green">
                            <div class="stat-icon">🩸</div>
                            <div class="stat-value">${patient.bloodGroup != null ? patient.bloodGroup : 'N/A'}</div>
                            <div class="stat-label">Blood Group</div>
                        </div>
                        <div class="stat-card orange">
                            <div class="stat-icon">⚠️</div>
                            <div class="stat-value" style="font-size:16px;">${patient.allergies != null ?
                                patient.allergies : 'None'}</div>
                            <div class="stat-label">Allergies</div>
                        </div>
                        <div class="stat-card purple">
                            <c:set var="hasVerifiedInsurance" value="false" />
                            <c:set var="insProvider" value="" />
                            <c:set var="insAmt" value="" />
                            <c:forEach items="${insurances}" var="ins">
                                <c:if test="${ins.status == 'Verified'}">
                                    <c:set var="hasVerifiedInsurance" value="true" />
                                    <c:set var="insProvider" value="${ins.provider}" />
                                    <c:set var="insAmt" value="${ins.coverageAmount}" />
                                </c:if>
                            </c:forEach>
                            <div class="stat-icon">🛡️</div>
                            <div class="stat-value" style="font-size:16px;">
                                <c:choose>
                                    <c:when test="${hasVerifiedInsurance}">✔️ ${insProvider}</c:when>
                                    <c:otherwise>No Active Cover</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stat-label">
                                <c:choose>
                                    <c:when test="${hasVerifiedInsurance}">Coverage: ₹${insAmt}</c:when>
                                    <c:otherwise>Insurance Status</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <!-- Lifestyle & Behavior Insights -->
                    <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 24px; margin-bottom: 24px;">
                        <div class="data-table-wrapper" style="padding: 24px; text-align: center;">
                            <h3 style="margin-bottom: 16px;">🎯 Health Score</h3>
                            <div style="position: relative; width: 100px; height: 100px; margin: 0 auto 16px;">
                                <svg viewBox="0 0 36 36"
                                    style="display: block; margin: 0 auto; width: 100%; height: 100%;">
                                    <path
                                        d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
                                        fill="none" stroke="#f1f5f9" stroke-width="3" />
                                    <path stroke-dasharray="${healthScore.overallScore}, 100"
                                        d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
                                        fill="none" stroke="#0f6fff" stroke-width="3" stroke-linecap="round" />
                                </svg>
                                <div
                                    style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 24px; font-weight: 800; color: #1e293b;">
                                    ${healthScore.overallScore}</div>
                            </div>
                            <div style="text-align: left; font-size: 13px; color: #64748b;">
                                <div style="margin-bottom: 8px;">🍎 Diet: <strong>${healthScore.dietScore}%</strong>
                                </div>
                                <div style="margin-bottom: 8px;">🏃 Exercise:
                                    <strong>${healthScore.exerciseScore}%</strong>
                                </div>
                                <div>💊 Medication: <strong>${healthScore.medicationScore}%</strong></div>
                            </div>
                        </div>
                        <div class="data-table-wrapper" style="padding: 24px;">
                            <h3 style="margin-bottom: 16px;">💡 Behavioral Insights</h3>
                            <div style="display: flex; flex-direction: column; gap: 10px;">
                                <c:forEach items="${healthInsights}" var="insight">
                                    <div
                                        style="padding: 12px; background: #f8fafc; border-radius: 10px; border-left: 4px solid #0f6fff; font-size: 14px; color: #475569;">
                                        ✨ ${insight}
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Diet & Exercise Prescription (NEW) -->
                    <div class="data-table-wrapper" style="margin-bottom: 24px;">
                        <div
                            style="background: linear-gradient(135deg, #10b981, #059669); padding: 16px 24px; color: #fff; border-radius: 12px 12px 0 0;">
                            <h3 style="margin: 0; font-size: 18px; font-weight: 700; color: #fff;">🥗 Prescribe Diet &
                                Health Plan</h3>
                        </div>
                        <c:if test="${not empty message}">
                            <div
                                style="margin-bottom: 20px; padding: 16px; background: #ecfdf5; border: 1px solid #10b981; border-radius: 12px; color: #065f46; font-weight: 600; display: flex; align-items: center; gap: 10px;">
                                <span>✔</span> ${message}
                            </div>
                        </c:if>
                        <div style="padding: 24px;">
                            <form action="${pageContext.request.contextPath}/doctor/prescribe-diet" method="POST">
                                <input type="hidden" name="patientId" value="${patient.id}">

                                <div
                                    style="display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 24px;">
                                    <!-- Meals -->
                                    <div style="display: flex; flex-direction: column; gap: 16px;">
                                        <h4
                                            style="margin: 0; color: #1e293b; font-size: 15px; border-left: 4px solid #10b981; padding-left: 10px;">
                                            Nutrition Plan</h4>
                                        <div>
                                            <label
                                                style="display: block; font-size: 12px; font-weight: 600; color: #64748b; margin-bottom: 6px;">Breakfast
                                                Selection</label>
                                            <select name="breakfast" required
                                                style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; outline: none; font-size: 14px; background: #fff;">
                                                <option value="Oats with Fruits">Oats with Fruits</option>
                                                <option value="Greek Yogurt & Nuts">Greek Yogurt & Nuts</option>
                                                <option value="Berry Smoothie Bowl">Berry Smoothie Bowl</option>
                                                <option value="Avocado Toast & Egg">Avocado Toast & Egg</option>
                                                <option value="Spinach Omelette">Spinach Omelette</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label
                                                style="display: block; font-size: 12px; font-weight: 600; color: #64748b; margin-bottom: 6px;">Lunch
                                                Selection</label>
                                            <select name="lunch" required
                                                style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; outline: none; font-size: 14px; background: #fff;">
                                                <option value="Grilled Chicken Salad">Grilled Chicken Salad</option>
                                                <option value="Quinoa & Veggie Bowl">Quinoa & Veggie Bowl</option>
                                                <option value="Lentil Soup & Salad">Lentil Soup & Salad</option>
                                                <option value="Brown Rice & Steamed Fish">Brown Rice & Steamed Fish
                                                </option>
                                                <option value="Chickpea Wrap">Chickpea Wrap</option>
                                            </select>
                                        </div>
                                        <div>
                                            <label
                                                style="display: block; font-size: 12px; font-weight: 600; color: #64748b; margin-bottom: 6px;">Dinner
                                                Selection</label>
                                            <select name="dinner" required
                                                style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; outline: none; font-size: 14px; background: #fff;">
                                                <option value="Baked Tofu & Broccoli">Baked Tofu & Broccoli</option>
                                                <option value="Roasted Salmon & Asparagus">Roasted Salmon & Asparagus
                                                </option>
                                                <option value="Turkey & Veggie Chili">Turkey & Veggie Chili</option>
                                                <option value="Zucchini Noodles with Pesto">Zucchini Noodles with Pesto
                                                </option>
                                                <option value="Steamed Veggies & Paneer">Steamed Veggies & Paneer
                                                </option>
                                            </select>
                                        </div>
                                        <div>
                                            <label
                                                style="display: block; font-size: 12px; font-weight: 600; color: #64748b; margin-bottom: 6px;">Healthy
                                                Drinks</label>
                                            <select name="drinks" required
                                                style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; outline: none; font-size: 14px; background: #fff;">
                                                <option value="Green Tea">Green Tea</option>
                                                <option value="Lemon & Chia Water">Lemon & Chia Water</option>
                                                <option value="Fresh Coconut Water">Fresh Coconut Water</option>
                                                <option value="Herbal Infusion">Herbal Infusion</option>
                                                <option value="Fresh Pomegranate Juice">Fresh Pomegranate Juice</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- Exercise & Goals -->
                                    <div style="display: flex; flex-direction: column; gap: 16px;">
                                        <h4
                                            style="margin: 0; color: #1e293b; font-size: 15px; border-left: 4px solid #3b82f6; padding-left: 10px;">
                                            Exercise & Activity</h4>
                                        <div>
                                            <label
                                                style="display: block; font-size: 12px; font-weight: 600; color: #64748b; margin-bottom: 6px;">Daily
                                                Steps Target</label>
                                            <input type="number" name="steps" value="8000" min="1000" step="500"
                                                style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; outline: none; font-size: 14px;">
                                        </div>
                                        <div>
                                            <label
                                                style="display: block; font-size: 12px; font-weight: 600; color: #64748b; margin-bottom: 6px;">Daily
                                                Workout (Min)</label>
                                            <input type="number" name="exercise" value="20" min="5" step="5"
                                                style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; outline: none; font-size: 14px;">
                                        </div>

                                        <h4
                                            style="margin: 10px 0 0; color: #1e293b; font-size: 15px; border-left: 4px solid #f97316; padding-left: 10px;">
                                            Analysis (Health Scores)</h4>
                                        <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px;">
                                            <div>
                                                <label
                                                    style="display: block; font-size: 12px; font-weight: 600; color: #64748b; margin-bottom: 6px;">Diet
                                                    Adherence (%)</label>
                                                <input type="number" name="dietScore" value="75" min="0" max="100"
                                                    style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; outline: none; font-size: 14px;">
                                            </div>
                                            <div>
                                                <label
                                                    style="display: block; font-size: 12px; font-weight: 600; color: #64748b; margin-bottom: 6px;">Exercise
                                                    Intensity (%)</label>
                                                <input type="number" name="exerciseScore" value="75" min="0" max="100"
                                                    style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; outline: none; font-size: 14px;">
                                            </div>
                                            <div>
                                                <label
                                                    style="display: block; font-size: 12px; font-weight: 600; color: #64748b; margin-bottom: 6px;">Duration
                                                    (Days)</label>
                                                <input type="number" name="duration" value="7" min="1" max="100"
                                                    style="width: 100%; padding: 10px; border-radius: 8px; border: 1px solid #e2e8f0; outline: none; font-size: 14px;">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div style="display: flex; justify-content: flex-end;">
                                    <button type="submit"
                                        style="padding: 12px 28px; background: linear-gradient(135deg, #10b981, #059669); color: #fff; border: none; border-radius: 10px; font-weight: 700; cursor: pointer; transition: all 0.3s ease;">
                                        🚀 Save & Prescribe Diet Plan
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="data-table-wrapper" style="margin-bottom:24px;">
                        <div class="table-header">
                            <h3>💊 Prescriptions</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Medicine</th>
                                    <th>Dosage</th>
                                    <th>Duration</th>
                                    <th>Instructions</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${prescriptions}" var="p">
                                    <tr>
                                        <td>${p.medicineName}</td>
                                        <td>${p.dosage}</td>
                                        <td>${p.duration}</td>
                                        <td>${p.instructions}</td>
                                        <td>${p.prescriptionDate}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty prescriptions}">
                                    <tr>
                                        <td colspan="5" style="text-align:center;padding:20px;">No prescriptions yet
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table></div>
                    </div>

                    <!-- Lab Reports -->
                    <div class="data-table-wrapper" style="margin-bottom:24px;">
                        <div class="table-header">
                            <h3>🧪 Lab Reports</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Test</th>
                                    <th>Result</th>
                                    <th>Normal Range</th>
                                    <th>Remarks</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${labReports}" var="r">
                                    <tr>
                                        <td>${r.testName}</td>
                                        <td>${r.result}</td>
                                        <td>${r.normalRange}</td>
                                        <td>${r.remarks}</td>
                                        <td>${r.reportDate}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty labReports}">
                                    <tr>
                                        <td colspan="5" style="text-align:center;padding:20px;">No lab reports yet</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table></div>
                    </div>

                    <!-- Consultation Notes -->
                    <div class="data-table-wrapper" style="margin-bottom:24px;">
                        <div class="table-header">
                            <h3>📋 Consultation Notes</h3>
                        </div>
                        <div class="table-responsive"><table class="data-table">
                            <thead>
                                <tr>
                                    <th>Note</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${notes}" var="n">
                                    <tr>
                                        <td>${n.noteText}</td>
                                        <td>${n.noteDate}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty notes}">
                                    <tr>
                                        <td colspan="2" style="text-align:center;padding:20px;">No notes yet</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table></div>
                    </div>

                </main>
            </div>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

