package com.entity.repository;

import com.entity.model.Bill;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface BillRepository extends JpaRepository<Bill, Long> {
    List<Bill> findByPatientId(Long patientId);

    List<Bill> findByPatientIdAndStatus(Long patientId, String status);
}
