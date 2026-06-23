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
import java.util.stream.Collectors;

@Controller
@RequestMapping("/lab")
public class LabTechController {

    @Autowired
    private LabTestRequestService labTestRequestService;
    @Autowired
    private LabReportService labReportService;
    @Autowired
    private PatientService patientService;
    @Autowired
    private BillService billService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (!isLabTech(session))
            return "redirect:/auth/login";
        long totalRequests = labTestRequestService.count();
        long completedReports = labReportService.findByStatus("Completed").size()
                + labReportService.findByStatus("Uploaded").size();
        long pendingReports = labReportService.findByStatus("Pending").size();
        long pendingRequests = labTestRequestService.findAll().stream()
            .filter(r -> "Pending".equals(r.getStatus()) || "Pending Payment".equals(r.getStatus()) || "PAID".equals(r.getStatus()))
            .count();

        model.addAttribute("totalRequests", totalRequests);
        model.addAttribute("completedReports", completedReports);
        model.addAttribute("pendingReports", pendingReports);
        model.addAttribute("pendingRequests", pendingRequests);
        model.addAttribute("bills", billService.findAll());
        return "lab/dashboard";
    }

    @GetMapping("/test-requests")
    public String testRequests(HttpSession session, Model model) {
        if (!isLabTech(session))
            return "redirect:/auth/login";
        model.addAttribute("requests", labTestRequestService.findAll());
        return "lab/test-requests";
    }

    @GetMapping("/upload-report")
    public String uploadForm(HttpSession session, Model model) {
        if (!isLabTech(session))
            return "redirect:/auth/login";
        List<LabTestRequest> requests = labTestRequestService.findAll().stream().filter(r -> "Pending".equals(r.getStatus()) || "Pending Payment".equals(r.getStatus()) || "PAID".equals(r.getStatus())).collect(Collectors.toList());
        model.addAttribute("requests", requests);
        model.addAttribute("patients", patientService.findAll());
        return "lab/upload-report";
    }

    @PostMapping("/upload-report")
    public String uploadReport(@RequestParam Long patientId, @RequestParam String testName,
            @RequestParam String result, @RequestParam(required = false) String normalRange,
            @RequestParam(required = false) String remarks,
            @RequestParam(required = false) Long requestId,
            HttpSession session) {
        if (!isLabTech(session))
            return "redirect:/auth/login";

        LabReport report = new LabReport();
        patientService.findById(patientId).ifPresent(report::setPatient);
        report.setTestName(testName);
        report.setResult(result);
        report.setNormalRange(normalRange);
        report.setRemarks(remarks);
        report.setStatus("Uploaded");
        report.setReportDate(LocalDate.now());

        if (requestId != null) {
            labTestRequestService.findById(requestId).ifPresent(req -> {
                report.setLabTestRequest(req);
                req.setStatus("Completed");
                labTestRequestService.save(req);

                boolean hasBill = billService.findAll().stream()
                    .anyMatch(b -> "LAB".equals(b.getServiceType()) && b.getServiceId() != null && b.getServiceId().equals(req.getId()));
                if (!hasBill) {
                    Bill labBill = new Bill();
                    labBill.setPatient(req.getPatient());
                    labBill.setServiceType("LAB");
                    labBill.setServiceId(req.getId());
                    labBill.setAmount(1000.0);
                    labBill.setStatus("UNPAID");
                    billService.save(labBill);
                }
            });
        }

        labReportService.save(report);
        return "redirect:/lab/upload-report?success=true";
    }

    @GetMapping("/report-status")
    public String reportStatus(HttpSession session, Model model) {
        if (!isLabTech(session))
            return "redirect:/auth/login";
        model.addAttribute("reports", labReportService.findAll());
        return "lab/report-status";
    }

    @PostMapping("/report-status/update")
    public String updateStatus(@RequestParam Long id, @RequestParam String status, HttpSession session) {
        if (!isLabTech(session))
            return "redirect:/auth/login";
        labReportService.findById(id).ifPresent(r -> {
            r.setStatus(status);
            labReportService.save(r);
        });
        return "redirect:/lab/report-status";
    }

    @GetMapping("/report-history")
    public String reportHistory(HttpSession session, Model model) {
        if (!isLabTech(session))
            return "redirect:/auth/login";
        model.addAttribute("reports", labReportService.findAll());
        return "lab/report-history";
    }

    @GetMapping("/patient-reports/{patientId}")
    public String patientReports(@PathVariable Long patientId, HttpSession session, Model model) {
        if (!isLabTech(session))
            return "redirect:/auth/login";
        patientService.findById(patientId).ifPresent(p -> model.addAttribute("patient", p));
        model.addAttribute("reports", labReportService.findByPatientId(patientId));
        model.addAttribute("patients", patientService.findAll());
        return "lab/patient-reports";
    }

    private boolean isLabTech(HttpSession session) {
        return "LAB_TECHNICIAN".equals(session.getAttribute("role"));
    }
}
