package com.entity.repository;

import com.entity.model.Complaint;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ComplaintRepository extends JpaRepository<Complaint, Long> {
    List<Complaint> findByStatus(String status);

    List<Complaint> findByPatientId(Long patientId);
}
