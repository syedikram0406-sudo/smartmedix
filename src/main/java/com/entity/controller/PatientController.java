package com.entity.controller;

import com.entity.model.*;
import com.entity.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.stream.Collectors;
import java.util.List;
import java.util.Optional;
import com.entity.model.QrShareToken;

@Controller
@RequestMapping("/patient")
public class PatientController {

    @Autowired
    private PatientService patientService;
    @Autowired
    private DoctorService doctorService;
    @Autowired
    private AppointmentService appointmentService;
    @Autowired
    private PrescriptionService prescriptionService;
    @Autowired
    private LabReportService labReportService;
    @Autowired
    private MedicineReminderService medicineReminderService;
    @Autowired
    private BillService billService;
    @Autowired
    private PaymentService paymentService;
    @Autowired
    private PdfReportService pdfReportService;
    @Autowired
    private ComplaintService complaintService;
    @Autowired
    private InsuranceService insuranceService;
    @Autowired
    private LabTestRequestService labTestRequestService;
    @Autowired
    private QrShareTokenService qrShareTokenService;
    @Autowired
    private DiseaseReportService diseaseReportService;
    @Autowired
    private HospitalService hospitalService;
    @Autowired
    private HealthScoreService healthScoreService;
    @Autowired
    private DietPlanService dietPlanService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";

        // Seed sample bills if none exist
        if (billService.findByPatientId(patient.getId()).isEmpty()) {
            seedSampleBills(patient);
        }

        List<Appointment> appointments = appointmentService.findByPatientId(patient.getId());
        long upcoming = appointments.stream()
                .filter(a -> a.getAppointmentDate() != null && !a.getAppointmentDate().isBefore(LocalDate.now())
                        && !"Cancelled".equals(a.getStatus()) && !"Completed".equals(a.getStatus()))
                .count();

        model.addAttribute("upcomingAppointments", upcoming);
        model.addAttribute("labReportsCount", labReportService.findByPatientId(patient.getId()).size());
        model.addAttribute("prescriptionsCount", prescriptionService.findByPatientId(patient.getId()).size());
        model.addAttribute("reminders", medicineReminderService.findActiveByPatientId(patient.getId()));
        model.addAttribute("doctors", doctorService.findAll());

        List<LabTestRequest> pendingLabRequests = labTestRequestService.findByPatientId(patient.getId()).stream()
            .filter(req -> {
                if ("Pending".equals(req.getStatus())) return true;
                
                List<Bill> relatedBills = billService.findByPatientId(patient.getId()).stream()
                           .filter(b -> "LAB".equals(b.getServiceType()) && req.getId().equals(b.getServiceId()))
                           .collect(Collectors.toList());
                           
                boolean hasPaid = relatedBills.stream().anyMatch(b -> "PAID".equals(b.getStatus()));
                if (hasPaid) return false;
                
                return relatedBills.stream().anyMatch(b -> "UNPAID".equals(b.getStatus()));
            })
            .collect(Collectors.toList());
        model.addAttribute("pendingLabRequests", pendingLabRequests);

        // Health Score & Diet Plan Data
        HealthScore latestScore = healthScoreService.getLatestScore(patient);
        model.addAttribute("healthScore", latestScore);
        model.addAttribute("healthTips", healthScoreService.getInsightsList(latestScore));
        model.addAttribute("latestDietPlan", dietPlanService.getLatestPlan(patient));
        model.addAttribute("patient", patient);

