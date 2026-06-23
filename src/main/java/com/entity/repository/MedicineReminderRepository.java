package com.entity.repository;

import com.entity.model.MedicineReminder;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface MedicineReminderRepository extends JpaRepository<MedicineReminder, Long> {
    List<MedicineReminder> findByPatientId(Long patientId);

    List<MedicineReminder> findByPatientIdAndActiveTrue(Long patientId);
}
