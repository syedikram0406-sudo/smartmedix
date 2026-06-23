package com.entity.controller;

import com.entity.model.*;
import com.entity.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.TemporalAdjusters;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private DoctorService doctorService;
    @Autowired
    private PatientService patientService;
    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private LabReportService labReportService;
    @Autowired
    private ComplaintService complaintService;
    @Autowired
    private UserService userService;
    @Autowired
    private InsuranceService insuranceService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private HospitalService hospitalService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        model.addAttribute("totalPatients", patientService.count());
        model.addAttribute("totalDoctors", doctorService.count());
        model.addAttribute("totalAppointments", appointmentService.count());
        model.addAttribute("totalLabReports", labReportService.count());
        model.addAttribute("pendingComplaints", complaintService.findPending().size());
        return "admin/dashboard";
    }

    // ---- Doctor Management ----
    @GetMapping("/doctors")
    public String doctors(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        model.addAttribute("doctors", doctorService.findAll());
        return "admin/doctors";
    }

    @PostMapping("/doctors/add")
    public String addDoctor(@RequestParam String name, @RequestParam String department,
            @RequestParam(required = false) String specialization,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String email,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        Doctor doctor = new Doctor();
        doctor.setName(name);
        doctor.setDepartment(department);
        doctor.setSpecialization(specialization);
        doctor.setPhone(phone);
        doctor.setEmail(email);
        doctor.setStatus("Active");

        // Create user account for doctor
        User user = new User();
        user.setUsername(name.toLowerCase().replaceAll("\\s+", "."));
        user.setPassword("doctor123");
        user.setFullName(name);
        user.setEmail(email != null ? email : name.toLowerCase().replaceAll("\\s+", "") + "@hospital.com");
        user.setRole(User.Role.DOCTOR);
        userService.register(user);
        doctor.setUser(user);

        doctorService.save(doctor);
        return "redirect:/admin/doctors";
    }

    @PostMapping("/doctors/update")
    public String updateDoctor(@RequestParam Long id, @RequestParam String name,
            @RequestParam String department,
            @RequestParam(required = false) String specialization,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String email,
            @RequestParam String status, HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        doctorService.findById(id).ifPresent(d -> {
            d.setName(name);
            d.setDepartment(department);
            d.setSpecialization(specialization);
            d.setPhone(phone);
            d.setEmail(email);
            d.setStatus(status);
            doctorService.save(d);
        });
        return "redirect:/admin/doctors";
    }

    @GetMapping("/doctors/delete/{id}")
    public String deleteDoctor(@PathVariable Long id, HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        doctorService.deleteById(id);
        return "redirect:/admin/doctors";
    }

    // ---- Patient Management ----
    @GetMapping("/patients")
    public String patients(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        model.addAttribute("patients", patientService.findAll());
        return "admin/patients";
    }

    @PostMapping("/patients/add")
    public String addPatient(@RequestParam String name, @RequestParam(required = false) Integer age,
            @RequestParam(required = false) String gender,
            @RequestParam(required = false) String bloodGroup,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String email,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        Patient patient = new Patient();
        patient.setName(name);
        patient.setAge(age);
        patient.setGender(gender);
        patient.setBloodGroup(bloodGroup);
        patient.setPhone(phone);
        patient.setEmail(email);

        // Create user account
        User user = new User();
        user.setUsername(name.toLowerCase().replaceAll("\\s+", "."));
        user.setPassword("patient123");
        user.setFullName(name);
        user.setEmail(email != null ? email : name.toLowerCase().replaceAll("\\s+", "") + "@patient.com");
        user.setRole(User.Role.PATIENT);
        userService.register(user);
        patient.setUser(user);

        patientService.save(patient);
        return "redirect:/admin/patients";
    }

    @GetMapping("/patient-records/{id}")
    public String patientRecords(@PathVariable Long id, HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        patientService.findById(id).ifPresent(p -> model.addAttribute("patient", p));
        model.addAttribute("appointments", appointmentService.findByPatientId(id));
        model.addAttribute("labReports", labReportService.findByPatientId(id));
        return "admin/patient-records";
    }

    // ---- Appointment Management ----
    @GetMapping("/appointments")
    public String appointments(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        model.addAttribute("appointments", appointmentService.findAll());
        return "admin/appointments";
    }

    @PostMapping("/appointments/status")
    public String updateAppointmentStatus(@RequestParam Long id, @RequestParam String status,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        appointmentService.findById(id).ifPresent(a -> {
            a.setStatus(status);
            appointmentService.save(a);
        });
        return "redirect:/admin/appointments";
    }

    @GetMapping("/appointments/delete/{id}")
    public String deleteAppointment(@PathVariable Long id, HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        appointmentService.deleteById(id);
        return "redirect:/admin/appointments";
    }

    // ---- Lab Report Monitoring ----
    @GetMapping("/lab-reports")
    public String labReports(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        model.addAttribute("labReports", labReportService.findAll());
        return "admin/lab-reports";
    }

    // ---- Analytics ----
    @GetMapping("/analytics")
    public String analytics(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";

        // Department-wise patient count
        List<Doctor> allDoctors = doctorService.findAll();
        Map<String, Long> deptCount = allDoctors.stream()
                .collect(Collectors.groupingBy(Doctor::getDepartment, Collectors.counting()));
        model.addAttribute("departmentStats", deptCount);

        // Revenue Analytics
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime monthStart = now.with(TemporalAdjusters.firstDayOfMonth()).with(LocalTime.MIN);
        LocalDateTime yearStart = now.with(TemporalAdjusters.firstDayOfYear()).with(LocalTime.MIN);

        model.addAttribute("monthlyRevenue", paymentService.getMonthlyRevenueHistory(6));
        model.addAttribute("yearlyRevenue", paymentService.getRevenueBreakdown(yearStart, now));

        model.addAttribute("totalPatients", patientService.count());
        model.addAttribute("totalDoctors", doctorService.count());
        model.addAttribute("totalAppointments", appointmentService.count());
        return "admin/analytics";
    }

    // ---- Complaint Management ----
    @GetMapping("/complaints")
    public String complaints(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        model.addAttribute("complaints", complaintService.findAll());
        return "admin/complaints";
    }

    @PostMapping("/complaints/resolve")
    public String resolveComplaint(@RequestParam Long id, @RequestParam String resolution,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        complaintService.resolve(id, resolution);
        return "redirect:/admin/complaints";
    }

    // ---- Insurance Management ----
    @GetMapping("/insurance-requests")
    public String insuranceRequests(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        model.addAttribute("insurances", insuranceService.findAll());
        return "admin/insurance-requests";
    }

    @PostMapping("/insurance/status")
    public String updateInsuranceStatus(@RequestParam Long id, @RequestParam String status, HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        insuranceService.findById(id).ifPresent(ins -> {
            ins.setStatus(status);
            insuranceService.save(ins);
        });
        return "redirect:/admin/insurance-requests";
    }

    private boolean isAdmin(HttpSession session) {
        return "ADMIN".equals(session.getAttribute("role"));
    }

    // ---- Hospital Bed Management ----
    @GetMapping("/hospitals")
    public String hospitals(HttpSession session, Model model) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        model.addAttribute("hospitals", hospitalService.findAll());
        return "admin/hospitals";
    }

    @PostMapping("/hospitals/update-beds")
    public String updateBeds(@RequestParam Long id,
            @RequestParam int icuBedsAvailable,
            @RequestParam int oxygenBedsAvailable,
            @RequestParam int generalBedsAvailable,
            HttpSession session) {
        if (!isAdmin(session))
            return "redirect:/auth/login";
        hospitalService.findById(id).ifPresent(h -> {
            h.setIcuBedsAvailable(icuBedsAvailable);
            h.setOxygenBedsAvailable(oxygenBedsAvailable);
            h.setGeneralBedsAvailable(generalBedsAvailable);
            hospitalService.save(h);
        });
        return "redirect:/admin/hospitals";
    }
}
