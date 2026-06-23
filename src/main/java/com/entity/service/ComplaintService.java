package com.entity.service;

import com.entity.model.Complaint;
import com.entity.repository.ComplaintRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class ComplaintService {

    @Autowired
    private ComplaintRepository complaintRepository;

    public Complaint save(Complaint complaint) {
        return complaintRepository.save(complaint);
    }

    public List<Complaint> findAll() {
        return complaintRepository.findAll();
    }

    public List<Complaint> findPending() {
        return complaintRepository.findByStatus("Pending");
    }

    public List<Complaint> findByPatientId(Long patientId) {
        return complaintRepository.findByPatientId(patientId);
    }

    public Optional<Complaint> findById(Long id) {
        return complaintRepository.findById(id);
    }

    public Complaint resolve(Long id, String resolution) {
        Optional<Complaint> opt = complaintRepository.findById(id);
        if (opt.isPresent()) {
            Complaint c = opt.get();
            c.setStatus("Resolved");
            c.setResolution(resolution);
            c.setResolvedDate(LocalDate.now());
            return complaintRepository.save(c);
        }
        return null;
    }
}
