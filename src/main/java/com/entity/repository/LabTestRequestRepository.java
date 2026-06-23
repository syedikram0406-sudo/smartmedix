package com.entity.repository;

import com.entity.model.LabTestRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface LabTestRequestRepository extends JpaRepository<LabTestRequest, Long> {
    List<LabTestRequest> findByStatus(String status);

    List<LabTestRequest> findByDoctorId(Long doctorId);

    List<LabTestRequest> findByPatientId(Long patientId);
}
