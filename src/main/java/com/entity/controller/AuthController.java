package com.entity.controller;

import com.entity.model.*;
import com.entity.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private EmailService emailService;

    @Autowired
    private UserService userService;

    @Autowired
    private DoctorService doctorService;

    @Autowired
    private PatientService patientService;

    @GetMapping("/login")
    public String loginPage() {
        return "auth/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password,
            HttpSession session, Model model) {
        User user = userService.login(username, password);
        if (user == null) {
            model.addAttribute("error", "Invalid username or password");
            return "auth/login";
        }
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getId());
        session.setAttribute("role", user.getRole().name());

        switch (user.getRole()) {
            case ADMIN:
                return "redirect:/admin/dashboard";
            case DOCTOR:
                return "redirect:/doctor/dashboard";
            case PATIENT:
                return "redirect:/patient/dashboard";
            case LAB_TECHNICIAN:
                return "redirect:/lab/dashboard";
            default:
                return "redirect:/auth/login";
        }
    }

    @GetMapping("/register")
    public String registerPage() {
        return "auth/register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username, @RequestParam String password,
            @RequestParam String fullName, @RequestParam String email,
            @RequestParam String role, Model model, HttpSession session) {
        if (userService.existsByUsername(username)) {
            model.addAttribute("error", "Username already exists");
            return "auth/register";
        }
        if (userService.existsByEmail(email)) {
            model.addAttribute("error", "Email already exists");
            return "auth/register";
        }

        String otp = userService.generateOTP();
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setRole(User.Role.valueOf(role));
        user.setOtp(otp);
        user.setVerified(false);
        userService.register(user);

        try {
            emailService.sendOTP(email, otp);
            session.setAttribute("verificationEmail", email);
            model.addAttribute("success", "OTP has been sent to your email. Please verify.");
            return "auth/otp-verification";
        } catch (Exception e) {
            model.addAttribute("error", "Error sending OTP. Please try again later.");
            return "auth/register";
        }
    }

    @GetMapping("/verify-otp")
    public String verifyOtpPage() {
        return "auth/otp-verification";
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam String otp, @RequestParam String email, Model model) {
        if (userService.verifyOTP(email, otp)) {
            Optional<User> userOpt = userService.findByEmail(email);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                // Auto-create profile based on role after verification
                if (user.getRole() == User.Role.DOCTOR) {
                    Doctor doctor = new Doctor();
                    doctor.setName(user.getFullName());
                    doctor.setDepartment("General");
                    doctor.setEmail(user.getEmail());
                    doctor.setUser(user);
                    doctorService.save(doctor);
                } else if (user.getRole() == User.Role.PATIENT) {
                    Patient patient = new Patient();
                    patient.setName(user.getFullName());
                    patient.setEmail(user.getEmail());
                    patient.setUser(user);
                    patientService.save(patient);
                }
            }
            model.addAttribute("success", "OTP Verified Successfully! You can now login.");
            return "auth/login";
        } else {
            model.addAttribute("error", "Invalid OTP. Please try again.");
            model.addAttribute("unverifiedEmail", email);
            return "auth/otp-verification";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }

    @GetMapping("/")
    public String root() {
        return "redirect:/auth/login";
    }
}
