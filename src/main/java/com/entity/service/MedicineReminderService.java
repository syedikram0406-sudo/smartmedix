package com.entity.service;

import com.entity.model.MedicineReminder;
import com.entity.repository.MedicineReminderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class MedicineReminderService {

    @Autowired
    private MedicineReminderRepository medicineReminderRepository;

    public MedicineReminder save(MedicineReminder reminder) {
        return medicineReminderRepository.save(reminder);
    }

    public List<MedicineReminder> findByPatientId(Long patientId) {
        return medicineReminderRepository.findByPatientId(patientId);
    }

    public List<MedicineReminder> findActiveByPatientId(Long patientId) {
        return medicineReminderRepository.findByPatientIdAndActiveTrue(patientId);
    }

    public Optional<MedicineReminder> findById(Long id) {
        return medicineReminderRepository.findById(id);
    }

    public void deleteById(Long id) {
        medicineReminderRepository.deleteById(id);
    }
}
