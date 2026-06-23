<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Upload Report - HMS</title>
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
                        <li><a href="${pageContext.request.contextPath}/lab/upload-report" class="active"><span
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
                        <h1>Upload Lab Report</h1>
                        <p>Upload test results for patients</p>
                    </div>

                    <% if (request.getParameter("success") !=null) { %>
                        <div class="alert alert-success">Lab report uploaded successfully!</div>
                        <% } %>

                            <div class="form-card">
                                <h3>📤 Upload Report</h3>
                                <form action="${pageContext.request.contextPath}/lab/upload-report" method="post">
                                    <c:if test="${param.requestId != null}">
                                        <input type="hidden" name="requestId" value="${param.requestId}">
                                    </c:if>
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label>Patient</label>
                                            <select name="patientId" required>
                                                <option value="">Select Patient</option>
                                                <c:forEach items="${patients}" var="p">
                                                    <option value="${p.id}" ${param.patientId==p.id ? 'selected' : '' }>
                                                        ${p.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Test Name</label>
                                            <select name="testName" required>
                                                <option value="">Select Test</option>
                                                <option value="Complete Blood Count (CBC)" ${param.testName == 'Complete Blood Count (CBC)' ? 'selected' : ''}>Complete Blood Count (CBC) (Overall health & infection check)</option>
                                                <option value="Comprehensive Metabolic Panel (CMP)" ${param.testName == 'Comprehensive Metabolic Panel (CMP)' ? 'selected' : ''}>Comprehensive Metabolic Panel (CMP) (Organ function & metabolism check)</option>
                                                <option value="Lipid Panel" ${param.testName == 'Lipid Panel' ? 'selected' : ''}>Lipid Panel (Cholesterol & heart health check)</option>
                                                <option value="Thyroid Stimulating Hormone (TSH)" ${param.testName == 'Thyroid Stimulating Hormone (TSH)' ? 'selected' : ''}>Thyroid Stimulating Hormone (TSH) (Thyroid function check)</option>
                                                <option value="Hemoglobin A1C" ${param.testName == 'Hemoglobin A1C' ? 'selected' : ''}>Hemoglobin A1C (Blood sugar & diabetes check)</option>
                                                <option value="Urinalysis" ${param.testName == 'Urinalysis' ? 'selected' : ''}>Urinalysis (Kidney & urinary tract check)</option>
                                                <option value="Prothrombin Time (PT)" ${param.testName == 'Prothrombin Time (PT)' ? 'selected' : ''}>Prothrombin Time (PT) (Blood clotting check)</option>
                                                <option value="Basic Metabolic Panel (BMP)" ${param.testName == 'Basic Metabolic Panel (BMP)' ? 'selected' : ''}>Basic Metabolic Panel (BMP) (Kidney & blood sugar check)</option>
                                                <option value="Liver Panel" ${param.testName == 'Liver Panel' ? 'selected' : ''}>Liver Panel (Liver health check)</option>
                                                <option value="Vitamin D, 25-Hydroxy" ${param.testName == 'Vitamin D, 25-Hydroxy' ? 'selected' : ''}>Vitamin D, 25-Hydroxy (Bone health & Vitamin levels)</option>
                                                <c:if test="${not empty param.testName and param.testName != 'Complete Blood Count (CBC)' and param.testName != 'Comprehensive Metabolic Panel (CMP)' and param.testName != 'Lipid Panel' and param.testName != 'Thyroid Stimulating Hormone (TSH)' and param.testName != 'Hemoglobin A1C' and param.testName != 'Urinalysis' and param.testName != 'Prothrombin Time (PT)' and param.testName != 'Basic Metabolic Panel (BMP)' and param.testName != 'Liver Panel' and param.testName != 'Vitamin D, 25-Hydroxy'}">
                                                    <option value="${param.testName}" selected>${param.testName} (Custom)</option>
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group"><label>Normal Range</label><input type="text"
                                                name="normalRange" placeholder="e.g. 70-110 mg/dL"></div>
                                        <div class="form-group"><label>Result</label><input type="text" name="result"
                                                placeholder="e.g. 120 mg/dL" required></div>
                                    </div>
                                    <div class="form-group">
                                        <label>Remarks</label>
                                        <div style="display: flex; gap: 10px; margin-bottom: 8px;">
                                            <button type="button" class="btn-sm" style="background-color: #22c55e; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;" onclick="addRemark('Low')">Low</button>
                                            <button type="button" class="btn-sm" style="background-color: #f97316; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;" onclick="addRemark('Medium')">Medium</button>
                                            <button type="button" class="btn-sm" style="background-color: #ef4444; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;" onclick="addRemark('High')">High</button>
                                        </div>
                                        <textarea name="remarks" id="remarksInput" rows="3"></textarea>
                                    </div>
                                    <button type="submit" class="btn-primary" style="max-width:250px;">Upload
                                        Report</button>
                                </form>
                            </div>

                            <c:if test="${not empty requests}">
                                <div class="data-table-wrapper">
                                    <div class="table-header">
                                        <h3>Pending Requests</h3>
                                    </div>
                                    <div class="table-responsive"><table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Patient</th>
                                                <th>Test</th>
                                                <th>Doctor</th>
                                                <th>Date</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${requests}" var="r">
                                                <tr>
                                                    <td>R${r.id}</td>
                                                    <td>${r.patient.name}</td>
                                                    <td>${r.testName}</td>
                                                    <td>${r.doctor.name}</td>
                                                    <td>${r.requestDate}</td>
                                                    <td><a href="${pageContext.request.contextPath}/lab/upload-report?requestId=${r.id}&patientId=${r.patient.id}&testName=${r.testName}"
                                                            class="btn-sm btn-info">Fill Report</a></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table></div>
                                </div>
                            </c:if>
                </main>
            </div>
            
            <script>
                document.addEventListener('DOMContentLoaded', function() {
                    const testSelect = document.querySelector('select[name="testName"]');
                    const resultInput = document.querySelector('input[name="result"]');
                    const rangeInput = document.querySelector('input[name="normalRange"]');

                    const testExamples = {
                        "Complete Blood Count (CBC)": { result: "e.g. 14.5 g/dL (Hb)", range: "13.8 - 17.2 g/dL" },
                        "Comprehensive Metabolic Panel (CMP)": { result: "e.g. 95 mg/dL (Glucose)", range: "70 - 99 mg/dL" },
                        "Lipid Panel": { result: "e.g. 180 mg/dL (Cholesterol)", range: "< 200 mg/dL" },
                        "Thyroid Stimulating Hormone (TSH)": { result: "e.g. 2.5 mIU/L", range: "0.4 - 4.0 mIU/L" },
                        "Hemoglobin A1C": { result: "e.g. 5.4%", range: "< 5.7%" },
                        "Urinalysis": { result: "e.g. Negative (Protein)", range: "Negative" },
                        "Prothrombin Time (PT)": { result: "e.g. 12.0 Seconds", range: "11.0 - 13.5 Seconds" },
                        "Basic Metabolic Panel (BMP)": { result: "e.g. 140 mEq/L (Sodium)", range: "135 - 145 mEq/L" },
                        "Liver Panel": { result: "e.g. 25 U/L (ALT)", range: "7 - 55 U/L" },
                        "Vitamin D, 25-Hydroxy": { result: "e.g. 45 ng/mL", range: "20 - 50 ng/mL" }
                    };

                    function updatePlaceholders() {
                        const selectedTest = testSelect.value;
                        if (testExamples[selectedTest]) {
                            resultInput.placeholder = testExamples[selectedTest].result;
                            rangeInput.value = testExamples[selectedTest].range; // Set value instead of placeholder
                            rangeInput.placeholder = ""; // Clear placeholder
                        } else {
                            resultInput.placeholder = "e.g. 120 mg/dL";
                            rangeInput.value = ""; // Clear value
                            rangeInput.placeholder = "e.g. 70-110 mg/dL"; // Reset placeholder
                        }
                    }

                    testSelect.addEventListener('change', updatePlaceholders);
                    // Initial setup if a test is pre-selected
                    updatePlaceholders();
                });

                function addRemark(level) {
                    const remarksInput = document.getElementById('remarksInput');
                    const currentValue = remarksInput.value.trim();
                    if (currentValue) {
                        remarksInput.value = currentValue + ", " + level;
                    } else {
                        remarksInput.value = level;
                    }
                }
            </script>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

// Triggering a minor file change to force JSP recompilation if devtools is active
</html>

