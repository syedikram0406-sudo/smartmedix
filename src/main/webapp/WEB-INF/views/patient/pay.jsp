<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Secure Checkout | SmartMedix</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&family=Inter:wght@400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --secondary: #64748b;
            --success: #059669;
            --indigo: #4f46e5;
            --glass-bg: rgba(255, 255, 255, 0.8);
            --glass-border: rgba(255, 255, 255, 0.4);
        }

        body {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            color: #1e293b;
        }

        h1, h2, h3, .amount-display {
            font-family: 'Outfit', sans-serif;
        }

        .checkout-wrapper {
            width: 100%;
            max-width: 580px;
            padding: 20px;
        }

        .checkout-container {
            background: var(--glass-bg);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid var(--glass-border);
            padding: 48px;
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
        }

        .checkout-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--primary), var(--indigo));
        }

        .tagline-banner {
            background: #f1f5f9;
            padding: 8px 0;
            font-size: 13px;
            color: var(--secondary);
            font-weight: 500;
            margin-bottom: 24px;
            border-radius: 100px;
            display: inline-block;
            padding: 6px 20px;
            letter-spacing: 0.5px;
        }

        .checkout-header {
            margin-bottom: 40px;
        }

        .checkout-header h3 {
            font-size: 28px;
            font-weight: 800;
            margin: 0;
            color: #0f172a;
        }

        .checkout-header p {
            color: var(--secondary);
            margin-top: 8px;
            font-size: 15px;
        }

        .amount-section {
            background: #fff;
            padding: 30px;
            border-radius: 24px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
            margin-bottom: 32px;
        }

        .amount-label {
            font-size: 14px;
            color: var(--secondary);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
            margin-bottom: 12px;
        }

        .amount-display {
            font-size: 56px;
            font-weight: 800;
            color: var(--primary);
            line-height: 1;
        }

        .info-pill {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px 20px;
            border-radius: 16px;
            margin-bottom: 16px;
            font-size: 14px;
            text-align: left;
        }

        .info-pill.discount {
            background: #f0fdf4;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .info-pill.insurance {
            background: #f5f3ff;
            color: #5b21b6;
            border: 1px solid #ddd6fe;
        }

        .payment-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
            margin: 32px 0;
        }

        .pay-card {
            background: #fff;
            border: 2px solid #f1f5f9;
            padding: 24px 16px;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
            font-weight: 600;
            color: #475569;
        }

        .pay-card:hover {
            border-color: var(--primary);
            transform: translateY(-4px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
        }

        .pay-card.active {
            border-color: var(--primary);
            background: #eff6ff;
            color: var(--primary);
        }

        .pay-card input {
            display: none;
        }

        .icon-box {
            font-size: 24px;
        }

        .complete-btn {
            background: linear-gradient(135deg, var(--primary) 0%, var(--indigo) 100%);
            color: white;
            border: none;
            padding: 20px;
            border-radius: 16px;
            font-size: 18px;
            font-weight: 700;
            width: 100%;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 10px 15px -3px rgba(37, 99, 235, 0.3);
            font-family: 'Outfit', sans-serif;
        }

        .complete-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 20px 25px -5px rgba(37, 99, 235, 0.4);
            filter: brightness(1.1);
        }

        .back-link {
            display: inline-block;
            margin-top: 32px;
            color: var(--secondary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .back-link:hover {
            color: var(--primary);
        }

        .health-quote {
            margin-top: 40px;
            font-style: italic;
            color: var(--secondary);
            font-size: 14px;
            border-top: 1px solid #e2e8f0;
            padding-top: 24px;
        }
    </style>
</head>

<body><!-- Mobile Top Bar --><div class="mobile-top-bar"><span class="mobile-logo">&#129658; SmartMedix</span><button class="hamburger-btn" id="hamburgerBtn" aria-label="Toggle menu"><span></span><span></span><span></span></button></div><div class="sidebar-overlay" id="sidebarOverlay"></div>
    <div class="checkout-wrapper">
        <div class="checkout-container">
            <div class="tagline-banner">
                🏥 Compassionate Care, Seamless Progress
            </div>

            <div class="checkout-header">
                <h3>Secure Checkout</h3>
                <p>Digital Medical Record Management System</p>
            </div>

            <div class="amount-section">
                <div class="amount-label">Total Amount</div>
                <div class="amount-display">₹${bill.amount}</div>
            </div>

            <c:set var="discountedTotal" value="${bill.amount - discountAmount}" />
            <c:if test="${hasVerifiedInsurance}">
                <div class="info-pill discount">
                    <span class="icon-box">🎉</span>
                    <div>
                        <strong>Insurance Holder Discount Applied:</strong> ${discountPercentage}% Off<br>
                        <small>Savings: -₹${discountAmount}</small>
                    </div>
                </div>
            </c:if>

            <c:if test="${totalInsurance > 0}">
                <c:set var="finalPayable" value="${discountedTotal - totalInsurance < 0 ? 0 : discountedTotal - totalInsurance}" />
                <div class="info-pill insurance">
                    <span class="icon-box">🛡️</span>
                    <div>
                        <strong>Active Insurance Coverage:</strong> Auto-applied -₹${discountedTotal > totalInsurance ? totalInsurance : discountedTotal}<br>
                        <small>Remaining Limit: ₹${totalInsurance}</small>
                    </div>
                </div>
                <div style="margin: 24px 0; text-align: center;">
                    <span style="font-size: 14px; color: var(--secondary); text-transform: uppercase; font-weight: 600;">Final Payable</span>
                    <div style="font-size: 36px; font-weight: 800; color: #1e3a8a;">₹${finalPayable}</div>
                </div>
            </c:if>
            
            <c:if test="${empty finalPayable}">
                <c:set var="finalPayable" value="${discountedTotal}" />
            </c:if>

            <div style="margin-bottom: 24px; font-size: 15px;">
                Paying for: <span style="font-weight: 700; color: #334155;">${bill.serviceType} Service</span>
            </div>

            <form action="${pageContext.request.contextPath}/patient/process-payment" method="post" id="paymentForm">
                <input type="hidden" name="billId" value="${bill.id}">

                <c:if test="${empty finalPayable or finalPayable > 0}">
                    <div class="payment-grid">
                        <label class="pay-card active">
                            <input type="radio" name="method" value="UPI" checked onclick="updateActive(this)">
                            <span class="icon-box">📱</span>
                            <span>UPI</span>
                        </label>
                        <label class="pay-card">
                            <input type="radio" name="method" value="CARD" onclick="updateActive(this)">
                            <span class="icon-box">💳</span>
                            <span>Card</span>
                        </label>
                        <label class="pay-card" style="grid-column: 1 / -1;">
                            <input type="radio" name="method" value="WALLET" onclick="updateActive(this)">
                            <span class="icon-box">💼</span>
                            <span>E-Wallet</span>
                        </label>
                    </div>
                </c:if>

                <button type="submit" class="complete-btn">Complete Transaction</button>
            </form>

            <div class="health-quote">
                "Your health is our greatest priority. Thank you for choosing SmartMedix for your care."
            </div>

            <a href="${pageContext.request.contextPath}/patient/bills" class="back-link">
                ← Return to Billing Records
            </a>
        </div>
    </div>

    <script>
        function updateActive(input) {
            document.querySelectorAll('.pay-card').forEach(card => card.classList.remove('active'));
            input.parentElement.classList.add('active');
        }
    </script>
<script src="${pageContext.request.contextPath}/js/responsive.js"></script></body>

</html>

