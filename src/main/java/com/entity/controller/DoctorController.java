package com.entity.controller;

import com.entity.model.*;
import com.entity.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/doctor")
public class DoctorController {

    @Autowired
    private DoctorService doctorService;
    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private PatientService patientService;
    @Autowired
    private PrescriptionService prescriptionService;
    @Autowired
    private LabTestRequestService labTestRequestService;
    @Autowired
    private LabReportService labReportService;
    @Autowired
    private BillService billService;
    @Autowired
    private ConsultationNoteService consultationNoteService;
    @Autowired
    private InsuranceService insuranceService;
    @Autowired
    private QrShareTokenService qrShareTokenService;
    @Autowired
    private HealthScoreService healthScoreService;
    @Autowired
    private DietPlanService dietPlanService;
    @Autowired
    private DiseaseReportService diseaseReportService;

    @PostMapping("/prescribe-diet")
    public String prescribeDiet(@RequestParam Long patientId,
                              @RequestParam String breakfast,
                              @RequestParam String lunch,
                              @RequestParam String dinner,
                              @RequestParam String drinks,
                              @RequestParam int steps,
                              @RequestParam int exercise,
                              @RequestParam int dietScore,
                              @RequestParam int exerciseScore,
                              @RequestParam int duration,
                              @RequestParam(required = false) String redirectSource,
                              HttpSession session,
                              org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        if (!isDoctor(session)) return "redirect:/auth/login";
        Doctor doctor = getCurrentDoctor(session);
        Patient patient = patientService.findById(patientId).orElse(null);
        
        if (doctor != null && patient != null) {
            dietPlanService.prescribeDiet(patient, doctor, breakfast, lunch, dinner, drinks, steps, exercise, dietScore, exerciseScore, duration);
            redirectAttributes.addFlashAttribute("message", "✅ Diet & Health Plan saved and sent to " + patient.getName() + " successfully!");
        }

        if ("dashboard".equals(redirectSource)) {
            return "redirect:/doctor/dashboard";
        }
        return "redirect:/doctor/patient-records/" + patientId;
    }

    @PostMapping("/update-availability")
    public String updateAvailability(@RequestParam String status, HttpSession session) {
        Doctor doctor = getCurrentDoctor(session);
        if (doctor != null) {
            doctorService.updateAvailability(doctor.getId(), status);
        }
        return "redirect:/doctor/dashboard";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        Doctor doctor = getCurrentDoctor(session);
        if (doctor == null)
            return "redirect:/auth/login";

        List<Appointment> appointments = appointmentService.findByDoctorId(doctor.getId());
        long todayAppts = appointments.stream()
                .filter(a -> a.getAppointmentDate() != null && a.getAppointmentDate().equals(LocalDate.now()))
                .count();
        long completed = appointments.stream().filter(a -> "Completed".equals(a.getStatus())).count();
        long pending = appointments.stream()
                .filter(a -> "Pending".equals(a.getStatus()) || "Approved".equals(a.getStatus())).count();

        model.addAttribute("todayAppointments", todayAppts);
        model.addAttribute("completedConsultations", completed);
        model.addAttribute("pendingAppointments", pending);
        model.addAttribute("totalPatients", patientService.count());
        model.addAttribute("doctor", doctor);
        
        // Add patients for diet prescription
        model.addAttribute("patients", patientService.findAll());
        
        return "doctor/dashboard";
    }

    @GetMapping("/appointments")
    public String appointments(HttpSession session, Model model) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        Doctor doctor = getCurrentDoctor(session);
        if (doctor == null)
            return "redirect:/auth/login";

        List<Appointment> appointments = appointmentService.findByDoctorId(doctor.getId());
        model.addAttribute("appointments", appointments);

        // Map Appointment IDs to Payment Statuses
        java.util.Map<Long, String> paymentStatusMap = new java.util.HashMap<>();
        List<Bill> consultationBills = billService.findAll().stream()
                .filter(b -> "CONSULTATION".equals(b.getServiceType()))
                .collect(Collectors.toList());

        for (Appointment appt : appointments) {
            boolean isPaid = consultationBills.stream()
                .filter(b -> b.getServiceId() != null && b.getServiceId().equals(appt.getId()))
                .anyMatch(b -> "PAID".equals(b.getStatus()));

            if (isPaid) {
                paymentStatusMap.put(appt.getId(), "PAID");
            } else {
                consultationBills.stream()
                    .filter(b -> b.getServiceId() != null && b.getServiceId().equals(appt.getId()))
                    .max(java.util.Comparator.comparing(Bill::getId))
                    .ifPresent(b -> paymentStatusMap.put(appt.getId(), b.getStatus()));
            }
        }
        model.addAttribute("paymentStatusMap", paymentStatusMap);