        return "patient/dashboard";
    }

    @GetMapping("/book-appointment")
    public String bookAppointmentForm(@RequestParam(required = false) Long doctorId, HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        model.addAttribute("doctors", doctorService.findByStatus("Active"));
        model.addAttribute("preSelectedDoctorId", doctorId);
        return "patient/book-appointment";
    }

    @PostMapping("/book-appointment")
    public String bookAppointment(@RequestParam Long doctorId, @RequestParam String appointmentDate,
            @RequestParam(required = false) String appointmentTime,
            @RequestParam(required = false) String reason,
            @RequestParam(required = false) String painLevel,
            HttpSession session) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";

        Appointment appt = new Appointment();
        doctorService.findById(doctorId).ifPresent(appt::setDoctor);
        appt.setPatient(patient);
        appt.setAppointmentDate(LocalDate.parse(appointmentDate));
        if (appointmentTime != null && !appointmentTime.isEmpty()) {
            appt.setAppointmentTime(appointmentTime);
        }
        appt.setReason(reason);
        appt.setPainLevel(painLevel);
        appt.setStatus("Pending");
        appointmentService.save(appt);

        // Generate Consultation Bill Automatically
        Bill consultationBill = new Bill();
        consultationBill.setPatient(patient);
        consultationBill.setServiceType("CONSULTATION");
        consultationBill.setServiceId(appt.getId());
        consultationBill.setAmount(500.0); // Standard Consultation Fee
        consultationBill.setStatus("UNPAID");
        billService.save(consultationBill);

        return "redirect:/patient/pay/" + consultationBill.getId();
    }

    @GetMapping("/my-appointments")
    public String myAppointments(HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";
        model.addAttribute("appointments", appointmentService.findByPatientId(patient.getId()));
        return "patient/my-appointments";
    }

    @GetMapping("/medical-records")
    public String medicalRecords(HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";
        model.addAttribute("prescriptions", prescriptionService.findByPatientId(patient.getId()));
        model.addAttribute("labReports", labReportService.findByPatientId(patient.getId()));
        return "patient/medical-records";
    }

    @GetMapping("/lab-reports")
    public String labReports(HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";
        model.addAttribute("labReports", labReportService.findByPatientId(patient.getId()));
        return "patient/lab-reports";
    }

    @PostMapping("/lab-request/accept")
    public String acceptLabRequest(@RequestParam Long requestId, HttpSession session) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";

        Optional<LabTestRequest> reqOpt = labTestRequestService.findById(requestId);
        if (reqOpt.isPresent()) {
            LabTestRequest req = reqOpt.get();
            if (req.getPatient().getId().equals(patient.getId())) {
                
                // Check for PAID bills to prevent duplicates
                Optional<Bill> paidBill = billService.findByPatientId(patient.getId()).stream()
                    .filter(b -> "LAB".equals(b.getServiceType()) && b.getServiceId() != null && b.getServiceId().equals(req.getId()) && "PAID".equals(b.getStatus()))
                    .findFirst();

                if (paidBill.isPresent()) {
                    req.setStatus("PAID");
                    labTestRequestService.save(req);
                    return "redirect:/patient/bills";
                }
                
                // Check if LabTech already generated a bill
                Optional<Bill> existingBill = billService.findByPatientId(patient.getId()).stream()
                    .filter(b -> "LAB".equals(b.getServiceType()) && b.getServiceId() != null && b.getServiceId().equals(req.getId()) && "UNPAID".equals(b.getStatus()))
                    .findFirst();
                
                if (existingBill.isPresent()) {
                    return "redirect:/patient/pay/" + existingBill.get().getId();
                }

                req.setStatus("Pending Payment");
                labTestRequestService.save(req);

                // Generate LAB Bill
                Bill labBill = new Bill();
                labBill.setPatient(patient);
                labBill.setServiceType("LAB");
                labBill.setServiceId(req.getId());
                labBill.setAmount(1000.0); // Standard Lab Fee
                labBill.setStatus("UNPAID");
                billService.save(labBill);

                return "redirect:/patient/pay/" + labBill.getId();
            }
        }
        return "redirect:/patient/dashboard";
    }

    @PostMapping("/lab-request/reject")
    public String rejectLabRequest(@RequestParam Long requestId, HttpSession session) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";

        Optional<LabTestRequest> reqOpt = labTestRequestService.findById(requestId);
        if (reqOpt.isPresent()) {
            LabTestRequest req = reqOpt.get();
            if (req.getPatient().getId().equals(patient.getId())) {
                req.setStatus("Rejected");
                labTestRequestService.save(req);
            }
        }
        return "redirect:/patient/dashboard";
    }

    @GetMapping("/lab-report/download/{id}")
    @ResponseBody
    public org.springframework.http.ResponseEntity<byte[]> downloadLabReport(@PathVariable Long id, HttpSession session) {
        if (!isPatient(session)) {
            return org.springframework.http.ResponseEntity.status(org.springframework.http.HttpStatus.FORBIDDEN).build();
        }
        Patient patient = getCurrentPatient(session);
        Optional<LabReport> reportOpt = labReportService.findById(id);

        if (reportOpt.isPresent()) {
            LabReport report = reportOpt.get();
            // Ownership check
            if (!report.getPatient().getId().equals(patient.getId())) {
                return org.springframework.http.ResponseEntity.status(org.springframework.http.HttpStatus.FORBIDDEN).build();
            }

            byte[] pdfContents = pdfReportService.generateLabReportPdf(report);
            org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
            headers.setContentType(org.springframework.http.MediaType.APPLICATION_PDF);
            String filename = "LabReport_" + report.getTestName().replaceAll("\\s+", "_") + "_" + report.getId() + ".pdf";
            headers.setContentDispositionFormData("attachment", filename);
            headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");

            return new org.springframework.http.ResponseEntity<>(pdfContents, headers, org.springframework.http.HttpStatus.OK);
        }
        return org.springframework.http.ResponseEntity.notFound().build();
    }

    @GetMapping("/receipt/download/{billId}")
    @ResponseBody
    public org.springframework.http.ResponseEntity<byte[]> downloadReceipt(@PathVariable Long billId, HttpSession session) {
        if (!isPatient(session)) {
            return org.springframework.http.ResponseEntity.status(org.springframework.http.HttpStatus.FORBIDDEN).build();
        }
        Patient patient = getCurrentPatient(session);
        java.util.Optional<Payment> paymentOpt = paymentService.findByBillId(billId);

        if (paymentOpt.isPresent()) {
            Payment payment = paymentOpt.get();
            // Ownership check
            if (!payment.getBill().getPatient().getId().equals(patient.getId())) {
                return org.springframework.http.ResponseEntity.status(org.springframework.http.HttpStatus.FORBIDDEN).build();
            }

            byte[] pdfContents = pdfReportService.generateReceiptPdf(payment);
            org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
            headers.setContentType(org.springframework.http.MediaType.APPLICATION_PDF);
            String filename = "Receipt_BILL_" + payment.getBill().getId() + ".pdf";
            headers.setContentDispositionFormData("attachment", filename);

            return new org.springframework.http.ResponseEntity<>(pdfContents, headers, org.springframework.http.HttpStatus.OK);
        }
        return org.springframework.http.ResponseEntity.notFound().build();
    }

    @GetMapping("/reminders")
    public String reminders(HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";
        model.addAttribute("reminders", medicineReminderService.findByPatientId(patient.getId()));
        return "patient/reminders";
    }

    @PostMapping("/reminders/add")
    public String addReminder(@RequestParam String medicineName, @RequestParam String dosage,
            @RequestParam String reminderTime, @RequestParam(required = false) String notes,
            HttpSession session) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";

        MedicineReminder r = new MedicineReminder();
        r.setPatient(patient);
        r.setMedicineName(medicineName);
        r.setDosage(dosage);
        r.setReminderTime(reminderTime);
        r.setNotes(notes);
        r.setActive(true);
        medicineReminderService.save(r);
        return "redirect:/patient/reminders";
    }

    @GetMapping("/reminders/delete/{id}")
    public String deleteReminder(@PathVariable Long id, HttpSession session) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        medicineReminderService.deleteById(id);
        return "redirect:/patient/reminders";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        model.addAttribute("patient", patient);
        return "patient/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam(required = false) Integer age,
            @RequestParam(required = false) String gender,
            @RequestParam(required = false) String bloodGroup,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String allergies,
            @RequestParam(required = false) String emergencyContact,
            @RequestParam(required = false) String address,
            HttpSession session) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";
        patient.setAge(age);
        patient.setGender(gender);
        patient.setBloodGroup(bloodGroup);
        patient.setPhone(phone);
        patient.setAllergies(allergies);
        patient.setEmergencyContact(emergencyContact);
        patient.setAddress(address);
        patientService.save(patient);
        return "redirect:/patient/profile?success=true";
    }

    @PostMapping("/complaint")
    public String submitComplaint(@RequestParam String complaintText, HttpSession session) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";

        Complaint c = new Complaint();
        c.setPatient(patient);
        c.setComplaintText(complaintText);
        complaintService.save(c);
        return "redirect:/patient/dashboard?complaint=submitted";
    }

    @GetMapping("/bills")
    public String viewBills(HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";
        model.addAttribute("bills", billService.findByPatientId(patient.getId()));
        return "patient/bills";
    }

    @GetMapping("/pay/{id}")
    public String payBillPage(@PathVariable Long id, HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";
        Optional<Bill> billOpt = billService.findById(id);
        if (billOpt.isPresent()) {
            Bill bill = billOpt.get();
            model.addAttribute("bill", bill);
            
            // Calculate active insurance and discounts
            List<Insurance> insurances = insuranceService.findByPatientId(patient.getId());
            boolean hasVerifiedInsurance = insurances.stream().anyMatch(i -> "Verified".equals(i.getStatus()));
            
            double totalCoverage = insurances.stream()
                .filter(i -> "Verified".equals(i.getStatus()))
                .mapToDouble(Insurance::getCoverageAmount)
                .sum();
            
            double discountPercentage = 0.0;
            if (hasVerifiedInsurance) {
                if ("CONSULTATION".equalsIgnoreCase(bill.getServiceType())) {
                    discountPercentage = 0.05; // 5%
                } else if ("LAB".equalsIgnoreCase(bill.getServiceType())) {
                    discountPercentage = 0.07; // 7%
                }
            }
            double discountAmount = bill.getAmount() * discountPercentage;

            model.addAttribute("totalInsurance", totalCoverage);
            model.addAttribute("hasVerifiedInsurance", hasVerifiedInsurance);
            model.addAttribute("discountPercentage", discountPercentage * 100);
            model.addAttribute("discountAmount", discountAmount);

            return "patient/pay";
        }
        return "redirect:/patient/bills";
    }

    @PostMapping("/process-payment")
    public String processPayment(@RequestParam Long billId, @RequestParam(required = false, defaultValue = "INSURANCE") String method, HttpSession session) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        Optional<Bill> billOpt = billService.findById(billId);
        if (billOpt.isPresent()) {
            Bill bill = billOpt.get();
            if ("PAID".equals(bill.getStatus())) {
                return "redirect:/patient/bills?error=already_paid";
            }
            double originalAmount = bill.getAmount();

            // Calculate Discounts
            List<Insurance> insurances = insuranceService.findByPatientId(patient.getId());
            boolean hasVerifiedInsurance = insurances.stream().anyMatch(i -> "Verified".equals(i.getStatus()));
            double discountPercentage = 0.0;
            
            if (hasVerifiedInsurance) {
                if ("CONSULTATION".equalsIgnoreCase(bill.getServiceType())) {
                    discountPercentage = 0.05;
                } else if ("LAB".equalsIgnoreCase(bill.getServiceType())) {
                    discountPercentage = 0.07;
                }
            }
            double discountAmount = originalAmount * discountPercentage;
            double discountedTotal = originalAmount - discountAmount;
            double amountToPay = discountedTotal;

            // Automatically apply insurance coverage
            Insurance activeIns = insurances.stream()
                .filter(i -> "Verified".equals(i.getStatus()) && i.getCoverageAmount() > 0)
                .findFirst().orElse(null);
                
            if (activeIns != null) {
                if (activeIns.getCoverageAmount() >= amountToPay) {
                    activeIns.setCoverageAmount(activeIns.getCoverageAmount() - amountToPay);
                    amountToPay = 0;
                } else {
                    amountToPay -= activeIns.getCoverageAmount();
                    activeIns.setCoverageAmount(0.0);
                }
                insuranceService.save(activeIns);
            }

            bill.setStatus("PAID");
            billService.save(bill);

            Payment payment = new Payment();
            payment.setBill(bill);
            payment.setAmountPaid(amountToPay);
            payment.setPaymentMethod(amountToPay == 0 ? "INSURANCE" : method);
            payment.setTransactionId("TXN" + System.currentTimeMillis());
            paymentService.save(payment);

            // Unlock Lab Test Requests for Lab Technicians when Paid
            if ("LAB".equalsIgnoreCase(bill.getServiceType()) && bill.getServiceId() != null) {
                labTestRequestService.findById(bill.getServiceId()).ifPresent(req -> {
                    if (!"Completed".equals(req.getStatus())) {
                        req.setStatus("PAID");
                        labTestRequestService.save(req);
                    }
                });
            }

            return "redirect:/patient/bills?payment=success&txnId=" + payment.getTransactionId();
        }
        return "redirect:/patient/bills?error=failed";
    }

    @GetMapping("/insurance")
    public String insurancePage(HttpSession session, Model model) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";
        
        List<Insurance> insurances = insuranceService.findByPatientId(patient.getId());
        model.addAttribute("insurances", insurances);
        return "patient/insurance";
    }

    @PostMapping("/insurance/add")
    public String addInsurance(@RequestParam String provider,
            @RequestParam String policyNumber,
            @RequestParam Double coverageAmount,
            @RequestParam String expiryDate,
            @RequestParam(value = "cardImage", required = false) org.springframework.web.multipart.MultipartFile cardImage,
            HttpSession session) {
        if (!isPatient(session))
            return "redirect:/auth/login";
        Patient patient = getCurrentPatient(session);
        if (patient == null)
            return "redirect:/auth/login";

        Insurance insurance = new Insurance();
        insurance.setPatient(patient);
        insurance.setProvider(provider);
        insurance.setPolicyNumber(policyNumber);
        insurance.setCoverageAmount(coverageAmount);
        insurance.setExpiryDate(LocalDate.parse(expiryDate));
        
        if (cardImage != null && !cardImage.isEmpty()) {
            try {
                String fileName = System.currentTimeMillis() + "_" + cardImage.getOriginalFilename();
                java.nio.file.Path uploadPath = java.nio.file.Paths.get("src/main/resources/static/uploads/insurance");
                if (!java.nio.file.Files.exists(uploadPath)) {
                    java.nio.file.Files.createDirectories(uploadPath);
                }
                java.nio.file.Files.copy(cardImage.getInputStream(), uploadPath.resolve(fileName), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                insurance.setCardImageUrl("/uploads/insurance/" + fileName);
            } catch (java.io.IOException e) {
                e.printStackTrace();
            }
        }
        
        insuranceService.save(insurance);
        return "redirect:/patient/insurance?success=true";
    }

    private void seedSampleBills(Patient patient) {
        Bill b1 = new Bill();
        b1.setPatient(patient);
        b1.setServiceType("CONSULTATION");
        b1.setServiceId(1L);
        b1.setAmount(500.0);
        b1.setStatus("UNPAID");
        billService.save(b1);

        Bill b2 = new Bill();
        b2.setPatient(patient);
        b2.setServiceType("LAB");
        b2.setServiceId(2L);
        b2.setAmount(1200.0);
        b2.setStatus("UNPAID");
        billService.save(b2);
    }

    private boolean isPatient(HttpSession session) {
        return "PATIENT".equals(session.getAttribute("role"));
    }

    private Patient getCurrentPatient(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return null;
        return patientService.findByUserId(user.getId()).orElse(null);
    }

    @PostMapping("/qr/generate")
    @ResponseBody
    public java.util.Map<String, Object> generateQrToken(HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        if (!isPatient(session)) {
            result.put("error", "Unauthorized");
            return result;
        }
        Patient patient = getCurrentPatient(session);
        if (patient == null) {
            result.put("error", "Patient not found");
            return result;
        }
        QrShareToken token = qrShareTokenService.generateToken(patient);
        result.put("token", token.getToken());
        result.put("expiresAt", token.getExpiresAt().toString());
        return result;
    }

    @GetMapping("/disease-trends")
    @ResponseBody
    public java.util.Map<String, Object> diseaseTrends(HttpSession session) {
        if (!isPatient(session)) {
            java.util.Map<String, Object> err = new java.util.HashMap<>();
            err.put("error", "Unauthorized");
            return err;
        }
        return diseaseReportService.getTrends();
    }

    @GetMapping("/hospitals/search")
    @ResponseBody
    public List<java.util.Map<String, Object>> searchHospitals(@RequestParam(required = false) String city, HttpSession session) {
        if (!isPatient(session)) return java.util.Collections.emptyList();
        List<Hospital> hospitals = hospitalService.searchByCity(city);
        List<java.util.Map<String, Object>> result = new java.util.ArrayList<>();
        for (Hospital h : hospitals) {
            java.util.Map<String, Object> map = new java.util.LinkedHashMap<>();
            map.put("id", h.getId());
            map.put("name", h.getName());
            map.put("city", h.getCity());
            map.put("area", h.getArea());
            map.put("address", h.getAddress());
            map.put("phone", h.getPhone());
            map.put("email", h.getEmail());
            map.put("icuAvailable", h.getIcuBedsAvailable());
            map.put("icuTotal", h.getIcuBedsTotal());
            map.put("oxygenAvailable", h.getOxygenBedsAvailable());
            map.put("oxygenTotal", h.getOxygenBedsTotal());
            map.put("generalAvailable", h.getGeneralBedsAvailable());
            map.put("generalTotal", h.getGeneralBedsTotal());
            map.put("totalAvailable", h.getTotalBedsAvailable());
            map.put("totalBeds", h.getTotalBeds());
            result.add(map);
        }
        return result;
    }

    @GetMapping("/health-history")
    @ResponseBody
    public List<HealthScore> getHealthHistory(HttpSession session) {
        if (!isPatient(session)) return java.util.Collections.emptyList();
        Patient patient = getCurrentPatient(session);
        if (patient == null) return java.util.Collections.emptyList();
        return healthScoreService.getHistory(patient);
    }
}
