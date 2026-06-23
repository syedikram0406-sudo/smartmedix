<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Prescriptions - SmartMedix</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
            <style>
                /* ===== Prescription Backdrop ===== */
                .main-content {
                    position: relative;
                    overflow: hidden;
                }

                .main-content::before {
                    content: '';
                    position: fixed;
                    top: 0;
                    right: 0;
                    bottom: 0;
                    left: 260px;
                    background: url('${pageContext.request.contextPath}/images/medical-backdrop.png') center/cover no-repeat;
                    opacity: 0.05;
                    z-index: 0;
                    pointer-events: none;
                }

                .main-content::after {
                    content: '';
                    position: fixed;
                    top: 0;
                    right: 0;
                    bottom: 0;
                    left: 260px;
                    background: linear-gradient(135deg, rgba(241, 245, 249, 0.96) 0%, rgba(241, 245, 249, 0.92) 50%, rgba(219, 234, 254, 0.95) 100%);
                    z-index: 0;
                    pointer-events: none;
                }

                .main-content>* {
                    position: relative;
                    z-index: 1;
                }

                .form-card {
                    border: 1px solid rgba(15, 111, 255, 0.08);
                    transition: all 0.3s ease;
                }

                .form-card:hover {
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
                }

                /* Custom styling for select dropdowns */
                .form-group select {
                    appearance: none;
                    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748b'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
                    background-repeat: no-repeat;
                    background-position: right 12px center;
                    background-size: 16px;
                    padding-right: 40px;
                }

                /* Quick Instruction Chips */
                .instruction-tips {
                    margin-bottom: 12px;
                }
                .tips-label {
                    font-size: 13px;
                    font-weight: 600;
                    color: #64748b;
                    margin-bottom: 8px;
                    display: block;
                }
                .chips-container {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 8px;
                    margin-bottom: 16px;
                }
                .chip {
                    padding: 6px 12px;
                    background: #f1f5f9;
                    border: 1px solid #e2e8f0;
                    border-radius: 20px;
                    font-size: 12px;
                    color: #475569;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    user-select: none;
                }
                .chip:hover {
                    background: #e2e8f0;
                    border-color: #cbd5e1;
                    color: #1e293b;
                    transform: translateY(-1px);
                }
                .chip.active {
                    background: #0F6FFF;
                    color: #fff;
                    border-color: #0F6FFF;
                }

                @media (max-width: 768px) {

                    .main-content::before,
                    .main-content::after {
                        left: 0;
                    }
                }
            </style>
        </head>

        <body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
            <div class="layout">
                <aside class="sidebar">
                    <div class="sidebar-header">
                        <h3> SmartMedix</h3>
                        <div class="role-badge">Doctor Panel</div>
                    </div>
                    <ul class="sidebar-nav">
                        <li><a href="${pageContext.request.contextPath}/doctor/dashboard"><span
                                    class="nav-icon">📊</span> Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/appointments"><span
                                    class="nav-icon">📅</span> Appointments</a></li>
                        <li><a href="${pageContext.request.contextPath}/doctor/prescription" class="active"><span
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
                        <h1>Digital Prescription Generator</h1>
                        <p>Create prescriptions for your patients with SmartMedix</p>
                    </div>

                    <% if (request.getParameter("success") !=null) { %>
                        <div class="alert alert-success">Prescription created successfully!</div>
                        <% } %>

                            <div class="form-card">
                                <h3>💊 New Prescription</h3>
                                <form action="${pageContext.request.contextPath}/doctor/prescription/add" method="post">
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label>Patient</label>
                                            <select name="patientId" required>
                                                <option value="">Select Patient</option>
                                                <c:forEach items="${patients}" var="p">
                                                    <option value="${p.id}">${p.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Medicine Name</label>
                                            <select name="medicineName" required>
                                                <option value="">-- Select Tablet --</option>
                                                <option value="Paracetamol (Fever and Pain relief)">Paracetamol (Fever
                                                    and Pain relief)</option>
                                                <option value="Ibuprofen (Anti-inflammatory/Pain)">Ibuprofen
                                                    (Anti-inflammatory/Pain)</option>
                                                <option value="Amoxicillin (Bacterial Infections)">Amoxicillin
                                                    (Bacterial Infections)</option>
                                                <option value="Cetirizine (Allergies/Hay fever)">Cetirizine
                                                    (Allergies/Hay fever)</option>
                                                <option value="Metformin (Type 2 Diabetes)">Metformin (Type 2 Diabetes)
                                                </option>
                                                <option value="Amlodipine (High Blood Pressure)">Amlodipine (High Blood
                                                    Pressure)</option>
                                                <option value="Omeprazole (Acid Reflux/Heartburn)">Omeprazole (Acid
                                                    Reflux/Heartburn)</option>
                                                <option value="Azithromycin (Respiratory Infections)">Azithromycin
                                                    (Respiratory Infections)</option>
                                                <option value="Atorvastatin (High Cholesterol)">Atorvastatin (High
                                                    Cholesterol)</option>
                                                <option value="Salbutamol (Asthma/Wheezing)">Salbutamol
                                                    (Asthma/Wheezing)</option>
                                                <option value="Metoprolol (Heart rate/Blood Pressure)">Metoprolol (Heart
                                                    rate/Blood Pressure)</option>
                                                <option value="Loratadine (Seasonal Allergies)">Loratadine (Seasonal
                                                    Allergies)</option>
                                                <option value="Ciprofloxacin (Urinary/Gut Infections)">Ciprofloxacin
                                                    (Urinary/Gut Infections)</option>
                                                <option value="Pantoprazole (Gastric Ulcers/Acidity)">Pantoprazole
                                                    (Gastric Ulcers/Acidity)</option>
                                                <option value="Diazepam (Anxiety/Muscle spasms)">Diazepam
                                                    (Anxiety/Muscle spasms)</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label>Dosage</label>
                                            <select name="dosage">
                                                <option value="">-- Select MG --</option>
                                                <c:forEach var="mg"
                                                    items="10,25,50,75,100,150,200,250,300,350,400,450,500">
                                                    <option value="${mg}mg">${mg}mg</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group"><label>Duration</label><input type="text"
                                                name="duration" placeholder="e.g. 5 Days"></div>
                                    </div>
                                    <div class="form-group">
                                        <label>Instructions</label>
                                        <div class="instruction-tips">
                                            <span class="tips-label">💡 Quick Selection:</span>
                                            <div class="chips-container" id="instructionChips">
                                                <div class="chip" data-val="Take after meals">Take after meals</div>
                                                <div class="chip" data-val="Take before meals">Take before meals</div>
                                                <div class="chip" data-val="Take on an empty stomach">On empty stomach</div>
                                                <div class="chip" data-val="Take at bedtime">At bedtime</div>
                                                <div class="chip" data-val="Avoid alcohol">Avoid alcohol</div>
                                                <div class="chip" data-val="Finish the entire course">Finish entire course</div>
                                                <div class="chip" data-val="Drink plenty of fluids">Plenty of fluids</div>
                                                <div class="chip" data-val="Do not drive after taking">Don't drive</div>
                                                <div class="chip" data-val="Keep out of reach of children">Keep away from kids</div>
                                                <div class="chip" data-val="Store in a cool place">Store in cool place</div>
                                            </div>
                                        </div>
                                        <textarea name="instructions" id="instructionsBox" rows="3" placeholder="Special instructions for the patient"></textarea>
                                    </div>
                                    <button type="submit" class="btn-primary" style="max-width:250px;">Create
                                        Prescription</button>
                                </form>
                            </div>
                </main>
            </div>
            <script>
                document.querySelectorAll('.chip').forEach(chip => {
                    chip.addEventListener('click', function() {
                        const val = this.getAttribute('data-val');
                        const textarea = document.getElementById('instructionsBox');
                        
                        let currentText = textarea.value.trim();
                        if (currentText === "") {
                            textarea.value = val;
                        } else {
                            // Avoid duplicates
                            if (!currentText.includes(val)) {
                                textarea.value = currentText + ", " + val;
                            }
                        }
                        
                        // Visual feedback
                        this.classList.add('active');
                        setTimeout(() => this.classList.remove('active'), 200);
                    });
                });
            </script>
        <script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

        </html>