        return "doctor/appointments";
    }

    @PostMapping("/appointments/status")
    public String updateStatus(@RequestParam Long id, @RequestParam String status, HttpSession session) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        appointmentService.findById(id).ifPresent(a -> {
            a.setStatus(status);
            appointmentService.save(a);
        });
        return "redirect:/doctor/appointments";
    }

    @GetMapping("/patient-records/{patientId}")
    public String patientRecords(@PathVariable Long patientId, HttpSession session, Model model) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        Doctor doctor = getCurrentDoctor(session);
        patientService.findById(patientId).ifPresent(p -> {
            model.addAttribute("patient", p);
            HealthScore latest = healthScoreService.getLatestScore(p);
            model.addAttribute("healthScore", latest);
            model.addAttribute("healthInsights", healthScoreService.getInsightsList(latest));
        });
        model.addAttribute("prescriptions", prescriptionService.findByPatientId(patientId));
        model.addAttribute("labReports", labReportService.findByPatientId(patientId));
        model.addAttribute("insurances", insuranceService.findByPatientId(patientId));
        model.addAttribute("notes",
                doctor != null ? consultationNoteService.findByDoctorAndPatient(doctor.getId(), patientId)
                        : consultationNoteService.findByPatientId(patientId));
        model.addAttribute("patients", patientService.findAll());
        return "doctor/patient-records";
    }

    @GetMapping("/prescription")
    public String prescriptionForm(HttpSession session, Model model) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        model.addAttribute("patients", patientService.findAll());
        return "doctor/prescription";
    }

    @PostMapping("/prescription/add")
    public String addPrescription(@RequestParam Long patientId, @RequestParam String medicineName,
            @RequestParam String dosage, @RequestParam String duration,
            @RequestParam(required = false) String instructions,
            HttpSession session) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        Doctor doctor = getCurrentDoctor(session);
        if (doctor == null)
            return "redirect:/auth/login";

        Prescription p = new Prescription();
        p.setDoctor(doctor);
        patientService.findById(patientId).ifPresent(p::setPatient);
        p.setMedicineName(medicineName);
        p.setDosage(dosage);
        p.setDuration(duration);
        p.setInstructions(instructions);
        p.setPrescriptionDate(LocalDate.now());
        prescriptionService.save(p);
        return "redirect:/doctor/prescription?success=true";
    }

    @GetMapping("/lab-request")
    public String labRequestForm(HttpSession session, Model model) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        Doctor doctor = getCurrentDoctor(session);
        model.addAttribute("patients", patientService.findAll());
        if (doctor != null) {
            model.addAttribute("requests", labTestRequestService.findByDoctorId(doctor.getId()));
        }
        return "doctor/lab-request";
    }

    @PostMapping("/lab-request/add")
    public String addLabRequest(@RequestParam Long patientId, @RequestParam String testName,
            @RequestParam(required = false) String description,
            @RequestParam(required = false) String urgency,
            HttpSession session) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        Doctor doctor = getCurrentDoctor(session);
        if (doctor == null)
            return "redirect:/auth/login";

        LabTestRequest req = new LabTestRequest();
        req.setDoctor(doctor);
        patientService.findById(patientId).ifPresent(req::setPatient);
        req.setTestName(testName);
        req.setDescription(description);
        req.setUrgency(urgency != null ? urgency : "Normal");
        req.setRequestDate(LocalDate.now());
        labTestRequestService.save(req);
        return "redirect:/doctor/lab-request?success=true";
    }

    @GetMapping("/consultation-notes")
    public String consultationNotes(HttpSession session, Model model) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        model.addAttribute("patients", patientService.findAll());
        return "doctor/consultation-notes";
    }

    @PostMapping("/consultation-notes/add")
    public String addNote(@RequestParam Long patientId, @RequestParam String noteText,
            HttpSession session) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        Doctor doctor = getCurrentDoctor(session);
        if (doctor == null)
            return "redirect:/auth/login";

        ConsultationNote note = new ConsultationNote();
        note.setDoctor(doctor);
        patientService.findById(patientId).ifPresent(note::setPatient);
        note.setNoteText(noteText);
        note.setNoteDate(LocalDate.now());
        consultationNoteService.save(note);
        return "redirect:/doctor/consultation-notes?success=true";
    }

    @GetMapping("/consultation-notes/{patientId}")
    public String viewNotes(@PathVariable Long patientId, HttpSession session, Model model) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        Doctor doctor = getCurrentDoctor(session);
        patientService.findById(patientId).ifPresent(p -> model.addAttribute("patient", p));
        model.addAttribute("notes",
                doctor != null ? consultationNoteService.findByDoctorAndPatient(doctor.getId(), patientId)
                        : consultationNoteService.findByPatientId(patientId));
        model.addAttribute("patients", patientService.findAll());
        return "doctor/consultation-notes";
    }

    private boolean isDoctor(HttpSession session) {
        return "DOCTOR".equals(session.getAttribute("role"));
    }

    private Doctor getCurrentDoctor(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return null;
        List<Doctor> doctors = doctorService.findAll();
        return doctors.stream().filter(d -> d.getUser() != null && d.getUser().getId().equals(user.getId()))
                .findFirst().orElse(null);
    }

    @GetMapping("/qr/scan")
    public String qrScanPage(HttpSession session, Model model) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        return "doctor/qr-scan";
    }

    @PostMapping("/qr/verify")
    public String verifyQrToken(@RequestParam String token, HttpSession session, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        if (!isDoctor(session))
            return "redirect:/auth/login";
        Optional<Patient> patientOpt = qrShareTokenService.validateAndConsume(token);
        if (patientOpt.isPresent()) {
            return "redirect:/doctor/patient-records/" + patientOpt.get().getId();
        }
        redirectAttributes.addFlashAttribute("qrError", "Invalid, expired, or already used QR token.");
        return "redirect:/doctor/qr/scan";
    }

    @GetMapping("/disease-trends")
    @ResponseBody
    public java.util.Map<String, Object> diseaseTrends(HttpSession session) {
        if (!isDoctor(session)) {
            java.util.Map<String, Object> err = new java.util.HashMap<>();
            err.put("error", "Unauthorized");
            return err;
        }
        return diseaseReportService.getTrends();
    }

    @PostMapping("/report-disease")
    @ResponseBody
    public java.util.Map<String, Object> reportDisease(@RequestParam String disease, @RequestParam String city, @RequestParam(defaultValue = "1") int count, HttpSession session) {
        if (!isDoctor(session)) {
            java.util.Map<String, Object> err = new java.util.HashMap<>();
            err.put("error", "Unauthorized");
            return err;
        }
        diseaseReportService.reportDisease(disease, city, count);
        return diseaseReportService.getTrends();
    }
}
