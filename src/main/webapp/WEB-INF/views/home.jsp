<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SmartMedix – Digital Medical Record Management System</title>
        <meta name="description"
            content="SmartMedix is a cutting-edge digital medical record management system. Secure, smart and efficient healthcare data management for hospitals, doctors and patients.">
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&family=Inter:wght@300;400;500;600;700;800;900&display=swap"
            rel="stylesheet">
        <style>
            /* ===== RESET & BASE ===== */
            *,
            *::before,
            *::after {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html {
                scroll-behavior: smooth;
            }

            :root {
                --primary-navy: #0F172A;
                --medical-blue: #3B82F6;
                --medical-sky: #60A5FA;
                --medical-teal: #14B8A6;
                --bg-pearl: #F8FAFC;
                --bg-soft: #F1F5F9;
                --text-main: #1E293B;
                --text-white: #F8FAFC;
                --glass-blue: rgba(59, 130, 246, 0.1);
                --shadow-premium: 0 20px 50px rgba(15, 23, 42, 0.15);
            }

            body {
                font-family: 'Poppins', 'Inter', sans-serif;
                color: var(--text-main);
                background: var(--bg-pearl);
                overflow-x: hidden;
            }

            /* ===== UTILITY ===== */
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 32px;
            }

            /* ===== BACKDROP SYSTEM ===== */
            .backdrop-section {
                position: relative;
                overflow: hidden;
            }

            .backdrop-section .bd-bg {
                position: absolute;
                inset: 0;
                background-size: cover;
                background-position: center;
                /* Removed background-attachment: fixed to prevent section mixing */
            }

            .bd-overlay-elegant-dark {
                background: linear-gradient(135deg,
                        rgba(15, 23, 42, 0.9) 0%,
                        rgba(30, 136, 229, 0.7) 100%);
            }

            .bd-overlay-elegant-light {
                background: linear-gradient(135deg,
                        rgba(245, 249, 255, 0.96) 0%,
                        rgba(235, 244, 255, 0.92) 50%,
                        rgba(245, 249, 255, 0.97) 100%);
            }

            /* ===== NAVBAR ===== */
            .top-nav {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 24px 64px;
                background: rgba(255, 255, 255, 0.02);
                backdrop-filter: blur(25px);
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .top-nav.scrolled {
                background: rgba(255, 255, 255, 0.98);
                padding: 18px 64px;
                box-shadow: 0 10px 40px rgba(0, 0, 0, 0.04);
                border-bottom: 1px solid rgba(30, 41, 59, 0.05);
            }

            .top-nav.scrolled .nav-links a {
                color: var(--primary-navy);
                opacity: 0.8;
            }

            .top-nav.scrolled .nav-links a:hover {
                color: var(--medical-blue);
                opacity: 1;
            }

            .top-nav .logo {
                display: flex;
                align-items: center;
                gap: 12px;
                color: #fff;
            }

            .top-nav.scrolled .logo {
                color: var(--primary-navy);
            }

            .top-nav .logo-icon {
                font-size: 32px;
                filter: drop-shadow(0 0 15px rgba(59, 130, 246, 0.5));
            }

            .top-nav .logo-text {
                font-size: 26px;
                font-weight: 700;
                letter-spacing: -0.5px;
            }

            .top-nav .logo-text span {
                color: var(--medical-blue);
            }

            .nav-links {
                display: flex;
                align-items: center;
                gap: 28px;
            }

            .nav-links a {
                color: rgba(255, 255, 255, 0.85);
                font-size: 16px;
                font-weight: 600;
                transition: 0.3s;
                text-decoration: none;
            }

            .nav-links a:hover {
                color: #fff;
            }

            .nav-btns {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .btn {
                padding: 12px 32px;
                border-radius: 12px;
                font-weight: 600;
                transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .btn-outline {
                background: transparent;
                color: #fff;
                border: 1.5px solid rgba(255, 255, 255, 0.3);
            }

            .top-nav.scrolled .btn-outline {
                color: var(--primary-navy);
                border-color: rgba(30, 41, 59, 0.2);
            }

            .btn-primary {
                background: var(--medical-blue);
                color: #fff;
                box-shadow: 0 10px 25px rgba(59, 130, 246, 0.3);
                border: none;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                background: #2563EB;
                box-shadow: 0 15px 35px rgba(59, 130, 246, 0.5);
            }

            .btn-lg {
                padding: 20px 48px;
                font-size: 16px;
                letter-spacing: 0.5px;
            }

            /* ===== ANIMATION KEYFRAMES ===== */
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @keyframes pulse-glow {
                0% {
                    filter: drop-shadow(0 0 10px rgba(5, 150, 105, 0.2));
                }

                50% {
                    filter: drop-shadow(0 0 20px rgba(5, 150, 105, 0.5));
                }

                100% {
                    filter: drop-shadow(0 0 10px rgba(5, 150, 105, 0.2));
                }
            }

            .fade-in {
                opacity: 0;
                transition: all 0.8s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .fade-in.visible {
                opacity: 1;
                transform: translateY(0);
            }

            .stagger-item {
                opacity: 0;
                transform: translateY(20px);
                transition: all 0.8s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .stagger-item.visible {
                opacity: 1;
                transform: translateY(0);
            }

            /* Floating Background Elements */
            .floating-icon {
                position: absolute;
                font-size: 80px;
                color: rgba(30, 136, 229, 0.08);
                pointer-events: none;
                z-index: 1;
                filter: blur(2px);
                animation: float-slow 15s ease-in-out infinite;
            }

            /* Glassmorphism Classes */
            .glass-card {
                background: rgba(255, 255, 255, 0.8);
                backdrop-filter: blur(15px);
                -webkit-backdrop-filter: blur(15px);
                border: 1px solid rgba(255, 255, 255, 0.5);
                box-shadow: 0 15px 45px rgba(30, 136, 229, 0.08);
            }

            /* Parallax Effect */
            .parallax-bg {
                transition: transform 0.6s cubic-bezier(0.1, 0, 0, 1);
                will-change: transform;
                filter: brightness(0.6) contrast(1.1) saturate(1.1);
                height: 120%;
                top: -10%;
            }

            /* ===== PARTICLES ===== */
            .particles {
                position: absolute;
                inset: 0;
                pointer-events: none;
                overflow: hidden;
            }

            .particles span {
                position: absolute;
                border-radius: 50%;
                background: rgba(45, 212, 191, 0.08);
                animation: float 20s linear infinite;
            }

            .particles span:nth-child(1) {
                width: 300px;
                height: 300px;
                top: -60px;
                left: 8%;
            }

            .particles span:nth-child(2) {
                width: 200px;
                height: 200px;
                bottom: 5%;
                right: 5%;
                animation-delay: 4s;
            }

            .particles span:nth-child(3) {
                width: 160px;
                height: 160px;
                top: 35%;
                left: 55%;
                animation-delay: 8s;
            }

            .particles span:nth-child(4) {
                width: 100px;
                height: 100px;
                top: 15%;
                right: 25%;
                animation-delay: 12s;
            }

            /* ===== 1. HERO ===== */
            .hero {
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
            }

            .hero-video-wrapper {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 0;
                pointer-events: none;
                overflow: hidden;
            }

            .hero-video-wrapper iframe {
                width: 100vw;
                height: 56.25vw;
                /* Given a 16:9 aspect ratio, 9/16*100 = 56.25 */
                min-height: 100vh;
                min-width: 177.77vh;
                /* Given a 16:9 aspect ratio, 16/9*100 = 177.77 */
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            .hero-content {
                text-align: center;
                max-width: 820px;
                padding: 0 24px;
                animation: fadeInUp 1s ease 0.3s both;
            }

            .hero-badge {
                display: inline-block;
                padding: 10px 24px;
                border-radius: 40px;
                background: rgba(59, 130, 246, 0.15);
                border: 1px solid rgba(59, 130, 246, 0.3);
                color: #fff;
                font-size: 13px;
                font-weight: 600;
                letter-spacing: 1px;
                text-transform: uppercase;
                margin-bottom: 30px;
                backdrop-filter: blur(10px);
            }

            .hero h1 {
                font-size: 64px;
                font-weight: 800;
                color: #fff;
                line-height: 1.1;
                margin-bottom: 24px;
                letter-spacing: -1.5px;
                text-shadow: 0 4px 30px rgba(0, 0, 0, 0.5);
            }

            .hero h1 .hl {
                color: #60A5FA;
                text-shadow: 0 0 30px rgba(59, 130, 246, 0.4);
            }

            .hero-sub {
                font-size: 19px;
                color: rgba(255, 255, 255, 0.95);
                line-height: 1.6;
                margin-bottom: 44px;
                max-width: 720px;
                margin-left: auto;
                margin-right: auto;
                text-shadow: 0 2px 15px rgba(0, 0, 0, 0.5);
            }

            .hero-cta {
                display: flex;
                gap: 16px;
                justify-content: center;
                flex-wrap: wrap;
                animation: fadeInUp 1s cubic-bezier(0.2, 0.8, 0.2, 1) 0.4s both;
            }

            .hero-scroll {
                position: absolute;
                bottom: 36px;
                left: 50%;
                transform: translateX(-50%);
                z-index: 2;
                color: rgba(255, 255, 255, 0.5);
                font-size: 28px;
                animation: bounce 2s ease infinite;
            }

            /* ===== SECTION HEADERS ===== */
            .sec-label {
                display: inline-block;
                font-size: 13px;
                font-weight: 700;
                color: var(--medical-blue);
                text-transform: uppercase;
                letter-spacing: 2px;
                margin-bottom: 12px;
                background: rgba(30, 136, 229, 0.1);
                padding: 6px 16px;
                border-radius: 20px;
            }

            .sec-title {
                font-size: 42px;
                font-weight: 800;
                color: var(--text-dark);
                margin-bottom: 18px;
                letter-spacing: -1px;
                line-height: 1.2;
            }

            .sec-desc {
                font-size: 17px;
                color: #5d7186;
                max-width: 650px;
                line-height: 1.7;
            }

            .sec-center {
                text-align: center;
            }

            .sec-center .sec-desc {
                margin: 0 auto;
            }

            .sec-white .sec-label {
                color: #fff;
                background: rgba(255, 255, 255, 0.15);
            }

            .sec-white .sec-title {
                color: #fff;
            }

            .sec-white .sec-desc {
                color: rgba(255, 255, 255, 0.85);
            }

            /* ===== 2. FEATURES ===== */
            .features-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 24px;
                margin-top: 56px;
            }

            .f-card {
                background: #fff;
                border-radius: 16px;
                padding: 48px 40px;
                box-shadow: var(--shadow-premium);
                border: 1px solid rgba(30, 41, 59, 0.04);
                transition: all 0.5s cubic-bezier(0.16, 1, 0.3, 1);
                position: relative;
            }

            .f-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 30px 60px rgba(30, 136, 229, 0.15);
                border-color: var(--medical-blue);
            }

            .f-icon {
                font-size: 44px;
                margin-bottom: 18px;
                display: inline-block;
            }

            .f-card h3 {
                font-size: 20px;
                font-weight: 700;
                color: var(--text-dark);
                margin-bottom: 12px;
            }

            .f-card p {
                font-size: 14px;
                line-height: 1.7;
                color: #5d7186;
            }

            /* ===== 3. HOW IT WORKS ===== */
            .steps-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 0;
                margin-top: 56px;
                position: relative;
            }

            .step {
                text-align: center;
                padding: 32px 20px;
                position: relative;
            }

            .step-num {
                width: 72px;
                height: 72px;
                border-radius: 50%;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                background: linear-gradient(135deg, var(--medical-blue) 0%, var(--medical-teal) 100%);
                color: #fff !important;
                font-size: 28px;
                font-weight: 700;
                margin-bottom: 24px;
                box-shadow: 0 10px 25px rgba(59, 130, 246, 0.4);
                border: 2px solid rgba(255, 255, 255, 0.3);
            }

            .step h4 {
                font-size: 16px;
                font-weight: 700;
                color: #0f172a;
                margin-bottom: 8px;
            }

            .step p {
                font-size: 13px;
                color: #64748b;
                line-height: 1.6;
            }

            .step-icon {
                font-size: 36px;
                margin-bottom: 12px;
                display: block;
            }

            /* Arrow connectors */
            .step::after {
                content: '→';
                position: absolute;
                right: -18px;
                top: 56px;
                font-size: 30px;
                color: var(--medical-blue);
                font-weight: 700;
                opacity: 0.25;
            }

            .step:last-child::after {
                display: none;
            }

            /* ===== 4. DASHBOARD PREVIEW ===== */
            .preview-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 28px;
                margin-top: 56px;
            }

            .preview-card {
                background: #fff;
                border-radius: 20px;
                padding: 48px 40px;
                border: 1px solid rgba(30, 41, 59, 0.04);
                box-shadow: var(--shadow-premium);
                transition: all 0.5s cubic-bezier(0.16, 1, 0.3, 1);
                position: relative;
            }

            .preview-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 30px 60px rgba(30, 136, 229, 0.15);
                border-color: var(--medical-blue);
            }

            .preview-card h3 {
                font-size: 20px;
                font-weight: 700;
                color: var(--text-dark);
                margin-bottom: 8px;
            }

            .preview-card p {
                font-size: 14px;
                color: #5d7186;
                line-height: 1.6;
            }

            .preview-card .preview-features {
                list-style: none;
                margin-top: 18px;
            }

            .preview-card .preview-features li {
                padding: 6px 0;
                font-size: 13px;
                color: #5d7186;
            }

            .preview-card .preview-features li::before {
                content: '✓ ';
                color: var(--medical-blue);
                font-weight: 700;
            }

            /* ===== 5. SECURITY ===== */
            .security-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 28px;
                margin-top: 56px;
            }

            .sec-card {
                background: #fff;
                border-radius: 20px;
                padding: 48px 40px;
                text-align: center;
                box-shadow: var(--shadow-premium);
                border: 1px solid rgba(30, 41, 59, 0.04);
                transition: all 0.5s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .sec-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 30px 60px rgba(30, 136, 229, 0.15);
                border-color: var(--medical-blue);
            }

            .sec-card-icon {
                font-size: 48px;
                margin-bottom: 18px;
                display: block;
            }

            .sec-card h3 {
                font-size: 20px;
                font-weight: 800;
                color: var(--text-dark);
                margin-bottom: 12px;
            }

            .sec-card p {
                font-size: 14px;
                color: #64748b;
                line-height: 1.6;
            }

            /* ===== 6. CTA BANNER ===== */
            .cta-content {
                text-align: center;
                padding: 100px 24px;
            }

            .cta-content h2 {
                font-size: 40px;
                font-weight: 800;
                color: #fff;
                margin-bottom: 16px;
                letter-spacing: -1px;
            }

            .cta-content p {
                font-size: 17px;
                color: rgba(255, 255, 255, 0.7);
                max-width: 600px;
                margin: 0 auto 36px;
                line-height: 1.7;
            }

            /* ===== 7. CONTACT ===== */
            .contact-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 28px;
                margin-top: 56px;
            }

            .c-card {
                background: #fff;
                border-radius: 20px;
                padding: 48px 40px;
                text-align: center;
                box-shadow: var(--shadow-premium);
                border: 1px solid rgba(30, 41, 59, 0.04);
                transition: all 0.5s cubic-bezier(0.16, 1, 0.3, 1);
            }

            .c-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 30px 60px rgba(30, 41, 59, 0.12);
                border-color: var(--accent-emerald);
            }

            .c-icon {
                font-size: 40px;
                margin-bottom: 18px;
                display: inline-block;
            }

            .c-card h3 {
                font-size: 18px;
                font-weight: 700;
                margin-bottom: 10px;
            }

            .c-card p {
                font-size: 14px;
                color: #64748b;
                line-height: 1.6;
            }

            .c-card a {
                color: #2DD4BF;
                font-weight: 700;
            }

            .c-card a:hover {
                text-decoration: underline;
            }

            /* ===== 8. FOOTER ===== */
            .home-footer {
                background: #fff;
                padding: 60px 48px 30px;
                border-top: 1px solid rgba(30, 136, 229, 0.1);
            }

            .footer-brand {
                color: var(--text-dark);
            }

            .footer-brand p {
                font-size: 14px;
                color: #5d7186;
                line-height: 1.7;
            }

            .footer-col h4 {
                color: var(--text-dark);
                font-size: 15px;
                font-weight: 700;
                margin-bottom: 16px;
            }

            .footer-col a {
                display: block;
                color: #5d7186;
                font-size: 14px;
                padding: 4px 0;
                transition: 0.3s;
            }

            .footer-col a:hover {
                color: var(--medical-blue);
            }

            .footer-col p {
                font-size: 14px;
                color: #5d7186;
                line-height: 1.7;
            }

            .footer-bottom {
                text-align: center;
                padding-top: 30px;
                margin-top: 30px;
                border-top: 1px solid rgba(30, 136, 229, 0.1);
            }

            .footer-bottom p {
                font-size: 13px;
                color: #94a3b8;
            }

            .footer-grid {
                display: grid;
                grid-template-columns: 2fr 1fr 1fr 1fr;
                gap: 40px;
                max-width: 1200px;
                margin: 0 auto;
            }

            .footer-brand {
                color: var(--primary-navy);
            }

            .footer-brand h3 {
                font-size: 22px;
                font-weight: 800;
                margin-bottom: 12px;
            }

            .footer-brand h3 span {
                color: var(--accent-emerald);
            }

            .footer-brand p {
                font-size: 14px;
                color: var(--text-main);
                line-height: 1.7;
                opacity: 0.8;
            }

            .footer-col h4 {
                color: var(--primary-navy);
                font-size: 15px;
                font-weight: 700;
                margin-bottom: 16px;
            }

            .footer-col a {
                display: block;
                color: var(--text-main);
                font-size: 14px;
                padding: 4px 0;
                transition: 0.3s;
                opacity: 0.7;
            }

            .footer-col a:hover {
                color: var(--accent-emerald);
                opacity: 1;
            }

            .footer-col p {
                font-size: 14px;
                color: var(--text-main);
                line-height: 1.7;
                opacity: 0.7;
            }

            .footer-bottom {
                text-align: center;
                padding-top: 30px;
                margin-top: 30px;
                border-top: 1px solid rgba(30, 41, 59, 0.05);
            }

            .footer-bottom p {
                font-size: 13px;
                color: #94a3b8;
            }

            .social-icons {
                display: flex;
                gap: 12px;
                margin-top: 16px;
            }

            .social-icons a {
                width: 36px;
                height: 36px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                background: rgba(30, 41, 59, 0.05);
                color: var(--primary-navy);
                font-size: 16px;
                transition: 0.3s;
            }

            .social-icons a:hover {
                background: var(--accent-emerald);
                color: #fff;
            }

            /* ===== HAMBURGER MENU ===== */
            .home-hamburger {
                display: none;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                width: 44px;
                height: 44px;
                background: rgba(255,255,255,0.1);
                border: 1px solid rgba(255,255,255,0.2);
                border-radius: 10px;
                cursor: pointer;
                padding: 10px;
                gap: 5px;
                transition: all 0.3s ease;
                -webkit-tap-highlight-color: transparent;
                z-index: 1001;
            }

            .top-nav.scrolled .home-hamburger {
                background: rgba(15,23,42,0.06);
                border-color: rgba(15,23,42,0.15);
            }

            .home-hamburger span {
                display: block;
                width: 22px;
                height: 2.5px;
                background: #fff;
                border-radius: 2px;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                transform-origin: center;
            }

            .top-nav.scrolled .home-hamburger span {
                background: var(--primary-navy);
            }

            .home-hamburger.active span:nth-child(1) {
                transform: rotate(45deg) translate(5px, 5px);
            }

            .home-hamburger.active span:nth-child(2) {
                opacity: 0;
                transform: scaleX(0);
            }

            .home-hamburger.active span:nth-child(3) {
                transform: rotate(-45deg) translate(5px, -5px);
            }

            /* Mobile Nav Overlay */
            .mobile-nav-overlay {
                display: none;
                position: fixed;
                inset: 0;
                background: rgba(0,0,0,0.5);
                z-index: 999;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .mobile-nav-overlay.active {
                display: block;
                opacity: 1;
            }

            /* Mobile Nav Drawer */
            .mobile-nav-drawer {
                display: none;
                position: fixed;
                top: 0;
                right: 0;
                width: 280px;
                max-width: 85vw;
                height: 100vh;
                background: var(--primary-navy);
                z-index: 1002;
                transform: translateX(100%);
                transition: transform 0.35s cubic-bezier(0.4, 0, 0.2, 1);
                padding: 80px 24px 32px;
                overflow-y: auto;
            }

            .mobile-nav-drawer.active {
                transform: translateX(0);
            }

            .mobile-nav-drawer a {
                display: block;
                padding: 16px 0;
                color: rgba(255,255,255,0.85);
                font-size: 18px;
                font-weight: 600;
                text-decoration: none;
                border-bottom: 1px solid rgba(255,255,255,0.08);
                transition: 0.3s;
            }

            .mobile-nav-drawer a:hover {
                color: var(--medical-sky);
            }

            .mobile-nav-drawer .mobile-nav-btns {
                margin-top: 24px;
                display: flex;
                flex-direction: column;
                gap: 12px;
            }

            .mobile-nav-drawer .mobile-nav-btns a {
                text-align: center;
                padding: 14px 24px;
                border-radius: 12px;
                border-bottom: none;
                font-size: 16px;
            }

            .mobile-nav-drawer .mobile-nav-btns .btn-outline {
                border: 1.5px solid rgba(255,255,255,0.3);
            }

            .mobile-nav-drawer .mobile-nav-btns .btn-primary {
                background: var(--medical-blue);
                box-shadow: 0 8px 20px rgba(59, 130, 246, 0.3);
            }

            /* ===== RESPONSIVE — LAPTOP ===== */
            @media (max-width: 1024px) {
                .top-nav {
                    padding: 18px 32px;
                }

                .features-grid,
                .security-grid,
                .contact-grid {
                    grid-template-columns: 1fr 1fr;
                }

                .steps-grid {
                    grid-template-columns: 1fr 1fr;
                    gap: 24px;
                }

                .step::after {
                    display: none;
                }

                .preview-grid {
                    grid-template-columns: 1fr;
                }

                .hero h1 {
                    font-size: 48px;
                }

                .sec-title {
                    font-size: 36px;
                }

                .footer-grid {
                    grid-template-columns: 1fr 1fr;
                    gap: 32px;
                }

                .container {
                    padding: 0 24px;
                }
            }

            /* ===== RESPONSIVE — TABLET ===== */
            @media (max-width: 768px) {
                .home-hamburger {
                    display: flex;
                }

                .mobile-nav-drawer {
                    display: block;
                }

                .nav-links,
                .nav-btns {
                    display: none;
                }

                .top-nav {
                    padding: 14px 20px;
                }

                .hero h1 {
                    font-size: 36px;
                    letter-spacing: -1px;
                }

                .hero-sub {
                    font-size: 16px;
                }

                .hero-cta {
                    flex-direction: column;
                    align-items: center;
                }

                .hero-cta .btn {
                    width: 100%;
                    max-width: 320px;
                    text-align: center;
                }

                .features-grid,
                .security-grid,
                .contact-grid,
                .steps-grid {
                    grid-template-columns: 1fr;
                    gap: 16px;
                }

                .f-card,
                .sec-card,
                .c-card,
                .preview-card {
                    padding: 32px 24px;
                }

                .sec-title {
                    font-size: 30px;
                }

                .sec-desc {
                    font-size: 15px;
                }

                .cta-content h2 {
                    font-size: 28px;
                }

                .cta-content {
                    padding: 60px 16px;
                }

                .footer-grid {
                    grid-template-columns: 1fr;
                    gap: 24px;
                }

                .home-footer {
                    padding: 40px 24px 20px;
                }

                .hero-badge {
                    font-size: 11px;
                    padding: 8px 16px;
                }

                .btn-lg {
                    padding: 16px 32px;
                    font-size: 15px;
                }

                .logo-text {
                    font-size: 22px !important;
                }

                body {
                    overflow-x: hidden;
                }
            }

            /* ===== RESPONSIVE — MOBILE ===== */
            @media (max-width: 480px) {
                .hero h1 {
                    font-size: 28px;
                }

                .hero-sub {
                    font-size: 14px;
                    margin-bottom: 28px;
                }

                .hero-content {
                    padding: 0 16px;
                }

                .sec-title {
                    font-size: 24px;
                }

                .sec-desc {
                    font-size: 14px;
                }

                .container {
                    padding: 0 16px;
                }

                .f-card,
                .sec-card,
                .c-card,
                .preview-card {
                    padding: 24px 20px;
                }

                .step {
                    padding: 20px 12px;
                }

                .step-num {
                    width: 56px;
                    height: 56px;
                    font-size: 22px;
                }

                .cta-content h2 {
                    font-size: 24px;
                }

                .home-footer {
                    padding: 32px 16px 16px;
                }

                .social-icons a {
                    width: 40px;
                    height: 40px;
                }

                .logo-text {
                    font-size: 20px !important;
                }

                .logo-icon {
                    font-size: 26px !important;
                }

                .top-nav {
                    padding: 12px 16px;
                }

                .btn-lg {
                    padding: 14px 24px;
                    font-size: 14px;
                }
            }
        </style>
    </head>

    <body>

        <!-- ===== 1. NAVBAR ===== -->
        <nav class="top-nav" id="topNav">
            <a href="#" class="logo">
                <span class="logo-icon" style="animation: pulse-glow 2.5s ease-in-out infinite;">🩺</span>
                <span class="logo-text">Smart<span>Medix</span></span>
            </a>
            <div class="nav-links">
                <a href="#home">Home</a>
                <a href="#about">About</a>
                <a href="#features">Services</a>
                <a href="#contact">Contact</a>
            </div>
            <div class="nav-btns">
                <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline">Login</a>
                <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary">Register</a>
            </div>
            <button class="home-hamburger" id="homeHamburger" aria-label="Toggle menu">
                <span></span><span></span><span></span>
            </button>
        </nav>

        <!-- Mobile Nav Drawer -->
        <div class="mobile-nav-overlay" id="mobileNavOverlay"></div>
        <div class="mobile-nav-drawer" id="mobileNavDrawer">
            <a href="#home">Home</a>
            <a href="#about">About</a>
            <a href="#features">Services</a>
            <a href="#contact">Contact</a>
            <div class="mobile-nav-btns">
                <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-outline">Login</a>
                <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary">Register</a>
            </div>
        </div>

        <section class="hero backdrop-section" id="home">
            <div class="hero-video-wrapper">
                <iframe
                    src="https://www.youtube.com/embed/fG52vMsTAak?autoplay=1&mute=1&controls=0&loop=1&playlist=fG52vMsTAak&showinfo=0&rel=0&modestbranding=1"
                    allow="autoplay; encrypted-media" frameborder="0"></iframe>
            </div>
            <div class="bd-overlay bd-overlay-elegant-dark" style="background: rgba(15, 23, 42, 0.7);"></div>
            <div class="bd-content hero-content">
                <div class="hero-badge"
                    style="background: rgba(59, 130, 246, 0.2); border: 1px solid rgba(255, 255, 255, 0.2); color: #fff; backdrop-filter: blur(15px);">
                    🚀 TRUSTED BY 500+ HEALTHCARE PROFESSIONALS</div>
                <h1 style="text-shadow: 0 10px 30px rgba(0,0,0,0.8);">Digital <span class="hl">Medical Record</span>
                    Management System</h1>
                <p class="hero-sub" style="font-weight: 500; text-shadow: 0 2px 10px rgba(0,0,0,0.8);">Secure, Smart and
                    Efficient Healthcare Data Management — empowering hospitals, doctors, and patients with a seamless
                    digital platform.</p>
                <div class="hero-cta">
                    <a href="${pageContext.request.contextPath}/auth/login" class="btn btn-primary btn-lg"
                        style="box-shadow: 0 15px 35px rgba(59, 130, 246, 0.4);">Login →</a>
                    <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-outline btn-lg"
                        style="background: rgba(255,255,255,0.1); backdrop-filter: blur(10px);">Get Started</a>
                </div>
            </div>
            <a href="#features" class="hero-scroll" style="color: #fff;">⌄</a>
        </section>


        <!-- ===== 4. FEATURES SECTION — Authentic Modern Ward ===== -->
        <section class="backdrop-section" id="features" style="padding: 120px 0;">
            <div class="bd-bg parallax-bg" data-speed="0.1"
                style="background-image: url('${pageContext.request.contextPath}/images/authentic-ward.png'); opacity: 0.15;">
            </div>
            <div class="bd-overlay bd-overlay-elegant-light"></div>
            <div class="bd-content container sec-center fade-in">
                <span class="sec-label">Service Excellence</span>
                <h2 class="sec-title" style="color: var(--primary-navy); font-weight: 600;">Refined Features for Modern
                    Care</h2>
                <p class="sec-desc">Everything you need to digitize, organize, and access medical data securely and
                    efficiently.</p>
                <div class="features-grid stagger-container">
                    <div class="f-card stagger-item">
                        <div class="f-icon">🦠</div>
                        <h3>Smart Disease Outbreak</h3>
                        <p>Monitor regional health trends in real-time. Our system detects spikes in cases, helping
                            clinics stay ahead of outbreaks with live data.</p>
                    </div>
                    <div class="f-card stagger-item">
                        <div class="f-icon">📱</div>
                        <h3>Secure QR Sharing</h3>
                        <p>Share your medical history instantly. Generate a unique QR code that allows doctors to view
                            your records via secure token-based access.</p>
                    </div>
                    <div class="f-card stagger-item">
                        <div class="f-icon">🏥</div>
                        <h3>Bed Availability Tracker</h3>
                        <p>Access a live directory of bed availability across hospitals, updated in real-time for ICUs,
                            Wards, and Oxygen support.</p>
                    </div>
                    <div class="f-card stagger-item">
                        <div class="f-icon">📈</div>
                        <h3>Health Credit Score</h3>
                        <p>Get a comprehensive view of your wellness. Our system analyzes diet, exercise, and history to
                            provide a dynamic health score.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== 4. HOW IT WORKS — Elegant Minimal ===== -->
        <section class="backdrop-section" style="padding: 120px 0; background: var(--bg-soft);">
            <div class="bd-content container sec-center fade-in">
                <span class="sec-label" style="background: rgba(30,41,59,0.05); color: var(--primary-navy);">Seamless
                    Workflow</span>
                <h2 class="sec-title" style="color: var(--primary-navy); font-weight: 600;">The SmartMedix Standard</h2>
                <p class="sec-desc">A refined, simple 4-step digital workflow designed for modern clinics.</p>
                <div class="steps-grid stagger-container">
                    <div class="step stagger-item">
                        <div class="step-icon">🧑‍💻</div>
                        <div class="step-num">1</div>
                        <h4>Step 1 – Patient Registration</h4>
                        <p>Patient creates an account and completes their medical
                            profile with personal and health details.</p>
                    </div>
                    <div class="step stagger-item">
                        <div class="step-icon">🩺</div>
                        <div class="step-num">2</div>
                        <h4>Step 2 – Doctor Consultation</h4>
                        <p>Book an appointment with any doctor. Receive
                            prescriptions and consultation notes digitally.</p>
                    </div>
                    <div class="step stagger-item">
                        <div class="step-icon">🧪</div>
                        <div class="step-num">3</div>
                        <h4>Step 3 – Lab Test & Report Upload</h4>
                        <p>Doctors request lab tests. Lab technicians upload
                            results directly to the patient's profile in real-time.</p>
                    </div>
                    <div class="step stagger-item">
                        <div class="step-icon">💾</div>
                        <div class="step-num">4</div>
                        <h4>Step 4 – Digital Medical Record Storage</h4>
                        <p>All medical data is securely stored and accessible
                            anytime — prescriptions, reports, billing, and health history.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== 5. DASHBOARD PREVIEW — Authentic Tech Overlay ===== -->
        <section class="backdrop-section" id="about" style="padding: 120px 0;">
            <div class="bd-bg parallax-bg" data-speed="0.1"
                style="background-image: url('${pageContext.request.contextPath}/images/authentic-consultation.png');">
            </div>
            <div class="bd-overlay bd-overlay-elegant-dark"></div>
            <div class="bd-content container sec-center fade-in">
                <span class="sec-label" style="background: rgba(255, 255, 255, 0.1); color: #fff;">Platform
                    Oversight</span>
                <h2 class="sec-title" style="color: #fff; font-weight: 700; text-shadow: 0 4px 15px rgba(0,0,0,0.5);">
                    Dashboards for Every Role</h2>
                <p class="sec-desc" style="color: rgba(255, 255, 255, 0.85); margin-bottom: 40px;">Tailored high-end
                    experiences for administrators, doctors, and patients.</p>
                <div class="preview-grid stagger-container">
                    <div class="preview-card stagger-item">
                        <div class="preview-icon">🛡️</div>
                        <h3>Admin Dashboard</h3>
                        <p>Complete hospital oversight and control center.</p>
                        <ul class="preview-features">
                            <li>Manage all doctors, patients, and staff</li>
                            <li>Monitor appointments and lab reports</li>
                            <li>Track all financial transactions</li>
                            <li>Handle complaints and analytics</li>
                        </ul>
                    </div>
                    <div class="preview-card stagger-item">
                        <div class="preview-icon">👨‍⚕️</div>
                        <h3>Doctor Dashboard</h3>
                        <p>Clinical workspace for medical professionals.</p>
                        <ul class="preview-features">
                            <li>View today's appointments at a glance</li>
                            <li>Write prescriptions and consultation notes</li>
                            <li>Request lab tests and view results</li>
                            <li>Track patient health timeline and billing</li>
                        </ul>
                    </div>
                    <div class="preview-card stagger-item">
                        <div class="preview-icon">🧑‍🦱</div>
                        <h3>Patient Dashboard</h3>
                        <p>Personal health hub for every patient.</p>
                        <ul class="preview-features">
                            <li>Book appointments with preferred doctors</li>
                            <li>View prescriptions and lab reports</li>
                            <li>Pay bills online and download receipts</li>
                            <li>Track complete health history timeline</li>
                        </ul>
                    </div>
                    <div class="preview-card stagger-item">
                        <div class="preview-icon">🔬</div>
                        <h3>Lab Technician Dashboard</h3>
                        <p>Efficient workspace for laboratory staff.</p>
                        <ul class="preview-features">
                            <li>View pending test requests</li>
                            <li>Upload reports directly to patient profiles</li>
                            <li>Manage report status and history</li>
                            <li>Track lab service billing payments</li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== 6. SECURITY SECTION — AI Tech Overlay ===== -->
        <section class="backdrop-section" style="padding: 140px 0; border-bottom: 1px solid rgba(255,255,255,0.05);">
            <div class="bd-bg parallax-bg" data-speed="0.1"
                style="background-image: url('${pageContext.request.contextPath}/images/ai-tech-backdrop.png');"></div>
            <div class="bd-overlay bd-overlay-elegant-dark"></div>
            <div class="bd-content container sec-center fade-in">
                <span class="sec-label"
                    style="background: rgba(255,255,255,0.15); color: #fff; backdrop-filter: blur(10px);">AI-Driven
                    Privacy</span>
                <h2 class="sec-title" style="color: #fff; font-weight: 700; text-shadow: 0 4px 15px rgba(0,0,0,0.7);">
                    Military-Grade Security</h2>
                <div
                    style="background: rgba(15, 23, 42, 0.4); backdrop-filter: blur(10px); padding: 15px 30px; border-radius: 12px; display: inline-block; margin-bottom: 40px; border: 1px solid rgba(255,255,255,0.1);">
                    <p class="sec-desc" style="color: rgba(255,255,255,1); text-shadow: none; margin-bottom: 0;">Your
                        health data is protected with industry-leading safeguards and encryption.</p>
                </div>
                <div class="security-grid stagger-container">
                    <div class="sec-card stagger-item">
                        <div class="sec-card-icon">🔐</div>
                        <h3>Secure Medical Data</h3>
                        <p>All medical records are encrypted at rest and in transit using AES-256 encryption, ensuring
                            no unauthorized access.</p>
                    </div>
                    <div class="sec-card stagger-item">
                        <div class="sec-card-icon">🛡️</div>
                        <h3>Privacy Protection</h3>
                        <p>HIPAA-compliant architecture with strict role-based access control. Only authorized personnel
                            can view sensitive data.</p>
                    </div>
                    <div class="sec-card stagger-item">
                        <div class="sec-card-icon">🔑</div>
                        <h3>Encrypted Patient Records</h3>
                        <p>Every patient record is individually encrypted with unique keys. Comprehensive audit trails
                            track every data access.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== 7. CTA BANNER — Authentic Operations ===== -->
        <section class="backdrop-section" style="padding: 0; border-top: 2px solid var(--medical-blue);">
            <div class="bd-bg parallax-bg" data-speed="0.1"
                style="background-image: url('${pageContext.request.contextPath}/images/ai-tech-backdrop.png');"></div>
            <div class="bd-overlay bd-overlay-elegant-dark"></div>
            <div class="bd-content cta-content fade-in" style="padding: 140px 24px;">
                <h2 style="font-weight: 700; text-shadow: 0 4px 15px rgba(0,0,0,0.7);">Start Managing Medical Records
                    Digitally Today</h2>
                <div
                    style="max-width: 750px; margin: 0 auto; background: rgba(255,255,255,0.1); backdrop-filter: blur(15px); padding: 24px; border-radius: 20px; border: 1.5px solid rgba(255,255,255,0.2); margin-bottom: 40px; box-shadow: 0 20px 40px rgba(0,0,0,0.2);">
                    <p style="color: #fff; margin-bottom: 0; font-size: 19px; font-weight: 500;">Secure, smart and
                        efficient healthcare data management for institutions and clinics.</p>
                </div>
                <a href="${pageContext.request.contextPath}/auth/register" class="btn btn-primary btn-lg"
                    style="box-shadow: 0 20px 40px rgba(59, 130, 246, 0.4); padding: 22px 54px;">Register Now</a>
            </div>
        </section>

        <!-- ===== 8. CONTACT — Elegant Clean ===== -->
        <section style="padding: 120px 0; background: var(--bg-soft);" id="contact">
            <div class="container sec-center fade-in">
                <span class="sec-label" style="background: rgba(30,41,59,0.05); color: var(--primary-navy);">Concierge
                    Support</span>
                <h2 class="sec-title" style="color: var(--primary-navy); font-weight: 600;">Reach Our Team</h2>
                <p class="sec-desc">Have questions about SmartMedix? Our medical tech specialists are here to assist.
                </p>
                <div class="contact-grid stagger-container">
                    <div class="c-card stagger-item">
                        <div class="c-icon">📧</div>
                        <h3>Email Us</h3>
                        <p><a href="mailto:support@smartmedix.com">support@smartmedix.com</a></p>
                        <p style="margin-top:6px;"><a href="mailto:info@smartmedix.com">info@smartmedix.com</a></p>
                    </div>
                    <div class="c-card stagger-item">
                        <div class="c-icon">📞</div>
                        <h3>Call Us</h3>
                        <p><a href="tel:+911234567890">+91 123 456 7890</a></p>
                        <p style="margin-top:6px;"><a href="tel:+911800123456">+91 1800 123 456</a> (Toll Free)</p>
                    </div>
                    <div class="c-card stagger-item">
                        <div class="c-icon">📍</div>
                        <h3>Visit Us</h3>
                        <p>SmartMedix Technologies<br>Tech Park, Bengaluru<br>Karnataka, India – 560001</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===== 9. FOOTER ===== -->
        <footer class="home-footer">
            <div class="footer-grid">
                <div class="footer-brand">
                    <h3>🩺 Smart<span>Medix</span></h3>
                    <p>Revolutionizing healthcare data management with secure, intelligent, and connected digital
                        solutions for hospitals, doctors, and patients worldwide.</p>
                    <div class="social-icons">
                        <a href="#">🐦</a>
                        <a href="#">📘</a>
                        <a href="#">💼</a>
                        <a href="#">📷</a>
                    </div>
                </div>
                <div class="footer-col">
                    <h4>Quick Links</h4>
                    <a href="#home">Home</a>
                    <a href="#features">Services</a>
                    <a href="#about">About</a>
                    <a href="#contact">Contact</a>
                </div>
                <div class="footer-col">
                    <h4>Platform</h4>
                    <a href="${pageContext.request.contextPath}/auth/login">Login</a>
                    <a href="${pageContext.request.contextPath}/auth/register">Register</a>
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                </div>
                <div class="footer-col">
                    <h4>Contact Information</h4>
                    <p>📧 Email: support@smartmedix.com</p>
                    <p style="margin-top: 8px;">📞 Phone: +91 123 456 7890</p>
                    <p style="margin-top: 8px;">📍 Visit Us: Bengaluru, India</p>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 SmartMedix Technologies. All Rights Reserved. | Digital Medical Record Management System
                </p>
            </div>
        </footer>

        <!-- ===== SCRIPTS ===== -->
        <script>
            // Navbar scroll effect
            window.addEventListener('scroll', function () {
                var nav = document.getElementById('topNav');
                if (window.scrollY > 60) {
                    nav.classList.add('scrolled');
                } else {
                    nav.classList.remove('scrolled');
                }
            });

            // Parallax scroll effect
            window.addEventListener('scroll', function () {
                var parallaxElements = document.querySelectorAll('.parallax-bg');
                var scrolled = window.pageYOffset;

                parallaxElements.forEach(function (el) {
                    var speed = el.getAttribute('data-speed') || 0.5;
                    var offset = el.parentElement.offsetTop;
                    var translateValue = (scrolled - offset) * speed;
                    el.style.transform = 'translateY(' + translateValue + 'px) scale(1.1)';
                });
            });

            // Scroll-triggered animations with staggered support
            var faders = document.querySelectorAll('.fade-in, .stagger-item');
            var observer = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.isIntersecting) {
                        if (entry.target.parentElement.classList.contains('stagger-container')) {
                            var siblings = Array.from(entry.target.parentElement.querySelectorAll('.stagger-item'));
                            var index = siblings.indexOf(entry.target);
                            setTimeout(function () {
                                entry.target.classList.add('visible');
                            }, index * 150);
                        } else {
                            entry.target.classList.add('visible');
                        }
                    }
                });
            }, { threshold: 0.15 });
            faders.forEach(function (el) { observer.observe(el); });

            // Mobile hamburger menu
            (function() {
                var hamburger = document.getElementById('homeHamburger');
                var drawer = document.getElementById('mobileNavDrawer');
                var overlay = document.getElementById('mobileNavOverlay');
                if (!hamburger || !drawer || !overlay) return;

                function toggleMenu() {
                    var isOpen = drawer.classList.contains('active');
                    if (isOpen) {
                        closeMenu();
                    } else {
                        openMenu();
                    }
                }

                function openMenu() {
                    drawer.classList.add('active');
                    overlay.classList.add('active');
                    hamburger.classList.add('active');
                    document.body.style.overflow = 'hidden';
                }

                function closeMenu() {
                    drawer.classList.remove('active');
                    overlay.classList.remove('active');
                    hamburger.classList.remove('active');
                    document.body.style.overflow = '';
                }

                hamburger.addEventListener('click', function(e) {
                    e.stopPropagation();
                    toggleMenu();
                });

                overlay.addEventListener('click', closeMenu);

                // Close on nav link click
                var drawerLinks = drawer.querySelectorAll('a');
                drawerLinks.forEach(function(link) {
                    link.addEventListener('click', closeMenu);
                });

                // Close on Escape
                document.addEventListener('keydown', function(e) {
                    if (e.key === 'Escape') closeMenu();
                });

                // Auto-close on resize to desktop
                window.addEventListener('resize', function() {
                    if (window.innerWidth > 768) closeMenu();
                });
            })();
        </script>

    </body>

    </html>