package com.entity.repository;

import com.entity.model.LabReport;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface LabReportRepository extends JpaRepository<LabReport, Long> {
    List<LabReport> findByPatientId(Long patientId);

    List<LabReport> findByStatus(String status);

    List<LabReport> findByPatientIdOrderByReportDateDesc(Long patientId);
}
