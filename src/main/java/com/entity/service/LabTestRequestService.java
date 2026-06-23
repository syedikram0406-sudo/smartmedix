package com.entity.service;

import com.entity.model.LabTestRequest;
import com.entity.repository.LabTestRequestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class LabTestRequestService {

    @Autowired
    private LabTestRequestRepository labTestRequestRepository;

    public LabTestRequest save(LabTestRequest request) {
        return labTestRequestRepository.save(request);
    }

    public List<LabTestRequest> findAll() {
        return labTestRequestRepository.findAll();
    }

    public List<LabTestRequest> findPending() {
        return labTestRequestRepository.findByStatus("Pending");
    }

    public List<LabTestRequest> findPaid() {
        return labTestRequestRepository.findByStatus("PAID");
    }

    public List<LabTestRequest> findByDoctorId(Long doctorId) {
        return labTestRequestRepository.findByDoctorId(doctorId);
    }

    public List<LabTestRequest> findByPatientId(Long patientId) {
        return labTestRequestRepository.findByPatientId(patientId);
    }

    public Optional<LabTestRequest> findById(Long id) {
        return labTestRequestRepository.findById(id);
    }

    public long count() {
        return labTestRequestRepository.count();
    }
}
