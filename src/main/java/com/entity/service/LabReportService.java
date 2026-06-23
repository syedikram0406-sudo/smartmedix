package com.entity.service;

import com.entity.model.LabReport;
import com.entity.repository.LabReportRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class LabReportService {

    @Autowired
    private LabReportRepository labReportRepository;

    public LabReport save(LabReport report) {
        return labReportRepository.save(report);
    }

    public List<LabReport> findAll() {
        return labReportRepository.findAll();
    }

    public List<LabReport> findByPatientId(Long patientId) {
        return labReportRepository.findByPatientIdOrderByReportDateDesc(patientId);
    }

    public List<LabReport> findByStatus(String status) {
        return labReportRepository.findByStatus(status);
    }

    public Optional<LabReport> findById(Long id) {
        return labReportRepository.findById(id);
    }

    public long count() {
        return labReportRepository.count();
    }
}
