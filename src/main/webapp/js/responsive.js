/**
 * SmartMedix - Responsive Navigation Controller
 * Handles hamburger menu, sidebar drawer, and mobile interactions
 * Shared across all dashboard pages (admin, doctor, patient, lab)
 */
(function () {
    'use strict';

    // Wait for DOM
    document.addEventListener('DOMContentLoaded', function () {
        var hamburgerBtn = document.getElementById('hamburgerBtn');
        var sidebar = document.querySelector('.sidebar');
        var sidebarOverlay = document.getElementById('sidebarOverlay');

        if (!hamburgerBtn || !sidebar || !sidebarOverlay) return;

        // Toggle sidebar
        function toggleSidebar() {
            var isOpen = sidebar.classList.contains('open');
            if (isOpen) {
                closeSidebar();
            } else {
                openSidebar();
            }
        }

        function openSidebar() {
            sidebar.classList.add('open');
            sidebarOverlay.classList.add('active');
            hamburgerBtn.classList.add('active');
            document.body.style.overflow = 'hidden';
        }

        function closeSidebar() {
            sidebar.classList.remove('open');
            sidebarOverlay.classList.remove('active');
            hamburgerBtn.classList.remove('active');
            document.body.style.overflow = '';
        }

        // Event listeners
        hamburgerBtn.addEventListener('click', function (e) {
            e.stopPropagation();
            toggleSidebar();
        });

        sidebarOverlay.addEventListener('click', function () {
            closeSidebar();
        });

        // Close sidebar on nav link click (mobile)
        var navLinks = sidebar.querySelectorAll('.sidebar-nav a');
        navLinks.forEach(function (link) {
            link.addEventListener('click', function () {
                if (window.innerWidth <= 768) {
                    closeSidebar();
                }
            });
        });

        // Close on Escape key
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                closeSidebar();
            }
        });

        // Auto-close sidebar when resizing to desktop
        var resizeTimer;
        window.addEventListener('resize', function () {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(function () {
                if (window.innerWidth > 768) {
                    closeSidebar();
                }
            }, 150);
        });

        // Prevent body scroll when sidebar is open on touch devices
        sidebar.addEventListener('touchmove', function (e) {
            if (sidebar.classList.contains('open')) {
                e.stopPropagation();
            }
        }, { passive: true });

        // Swipe to close sidebar
        var touchStartX = 0;
        var touchEndX = 0;

        sidebar.addEventListener('touchstart', function (e) {
            touchStartX = e.changedTouches[0].screenX;
        }, { passive: true });

        sidebar.addEventListener('touchend', function (e) {
            touchEndX = e.changedTouches[0].screenX;
            var swipeDistance = touchStartX - touchEndX;
            if (swipeDistance > 50) {
                closeSidebar();
            }
        }, { passive: true });

        // Swipe from left edge to open sidebar
        document.addEventListener('touchstart', function (e) {
            touchStartX = e.changedTouches[0].screenX;
        }, { passive: true });

        document.addEventListener('touchend', function (e) {
            touchEndX = e.changedTouches[0].screenX;
            var swipeDistance = touchEndX - touchStartX;
            if (touchStartX < 30 && swipeDistance > 60 && window.innerWidth <= 768) {
                openSidebar();
            }
        }, { passive: true });
    });
})();
